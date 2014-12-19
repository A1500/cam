package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao;
import com.inspur.cams.bpt.base.domain.IBptApplyEmigrationDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @description:优抚人员抚恤关系跨省迁出
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
public class BptApplyEmigrationQueryCommand extends BaseQueryCommand{
	IBptApplyEmigrationDomain bptApplyEmigrationService = ScaComponentFactory.getService(IBptApplyEmigrationDomain.class,
	"BptApplyEmigrationDomain/BptApplyEmigrationDomain");
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	/**
	 *  工作流信息的服务接口
	 */
	IWfProcessBusinessDomain processBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	/**
	 * 伤残人员信息服务接口
	 */
	IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory.getService(IBptPeopleDisabilityDomain.class,
	"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
	
	/**
	 * 获得参试人员服务接口
	 */
	IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory.getService(IBptPeopleTestedDomain.class,"bptPeopleTestedDomain/bptPeopleTestedDomain");
	
	
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return bptApplyEmigrationService.query(pset);
	}
	
	/**
	 * 根据前台传过来的process_Id或者assignmentId,查询审批表信息
	 */
	public DataSet queryById(){
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet() ;
		if(pset.containsKey("APPLY_ID")){
			String applyId = (String)pset.get("APPLY_ID");
			pset.clear();
			pset.setParameter("APPLY_ID", applyId);
			return bptApplyEmigrationService.query(pset);
		}
		if(pset.containsKey("PROCESS_ID")){
			DataSet ds1 = processBusinessService.query(pset);
			String applyId = (String)ds1.getRecord(0).get("businessId");
			pset.clear();
			pset.setParameter("APPLY_ID", applyId);
			return bptApplyEmigrationService.query(pset);
		}else{
			String assignmentId = (String)pset.getParameter("assignmentId");
			String processId = processBusinessService.getProcessId(assignmentId);
			pset.clear();
			pset.setParameter("PROCESS_ID", processId);
			DataSet ds1 = processBusinessService.query(pset);
			String applyId = (String)ds1.getRecord(0).get("businessId");
			pset.remove("PROCESS_ID");
			pset.setParameter("APPLY_ID", applyId);
			ds = bptApplyEmigrationService.query(pset);
		}
		return ds;
	}
	
	/**
	 * 查询未提交的伤残人员抚恤关系跨省迁出人员列表
	 */
	public DataSet queryUnCommiDisaEmigrate(){
		ParameterSet pset = getParameterSet();
		return bptApplyEmigrationService.queryUnCommiDisaEmigrate(pset);
	}
	
	/**
	 * 查询伤残人员抚恤关系跨省迁出修改时的记录
	 */
	public DataSet queryDisaUpdateRecord(){
		String applyId = getParameter("APPLY_ID").toString();
		String peoleId = getParameter("PEOPLE_ID").toString();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("PEOPLE_ID", peoleId);
		
		DataSet peopleDataSet = service.queryPeople(pset);
		
		peopleDataSet.addField("disabilityTypeCode"); 
		peopleDataSet.addField("disabilityCaseCode");
		peopleDataSet.addField("disabilityLevelCode");
		peopleDataSet.addField("ingoingAddress");
		peopleDataSet.addField("allowanceMonth");
		peopleDataSet.addField("townCheckPhone");
		Record peopleRecord = peopleDataSet.getRecord(0);
			//通过优抚信息表获得伤残类型
			DataSet bptDataSet = service.queryBptPeople(pset);
			String disabilityTypeCode = bptDataSet.getRecord(0).get("disabilityTypeCode").toString();
			//查询伤残性质和伤残等级
			DataSet disabilityDataSet = disabilityService.queryBptPeopleDisability(pset);
			String disabilityCaseCode = disabilityDataSet.getRecord(0).get("disabilityCaseCode").toString();
			String disabilityLevelCode = disabilityDataSet.getRecord(0).get("disabilityLevelCode").toString();
			//查询迁入地民政局名称和抚恤金发放至月份
			pset.clear();
			pset.setParameter("APPLY_ID", applyId);
			DataSet disEmigDataSet = bptApplyEmigrationService.query(pset);
			String ingoingAddress = disEmigDataSet.getRecord(0).get("ingoingAddress").toString();
			String allowanceMonth = disEmigDataSet.getRecord(0).get("allowanceMonth").toString();
			if(disEmigDataSet.getRecord(0).get("townCheckPhone")!=null){
				String townCheckPhone = disEmigDataSet.getRecord(0).get("townCheckPhone").toString();
				peopleRecord.set("townCheckPhone",townCheckPhone);
			}
			peopleRecord.set("disabilityTypeCode",disabilityTypeCode);
			peopleRecord.set("disabilityCaseCode",disabilityCaseCode);
			peopleRecord.set("disabilityLevelCode",disabilityLevelCode);
			peopleRecord.set("ingoingAddress",ingoingAddress);
			peopleRecord.set("allowanceMonth",allowanceMonth);
		return new DataSet(peopleRecord);
	}
	
