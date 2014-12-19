package com.inspur.cams.bpt.manage.cmd;

import org.jfree.data.general.Dataset;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.data.DicCity;

public class BptApplyDemobilizedQueryCommand extends BaseQueryCommand{
	
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	
	
	/**  
	 * 在乡复员军人服务接口
	 */
	IBptPeopleDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
	"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
	
	/**
	 * 在乡复员人员信息服务接口
	 */
	IBptApplyDemobilizedDomain applyDemobilizedService = ScaComponentFactory.getService(IBptApplyDemobilizedDomain.class,
	"bptApplyDemobilizedDomain/bptApplyDemobilizedDomain");
	
	
	IBptApplyEmigrationDomain bptApplyEmigrationService = ScaComponentFactory.getService(IBptApplyEmigrationDomain.class,
	"BptApplyEmigrationDomain/BptApplyEmigrationDomain");
	/**
	 * 查询调残、换证（补证）、证件变更人员信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryAdjustDisability(){
		ParameterSet pset = getParameterSet();
		
		DataSet applydemobilizedDataSet = applyDemobilizedService.query(pset);
		Record applyDemobilizedRecord = applydemobilizedDataSet.getRecord(0);
		
		applydemobilizedDataSet.addField("familyId");
		applydemobilizedDataSet.addField("name");
		applydemobilizedDataSet.addField("sex");
		applydemobilizedDataSet.addField("idCard");
		applydemobilizedDataSet.addField("nation");
		applydemobilizedDataSet.addField("birthday");
		applydemobilizedDataSet.addField("address");
		applydemobilizedDataSet.addField("apanageName");
		applydemobilizedDataSet.addField("conscriptDate");
		applydemobilizedDataSet.addField("decruitmentDate");
		applydemobilizedDataSet.addField("position");
		applydemobilizedDataSet.addField("isKoeanwar");
		applydemobilizedDataSet.addField("belongDate");
		applydemobilizedDataSet.addField("demobilizedNo");
		
		String peopleId = applyDemobilizedRecord.get("peopleId").toString();
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		
		//查询人员信息
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord = peopleDataSet.getRecord(0);
		//查询za信息表中的信息
		DataSet disabilityDataSet = demobilizedService.query(pset);
		Record demobilizedRecord = disabilityDataSet.getRecord(0);
		
		//通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("apanageCode").toString());
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = apanageCodeRecord.get("name").toString();
		
		applyDemobilizedRecord.set("familyId", peopleRecord.get("familyId").toString());
		applyDemobilizedRecord.set("name", peopleRecord.get("name").toString());
		applyDemobilizedRecord.set("sex", peopleRecord.get("sex").toString());
		applyDemobilizedRecord.set("idCard", peopleRecord.get("idCard").toString());
		applyDemobilizedRecord.set("nation", peopleRecord.get("nation").toString());
		applyDemobilizedRecord.set("birthday", peopleRecord.get("birthday").toString());
		applyDemobilizedRecord.set("apanageName", apanageName);
		applyDemobilizedRecord.set("conscriptDate", demobilizedRecord.get("conscriptDate").toString());
		if(peopleRecord.get("address") != null){
			applyDemobilizedRecord.set("address", peopleRecord.get("address").toString());
		}
		if(peopleRecord.get("demobilizedNo") != null){
			applyDemobilizedRecord.set("demobilizedNo", peopleRecord.get("demobilizedNo").toString());
		}
		if(demobilizedRecord.get("decruitmentDate") != null){
			applyDemobilizedRecord.set("decruitmentDate", demobilizedRecord.get("decruitmentDate").toString());
		}
		if(demobilizedRecord.get("position") != null){
			applyDemobilizedRecord.set("position", demobilizedRecord.get("position").toString());
		}
		if(demobilizedRecord.get("isKoeanwar") != null){
			applyDemobilizedRecord.set("isKoeanwar", demobilizedRecord.get("isKoeanwar").toString());
		}
		if(demobilizedRecord.get("belongDate") != null){
			applyDemobilizedRecord.set("belongDate", demobilizedRecord.get("belongDate").toString());
		}
		return new DataSet(applyDemobilizedRecord);
	}
	public DataSet queryDemobilizedPeopleList(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryDemobilizedPeopleList(pset);
		
		
	}
	public DataSet queryDemoEmigrationPeopleList(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryDemoEmigrationPeopleList(pset);
	}
	/**
	 * 查询伤残人员抚恤关系跨省迁出修改时的记录
	 */
	public DataSet queryDemoUpdateRecord(){
		String applyId = getParameter("APPLY_ID").toString();
		String peoleId = getParameter("PEOPLE_ID").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peoleId);
		//查询人员信息
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord2 = peopleDataSet.getRecord(0);
		//查询信息表中的信息
		DataSet peopleDataSet1 = demobilizedService.query(pset);
		//查询信息表中的信息
		DataSet disabilityDataSet = demobilizedService.query(pset);
		Record demobilizedRecord = disabilityDataSet.getRecord(0);
		//通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord2.get("apanageCode").toString());
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = apanageCodeRecord.get("name").toString();

