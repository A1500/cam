package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyIntoprovinceDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * @description:外省优抚人员抚恤关系迁入我省
 * @author:
 * @since:2011-07-14
 * @version:1.0
*/
public class BptApplyIntoprovinceQueryCommand extends BaseQueryCommand{
	/**
	 * 获得【外省优抚人员抚恤关系迁入我省】服务接口
	 */
	private IBptApplyIntoprovinceDomain bptApplyIntoprovinceService = ScaComponentFactory.getService(IBptApplyIntoprovinceDomain.class,
	"BptApplyIntoprovinceDomain/BptApplyIntoprovinceDomain");
	
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
	 * 在乡复员军人服务接口
	 */
	IBptPeopleDemobilizedDomain demobilizedService = ScaComponentFactory.getService(IBptPeopleDemobilizedDomain.class,
	"bptPeopleDemobilizedDomain/bptPeopleDemobilizedDomain");
	
	
	IBptPeopleDemobilizedIllnessDomain demobilizedIllnessService = ScaComponentFactory.getService(IBptPeopleDemobilizedIllnessDomain.class,
	"demobilizedIllnessDomain/demobilizedIllnessDomain");
	
	/**
	 * 获得参试人员服务接口
	 */
	IBptPeopleTestedDomain bptPeopleTestedService = ScaComponentFactory.getService(IBptPeopleTestedDomain.class,"bptPeopleTestedDomain/bptPeopleTestedDomain");
	
	
	IWarDomain bptPeopleWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
	
