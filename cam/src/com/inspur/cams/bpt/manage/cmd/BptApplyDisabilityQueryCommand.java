package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * @title:BptApplyDisabilityQueryCommand
 * @description:伤残业务审批查询
 * @author:
 * @since:2011-06-10
 * @version:1.0
*/
public class BptApplyDisabilityQueryCommand extends BaseQueryCommand{
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,"bptGroupDomain/bptGroupDomain");
	
	/**
	 * 伤残审批服务接口
	 */
	IBptApplyDisabilityDomain applyDisabilityService = ScaComponentFactory.getService(IBptApplyDisabilityDomain.class,
	"bptApplyDisabilityDomain/bptApplyDisabilityDomain");

	
	/**
	 * 伤残人员信息服务接口
	 */
	IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory.getService(IBptPeopleDisabilityDomain.class,
	"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
	
	/**
	 *  工作流信息的服务接口
	 */
	IWfProcessBusinessDomain processBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	/**
	 * 根据伤残审批信息
	 * @return
	 */
	public DataSet queryApplyInfo() {
		ParameterSet pset = getParameterSet();
		return applyDisabilityService.query(pset);
	}
	public DataSet queryApplyInfoForCheck() {
		ParameterSet pset = getParameterSet();
		return applyDisabilityService.queryApplyInfoForCheck(pset);
	}
	/**
	 * 根据前台传过来的process_Id或者assignmentId,查询记录
	 */
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		String serviceType = (String)pset.getParameter("serviceType");
		pset.remove("serviceType");
		DataSet ds = null ;
		if(pset.containsKey("APPLY_ID")) {
			ds = applyDisabilityService.query(pset);
		}  else {
			if(pset.containsKey("PROCESS_ID")){
				DataSet ds1 = processBusinessService.query(pset);
				String applyId = (String)ds1.getRecord(0).get("businessId");
				pset.clear();
				pset.setParameter("apply_Id", applyId);
				return applyDisabilityService.query(pset);
			}else{
				String assignmentId = (String)pset.getParameter("assignmentId");
				String processId = processBusinessService.getProcessId(assignmentId);
				pset.clear();
				pset.setParameter("PROCESS_ID", processId);
				DataSet ds1 = processBusinessService.query(pset);
				String applyId = (String)ds1.getRecord(0).get("businessId");
				pset.remove("PROCESS_ID");
				pset.setParameter("APPLY_ID", applyId);
				ds = applyDisabilityService.query(pset);
			}
		}
		if(ds != null && ds.getCount() > 0 ) {
			Record record = ds.getRecord(0);
			String peopleId = (String)record.get("peopleId");
			pset.clear();
			pset.setParameter("PEOPLE_ID", peopleId);
			DataSet baseinfoDs = service.queryPeople(pset);
			DataSet bptDs = service.queryBptPeople(pset);
			DataSet disbilityDs = disabilityService.queryBptPeopleDisability(pset);
			if(baseinfoDs != null && baseinfoDs.getCount() >0) {
				Record baseRecord = baseinfoDs.getRecord(0);
				record.set("name", baseRecord.get("name"));
				record.set("birthday", baseRecord.get("birthday"));
				record.set("address", baseRecord.get("address"));
				String n=(String)ds.getRecord(0).get("oldName");
				if(n==null||"".equals(n)) {
					if("13".equals(serviceType)){
						record.set("oldName", baseRecord.get("name"));
						record.set("newName", baseRecord.get("name"));
						record.set("oldIdCard", baseRecord.get("idCard"));
						record.set("newIdCard", baseRecord.get("idCard"));
						record.set("newDisabilityNo", baseRecord.get("disabilityNo"));
					}
					
					if(!"14".equals(serviceType)){ //退役军人伤残抚恤关系迁入
						record.set("oldDisabilityNo", baseRecord.get("disabilityNo"));
					}
				}
				baseRecord = null;
				baseinfoDs = null;
			}
			if(bptDs != null && bptDs.getCount() > 0) {
				Record bptRecord = bptDs.getRecord(0);
				record.set("disabilityTypeCode", bptRecord.get("disabilityTypeCode"));
				bptRecord = null;
				bptDs = null;
			}
			if(disbilityDs != null && disbilityDs.getCount() > 0) {
				Record disRecord = disbilityDs.getRecord(0);
				record.set("disabilityDate", disRecord.get("disabilityDate"));
				record.set("disabilityAdd", disRecord.get("disabilityAdd"));
				record.set("disabilityBody", disRecord.get("disabilityBody"));
				record.set("disabilityReason", disRecord.get("disabilityReason"));
				disRecord = null;
				disbilityDs = null;
			}
		}
		return ds;
}
	/**
	 * 查询伤残相关审批信息
	 * @param pset
	 * @return
	 */
	public DataSet queryApply(){
		ParameterSet pset = getParameterSet();
		return applyDisabilityService.query(pset);
	}
	 /**
	 * 查询未提交的调残人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiAdjust(){
		ParameterSet pset = getParameterSet();
		return applyDisabilityService.queryUnCommiAdjust(pset);
	}
	
	/**
	 * 根据PROCESS_ID或assignmentId查询调残人员信息
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryAdjustById(){
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
		
		DataSet applyDisabilityDataSet = applyDisabilityService.query(pset);
		Record applyDisabilityRecord = applyDisabilityDataSet.getRecord(0);
		
		applyDisabilityDataSet.addField("familyId");
		applyDisabilityDataSet.addField("name");
		applyDisabilityDataSet.addField("sex");
		applyDisabilityDataSet.addField("idCard");
		applyDisabilityDataSet.addField("nation");
		applyDisabilityDataSet.addField("birthday");
		applyDisabilityDataSet.addField("address");
		applyDisabilityDataSet.addField("domicileAddress");
		applyDisabilityDataSet.addField("apanageName");
		applyDisabilityDataSet.addField("domicileName");
		applyDisabilityDataSet.addField("disabilityWarCode");
		applyDisabilityDataSet.addField("domicileName");
		applyDisabilityDataSet.addField("conscriptDate");
		applyDisabilityDataSet.addField("veteransDate");
		applyDisabilityDataSet.addField("retiredDate");
		applyDisabilityDataSet.addField("disabilityGenusCode");
		applyDisabilityDataSet.addField("uinitOfDisability");
		applyDisabilityDataSet.addField("disabilityCaseCode");
		applyDisabilityDataSet.addField("disabilityLevelCode");
		applyDisabilityDataSet.addField("disabilityNo");
		
		String peopleId = applyDisabilityRecord.get("peopleId").toString();
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		
		//查询人员信息
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord = peopleDataSet.getRecord(0);
		
		//查询伤残信息表中的信息
		DataSet disabilityDataSet = disabilityService.queryBptPeopleDisability(pset);
		Record disabilityRecord = disabilityDataSet.getRecord(0);
		
		//通过apanageCode获取apanageName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("apanageCode").toString());
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = apanageCodeRecord.get("name").toString();
		//通过domicileCode获取domicileName
		EntityDao<DicCity> dao1= (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("domicileCode").toString());
		DataSet domicileCodeDataSet = dao1.query(pset);
		Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
		String domicileName = domicileCodeRecord.get("name").toString();
		
		
		applyDisabilityRecord.set("disabilityNo", disabilityRecord.get("disabilityNo").toString());
		applyDisabilityRecord.set("domicileAddress", disabilityRecord.get("domicileAddress").toString());
		
		
		
		applyDisabilityRecord.set("familyId", peopleRecord.get("familyId").toString());
		applyDisabilityRecord.set("name", peopleRecord.get("name").toString());
		applyDisabilityRecord.set("sex", peopleRecord.get("sex").toString());
		applyDisabilityRecord.set("idCard", peopleRecord.get("idCard").toString());
		applyDisabilityRecord.set("nation", peopleRecord.get("nation").toString());
		applyDisabilityRecord.set("birthday", peopleRecord.get("birthday").toString());
		if(peopleRecord.get("address") != null){
			applyDisabilityRecord.set("address", peopleRecord.get("address").toString());
		}
		if(peopleRecord.get("domicileAddress") != null){
			applyDisabilityRecord.set("domicileAddress", peopleRecord.get("domicileAddress").toString());
		}
		applyDisabilityRecord.set("apanageName", apanageName);
		applyDisabilityRecord.set("domicileName", domicileName);
		
		applyDisabilityRecord.set("disabilityWarCode", disabilityRecord.get("disabilityWarCode").toString());
	
		
		applyDisabilityRecord.set("conscriptDate", disabilityRecord.get("conscriptDate").toString());
		applyDisabilityRecord.set("veteransDate", disabilityRecord.get("veteransDate").toString());
		applyDisabilityRecord.set("retiredDate", disabilityRecord.get("retiredDate").toString());
		applyDisabilityRecord.set("disabilityGenusCode", disabilityRecord.get("disabilityGenusCode").toString());
		applyDisabilityRecord.set("disabilityWarCode", disabilityRecord.get("disabilityWarCode").toString());
		if(disabilityRecord.get("uinitOfDisability") != null){
			applyDisabilityRecord.set("uinitOfDisability", disabilityRecord.get("uinitOfDisability").toString());
		}
		applyDisabilityRecord.set("disabilityCaseCode", disabilityRecord.get("disabilityCaseCode").toString());
		applyDisabilityRecord.set("disabilityLevelCode", disabilityRecord.get("disabilityLevelCode").toString());
		
		return new DataSet(applyDisabilityRecord);
	}
	
	/**
	 * 查询调残、换证（补证）、证件变更人员信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryAdjustDisability(){
		ParameterSet pset = getParameterSet();
		Record applyDisabilityRecord = new Record();
		DataSet applyDisabilityDataSet = applyDisabilityService.query(pset);
		int count = applyDisabilityDataSet.getCount();
		if(count>0){
		applyDisabilityRecord = applyDisabilityDataSet.getRecord(0);
		
		applyDisabilityDataSet.addField("familyId");
		applyDisabilityDataSet.addField("name");
		applyDisabilityDataSet.addField("sex");
		applyDisabilityDataSet.addField("idCard");
		applyDisabilityDataSet.addField("nation");
		applyDisabilityDataSet.addField("birthday");
		applyDisabilityDataSet.addField("address");
		applyDisabilityDataSet.addField("domicileAddress");
		applyDisabilityDataSet.addField("apanageName");
		applyDisabilityDataSet.addField("disabilityWarCode");
		applyDisabilityDataSet.addField("domicileName");
		applyDisabilityDataSet.addField("conscriptDate");
		applyDisabilityDataSet.addField("veteransDate");
		applyDisabilityDataSet.addField("retiredDate");
		applyDisabilityDataSet.addField("disabilityGenusCode");
		applyDisabilityDataSet.addField("uinitOfDisability");
		applyDisabilityDataSet.addField("disabilityCaseCode");
		applyDisabilityDataSet.addField("disabilityLevelCode");
		applyDisabilityDataSet.addField("disabilityNo");
		
		String peopleId = applyDisabilityRecord.get("peopleId").toString();
		pset.clear();
		pset.setParameter("PEOPLE_ID", peopleId);
		
		//查询人员信息
		DataSet peopleDataSet = service.queryPeople(pset);
		Record peopleRecord = peopleDataSet.getRecord(0);
		//查询伤残信息表中的信息
		DataSet disabilityDataSet = disabilityService.queryBptPeopleDisability(pset);
		Record disabilityRecord = disabilityDataSet.getRecord(0);
		
		//通过apanageCode获取domicileName
		EntityDao<DicCity> dao = (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("apanageCode").toString());
		DataSet apanageCodeDataSet = dao.query(pset);
		Record apanageCodeRecord = apanageCodeDataSet.getRecord(0);
		String apanageName = apanageCodeRecord.get("name").toString();
		//通过domicileCode获取domicileName
		EntityDao<DicCity> dao1= (EntityDao<DicCity>)DaoFactory.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
		pset.clear();
		pset.setParameter("ID", peopleRecord.get("domicileCode").toString());
		DataSet domicileCodeDataSet = dao1.query(pset);
		Record domicileCodeRecord = domicileCodeDataSet.getRecord(0);
		String domicileName = domicileCodeRecord.get("name").toString();
		
		
		
		applyDisabilityRecord.set("familyId", peopleRecord.get("familyId").toString());
		applyDisabilityRecord.set("name", peopleRecord.get("name").toString());
		applyDisabilityRecord.set("sex", peopleRecord.get("sex").toString());
		applyDisabilityRecord.set("idCard", peopleRecord.get("idCard").toString());
		applyDisabilityRecord.set("nation", peopleRecord.get("nation").toString());
		applyDisabilityRecord.set("birthday", peopleRecord.get("birthday").toString());
		if(peopleRecord.get("address") != null){
			applyDisabilityRecord.set("address", peopleRecord.get("address").toString());
		}
		if(peopleRecord.get("domicileAddress") != null){
			applyDisabilityRecord.set("domicileAddress", peopleRecord.get("domicileAddress").toString());
		}
		if(peopleRecord.get("disabilityNo") != null){
			applyDisabilityRecord.set("disabilityNo", peopleRecord.get("disabilityNo").toString());
		}
	
		
		applyDisabilityRecord.set("apanageName", apanageName);
		applyDisabilityRecord.set("domicileName", domicileName);
		applyDisabilityRecord.set("disabilityWarCode", disabilityRecord.get("disabilityWarCode")==null?null:disabilityRecord.get("disabilityWarCode").toString());
		applyDisabilityRecord.set("conscriptDate", disabilityRecord.get("conscriptDate")==null?null:disabilityRecord.get("conscriptDate").toString());
		applyDisabilityRecord.set("veteransDate", disabilityRecord.get("veteransDate")==null?null:disabilityRecord.get("veteransDate").toString());
		applyDisabilityRecord.set("retiredDate", disabilityRecord.get("retiredDate")==null?null:disabilityRecord.get("retiredDate").toString());
		applyDisabilityRecord.set("disabilityGenusCode", disabilityRecord.get("disabilityGenusCode")==null?null:disabilityRecord.get("disabilityGenusCode").toString());
		if(disabilityRecord.get("uinitOfDisability") != null){
			applyDisabilityRecord.set("uinitOfDisability", disabilityRecord.get("uinitOfDisability").toString());
		}
		applyDisabilityRecord.set("disabilityCaseCode", disabilityRecord.get("disabilityCaseCode")==null?null:disabilityRecord.get("disabilityCaseCode").toString());
		applyDisabilityRecord.set("disabilityLevelCode", disabilityRecord.get("disabilityLevelCode")==null?null:disabilityRecord.get("disabilityLevelCode").toString());
		}
		return new DataSet(applyDisabilityRecord);
	}
	/**
	 * 查询伤残退役军人
	 * @return
	 */
	public DataSet queryVeteransDisability(){
		ParameterSet pset = getParameterSet();
		DataSet applyDisabilityDataSet = applyDisabilityService.query(pset);
		pset.remove("APPLY_ID");
		DataSet disabilityDataSet = service.queryDisabilityInfo(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataSet = service.queryPeople(pset);
		
		disabilityDataSet.addField("disabilityTypeCode");
		disabilityDataSet.addField("dependantTypeCode");
		disabilityDataSet.addField("redaTypeCode");
		disabilityDataSet.addField("warTypeCode");
		disabilityDataSet.addField("bank");
		disabilityDataSet.addField("accountName");
		disabilityDataSet.addField("accountCode");
		disabilityDataSet.addField("insanityFlag");
		disabilityDataSet.addField("oldLonelyFlag");
		disabilityDataSet.addField("orphanFlag");
		disabilityDataSet.addField("workAbilityCode");
		disabilityDataSet.addField("workAbilityDescribe");
		disabilityDataSet.addField("viabilityCode");
		disabilityDataSet.addField("supportPattern");
		disabilityDataSet.addField("jobStatusDescribe");
		disabilityDataSet.addField("disabilityStateCode");
		disabilityDataSet.addField("disabilityNo");
		disabilityDataSet.addField("oldDisabilityNo");
		disabilityDataSet.addField("applyId");
		disabilityDataSet.addField("exchangeReason");
		disabilityDataSet.addField("ingoingAddress");
		disabilityDataSet.addField("allowanceMonth");
		Record rd1 = new Record();
		if(disabilityDataSet.getCount()>0){
			rd1 = disabilityDataSet.getRecord(0);
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataSet.getRecord(0);
			Record rd4 = applyDisabilityDataSet.getRecord(0);
			
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
			rd1.set("disabilityStateCode", rd3.get("disabilityStateCode"));
			rd1.set("disabilityNo", rd3.get("disabilityNo"));
			rd1.set("oldDisabilityNo", rd4.get("oldDisabilityNo"));
			rd1.set("exchangeReason", rd4.get("exchangeReason"));
			rd1.set("allowanceMonth", rd4.get("allowanceMonth"));
			rd1.set("ingoingAddress", rd4.get("ingoingAddress"));
			rd1.set("applyId", rd4.get("applyId"));
			rd1.set("serviceType", "14");
			rd1.set("commitFlag", "0");
			
		}
		
		
		DataSet ds = new DataSet(rd1);
		
		return ds;
		
		
	}
	
	/**
	 * 查询审批后打证信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryPrintInfo() {
		ParameterSet pset = getParameterSet();
		return applyDisabilityService.queryPrintInfo(pset);
	}
}