	/**
	 * 查询未提交的三属人员抚恤关系跨省迁出人员列表
	 * 
	 */
	public DataSet queryUncommitDependent() {
		ParameterSet pset = getParameterSet();
		return bptApplyEmigrationService.queryUncommitDependent(pset);
	}
	
	/**
	 * 查询三属人员抚恤关系跨省迁出人员详细信息
	 * @return
	 */
	public DataSet queryDependentInfo() {
		ParameterSet pset = getParameterSet();
		DataSet depEmigDataSet = bptApplyEmigrationService.query(pset); //三属人员抚恤关系跨省迁出信息
		Record record = depEmigDataSet.getRecord(0);
		String peopleId = (String)record.get("peopleId");
		
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		DataSet basePeopleDs = service.queryPeople(pset); //查询人员基本信息
		DataSet bptDenpendPeopleDs = service.queryDependantInfo(pset); //查询三属人员基本信息
		DataSet bptPeopleDs = service.queryBptPeople(pset);//查询优抚信息
		
		record.set("name", basePeopleDs.getRecord(0).get("name"));
		record.set("sex", basePeopleDs.getRecord(0).get("sex"));
		record.set("idCard", basePeopleDs.getRecord(0).get("idCard"));
		record.set("dependantNo", basePeopleDs.getRecord(0).get("dependantNo"));
		record.set("dependantTypeCode", bptPeopleDs.getRecord(0).get("dependantTypeCode"));
		record.set("relationship", bptDenpendPeopleDs.getRecord(0).get("relationship"));
		return depEmigDataSet;
	}
//****************************************参战跨省迁出****************************************************
	
	/**
	 * 查询未提交的参战人员抚恤关系跨省迁出人员列表
	 * @return
	 */
	public DataSet queryUnComWarEmigrate(){
		ParameterSet pset = super.getParameterSet();
		return bptApplyEmigrationService.queryUnComWarEmigrate(pset);
	}
	/**
	 * 查询参战省内迁移审批修改时的记录
	 */
	@Trans
	@SuppressWarnings("unchecked")
	public DataSet queryWarUpdateRecord(){
		String applyId = getParameter("APPLY_ID").toString();
		String peoleId = getParameter("PEOPLE_ID").toString();
		ParameterSet pset = new ParameterSet();
		
		pset.setParameter("APPLY_ID", applyId);
		DataSet disEmigDataSet = bptApplyEmigrationService.query(pset);
		disEmigDataSet.addField("idCard");
		disEmigDataSet.addField("name");
		disEmigDataSet.addField("sex");
		disEmigDataSet.addField("warTypeCode");
		disEmigDataSet.addField("forcesNo");
		disEmigDataSet.addField("position");
		disEmigDataSet.addField("asdpNo");
		Record provinceEmigrateRd = disEmigDataSet.getRecord(0);
		pset.clear();
		pset.setParameter("peopleId", peoleId);
		Record peopleRd = bptApplyEmigrationService.queryWarDetailByPeopleId(pset).getRecord(0);
			String name = peopleRd.get("NAME").toString();
			String idCard = peopleRd.get("ID_CARD").toString();
			String sex = peopleRd.get("SEX").toString();
			if(peopleRd.get("WAR_TYPE_CODE") !=null) {
				String warTypeCode = peopleRd.get("WAR_TYPE_CODE").toString();
				provinceEmigrateRd.set("warTypeCode",warTypeCode);
			}
			if(peopleRd.get("FORCES_NO")!=null) {
				String forcesNo = peopleRd.get("FORCES_NO").toString();
				provinceEmigrateRd.set("forcesNo",forcesNo);
			}
			if(peopleRd.get("POSITION")!=null) {
				String position = peopleRd.get("POSITION").toString();
				provinceEmigrateRd.set("position",position);
			}
			if(peopleRd.get("ASDP_NO")!=null) {
				String asdpNo = peopleRd.get("ASDP_NO").toString();
				provinceEmigrateRd.set("asdpNo",asdpNo);
			}
			provinceEmigrateRd.set("idCard",idCard);
			provinceEmigrateRd.set("name",name);
			provinceEmigrateRd.set("sex",sex);
		DataSet resultDs = new DataSet(provinceEmigrateRd);
		return resultDs;
	}
	
	
	/**
	 * 查询未提交的参试人员跨省迁出列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitTested() {
		ParameterSet pset = getParameterSet();
		return bptApplyEmigrationService.queryUncommitTested(pset);
	}
	
	
	/**
	 *  查询参试人员跨省迁出详细信息
	 * @return
	 */
	public DataSet queryTestedInfo() {
		ParameterSet pset = getParameterSet();
		DataSet TestedEmigDataSet = bptApplyEmigrationService.query(pset); //参试人员抚恤关系跨省迁出信息
		if(TestedEmigDataSet.getCount() != 0) {
			Record record = TestedEmigDataSet.getRecord(0);
			String peopleId = (String)record.get("peopleId");
			pset.clear();
			
			pset.setParameter("PEOPLE_ID", peopleId);
			DataSet basePeopleDs = service.queryPeople(pset); //查询人员基本信息
			DataSet testedDs = bptPeopleTestedService.queryPeopleTested(pset); //查询参试人员基本信息
			if(testedDs.getCount() !=0 && basePeopleDs.getCount() != 0) {
				record.set("name", basePeopleDs.getRecord(0).get("name"));
				record.set("sex", basePeopleDs.getRecord(0).get("sex"));
				record.set("idCard", basePeopleDs.getRecord(0).get("idCard"));
				record.set("warNo", basePeopleDs.getRecord(0).get("warNo"));
				record.set("testedType", testedDs.getRecord(0).get("testedType"));
				record.set("position", testedDs.getRecord(0).get("position"));
			}
		}
		return TestedEmigDataSet;
	}
	