	/**
	 * 获得外省迁入我省审批详细信息
	 * @return
	 */
	public DataSet queryApplyInfo() {
		ParameterSet pset = getParameterSet();
		return bptApplyIntoprovinceService.query(pset);
	}
	
	
	/**
	 * 根据前台传过来的process_Id或者assignmentId,查询记录
	 */
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet() ;
		if(pset.containsKey("APPLY_ID")) {
			ds = bptApplyIntoprovinceService.query(pset);
		} else {
			if(pset.containsKey("PROCESS_ID")){
				DataSet ds1 = processBusinessService.query(pset);
				String applyId = (String)ds1.getRecord(0).get("businessId");
				pset.clear();
				pset.setParameter("apply_Id", applyId);
				return bptApplyIntoprovinceService.query(pset);
			}else{
				String assignmentId = (String)pset.getParameter("assignmentId");
				String processId = processBusinessService.getProcessId(assignmentId);
				pset.clear();
				pset.setParameter("PROCESS_ID", processId);
				DataSet ds1 = processBusinessService.query(pset);
				String applyId = (String)ds1.getRecord(0).get("businessId");
				pset.remove("PROCESS_ID");
				pset.setParameter("APPLY_ID", applyId);
				ds = bptApplyIntoprovinceService.query(pset);
			}
		}
		return ds;
	}
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		DataSet ds = bptApplyIntoprovinceService.query(pset);
		return ds;
	}
	/**
	 * 查询外省残疾人员抚恤关系迁入审批表表头信息,根据PROCESS_ID或assignmentId
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryInprovinceApproveHeader(){
		ParameterSet pset = getParameterSet();
		String applyId = "";
		if(pset.containsKey("PROCESS_ID")){
			applyId = processBusinessService.query(pset).getRecord(0).get("businessId").toString();
		}
		if(pset.containsKey("assignmentId")){
			String assignmentId = (String)pset.getParameter("assignmentId");
			String processId = processBusinessService.getProcessId(assignmentId);
			pset.clear();
			pset.setParameter("PROCESS_ID", processId);
			applyId = processBusinessService.query(pset).getRecord(0).get("businessId").toString();
		}
		
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		
		DataSet intoprovinceDataSet = bptApplyIntoprovinceService.query(pset);
		Record intoprovinceRecord = intoprovinceDataSet.getRecord(0);
		intoprovinceDataSet.addField("peopleId");
		intoprovinceDataSet.addField("familyId");
		intoprovinceDataSet.addField("name");
		intoprovinceDataSet.addField("name");
		intoprovinceDataSet.addField("sex");
		intoprovinceDataSet.addField("birthday");
		intoprovinceDataSet.addField("idCard");
		intoprovinceDataSet.addField("domicileName");
		intoprovinceDataSet.addField("telMobile");
		intoprovinceDataSet.addField("disabilityCaseCode");
		intoprovinceDataSet.addField("disabilityLevelCode");
		
		intoprovinceDataSet.addField("conscriptDate");
		intoprovinceDataSet.addField("veteransDate");
		
		String peopleId = intoprovinceRecord.get("peopleId").toString();
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		
		//查询人员信息
		DataSet peopleDataSet = service.queryPeople(pset);
			Record peopleRecord = peopleDataSet.getRecord(0);
		//查询伤残信息表中的信息
		DataSet disabilityDataSet = disabilityService.queryBptPeopleDisability(pset);
			Record disabilityRecord = disabilityDataSet.getRecord(0);
		
		//通过domicileCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("domicileCode").toString());
		DataSet domicileCodeDataSet = dao.query(pset);
		Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
		String domicileName = domicileCodeRecord.get("name").toString();
		
		intoprovinceRecord.set("peopleId", peopleRecord.get("peopleId").toString());
		intoprovinceRecord.set("familyId", peopleRecord.get("familyId").toString());
		intoprovinceRecord.set("name", peopleRecord.get("name").toString());
		intoprovinceRecord.set("sex", peopleRecord.get("sex").toString());
		intoprovinceRecord.set("birthday", peopleRecord.get("birthday").toString());
		intoprovinceRecord.set("idCard", peopleRecord.get("idCard").toString());
		intoprovinceRecord.set("domicileName", domicileName);
		if(peopleRecord.get("telMobile") != null && !peopleRecord.get("telMobile").equals("") ){
			intoprovinceRecord.set("telMobile", peopleRecord.get("telMobile").toString());
		}
		intoprovinceRecord.set("disabilityCaseCode", peopleRecord.get("disabilityCaseCode").toString());
		intoprovinceRecord.set("disabilityLevelCode", peopleRecord.get("disabilityLevelCode").toString());

		intoprovinceRecord.set("conscriptDate",disabilityRecord.get("conscriptDate").toString());
		intoprovinceRecord.set("veteransDate",disabilityRecord.get("veteransDate").toString());
		return new DataSet(intoprovinceRecord);
	}
	
	/**
	 * 查询未提交的外省残疾人员抚恤关系迁入我省信息列表
	 */
	public DataSet queryUnCommitDisaIntoprovi(){
		ParameterSet pset = getParameterSet();
		return bptApplyIntoprovinceService.queryUnCommitDisaIntoprovi(pset);
	}
	
	/**
	 * 查询外省残疾人员抚恤关系迁入我省修改时的DataSet
	 */
	public DataSet queryDisaIntoProvince(){
		ParameterSet pset = getParameterSet();
		DataSet intoProvinceDataSet = bptApplyIntoprovinceService.query(pset);
		pset.remove("APPLY_ID");
		DataSet disabilityDataSet = service.queryDisabilityInfo(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataSet = service.queryPeople(pset);
		
		
		disabilityDataSet.addField("disabilityTypeCode");
		disabilityDataSet.addField("insanityFlag");
		disabilityDataSet.addField("oldLonelyFlag");
		disabilityDataSet.addField("workAbilityCode");
		disabilityDataSet.addField("workAbilityDescribe");
		disabilityDataSet.addField("viabilityCode");
		disabilityDataSet.addField("supportPattern");
		disabilityDataSet.addField("jobStatusDescribe");
		disabilityDataSet.addField("bank");
		disabilityDataSet.addField("accountName");
		disabilityDataSet.addField("accountCode");
		
		disabilityDataSet.addField("disabilityStateCode");
		
		disabilityDataSet.addField("ingoingAddress");
		disabilityDataSet.addField("ingoingReason");
		disabilityDataSet.addField("oldPaperNo");
		disabilityDataSet.addField("allowanceMonth");
		
		Record disaRecord = new Record();
		if(disabilityDataSet.getCount()>0){
			disaRecord = disabilityDataSet.getRecord(0);
			Record bptRecord = bptPeoleDataSet.getRecord(0);
			Record peopleRecord = peopleDataSet.getRecord(0);
			Record intoProvincRd = intoProvinceDataSet.getRecord(0);
			
			disaRecord.set("disabilityTypeCode", bptRecord.get("disabilityTypeCode").toString());
			disaRecord.set("insanityFlag", bptRecord.get("insanityFlag").toString());
			disaRecord.set("oldLonelyFlag", bptRecord.get("oldLonelyFlag").toString());
			disaRecord.set("workAbilityCode", bptRecord.get("workAbilityCode").toString());
			if(bptRecord.get("workAbilityDescribe") != null){
				disaRecord.set("workAbilityDescribe", bptRecord.get("workAbilityDescribe").toString());
			}
			disaRecord.set("viabilityCode", bptRecord.get("viabilityCode").toString());
			disaRecord.set("supportPattern", bptRecord.get("supportPattern").toString());
			if(bptRecord.get("jobStatusDescribe") != null){
				disaRecord.set("jobStatusDescribe", bptRecord.get("jobStatusDescribe").toString());
			}
			if(bptRecord.get("bank") != null){
				disaRecord.set("bank", bptRecord.get("bank").toString());
			}
			if(bptRecord.get("accountName") != null){
				disaRecord.set("accountName", bptRecord.get("accountName").toString());
			}	if(bptRecord.get("accountCode") != null){
				disaRecord.set("accountCode", bptRecord.get("accountCode").toString());
			}
			
			
			
			disaRecord.set("disabilityStateCode", peopleRecord.get("disabilityStateCode").toString());
			
			disaRecord.set("ingoingAddress", intoProvincRd.get("ingoingAddress").toString());
			disaRecord.set("ingoingReason", intoProvincRd.get("ingoingReason").toString());
			disaRecord.set("oldPaperNo", intoProvincRd.get("oldPaperNo").toString());
			disaRecord.set("allowanceMonth", intoProvincRd.get("allowanceMonth").toString());
			disaRecord.set("ingoingCode", intoProvincRd.get("ingoingCode").toString());
		}
		
		DataSet ds = new DataSet(disaRecord);
		
		return  ds;
	}
	
	/**
	 * 查询未提交的三属外省迁入我省信息列表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependIntoprovin() {
		ParameterSet pset = getParameterSet();
		return bptApplyIntoprovinceService.queryUncommitDependIntoprovin(pset);
	}
	
	/**
	 * 查询外省迁入我省三属信息
	 * @return
	 */
	public DataSet queryDependIntoProvice() {
		ParameterSet pset = getParameterSet();
		DataSet ingoingDs = bptApplyIntoprovinceService.query(pset);
		DataSet ds = new DataSet();
		if(ingoingDs.getCount() != 0) {
			Record ingorecord = ingoingDs.getRecord(0);
			pset.clear();
			pset.setParameter("PEOPLE_ID", ingorecord.get("peopleId"));
			
			ds = service.queryDependantInfo(pset);
			if(ds.getCount() != 0) {
				Record record = ds.getRecord(0);
				
				// 审批表信息
				record.set("ingoingCode", ingorecord.get("ingoingCode"));
				record.set("ingoingAddress", ingorecord.get("ingoingAddress"));
				record.set("ingoingReason", ingorecord.get("ingoingReason"));
				record.set("oldPaperNo", ingorecord.get("oldPaperNo"));
				record.set("allowanceMonth", ingorecord.get("allowanceMonth"));
				record.set("serviceType", ingorecord.get("serviceType"));
				
				// 优抚基本信息
				DataSet bptDs = service.queryBptPeople(pset);
				if(bptDs.getCount() != 0) {
					Record bptRecord = bptDs.getRecord(0);
					record.set("dependantTypeCode", bptRecord.get("dependantTypeCode"));
					record.set("bank", bptRecord.get("bank"));
					record.set("accountName", bptRecord.get("accountName"));
					record.set("accountCode", bptRecord.get("accountCode"));
					record.set("oldLonelyFlag", bptRecord.get("oldLonelyFlag"));
					record.set("orphanFlag", bptRecord.get("orphanFlag"));
					record.set("workAbilityCode", bptRecord.get("workAbilityCode"));
					record.set("workAbilityDescribe", bptRecord.get("workAbilityDescribe"));
					record.set("viabilityCode", bptRecord.get("viabilityCode"));
					record.set("supportPattern", bptRecord.get("supportPattern"));
					record.set("jobStatusDescribe", bptRecord.get("jobStatusDescribe"));
				}
				
				// 人员基本信息
				DataSet baseDs = service.queryPeople(pset);
				if(baseDs.getCount() != 0) {
					Record baseRecord = baseDs.getRecord(0);
					record.set("dependantStateCode", baseRecord.get("dependantStateCode"));
					record.set("handicapFlag", baseRecord.get("handicapFlag"));
				}
			}
		}
		return ds;
	}
	//*****************************************参战**************************************************************
	/**
	 * 查询未提交的参战人员抚恤关系跨省迁入人员列表
	 * @return
	 */
	public DataSet queryUnCommitWarIntoprovi(){
		ParameterSet pset = super.getParameterSet();
		return bptApplyIntoprovinceService.queryUnCommitWarIntoprovi(pset);
	}
	/**
	 * 查询人员参战信息和迁入信息
	 * @return
	 */
	public DataSet queryWarDetail(){
		IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
		ParameterSet pset = getParameterSet();
		ParameterSet applyPset = new ParameterSet();
		applyPset = pset;
		String peopleId = (String)pset.getParameter("PEOPLE_ID");
		pset.clear();
		pset.setParameter("PEOPLE_ID@=", peopleId);
		DataSet warDataSet = iWarService.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataSet = service.queryPeople(pset);
		DataSet bptApplyDataSet  = bptApplyIntoprovinceService.query(applyPset);
		
		warDataSet.addField("bank");
		warDataSet.addField("accountName");
		warDataSet.addField("accountCode");
		warDataSet.addField("warNo");
		warDataSet.addField("approveDate");
		warDataSet.addField("insanityFlag");
		warDataSet.addField("supportPattern");
		warDataSet.addField("oldLonelyFlag");
		warDataSet.addField("orphanFlag");
		warDataSet.addField("workAbilityCode");
		warDataSet.addField("viabilityCode");
		warDataSet.addField("workAbilityDescribe");
		warDataSet.addField("jobStatusDescribe");
		warDataSet.addField("warStateCode");
		warDataSet.addField("ingoingReason");
		warDataSet.addField("allowanceMonth");
		warDataSet.addField("ingoingAddress");
		
		Record rd1 = new Record();
		if(warDataSet.getCount()>0){
			rd1 = warDataSet.getRecord(0);
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataSet.getRecord(0);
			Record rd4 = bptApplyDataSet.getRecord(0);
			
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
			rd1.set("ingoingReason", rd4.get("ingoingReason"));
			rd1.set("allowanceMonth", rd4.get("allowanceMonth"));
			rd1.set("ingoingAddress", rd4.get("ingoingAddress"));
			rd1.set("ingoingCode", rd4.get("ingoingCode"));
		}
		
		DataSet ds = new DataSet(rd1);
		
		return  ds;
	}
	/**
	 * 查询外省参战人员抚恤关系迁入审批表表头信息,根据PROCESS_ID或assignmentId
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryInprovinceWarApproveHeader(){
		IWarDomain iWarService = ScaComponentFactory.getService(IWarDomain.class,"bptWarDomain/bptWarDomain");
		ParameterSet pset = getParameterSet();
		String applyId = "";
		if(pset.containsKey("PROCESS_ID")){
			applyId = processBusinessService.query(pset).getRecord(0).get("businessId").toString();
		}
		if(pset.containsKey("assignmentId")){
			String assignmentId = (String)pset.getParameter("assignmentId");
			String processId = processBusinessService.getProcessId(assignmentId);
			pset.clear();
			pset.setParameter("PROCESS_ID", processId);
			applyId = processBusinessService.query(pset).getRecord(0).get("businessId").toString();
		}
		
		pset.clear();
		pset.setParameter("APPLY_ID", applyId);
		
		DataSet intoprovinceDataSet = bptApplyIntoprovinceService.query(pset);
		Record intoprovinceRecord = intoprovinceDataSet.getRecord(0);
		intoprovinceDataSet.addField("peopleId");
		intoprovinceDataSet.addField("familyId");
		intoprovinceDataSet.addField("name");
		intoprovinceDataSet.addField("name");
		intoprovinceDataSet.addField("sex");
		intoprovinceDataSet.addField("birthday");
		intoprovinceDataSet.addField("idCard");
		intoprovinceDataSet.addField("domicileName");
		intoprovinceDataSet.addField("telMobile");
		intoprovinceDataSet.addField("warTypeCode");
		intoprovinceDataSet.addField("forcesNo");
		intoprovinceDataSet.addField("asdpNo");
		intoprovinceDataSet.addField("conscriptDate");
		intoprovinceDataSet.addField("veteransDate");
		
		String peopleId = intoprovinceRecord.get("peopleId").toString();
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		
		//查询人员信息
		DataSet peopleDataSet = service.queryPeople(pset);
			Record peopleRecord = peopleDataSet.getRecord(0);
		//查询参战信息表中的信息
		DataSet warDataSet = iWarService.query(pset);
			Record warRecord = warDataSet.getRecord(0);
		
		//通过domicileCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("domicileCode").toString());
		DataSet domicileCodeDataSet = dao.query(pset);
		Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
		String domicileName = domicileCodeRecord.get("name").toString();
		
		intoprovinceRecord.set("peopleId", peopleRecord.get("peopleId").toString());
		intoprovinceRecord.set("familyId", peopleRecord.get("familyId").toString());
		intoprovinceRecord.set("name", peopleRecord.get("name").toString());
		intoprovinceRecord.set("sex", peopleRecord.get("sex").toString());
		intoprovinceRecord.set("birthday", peopleRecord.get("birthday").toString());
		intoprovinceRecord.set("idCard", peopleRecord.get("idCard").toString());
		intoprovinceRecord.set("domicileName", domicileName);
		if(peopleRecord.get("warTypeCode") != null && !peopleRecord.get("telMobile").equals("") ){
			intoprovinceRecord.set("telMobile", warRecord.get("telMobile").toString());
		}
		if(peopleRecord.get("forcesNo") != null && !peopleRecord.get("telMobile").equals("") ){
			intoprovinceRecord.set("telMobile", warRecord.get("telMobile").toString());
		}
		if(peopleRecord.get("asdpNo") != null && !peopleRecord.get("telMobile").equals("") ){
			intoprovinceRecord.set("telMobile", warRecord.get("telMobile").toString());
		}
		if(warRecord.get("veteransDate") != null && !warRecord.get("veteransDate").equals("") ){
			intoprovinceRecord.set("veteransDate",warRecord.get("veteransDate").toString());
		}
		if(warRecord.get("conscriptDate") != null && !warRecord.get("conscriptDate").equals("") ){
			intoprovinceRecord.set("conscriptDate",warRecord.get("conscriptDate").toString());
		}
		return new DataSet(intoprovinceRecord);
	}
	//*****************************************在乡复员**************************************************************
	/**
	 * 查询在乡复员军人信息和相应的优抚人员信息[用于明细查看页面，需接受peopleId参数]
	 */            
	public DataSet queryDemobilizedBptPeople(){
		
		ParameterSet pset = getParameterSet();
		
		String peopleId = (String)pset.getParameter("peopleId");
		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
		
		DataSet demobilizedDataSet = demobilizedService.query(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataset = service.queryPeople(pset);
		DataSet bptApplyDataSet  = bptApplyIntoprovinceService.query(pset);
		
		
		demobilizedDataSet.addField("demobilizedTypeCode");
		demobilizedDataSet.addField("dependantTypeCode");
		demobilizedDataSet.addField("redaTypeCode");

		demobilizedDataSet.addField("bank");
		demobilizedDataSet.addField("accountName");
		demobilizedDataSet.addField("accountCode");
		demobilizedDataSet.addField("insanityFlag");
		demobilizedDataSet.addField("oldLonelyFlag");
		demobilizedDataSet.addField("orphanFlag");
		demobilizedDataSet.addField("workAbilityCode");
		demobilizedDataSet.addField("workAbilityDescribe");
		demobilizedDataSet.addField("viabilityCode");
		demobilizedDataSet.addField("supportPattern");
		demobilizedDataSet.addField("jobStatusDescribe");
		demobilizedDataSet.addField("oldPaperNo");
		
		demobilizedDataSet.addField("demobilizedStateCode");
		demobilizedDataSet.addField("demobilizedNo");
		demobilizedDataSet.addField("ingoingReason");
		demobilizedDataSet.addField("allowanceMonth");
		demobilizedDataSet.addField("ingoingAddress");
		
		Record rd1=new Record();
		if(demobilizedDataSet.getCount()>0)
		{
		rd1 = demobilizedDataSet.getRecord(0);
		Record rd2 = bptPeoleDataSet.getRecord(0);
		Record rd3 = peopleDataset.getRecord(0);
		Record rd4 = bptApplyDataSet.getRecord(0);
		rd1.set("disabilityTypeCode", rd2.get("demobilizedTypeCode"));
		rd1.set("dependantTypeCode", rd2.get("dependantTypeCode"));
		rd1.set("redaTypeCode", rd2.get("redaTypeCode"));
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
		
		rd1.set("oldPaperNo", rd4.get("oldPaperNo"));
		rd1.set("ingoingReason", rd4.get("ingoingReason"));
		rd1.set("allowanceMonth", rd4.get("allowanceMonth"));
		rd1.set("ingoingAddress", rd4.get("ingoingAddress"));
		rd1.set("ingoingCode", rd4.get("ingoingCode"));
		}
		return new DataSet(rd1);
	}
	
	/**
	 * 查询未提交的外省迁入我省参试抚恤关系列表
	 * 
	 */
	public DataSet queryUncommitTestedIntoprovin() {
		ParameterSet pset = getParameterSet();
		return bptApplyIntoprovinceService.queryUncommitTestedIntoprovin(pset);
	}
	
	/**
	 * 查询外省迁入我省参试信息
	 * @return
	 */
	public DataSet queryTestedIntoProvince() {
		ParameterSet pset = getParameterSet();
		DataSet ingoingDs = bptApplyIntoprovinceService.query(pset);
		DataSet ds = new DataSet();
		if(ingoingDs.getCount() != 0) {
			Record ingorecord = ingoingDs.getRecord(0);
			pset.clear();
			pset.setParameter("PEOPLE_ID", ingorecord.get("peopleId"));
			ds = bptPeopleTestedService.queryPeopleTested(pset);
			
			if(ds.getCount() != 0) {
				Record record = ds.getRecord(0);
				
				// 审批表信息
				record.set("ingoingCode", ingorecord.get("ingoingCode"));
				record.set("ingoingAddress", ingorecord.get("ingoingAddress"));
				record.set("ingoingReason", ingorecord.get("ingoingReason"));
				record.set("oldPaperNo", ingorecord.get("oldPaperNo"));
				record.set("allowanceMonth", ingorecord.get("allowanceMonth"));
				record.set("serviceType", ingorecord.get("serviceType"));
			
				// 优抚基本信息
				DataSet bptDs = service.queryBptPeople(pset);
				if(bptDs.getCount() != 0) {
					Record bptRecord = bptDs.getRecord(0);
					record.set("bank", bptRecord.get("bank"));
					record.set("accountName", bptRecord.get("accountName"));
					record.set("accountCode", bptRecord.get("accountCode"));
					record.set("oldLonelyFlag", bptRecord.get("oldLonelyFlag"));
					record.set("workAbilityCode", bptRecord.get("workAbilityCode"));
					record.set("workAbilityDescribe", bptRecord.get("workAbilityDescribe"));
					record.set("viabilityCode", bptRecord.get("viabilityCode"));
					record.set("supportPattern", bptRecord.get("supportPattern"));
					record.set("jobStatusDescribe", bptRecord.get("jobStatusDescribe"));
					record.set("insanityFlag", bptRecord.get("insanityFlag"));
				}
				 
				
				// 人员基本信息
				DataSet baseDs = service.queryPeople(pset);
				if(baseDs.getCount() != 0) {
					Record baseRecord = baseDs.getRecord(0);
					record.set("warStateCode", baseRecord.get("warStateCode"));
				}
				
				
			
			}
		}
		return ds;
	}
	
	
	/**
	 * 查看外省迁入我省带病回乡信息
	 * @return
	 */
	public DataSet queryIntoDemobilizedIllnessBPTPeople() {
		ParameterSet pset = getParameterSet();
		DataSet ingoingDs = bptApplyIntoprovinceService.query(pset);
		DataSet ds = new DataSet();
		if(ingoingDs.getCount() != 0) {
			Record ingorecord = ingoingDs.getRecord(0);
			pset.clear();
			pset.setParameter("PEOPLE_ID", ingorecord.get("peopleId"));
			ds = demobilizedIllnessService.query(pset);
			
			if(ds.getCount() != 0) {
				Record record = ds.getRecord(0);
				
				// 审批表信息
				record.set("ingoingCode", ingorecord.get("ingoingCode"));
				record.set("ingoingAddress", ingorecord.get("ingoingAddress"));
				record.set("ingoingReason", ingorecord.get("ingoingReason"));
				record.set("oldPaperNo", ingorecord.get("oldPaperNo"));
				record.set("allowanceMonth", ingorecord.get("allowanceMonth"));
				record.set("serviceType", ingorecord.get("serviceType"));
			
				// 优抚基本信息
				DataSet bptDs = service.queryBptPeople(pset);
				if(bptDs.getCount() != 0) {
					Record bptRecord = bptDs.getRecord(0);
					record.set("bank", bptRecord.get("bank"));
					record.set("accountName", bptRecord.get("accountName"));
					record.set("accountCode", bptRecord.get("accountCode"));
					record.set("oldLonelyFlag", bptRecord.get("oldLonelyFlag"));
					record.set("workAbilityCode", bptRecord.get("workAbilityCode"));
					record.set("workAbilityDescribe", bptRecord.get("workAbilityDescribe"));
					record.set("viabilityCode", bptRecord.get("viabilityCode"));
					record.set("supportPattern", bptRecord.get("supportPattern"));
					record.set("jobStatusDescribe", bptRecord.get("jobStatusDescribe"));
					record.set("insanityFlag", bptRecord.get("insanityFlag"));
					record.set("orphanFlag", bptRecord.get("orphanFlag"));
					record.set("warTypeCode", bptRecord.get("warTypeCode"));
				}
				
				
				
				// 人员基本信息
				DataSet baseDs = service.queryPeople(pset);
				if(baseDs.getCount() != 0) {
					Record baseRecord = baseDs.getRecord(0);
					record.set("demobilizedStateCode", baseRecord.get("demobilizedStateCode"));
					record.set("demobilizedNo", baseRecord.get("demobilizedNo"));
				}
				
				
			
			}
		}
		return ds;
	}
	
	/**
	 * 查询其他抚恤关系外省迁入
	 * @return
	 */
	public DataSet queryIntoprovin() {
		ParameterSet pset = getParameterSet();
		return bptApplyIntoprovinceService.queryIntoprovin(pset);
	}
	
	
	/**
	 *  查询参战外省迁入信息
	 * @return
	 */
	public DataSet queryWarIntoProvince() {
		ParameterSet pset = getParameterSet();
	    DataSet ingoingDs = bptApplyIntoprovinceService.query(pset);
	    DataSet ds = new DataSet();
		if(ingoingDs.getCount() != 0) {
			Record ingorecord = ingoingDs.getRecord(0);
			pset.clear();
			pset.setParameter("PEOPLE_ID", ingorecord.get("peopleId"));
			
			ds = bptPeopleWarService.query(pset);
			if(ds.getCount() != 0) {
				Record record = ds.getRecord(0);
				
				// 审批表信息
				record.set("ingoingCode", ingorecord.get("ingoingCode"));
				record.set("ingoingAddress", ingorecord.get("ingoingAddress"));
				record.set("ingoingReason", ingorecord.get("ingoingReason"));
				record.set("oldPaperNo", ingorecord.get("oldPaperNo"));
				record.set("allowanceMonth", ingorecord.get("allowanceMonth"));
				record.set("serviceType", ingorecord.get("serviceType"));
				
				// 优抚基本信息
				DataSet bptDs = service.queryBptPeople(pset);
				if(bptDs.getCount() != 0) {
					Record bptRecord = bptDs.getRecord(0);
					record.set("bank", bptRecord.get("bank"));
					record.set("accountName", bptRecord.get("accountName"));
					record.set("accountCode", bptRecord.get("accountCode"));
					record.set("insanityFlag", bptRecord.get("insanityFlag"));
					record.set("supportPattern", bptRecord.get("supportPattern"));
					record.set("oldLonelyFlag", bptRecord.get("oldLonelyFlag"));
					record.set("orphanFlag", bptRecord.get("orphanFlag"));
					record.set("workAbilityCode", bptRecord.get("workAbilityCode"));
					record.set("viabilityCode", bptRecord.get("viabilityCode"));
					record.set("workAbilityDescribe", bptRecord.get("workAbilityDescribe"));
					record.set("jobStatusDescribe", bptRecord.get("jobStatusDescribe"));
				}
				
				// 人员基本信息
				DataSet baseDs = service.queryPeople(pset);
				if(baseDs.getCount() != 0) {
					Record baseRecord = baseDs.getRecord(0);
					record.set("warNo", baseRecord.get("warNo"));
					record.set("approveDate", baseRecord.get("approveDate"));
					record.set("warStateCode", baseRecord.get("warStateCode"));
				}
			}
		}
	    return ds;
	}
	
}
