package com.inspur.cams.bpt.manage.cmd;


import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.dichealth.dao.DicHealth;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;


/**
 * @title:BptPeopleWarQueryCommand
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
public class BptPeopleWarQueryCommand extends BaseQueryCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");	
	IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
	public DataSet queryPeople() {
		ParameterSet pset = getParameterSet();
		return iWarService.queryWar(pset);
//		return service.queryWar(pset);
		
	}
	
	
	/**
	 * 查询人员参战信息和优抚人员信息
	 * @return
	 */
	public DataSet queryPeopleWarInfo(){
		IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
		ParameterSet pset = getParameterSet();
		IBptApplyIntoprovinceDomain intoProvinceService=ScaComponentFactory.getService(IBptApplyIntoprovinceDomain.class,"BptApplyIntoprovinceDao/BptApplyIntoprovinceDao");
		
		DataSet warDataSet = iWarService.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataSet = service.queryPeople(pset);
		DataSet intoProvinceDataset= intoProvinceService.query(pset);
		
		Record rd1 = new Record();
		if(warDataSet.getCount()>0){
			rd1 = warDataSet.getRecord(0);
			String healthStateName = queryHealthInfo((String)rd1.get("healthStateCode"));
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataSet.getRecord(0);
			if(intoProvinceDataset.getCount()>0){
				Record rd4 = intoProvinceDataset.getRecord(0);
				rd1.set("ingoingReason", rd4.get("ingoingReason"));
				rd1.set("allowanceMonth", rd4.get("allowanceMonth"));
				rd1.set("ingoingAddress", rd4.get("ingoingAddress"));
				rd1.set("oldPaperNo", rd4.get("oldPaperNo"));
			}
			rd1.set("bank", rd2.get("bank"));
			rd1.set("accountName", rd2.get("accountName"));
			rd1.set("accountCode", rd2.get("accountCode"));
			rd1.set("insanityFlag", rd2.get("insanityFlag"));
			rd1.set("supportPattern", rd2.get("supportPattern"));
			rd1.set("oldLonelyFlag", rd2.get("oldLonelyFlag"));
			rd1.set("orphanFlag", rd2.get("orphanFlag"));
			rd1.set("workAbilityCode", rd2.get("workAbilityCode"));
			rd1.set("viabilityCode", rd2.get("viabilityCode"));
			rd1.set("workAbilityDescribe", rd2.get("workAbilityDescribe"));
			rd1.set("jobStatusDescribe", rd2.get("jobStatusDescribe"));
			rd1.set("warNo", rd3.get("warNo"));
			rd1.set("approveDate", rd3.get("approveDate"));
			rd1.set("warStateCode", rd3.get("warStateCode"));
			rd1.set("healthStateName", healthStateName);
		}
		DataSet ds = new DataSet(rd1);
		return  ds;
	}
	
	/**
	 * 查询未提交参战人员信息
	 * @return
	 */
	public DataSet queryUnCommitWar() {
		ParameterSet pset = getParameterSet();
		return iWarService.queryUnCommitWar(pset);
	}
	// 查询健康状况
	public String queryHealthInfo(String healthStateCode) {
		// 获得健康状况dao
		EntityDao<DicHealth> healthDao = (EntityDao<DicHealth>) DaoFactory
				.getDao("com.inspur.cams.bpt.dichealth.dao.DicHealthDao");
		ParameterSet pest = new ParameterSet();
		pest.setParameter("CODE@=", healthStateCode);
		DataSet ds = healthDao.query(pest);
		String healthStateName = "";
		if (ds.getCount() > 0) {
			healthStateName = (String) ds.getRecord(0).get("name");
		}
		return healthStateName;
	}


}