	/**
	 *  查询平反人员跨省迁出详细信息
	 * @return
	 */
	public DataSet queryMartyInfo() {
		ParameterSet pset = getParameterSet();
		DataSet mEmigDataSet = bptApplyEmigrationService.query(pset); 
		if(mEmigDataSet.getCount() != 0) {
			Record record = mEmigDataSet.getRecord(0);
			String peopleId = (String)record.get("peopleId");
			pset.clear();
			
			pset.setParameter("PEOPLE_ID", peopleId);
			DataSet basePeopleDs = service.queryPeople(pset); //查询人员基本信息
			IBptPeopleMartyrOffspringDomain martyrOffspringDomain = (IBptPeopleMartyrOffspringDomain)ScaComponentFactory.getService(IBptPeopleMartyrOffspringDomain.class, "bptPeopleMartyrOffspringDomain/bptPeopleMartyrOffspringDomain");
			DataSet mDs = martyrOffspringDomain.query(pset); 
			if(mDs.getCount() !=0 && basePeopleDs.getCount() != 0) {
				Record recordMarty = mDs.getRecord(0);
				record.set("name", basePeopleDs.getRecord(0).get("name"));
				record.set("sex", basePeopleDs.getRecord(0).get("sex"));
				record.set("idCard", basePeopleDs.getRecord(0).get("idCard"));
				record.set("lezswApproveDate", recordMarty.get("lezswApproveDate"));
				record.set("statusType", recordMarty.get("statusType"));
				record.set("lezswName", recordMarty.get("lezswName"));
				
				String ingoingCode = (String)record.get("ingoingCode");
				record.set("ingoingName", BptApplyEmigrationCommand.queryDomicileCodeName(ingoingCode));
			}
		}
		return mEmigDataSet;
	}
	/**
	 *  查询60岁退役士兵跨省迁出详细信息
	 * @return
	 */
	public DataSet querySoldierInfo() {
		ParameterSet pset = getParameterSet();
		DataSet mEmigDataSet = bptApplyEmigrationService.query(pset); 
		if(mEmigDataSet.getCount() != 0) {
			Record record = mEmigDataSet.getRecord(0);
			String peopleId = (String)record.get("peopleId");
			pset.clear();
			
			pset.setParameter("PEOPLE_ID", peopleId);
			DataSet basePeopleDs = service.queryPeople(pset); //查询人员基本信息
			BptCountRetiredSoldierDao dao = (BptCountRetiredSoldierDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptCountRetiredSoldierDao");
			DataSet mDs = dao.query(pset); 
			if(mDs.getCount() !=0 && basePeopleDs.getCount() != 0) {
				Record recordMarty = mDs.getRecord(0);
				record.set("name", basePeopleDs.getRecord(0).get("name"));
				record.set("sex", basePeopleDs.getRecord(0).get("sex"));
				record.set("idCard", basePeopleDs.getRecord(0).get("idCard"));
				record.set("conscriptDate", recordMarty.get("conscriptDate"));
				record.set("decruitmentDate", recordMarty.get("decruitmentDate"));
				record.set("retiredNo", recordMarty.get("retiredNo"));
				record.set("forcesName", recordMarty.get("forcesName"));
				record.set("forcesNo", recordMarty.get("forcesNo"));
				record.set("soldierStartDate", recordMarty.get("soldierStartDate"));
				record.set("soldierEndDate", recordMarty.get("soldierEndDate"));
				record.set("soldierYears", recordMarty.get("soldierYears"));
				
				String ingoingCode = (String)record.get("ingoingCode");
				record.set("ingoingName", BptApplyEmigrationCommand.queryDomicileCodeName(ingoingCode));
			}
		}
		return mEmigDataSet;
	}
	/**
	 * 查询其他抚恤关系跨省迁出
	 * @return
	 */
	public DataSet queryEmigration() {
		ParameterSet pset = getParameterSet();
		return bptApplyEmigrationService.queryEmigration(pset);
	}
	
	public static void main(String[] args) {
		Integer i = new Integer(5);
		Integer i1 = new Integer(5);
		System.out.println(i==i1);
	}
}
