package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;

/**
 * @author zhaojin
 * 创建时间:2011-10-11
 * SomOrganCmd
 * 说明:
 */
public class SomOrganCmd extends BaseAjaxCommand {
	
	ISomOrganDomain somOrganDomain = ScaComponentFactory.getService(ISomOrganDomain.class, "somOrganDomain/somOrganDomain");
	ISomCertDomain somCertDomain = ScaComponentFactory.getService(ISomCertDomain.class, "somCertDomain/somCertDomain");
	
	/**
	 * 查询社会组织名称是否重复
	 */
	public void cnNameUK() {
		ParameterSet pset = new ParameterSet();
		String cnName = (String) getParameter("cnName");
		String sorgId = (String) getParameter("sorgId");
		pset.setParameter("CN_NAME@=", cnName);
		pset.setParameter("MORG_AREA@=", BspUtil.getCorpOrgan().getOrganCode());//行政区划限制
		if(sorgId!=null){
			pset.setParameter("SORG_ID@!=", sorgId);
		}
		DataSet ds= somOrganDomain.queryOrgan(pset);
		int cnNameNum=ds.getCount();
		String branchAP_sorgId="";
		String sorgStatus="";
		String oldSorgId="";
		for (int i = 0; i < ds.getCount(); i++) {
			SomOrgan somOrgan=(SomOrgan) ds.getRecord(i).toBean(SomOrgan.class);
			//如果是分支异地审核通过，则排除在外，-1
			if ("1".equals(somOrgan.getIfBranch())&&"15".equals(somOrgan.getSorgStatus())) {
				--cnNameNum;
				branchAP_sorgId=somOrgan.getSorgId();
			}
			//下边几种情况的允许重复登记，不查询出来,-1
			//7：名称核准作废(登记，作判断)
			//10：名核准不通称过
			//13：筹备审批未通过
			//16：异地分支不通过
			//23：登记审批未通过
			//32：已注销
			if ("7".equals(somOrgan.getSorgStatus())||"10".equals(somOrgan.getSorgStatus())||"13".equals(somOrgan.getSorgStatus())||"16".equals(somOrgan.getSorgStatus())||"23".equals(somOrgan.getSorgStatus())||"32".equals(somOrgan.getSorgStatus())) {
				--cnNameNum;
				if("7".equals(somOrgan.getSorgStatus())){
					sorgStatus="7";
					cnNameNum++;
					oldSorgId=somOrgan.getSorgId();
				}
			}
		}
		setReturn("oldSorgId", oldSorgId);
		setReturn("sorgStatus", sorgStatus);
		setReturn("cnNameNum", cnNameNum+"");
		setReturn("branchAP_sorgId", branchAP_sorgId);
	}
	
	/**
	 * 查询登记证号是否重复
	 */
	public void sorgCodeUK() {
		ParameterSet pset = new ParameterSet();
		String sorgCode = (String) getParameter("sorgCode");
		String sorgType = (String) getParameter("sorgType");
		String sorgId = (String) getParameter("sorgId");
		pset.setParameter("SORG_CODE@=", sorgCode);
		pset.setParameter("SORG_TYPE@=", sorgType);
		//行政区划限制
		pset.setParameter("MORG_AREA@=", BspUtil.getCorpOrgan().getOrganCode());
		if(sorgId!=null){
			pset.setParameter("SORG_ID@!=", sorgId);
		}
		setReturn("sorgCodeNum", somOrganDomain.sorgCodeUK(pset));
	}
	
	/**
	 * 查询主体对应的未注销分支机构状态的数量
	 */
	public void branchStatusNum() {
		String mainMorgId = (String) getParameter("mainSorgId");
		setReturn("num", somOrganDomain.branchStatusNum(mainMorgId));
	}
	
	
	public void queryOrganName() {
		ParameterSet pset = new ParameterSet();
		String sorgId = (String) getParameter("sorgId");
		pset.setParameter("SORG_ID@=", sorgId);		
		setReturn("cnName", somOrganDomain.queryOrganName(pset));
	}
	
	public void queryOrganNameAndSorgCode() {
		ParameterSet pset = new ParameterSet();
		String sorgId = (String) getParameter("sorgId");
		pset.setParameter("SORG_ID@=", sorgId);		
		Record Record =  somOrganDomain.queryOrganNameAndSorgCode(pset);
		setReturn("cnName",Record.get("cnName"));
		setReturn("sorgCode",Record.get("sorgCode"));
	}
	
	/**
	 * 查询社会组织名称相似
	 */
	public void cnNameSame() {
		ParameterSet pset = new ParameterSet();
		String cnName = (String) getParameter("cnName");
		String sorgType = (String) getParameter("sorgType");
		String ifBranch = (String) getParameter("ifBranch");
		String morgArea = (String) getParameter("morgArea");
		pset.setParameter("CN_NAME@like", cnName);
		pset.setParameter("SORG_TYPE@=", sorgType);
		pset.setParameter("IF_BRANCH@=", ifBranch);
		pset.setParameter("MORG_AREA@=", morgArea);
		setReturn("cnNameSameNum", somOrganDomain.cnNameSame(pset));
	}
	
	/**
	 * 取消社会组织限期停止活动状态
	 */
	public void cancelLimitPeriod() {
		ParameterSet pset = new ParameterSet();
		String sorgId = (String) getParameter("sorgId");
		pset.setParameter("SORG_ID@=", sorgId);
		somOrganDomain.cancelLimitPeriod(pset);
	}
	/**
	 * 名称核准作废，更新sorg_status
	 */
	public void updateSorgStatus() {
		ParameterSet pset = new ParameterSet();
		String sorgId = (String) getParameter("sorgId");
		pset.setParameter("SORG_ID@=", sorgId);
		somOrganDomain.updateSorgStatus(pset);
	}
	
	/**
	 * 社会组织修订功能页面中调用
	 */
	@Trans
	public void modifyOrganInfo() {
		Record organRecord = (Record) getParameter("organRecord");
		SomOrgan somOrgan=(SomOrgan)organRecord.toBean(SomOrgan.class);	
		somOrganDomain.update(somOrgan);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", somOrgan.getSorgId());
		pset.setParameter("CERT_STATUS@=", "1");
		DataSet certDs = somCertDomain.query(pset);
		for(int i = 0;i<certDs.getCount();i++){
			SomCert SomCert = (SomCert)certDs.getRecord(i).toBean(SomCert.class);
			SomCert.setSorgCode(somOrgan.getSorgCode());
			SomCert.setSorgKind(somOrgan.getSorgKind());
			SomCert.setOrganCode(somOrgan.getOrganCode());
			SomCert.setSorgName(somOrgan.getCnName());
			//SomCert.setBusiness(somOrgan.getBusiness());
			SomCert.setResidence(somOrgan.getResidence());
			SomCert.setActArea(somOrgan.getActArea());
			SomCert.setRegMon(somOrgan.getRegMon());
			SomCert.setBorgName(somOrgan.getBorgName());
			somCertDomain.update(SomCert);
		}
	}
}
