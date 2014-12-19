package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.RecordSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomCertDao;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;

/**
 * 社会组织证书domain实现类
 * 
 * @author yanliangliang
 * @date 2011年5月13日14:43:42
 */
public class SomCertDomain implements ISomCertDomain {
	// --------------------------------------------------yanliangliang-----------------------------------
	@Reference
	private ISomCertDao somCertDao;

	/**
	 * 社会组织证书查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somCertDao.query(pset);
	}

	/**
	 * 增加社会组织证书
	 * 
	 * @param somCert
	 */
	public String insert(SomCert somCert) {
		somCert.setId(IdHelp.getUUID30());
		SomCert s = somCertDao.insert(somCert);
		return s.getId();
	}

	/**
	 * 更新社会组织证书
	 * 
	 * @param somCert
	 */
	public void update(SomCert somCert) {
		somCertDao.update(somCert);
	}
	
	/**
	 * 换发社会组织证书
	 * 
	 * @param somCert
	 */
	public void change(SomCert somCert) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("id", somCert.getId());
		DataSet ds = somCertDao.query(pset);
		SomCert bean = (SomCert) ds.getRecord(0).toBean(SomCert.class);
		bean.setCertStatus("0");
		somCertDao.update(bean);
		somCert.setId(IdHelp.getUUID32());
		somCertDao.insert(somCert);
	}

	/**
	 * 批量更新社会组织证书
	 */
	public void batchUpdate(List<SomCert> list){
		somCertDao.batchUpdate(list);
	}
	
	/**
	 * 收回证书 2011年5月17日20:08:27
	 */
	public void receive(SomCert somCert) {
		somCert.setCertStatus("0");
		somCert.setIfReceive("1");
		somCert.setReceivePeople(BspUtil.getEmpOrgan().getOrganName());
		somCert.setReceiveDate(DateUtil.getDay());
		somCertDao.update(somCert);

	}
	/**
	 * 综合查询中根据证书查询社会组织ID
	 */
	public String queryForQuery(ParameterSet pset) {
		String signDate=(String)pset.getParameter("signDate");
		String signOrgan=(String)pset.getParameter("signOrgan");
		String signEndDate=(String)pset.getParameter("signEndDate");
		//System.out.println("signDate="+signDate);
		//System.out.println("signOrgan="+signOrgan);
		//System.out.println("signEndDate="+signEndDate);
		pset.clear();
		
		if(signDate.indexOf("~")!=-1){
			pset.setParameter("sign_Date@between", signDate);
		}if(signDate.indexOf("~")==-1){
			pset.setParameter("sign_Date@like", signDate);
		}
		if(StringUtils.isNotEmpty(signOrgan)){
			pset.setParameter("sign_Organ@like", signOrgan);
		}
		if(StringUtils.isNotEmpty(signEndDate)){
			pset.setParameter("sign_EndDate@=", signEndDate);
		}
		//System.out.println("sss");
		DataSet ds=somCertDao.query(pset);
		RecordSet rs=ds.getRecordSet();
		String idString="";
		for (int i = 0; i < rs.size(); i++) {
			idString+=rs.get(i).get("sorgId")+",";
		}
		//System.out.println(idString);
		return idString;
	}
}
