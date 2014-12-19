package com.inspur.cams.bpt.manage.cmd;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.bpt.base.domain.IBptApplyDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IWfProcessBusinessDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

public class BptPeopleDisabilityQueryCommand extends BaseQueryCommand{
	
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class,
	"bptGroupDomain/bptGroupDomain");
	
	/**
	 * 伤残人员信息服务接口
	 */
	IBptPeopleDisabilityDomain disabilityService = ScaComponentFactory.getService(IBptPeopleDisabilityDomain.class,
	"bptPeopleDisabilityDomain/bptPeopleDisabilityDomain");
	
	/**
	 * 工作流信息服务接口
	 */
	IWfProcessBusinessDomain wfProcessBusinessService = ScaComponentFactory.getService(IWfProcessBusinessDomain.class,
	"wfProcessBusinessDomain/wfProcessBusinessDomain");
	
	/**
	 * 获得伤残审批服务接口
	 */
	IBptApplyDisabilityDomain bptApplyDisabilityService = ScaComponentFactory.getService(IBptApplyDisabilityDomain.class,
	"bptApplyDisabilityDomain/bptApplyDisabilityDomain");
	
	/**
	 * 查询伤残人员信息
	 * @return
	 */
	public DataSet queryDisabilityPeople(){
		ParameterSet pset = getParameterSet();
		pset.setParameter("DISABILITY_FLAG@=","1");
		return service.queryPeople(pset);
	}
	
	/**
	 * 查询伤残人员信息及其相应的优抚信息（优抚对象类型）
	 * @param pset
	 * @return
	 */
	public DataSet queryDisabilityBPTPeople(){
		ParameterSet pset = getParameterSet();
		return disabilityService.queryDisabilityBPTPeople(pset);
	}
	
	/**
	 * 查询人员、类别【伤残】、优抚信息-----------或替代queryDisabilityBPTPeople
	 */
	public DataSet queryDisabilityBptPeople(){
		ParameterSet pset = getParameterSet();
		return disabilityService.queryDisabilityBptPeople(pset);
	}
	
	/**
	 * 查询人员伤残信息和优抚人员信息
	 * @return
	 */
	public DataSet queryPeopleDisabilityInfo(){
		ParameterSet pset = getParameterSet();
		String peopleId = (String)pset.getParameter("peopleId");
		pset.setParameter("PEOPLE_ID@=", peopleId);
		pset.remove("peopleId");
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
		
		Record rd1 = new Record();
		if(disabilityDataSet.getCount()>0){
			rd1 = disabilityDataSet.getRecord(0);
			Record rd2 = bptPeoleDataSet.getRecord(0);
			Record rd3 = peopleDataSet.getRecord(0);
			
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
		}
		
		
		DataSet ds = new DataSet(rd1);
		
		return  ds;
	}
	
	/**
	 * 查询未提交的伤残优抚对象信息
	 */
	public DataSet queryUnCommitDisPeo(){
		ParameterSet pset = getParameterSet();
		return disabilityService.queryUnCommitDisPeo(pset);
		
	}
	
	/**
	 * 查询评定、调整伤残等级审批表[表头信息]
	 */
	public DataSet queryDisabilityApproveHeader(){
		ParameterSet pset = getParameterSet();
		DataSet ds = null;
		if(pset.containsKey("PROCESS_ID")){
			Record rd = wfProcessBusinessService.query(pset).getRecord(0);
			String peopleId = ((String)rd.get("connectId"));
			ds = disabilityService.queryDisabilityApproveHeader(peopleId);
		}else{
			String assignmentId = (String)pset.getParameter("assignmentId");
			String processId = wfProcessBusinessService.getProcessId(assignmentId);
			pset.clear();
			pset.setParameter("PROCESS_ID", processId);
			Record rd = wfProcessBusinessService.query(pset).getRecord(0);
			String peopleId = ((String)rd.get("connectId"));
			ds = disabilityService.queryDisabilityApproveHeader(peopleId);
		}
		return ds;
		
	}
	
	/**
	 * 查询身份证号查询伤残信息
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryDisabilityByIdCard() {
		ParameterSet pset = getParameterSet();
		DataSet ds = new DataSet();

		List list = disabilityService.queryDisabilityByIdCard(pset);
		if (list != null && list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map) list.get(i);
				Record record = new Record();
				Set<String> sets = map.keySet();
				Iterator<String> iterable = sets.iterator();
				while (iterable.hasNext()) {
					String key = iterable.next();
					record.set(formatModelName(key), map.get(key));
				}
				ds.add(record);
			}

		}
		return ds;
	}

	/**
	 * 转换列表名:如PEOPLE_ID转换为peopleId
	 * 
	 * @param str
	 * @return
	 */
	public String formatModelName(String str) {
		str = str.toLowerCase();
		if (str.indexOf("_") != -1) {
			String[] strs = str.split("_");
			str = strs[0];
			for (int i = 1; i < strs.length; i++) {
				str += strs[i].replaceFirst(strs[i].substring(0, 1), strs[i]
						.substring(0, 1).toUpperCase());
			}
		}
		return str;
	}
	
	/**
	 * 查询换证的伤残军人
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryRenewal(){
		ParameterSet pset = getParameterSet();
		return disabilityService.queryRenewal(pset);
	}
	
}