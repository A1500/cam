package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.dao.IBptPeopleTestedDao;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.support.BptPeopleTestedDomain;
import com.inspur.cams.bpt.dichealth.dao.DicHealth;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptPeopleTestedQueryCommand
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
 */
public class BptPeopleTestedQueryCommand extends BaseQueryCommand {
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");

	/**
	 * 获得参试人员服务接口
	 */
	IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory
			.getService(IBptPeopleTestedDomain.class,
					"bptPeopleTestedDomain/bptPeopleTestedDomain");

	public DataSet queryPeople() {
		ParameterSet pset = getParameterSet();
		return service.queryTested(pset);

	}

	public DataSet queryEmployment() {
		IBptPeopleTestedDao testedDao = (IBptPeopleTestedDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleTestedDao");
		return testedDao.getEmployment();
	}

	

	/**
	 * 查询参试人员信息和优抚人员信息
	 * 
	 * @return
	 */
	public DataSet queryPeopleTestedInfo(){
		IBptPeopleTestedDomain testService = ScaComponentFactory.getService(BptPeopleTestedDomain.class, "bptPeopleTestedDomain/bptPeopleTestedDomain");
		ParameterSet pset = getParameterSet();
		
		String peopleId = (String)pset.getParameter("PEOPLE_ID");

		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
		DataSet testedDataSet = testService.queryPeopleTested(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataSet = service.queryPeople(pset);
		

		testedDataSet.addField("bank");
		testedDataSet.addField("accountName");
		testedDataSet.addField("accountCode");
		testedDataSet.addField("insanityFlag");
		testedDataSet.addField("supportPattern");
		testedDataSet.addField("oldLonelyFlag");
		testedDataSet.addField("orphanFlag");
		testedDataSet.addField("workAbilityCode");
		testedDataSet.addField("viabilityCode");
		testedDataSet.addField("workAbilityDescribe");
		testedDataSet.addField("jobStatusDescribe");
		testedDataSet.addField("warStateCode");
		testedDataSet.addField("warNo");
		testedDataSet.addField("approveDate");
		Record rd1 = new Record();
		if(testedDataSet.getCount()>0){
			rd1 = testedDataSet.getRecord(0);
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataSet.getRecord(0);
			String healthStateCode = queryHealthInfo((String)rd1.get("healthStateCode"));
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
			rd1.set("healthStateName",healthStateCode);
		}
		
		DataSet ds = new DataSet(rd1);
		
		return  ds;
	}

	/**
	 * 查询未提交的参试人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommitTest() {
		ParameterSet pset = getParameterSet();
		BptPeopleTestedDomain testService = ScaComponentFactory.getService(
				BptPeopleTestedDomain.class,
				"bptPeopleTestedDomain/bptPeopleTestedDomain");
		return testService.queryUnCommitTest(pset);
	}

	/**
	 * 通过id_card查询参试人员信息
	 * 
	 * @return
	 */
	public DataSet queryByIdCard() {
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();
		DataSet basepeopleDs = service.queryPeople(pset); // 人员基本信息
		if (basepeopleDs.getCount() != 0) {
			Record record = (Record) basepeopleDs.getRecord(0);

			pset.clear();
			pset.setParameter("PEOPLE_ID", record.get("peopleId"));
			DataSet testDs = bptPeopleTestedService.queryPeopleTested(pset); // 参试人员基本信息
			if (testDs.getCount() != 0) {
				Record testRecord = testDs.getRecord(0);
				record.set("testedType", testRecord.get("testedType"));
				record.set("position", testRecord.get("position"));
				ds.add(record);
			}

		}
		return ds;
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
	public DataSet queryTongJiTested(){
		ParameterSet pset = getParameterSet();
		return service.queryTongJiTested(pset);
	}
}
