package com.inspur.cams.sorg.base.domain.support;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.RecordSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomAccountDao;
import com.inspur.cams.sorg.base.data.SomAccount;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.domain.ISomAccountDomain;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 社会组织账户domain实现类
 * @author shgtch
 * @date 2011-5-11
 */
public class SomAccountDomain implements ISomAccountDomain {
	
	@Reference
	private ISomAccountDao somAccountDao;
	
	@Reference
	private ISomApplyDomain somApplyDomain;
	
	/**
	 * 查询社会组织账户
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somAccountDao.query(pset);
	}
	
	/**
	 * 增加社会组织账户
	 * @param somAccount
	 */
	@Trans
	public void insert(SomAccount somAccount) {
		//把有效的银行账户备案状态改为历史
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=",somAccount.getSorgId());
		pset.setParameter("REG_STATUS@=","1");
		DataSet ds = query(pset);
		if(ds.getCount()>0){
			SomAccount bean = (SomAccount)(ds.getRecord(0).toBean(SomAccount.class));
			bean.setRegStatus("2");
			somAccountDao.update(bean);
		}
		//增加新的备案信息
		somAccount.setId(IdHelp.getUUID30());
		somAccount.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somAccount.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somAccount.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somAccount.setCreateTime(DateUtil.getTime());
		//somAccount.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		//somAccount.setRegDate(DateUtil.getDay());
		somAccount.setRegStatus("1");		
		somAccountDao.insert(somAccount);
		
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somAccount.getTaskCode());
		somApply.setSorgId(somAccount.getSorgId());
		if(somAccount.getSorgType().equals("S")){
			somApply.setApplyType(ApplyType.SOM_GROUP_ACCOUNT);
		}
		if(somAccount.getSorgType().equals("M")){
			somApply.setApplyType(ApplyType.SOM_UNGOV_ACCOUNT);
		}
		if(somAccount.getSorgType().equals("J")){
			somApply.setApplyType(ApplyType.SOM_FUND_ACCOUNT_FILING);
		}
		somApply.setSorgType(somAccount.getSorgType());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
	}
	
	/**
	 * 更新社会组织账户
	 * @param somAccount
	 */
	public void update(SomAccount somAccount) {
		somAccountDao.update(somAccount);
	}
	/**
	 * 综合查询中根据账号查询社会组织ＩＤ
	 * ２０１１年５月２６日９：３１：０８
	 */
	public String queryForQuery(ParameterSet pset) {
		//System.out.println("in queryForQuery");
		String bank=(String)pset.getParameter("bank");
		String accountDate=(String)pset.getParameter("accountDate");
		String accountCode=(String)pset.getParameter("accountCode");
		//System.out.println("bank="+bank);
		//System.out.println("accountDate="+accountDate);
		//System.out.println("accountCode="+accountCode);
		pset.clear();
		
		if(accountDate.indexOf("~")!=-1){
			pset.setParameter("account_Date@between", accountDate);
		}if(accountDate.indexOf("~")==-1){
			pset.setParameter("account_Date@like", accountDate);
		}
		if(StringUtils.isNotEmpty(bank)){
			pset.setParameter("bank@like", bank);
		}
		if(StringUtils.isNotEmpty(accountCode)){
			pset.setParameter("account_Code@=", accountCode);
		}
		//System.out.println("account");
		DataSet ds=somAccountDao.query(pset);
		RecordSet rs=ds.getRecordSet();
		//System.out.println("size="+rs.size());
		String idString2="";
		for (int i = 0; i < rs.size(); i++) {
			idString2+=rs.get(i).get("sorgId")+",";
		}
		//System.out.println(idString2);
		return idString2;
	}
	
	public void del(String taskCode) {
		somAccountDao.del(taskCode);
	}

}
