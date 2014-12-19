package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.data.BptPhysicalExamination;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.support.BptPeopleTestedDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * @title:BptPhysicalExaminationQueryCommand
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
 */
public class BptPhysicalExaminationQueryCommand extends BaseQueryCommand {
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptPhysicalExamination> dao = (EntityDao<BptPhysicalExamination>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");
		return dao.query(pset);
	}

	public DataSet queryInfo() {
		
		String peopleId = (String) getParameter("peopleId");
		String applyId = (String)getParameter("applyId");
		String serviceType = (String) getParameter("serviceType");
		EntityDao<BptPhysicalExamination> dao = (EntityDao<BptPhysicalExamination>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPhysicalExaminationDao");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("APPLY_ID",applyId);
		Record phyRecord = new Record();
		DataSet phyDs = dao.query(pset);
		if (phyDs.getCount() > 0) {
			phyRecord = phyDs.getRecord(0);
		}
		DataSet ds = queryPeopleInfo(serviceType,peopleId);
		Record rd = ds.getRecord(0);

		String name = (String) rd.get("name");
		String sex = (String) rd.get("sex");
		String birthday = (String) rd.get("birthday");
		String idCard = (String) rd.get("idCard");
		peopleId = (String) rd.get("peopleId");
		String address = (String) rd.get("address");
		String conscriptDate = (String) rd.get("conscriptDate");
		String decruitmentDate = (String) rd.get("decruitmentDate");
		String veteransDate = (String) rd.get("veteransDate");
		String asdpNo = (String) rd.get("asdpNo");
		//String forcesNo = (String) rd.get("forcesNo");
		
		phyRecord.set("name", name);
		phyRecord.set("sex", sex);
		phyRecord.set("birthday", birthday);
		phyRecord.set("idCard", idCard);
		phyRecord.set("peopleId", peopleId);
		phyRecord.set("address", address);
		phyRecord.set("conscriptDate", conscriptDate);
		phyRecord.set("decruitmentDate", decruitmentDate);
		phyRecord.set("veteransDate", veteransDate);
		phyRecord.set("asdpNo", asdpNo);
		//phyRecord.set("forcesNo", forcesNo);
		phyRecord.set("decruitmentDate", decruitmentDate);
		
		if ((String) rd.get("forcesNo") != null
				&& !"".equals((String) rd.get("forcesNo"))) {
			String forcesNo = (String) rd.get("forcesNo");
			phyRecord.set("forcesNo", forcesNo);
		}
		
		if ((String) rd.get("postCode") != null
				&& !"".equals((String) rd.get("postCode"))) {
			String postCode = (String) rd.get("postCode");
			phyRecord.set("postCode", postCode);
		}
		if ((String) rd.get("workUnitName") != null
				&& !"".equals((String) rd.get("workUnitName"))) {
			String workUnitName = (String) rd.get("workUnitName");
			phyRecord.set("workUnitName", workUnitName);
		}
		if ((String) rd.get("telMobile") != null
				&& !"".equals((String) rd.get("telMobile"))) {
			String telMobile = (String) rd.get("telMobile");
			phyRecord.set("telMobile", telMobile);
		}
		if ((String) rd.get("domicileAddress") != null
				&& !"".equals((String) rd.get("domicileAddress"))) {
			String domicileAddress = (String) rd.get("domicileAddress");
			phyRecord.set("domicileAddress", domicileAddress);
		}

		return new DataSet(phyRecord);
	}

	/**
	 * 查询人员信息
	 * 
	 * @return
	 */
	public DataSet queryPeopleInfo(String serviceType,String peopleId) {
		ParameterSet pset1 = new ParameterSet();
		pset1.setParameter("PEOPLE_ID",peopleId);
		DataSet peopleDataSet = service.queryPeople(pset1);
		DataSet demobilizedIllnessDataSet = new DataSet() ;
		
		if("45".equals(serviceType)) {//带病回乡
			//获取带病回乡service
			IBptPeopleDemobilizedIllnessDomain demobilizedIllnessService = ScaComponentFactory.getService(IBptPeopleDemobilizedIllnessDomain.class,
			"demobilizedIllnessDomain/demobilizedIllnessDomain");
			DataSet demIllnessDataSet = demobilizedIllnessService.query(pset1);
			demobilizedIllnessDataSet = demIllnessDataSet;
		} else if ("11".equals(serviceType)) {//伤残
			//获取伤残类别信息service
			IBptGroupDomain disService = ScaComponentFactory.getService(IBptGroupDomain.class,
			"bptGroupDomain/bptGroupDomain");
			DataSet disableDataSet = disService.queryDisabilityInfo(pset1);
			demobilizedIllnessDataSet = disableDataSet;
		} else if ("61".equals(serviceType)) {//参试
			//获取参试的类别信息Service
			IBptPeopleTestedDomain testService = ScaComponentFactory.getService(BptPeopleTestedDomain.class, "bptPeopleTestedDomain/bptPeopleTestedDomain");
			DataSet testedDataSet = testService.queryPeopleTested(pset1);
			demobilizedIllnessDataSet = testedDataSet;
		}
		// if(peopleDataSet.getCount()==1){
		ArrayList list = new ArrayList();

		peopleDataSet.addField("domicileName");
		peopleDataSet.addField("apanageName");

		for (int i = 0; i < peopleDataSet.getCount(); i++) {
			Record peopleRecord = peopleDataSet.getRecord(i);
			EntityDao<DicCity> dao = (EntityDao<DicCity>) DaoFactory
					.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			Record demIllnessRecord = demobilizedIllnessDataSet.getRecord(0);
			//获取入伍时间
			if (demIllnessRecord.get("conscriptDate") !=null && demIllnessRecord.get("conscriptDate") !=""){
				String conscriptDate = (String) demIllnessRecord.get("conscriptDate");
				peopleRecord.set("conscriptDate", conscriptDate);
			}
			//获取参试入伍时间
			if (demIllnessRecord.get("conscriptcDate") !=null && demIllnessRecord.get("conscriptcDate") !=""){
				String conscriptcDate = (String) demIllnessRecord.get("conscriptcDate");
				peopleRecord.set("conscriptDate", conscriptcDate);
			}
			//获取退伍时间
			if (demIllnessRecord.get("veteransDate") !=null && demIllnessRecord.get("veteransDate") !=""){
				String veteransDate = (String) demIllnessRecord.get("veteransDate");
				peopleRecord.set("veteransDate", veteransDate);
			}
			//获取伤残、参试退伍时间
			if (demIllnessRecord.get("decruitmentDate") !=null && demIllnessRecord.get("decruitmentDate") !=""){
				String decruitmentDate = (String) demIllnessRecord.get("decruitmentDate");
				peopleRecord.set("decruitmentDate", decruitmentDate);
			}
			//获取退伍证号
			if (demIllnessRecord.get("asdpNo") !=null && demIllnessRecord.get("asdpNo") !=""){
				String asdpNo = (String) demIllnessRecord.get("asdpNo");
				peopleRecord.set("asdpNo", asdpNo);
			}
			//获取原部队番号
			if (demIllnessRecord.get("forcesNo") !=null && demIllnessRecord.get("forcesNo") !=""){
				String forcesNo = (String) demIllnessRecord.get("forcesNo");
				peopleRecord.set("forcesNo", forcesNo);
			}
			// 获取domicileName
			if (peopleRecord.get("domicileCode") != null
					&& peopleRecord.get("domicileCode") != "") {
				String domicileCode = peopleRecord.get("domicileCode")
						.toString();
				pset1.clear();
				pset1.setParameter("ID", domicileCode);
				DataSet domicileCodeDataSet = dao.query(pset1);
				Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
				String domicileName = (String) domicileCodeRecord
						.get("fullName");
				peopleRecord.set("domicileName", domicileName);
			}

			// 获取apanageName
			if (peopleRecord.get("apanageCode") != null
					&& peopleRecord.get("apanageCode") != "") {
				String apanageCode = peopleRecord.get("apanageCode").toString();
				pset1.clear();
				pset1.setParameter("ID", apanageCode);
				DataSet apanageCodeDataSet = dao.query(pset1);
				Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
				String apanageName = apanageCodeRecord.get("fullName")
						.toString();
				peopleRecord.set("apanageName", apanageName);
			}
			list.add(peopleRecord);
		}

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(list);
		ds.setTotalCount(list.size());
		return ds;
	}
}
