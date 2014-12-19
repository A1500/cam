package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.dao.IBptPeopleDemobilizedIllnessDao;
import com.inspur.cams.bpt.base.data.DicHealth;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptPeopleDemobilizedIllnessQueryCommand
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
public class BptPeopleDemobilizedIllnessQueryCommand extends BaseQueryCommand{

	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory.getService(IBptApplyIntoprovinceDomain.class,
	"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");
	
	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessService = ScaComponentFactory.getService(IBptPeopleDemobilizedIllnessDomain.class,
			"demobilizedIllnessDomain/demobilizedIllnessDomain");
	IBptApplyEmigrationDomain bptApplyEmigrationService = ScaComponentFactory.getService(IBptApplyEmigrationDomain.class,
	"BptApplyEmigrationDomain/BptApplyEmigrationDomain");
	/**
	 * 查询带病回乡退伍军人信息
	 * @return
	 */
	public DataSet queryDemobilizedPeople(){
		ParameterSet pset = getParameterSet();
		pset.setParameter("DEMOBILIZED_FLAG@=","1");
		return service.queryPeople(pset);
	}
	
	/**
	 * 查询带病回乡退伍军人信息和相应的优抚人员信息
	 */            
	public DataSet queryDemobilizedIllnessPeople(){
		ParameterSet pset = getParameterSet();
		IBptPeopleDemobilizedIllnessDao demobilizedIllnessDao = (IBptPeopleDemobilizedIllnessDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDemobilizedIllnessDao");
        return demobilizedIllnessDao.queryDemobilizedIllnessPeople(pset);
	}
	
	/**
	 * 查询带病回乡退伍军人信息和相应的优抚人员信息【用在明细列表中】
	 */
	public DataSet queryDemobilizedIllnessBPTPeople(){
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		
		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
		DataSet demobilizedIllnessDataSet = demobilizedIllnessService.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataset = service.queryPeople(pset);
		DataSet bptApplyDataSet  = bptApplyIntoprovinceService.query(pset);
		
		demobilizedIllnessDataSet.addField("disabilityTypeCode");
		demobilizedIllnessDataSet.addField("dependantTypeCode");
		demobilizedIllnessDataSet.addField("redaTypeCode");
		demobilizedIllnessDataSet.addField("warTypeCode");
		demobilizedIllnessDataSet.addField("bank");
		demobilizedIllnessDataSet.addField("accountName");
		demobilizedIllnessDataSet.addField("accountCode");
		demobilizedIllnessDataSet.addField("insanityFlag");
		demobilizedIllnessDataSet.addField("oldLonelyFlag");
		demobilizedIllnessDataSet.addField("orphanFlag");
		demobilizedIllnessDataSet.addField("workAbilityCode");
		demobilizedIllnessDataSet.addField("workAbilityDescribe");
		demobilizedIllnessDataSet.addField("viabilityCode");
		demobilizedIllnessDataSet.addField("supportPattern");
		demobilizedIllnessDataSet.addField("jobStatusDescribe");
		
		demobilizedIllnessDataSet.addField("demobilizedStateCode");
		demobilizedIllnessDataSet.addField("demobilizedNo");
		
		demobilizedIllnessDataSet.addField("ingoingReason");
		demobilizedIllnessDataSet.addField("allowanceMonth");
		demobilizedIllnessDataSet.addField("ingoingAddress");
		Record rd1 = new Record();
		if(demobilizedIllnessDataSet.getCount()>0){
			rd1 = demobilizedIllnessDataSet.getRecord(0);
			String healthStateName = queryHealthInfo((String)rd1.get("healthStateCode"));
			
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataset.getRecord(0);

			
			rd1.set("disabilityTypeCode", rd2.get("disabilityTypeCode"));
			rd1.set("dependantTypeCode", rd2.get("dependantTypeCode"));
			rd1.set("redaTypeCode", rd2.get("redaTypeCode"));
			rd1.set("warTypeCode", rd2.get("warTypeCode"));
			rd1.set("bank", rd2.get("bank"));
			rd1.set("accountName", rd2.get("accountName"));
			rd1.set("accountCode", rd2.get("accountCode"));
			rd1.set("insanityFlag", rd2.get("insanityFlag"));
			rd1.set("oldLonelyFlag", rd2.get("oldLonelyFlag"));
			rd1.set("orphanFlag", rd2.get("orphanFlag"));
			rd1.set("workAbilityCode", rd2.get("workAbilityCode"));
			rd1.set("workAbilityDescribe", rd2.get("workAbilityDescribe"));
			rd1.set("viabilityCode", rd2.get("viabilityCode"));
			rd1.set("supportPattern", rd2.get("supportPattern"));
			rd1.set("jobStatusDescribe", rd2.get("jobStatusDescribe"));
			rd1.set("demobilizedStateCode", rd3.get("demobilizedStateCode"));
			rd1.set("demobilizedNo", rd3.get("demobilizedNo"));
			rd1.set("healthStateName", healthStateName);
			
			

		}
		DataSet ds = new DataSet(rd1);
		
		return  ds;
	}
	/**
	 * 查询未提交的 带病回乡退伍军人信息和相应的优抚人员信息
	 */            
	public DataSet queryApplyDemobilizedIllnessPeople(){
		ParameterSet pset = getParameterSet();
		IBptPeopleDemobilizedIllnessDao demobilizedIllnessDao = (IBptPeopleDemobilizedIllnessDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDemobilizedIllnessDao");
        return demobilizedIllnessDao.queryApplyDemobilizedIllnessPeople(pset);
	}
	/**
	 * 查询带病回乡退伍军人信息和相应的优抚人员信息【用在明细列表中】
	 */
	public DataSet queryIllnessBPTPeople(){
		
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		String applyId = getParameter("APPLY_ID").toString();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
		DataSet demobilizedIllnessDataSet = demobilizedIllnessService.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataset = service.queryPeople(pset);
		//查询迁入地民政局名称和抚恤金发放至月份
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		DataSet disEmigDataSet = bptApplyEmigrationService.query(pset);
		demobilizedIllnessDataSet.addField("disabilityTypeCode");
		demobilizedIllnessDataSet.addField("dependantTypeCode");
		demobilizedIllnessDataSet.addField("redaTypeCode");
		demobilizedIllnessDataSet.addField("warTypeCode");
		demobilizedIllnessDataSet.addField("bank");
		demobilizedIllnessDataSet.addField("accountName");
		demobilizedIllnessDataSet.addField("accountCode");
		demobilizedIllnessDataSet.addField("insanityFlag");
		demobilizedIllnessDataSet.addField("oldLonelyFlag");
		demobilizedIllnessDataSet.addField("orphanFlag");
		demobilizedIllnessDataSet.addField("workAbilityCode");
		demobilizedIllnessDataSet.addField("workAbilityDescribe");
		demobilizedIllnessDataSet.addField("viabilityCode");
		demobilizedIllnessDataSet.addField("supportPattern");
		demobilizedIllnessDataSet.addField("jobStatusDescribe");
		
		demobilizedIllnessDataSet.addField("demobilizedStateCode");
		demobilizedIllnessDataSet.addField("demobilizedNo");
		Record rd1 = new Record();
		if(demobilizedIllnessDataSet.getCount()>0){
			rd1 = demobilizedIllnessDataSet.getRecord(0);
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataset.getRecord(0);
			rd1.set("disabilityTypeCode", rd2.get("disabilityTypeCode"));
			rd1.set("dependantTypeCode", rd2.get("dependantTypeCode"));
			rd1.set("redaTypeCode", rd2.get("redaTypeCode"));
			rd1.set("warTypeCode", rd2.get("warTypeCode"));
			rd1.set("bank", rd2.get("bank"));
			rd1.set("accountName", rd2.get("accountName"));
			rd1.set("accountCode", rd2.get("accountCode"));
			rd1.set("insanityFlag", rd2.get("insanityFlag"));
			rd1.set("oldLonelyFlag", rd2.get("oldLonelyFlag"));
			rd1.set("orphanFlag", rd2.get("orphanFlag"));
			rd1.set("workAbilityCode", rd2.get("workAbilityCode"));
			rd1.set("workAbilityDescribe", rd2.get("workAbilityDescribe"));
			rd1.set("viabilityCode", rd2.get("viabilityCode"));
			rd1.set("supportPattern", rd2.get("supportPattern"));
			rd1.set("jobStatusDescribe", rd2.get("jobStatusDescribe"));
			rd1.set("demobilizedStateCode", rd3.get("demobilizedStateCode"));
			rd1.set("demobilizedNo", rd3.get("demobilizedNo"));
		}
		DataSet ds = new DataSet(rd1);
		
		return  ds;
	}
	/**
	 * 查询未提交的 外省带病回乡迁入退伍军人信息和相应的优抚人员信息
	 */            
	public DataSet queryApplyIntoDemobilizedIllnessPeople(){
		ParameterSet pset = getParameterSet();
		IBptPeopleDemobilizedIllnessDao demobilizedIllnessDao = (IBptPeopleDemobilizedIllnessDao) DaoFactory
        .getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDemobilizedIllnessDao");
        return demobilizedIllnessDao.queryApplyIntoDemobilizedIllnessPeople(pset);
	}
	/**
	 * 查询带病回乡退伍军人信息和相应的优抚人员信息【用在明细列表中】
	 */
	public DataSet queryIntoDemobilizedIllnessBPTPeople(){
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
		DataSet demobilizedIllnessDataSet = demobilizedIllnessService.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataset = service.queryPeople(pset);
		DataSet bptApplyDataSet  = bptApplyIntoprovinceService.query(pset);
		demobilizedIllnessDataSet.addField("disabilityTypeCode");
		demobilizedIllnessDataSet.addField("dependantTypeCode");
		demobilizedIllnessDataSet.addField("redaTypeCode");
		demobilizedIllnessDataSet.addField("warTypeCode");
		demobilizedIllnessDataSet.addField("bank");
		demobilizedIllnessDataSet.addField("accountName");
		demobilizedIllnessDataSet.addField("accountCode");
		demobilizedIllnessDataSet.addField("insanityFlag");
		demobilizedIllnessDataSet.addField("oldLonelyFlag");
		demobilizedIllnessDataSet.addField("orphanFlag");
		demobilizedIllnessDataSet.addField("workAbilityCode");
		demobilizedIllnessDataSet.addField("workAbilityDescribe");
		demobilizedIllnessDataSet.addField("viabilityCode");
		demobilizedIllnessDataSet.addField("supportPattern");
		demobilizedIllnessDataSet.addField("jobStatusDescribe");
		
		demobilizedIllnessDataSet.addField("demobilizedStateCode");
		demobilizedIllnessDataSet.addField("demobilizedNo");
		
		demobilizedIllnessDataSet.addField("ingoingReason");
		demobilizedIllnessDataSet.addField("allowanceMonth");
		demobilizedIllnessDataSet.addField("ingoingAddress");
		Record rd1 = new Record();
		if(demobilizedIllnessDataSet.getCount()>0){
			rd1 = demobilizedIllnessDataSet.getRecord(0);
			
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataset.getRecord(0);
			Record rd4 = bptApplyDataSet.getRecord(0);
			rd1.set("disabilityTypeCode", rd2.get("disabilityTypeCode"));
			rd1.set("dependantTypeCode", rd2.get("dependantTypeCode"));
			rd1.set("redaTypeCode", rd2.get("redaTypeCode"));
			rd1.set("warTypeCode", rd2.get("warTypeCode"));
			rd1.set("bank", rd2.get("bank"));
			rd1.set("accountName", rd2.get("accountName"));
			rd1.set("accountCode", rd2.get("accountCode"));
			rd1.set("insanityFlag", rd2.get("insanityFlag"));
			rd1.set("oldLonelyFlag", rd2.get("oldLonelyFlag"));
			rd1.set("orphanFlag", rd2.get("orphanFlag"));
			rd1.set("workAbilityCode", rd2.get("workAbilityCode"));
			rd1.set("workAbilityDescribe", rd2.get("workAbilityDescribe"));
			rd1.set("viabilityCode", rd2.get("viabilityCode"));
			rd1.set("supportPattern", rd2.get("supportPattern"));
			rd1.set("jobStatusDescribe", rd2.get("jobStatusDescribe"));
			rd1.set("demobilizedStateCode", rd3.get("demobilizedStateCode"));
			String demobilizedNo=rd3.get("demobilizedNo").toString();
			rd1.set("demobilizedNo", rd3.get("demobilizedNo"));
			
			rd1.set("ingoingReason", rd4.get("ingoingReason"));
			rd1.set("allowanceMonth", rd4.get("allowanceMonth"));
			rd1.set("ingoingAddress", rd4.get("ingoingAddress"));
		}
		DataSet ds = new DataSet(rd1);
		
		return  ds;
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