		peopleDataSet.addField("familyId");
		peopleDataSet.addField("name");
		peopleDataSet.addField("sex");
		peopleDataSet.addField("idCard");
		peopleDataSet.addField("nation");
		peopleDataSet.addField("birthday");
		peopleDataSet.addField("ingoingAddress");
		peopleDataSet.addField("allowanceMonth");
		peopleDataSet.addField("townCheckPhone");
		Record peopleRecord1 = peopleDataSet1.getRecord(0);
			//查询迁入地民政局名称和抚恤金发放至月份
			pset.clear();
			pset.setParameter("APPLY_ID", applyId);
			DataSet disEmigDataSet = bptApplyEmigrationService.query(pset);
			String ingoingAddress = disEmigDataSet.getRecord(0).get("ingoingAddress").toString();
			String allowanceMonth = disEmigDataSet.getRecord(0).get("allowanceMonth").toString();
			peopleRecord1.set("familyId", peopleRecord2.get("familyId").toString());
			peopleRecord1.set("name", peopleRecord2.get("name").toString());
			peopleRecord1.set("sex", peopleRecord2.get("sex").toString());
			peopleRecord1.set("idCard", peopleRecord2.get("idCard").toString());
			peopleRecord1.set("nation", peopleRecord2.get("nation").toString());
			peopleRecord1.set("birthday", peopleRecord2.get("birthday").toString());
			peopleRecord1.set("apanageName", apanageName);
			peopleRecord1.set("conscriptDate", demobilizedRecord.get("conscriptDate").toString());
			if(demobilizedRecord.get("decruitmentDate") != null){
				peopleRecord1.set("decruitmentDate", demobilizedRecord.get("decruitmentDate").toString());
			}
			if(demobilizedRecord.get("position") != null){
				peopleRecord1.set("position", demobilizedRecord.get("position").toString());
			}
			if(demobilizedRecord.get("isKoeanwar") != null){
				peopleRecord1.set("isKoeanwar", demobilizedRecord.get("isKoeanwar").toString());
			}
			if(demobilizedRecord.get("belongDate") != null){
				peopleRecord1.set("belongDate", demobilizedRecord.get("belongDate").toString());
			}
			if(peopleRecord2.get("address") != null){
				peopleRecord1.set("address", peopleRecord2.get("address").toString());
			}
			if(peopleRecord2.get("demobilizedNo") != null){
				peopleRecord1.set("demobilizedNo", peopleRecord2.get("demobilizedNo").toString());
			}
			if(disEmigDataSet.getRecord(0).get("townCheckPhone")!=null){
				String townCheckPhone = disEmigDataSet.getRecord(0).get("townCheckPhone").toString();
				peopleRecord1.set("townCheckPhone",townCheckPhone);
			}
			peopleRecord1.set("ingoingAddress",ingoingAddress);
			peopleRecord1.set("allowanceMonth",allowanceMonth);
		return new DataSet(peopleRecord1);
	}
	public DataSet queryIllEmigrationPeopleList(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryIllEmigrationPeopleList(pset);
	}
	/**
	 * 查询在乡人员抚恤关系跨省迁出修改时的记录
	 */
	public DataSet queryIllUpdateRecord(){
		String applyId = getParameter("APPLY_ID").toString();
		String peoleId = getParameter("PEOPLE_ID").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peoleId);
		//查询人员信息
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord2 = peopleDataSet.getRecord(0);
		//查询信息表中的信息
		DataSet peopleDataSet1 = demobilizedService.query(pset);
		//查询信息表中的信息
		DataSet disabilityDataSet = demobilizedService.query(pset);
		Record demobilizedRecord = disabilityDataSet.getRecord(0);
		//通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord2.get("apanageCode").toString());
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = apanageCodeRecord.get("name").toString();

		peopleDataSet.addField("familyId");
		peopleDataSet.addField("name");
		peopleDataSet.addField("sex");
		peopleDataSet.addField("idCard");
		peopleDataSet.addField("nation");
		peopleDataSet.addField("birthday");
		peopleDataSet.addField("ingoingAddress");
		peopleDataSet.addField("allowanceMonth");
		peopleDataSet.addField("townCheckPhone");
		Record peopleRecord1 = peopleDataSet1.getRecord(0);
			//查询迁入地民政局名称和抚恤金发放至月份
			pset.clear();
			pset.setParameter("APPLY_ID", applyId);
			DataSet disEmigDataSet = bptApplyEmigrationService.query(pset);
			String ingoingAddress = disEmigDataSet.getRecord(0).get("ingoingAddress").toString();
			String allowanceMonth = disEmigDataSet.getRecord(0).get("allowanceMonth").toString();
			peopleRecord1.set("familyId", peopleRecord2.get("familyId").toString());
			peopleRecord1.set("name", peopleRecord2.get("name").toString());
			peopleRecord1.set("sex", peopleRecord2.get("sex").toString());
			peopleRecord1.set("idCard", peopleRecord2.get("idCard").toString());
			peopleRecord1.set("nation", peopleRecord2.get("nation").toString());
			peopleRecord1.set("birthday", peopleRecord2.get("birthday").toString());
			peopleRecord1.set("apanageName", apanageName);
			peopleRecord1.set("conscriptDate", demobilizedRecord.get("conscriptDate").toString());
			if(demobilizedRecord.get("decruitmentDate") != null){
				peopleRecord1.set("decruitmentDate", demobilizedRecord.get("decruitmentDate").toString());
			}
			if(demobilizedRecord.get("position") != null){
				peopleRecord1.set("position", demobilizedRecord.get("position").toString());
			}
			if(demobilizedRecord.get("isKoeanwar") != null){
				peopleRecord1.set("isKoeanwar", demobilizedRecord.get("isKoeanwar").toString());
			}
			if(demobilizedRecord.get("belongDate") != null){
				peopleRecord1.set("belongDate", demobilizedRecord.get("belongDate").toString());
			}
			if(peopleRecord2.get("address") != null){
				peopleRecord1.set("address", peopleRecord2.get("address").toString());
			}
			if(peopleRecord2.get("demobilizedNo") != null){
				peopleRecord1.set("demobilizedNo", peopleRecord2.get("demobilizedNo").toString());
			}
			if(disEmigDataSet.getRecord(0).get("townCheckPhone")!=null){
				String townCheckPhone = disEmigDataSet.getRecord(0).get("townCheckPhone").toString();
				peopleRecord1.set("townCheckPhone",townCheckPhone);
			}
			peopleRecord1.set("ingoingAddress",ingoingAddress);
			peopleRecord1.set("allowanceMonth",allowanceMonth);
		return new DataSet(peopleRecord1);
	}
	public DataSet queryillprovinceEmigrationPeopleList(){
		ParameterSet pset = getParameterSet();
		return demobilizedService.queryillprovinceEmigrationPeopleList(pset);
	}
}
