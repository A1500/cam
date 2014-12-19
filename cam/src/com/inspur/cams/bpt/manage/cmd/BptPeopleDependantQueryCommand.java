package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptPeopleDependantQueryCommand
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
*/
public class BptPeopleDependantQueryCommand extends BaseQueryCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	
	/**
	 * 三属服务接口
	 */
	IBptPeopleDependantDomain dependantService = ScaComponentFactory.getService(IBptPeopleDependantDomain.class,
	"bptPeopleDependantDomain/bptPeopleDependantDomain");
	
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	
	/**
	 * 查询三属人员信息
	 * @return
	 */
	public DataSet queryDependantPeople(){
		ParameterSet pset = getParameterSet();
		pset.setParameter("DEPENDANT_FLAG@=","1");
		return service.queryPeople(pset);
	}
	
	/**
	 * 查询人员三属信息和优抚人员信息
	 * @return
	 */
	public DataSet queryDependantInfo(){
		ParameterSet pset = getParameterSet();
		
		DataSet dependantDataSet = service.queryDependantInfo(pset);
		DataSet bptPeoleDataSet = service.queryBptPeople(pset);
		DataSet peopleDataSet = service.queryPeople(pset);
		
		dependantDataSet.addField("dependantStateCode");
		dependantDataSet.addField("handicapFlag");
		dependantDataSet.addField("dependantNo");
		
		dependantDataSet.addField("bank");
		dependantDataSet.addField("accountName");
		dependantDataSet.addField("accountCode");
		dependantDataSet.addField("oldLonelyFlag");
		dependantDataSet.addField("orphanFlag");
		dependantDataSet.addField("workAbilityCode");
		dependantDataSet.addField("viabilityCode");
		dependantDataSet.addField("supportPattern");
		dependantDataSet.addField("jobStatusDescribe");
		dependantDataSet.addField("dependantTypeCode");
		
		Record rd1 = new Record();
		if(dependantDataSet.getCount()>0){
			rd1 = dependantDataSet.getRecord(0);
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataSet.getRecord(0);
			
			rd1.set("dependantStateCode", rd3.get("dependantStateCode"));
			rd1.set("handicapFlag", rd3.get("handicapFlag"));
			rd1.set("dependantNo", rd3.get("dependantNo"));
			
			rd1.set("bank", rd2.get("bank"));
			rd1.set("accountName", rd2.get("accountName"));
			rd1.set("accountCode", rd2.get("accountCode"));
			rd1.set("oldLonelyFlag", rd2.get("oldLonelyFlag"));
			rd1.set("orphanFlag", rd2.get("orphanFlag"));
			rd1.set("workAbilityCode", rd2.get("workAbilityCode"));
			rd1.set("viabilityCode", rd2.get("viabilityCode"));
			rd1.set("supportPattern", rd2.get("supportPattern"));
			rd1.set("jobStatusDescribe", rd2.get("jobStatusDescribe"));
			rd1.set("dependantTypeCode", rd2.get("dependantTypeCode"));
		}
		DataSet ds = new DataSet(rd1);
		
		return  ds;
	}
	
	/**
	 * 查找人员、三属和优抚信息
	 */
	public DataSet queryDepePeo(){
		ParameterSet pset = getParameterSet();
		return dependantService.queryDepePeo(pset);
	}
	
	/**
	 * 查找未提交三属人员信息
	 */
	public DataSet queryUncommitDependant() {
		ParameterSet pset = getParameterSet();
		return dependantService.queryUncommitDependant(pset);
	}
	
	/**
	 * 查询三属人员申请审批表[表头信息]
	 */
	public DataSet queryDisabilityApproveHeader(){
		ParameterSet pset = getParameterSet();
		if(!pset.containsKey("PROCESS_ID")){
			String assignmentId = (String)pset.getParameter("assignmentId");
			String processId = wfProcessBusinessService.getProcessId(assignmentId);
			pset.clear();
			pset.setParameter("PROCESS_ID", processId);
		} 
		Record	rd = wfProcessBusinessService.query(pset).getRecord(0);
		String peopleId = ((String)rd.get("connectId"));
		return dependantService.queryApplyHeader(peopleId);
	}
	
	/**
	 * 通过身份证查询三属基本信息
	 * @return
	 */
	public DataSet queryByIdCard() {
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();
		DataSet peopleDataSet = service.queryPeople(pset); // 查询人员基本信息
		if(peopleDataSet.getCount() != 0) {
			Record record = peopleDataSet.getRecord(0);
			String peopleId = (String)record.get("peopleId");
//			pset.clear();
//			pset.setParameter("PEOPLE_ID", peopleId);
			DataSet typeDataSet = service.queryBptPeople(pset); // 查询优抚人员基本信息 
			DataSet dependantDataSet = dependantService.query(pset); // 查询三属基本信息
			if(dependantDataSet.getCount() != 0 && typeDataSet.getCount() != 0) { 
				Record bptRecord = typeDataSet.getRecord(0);
				Record dependantRecord = dependantDataSet.getRecord(0);
				record.set("relationship", dependantRecord.get("relationship"));
				record.set("dependantTypeCode", bptRecord.get("dependantTypeCode"));
				ds.add(record);
			}
		}
		return ds;
	}
}
