package com.inspur.cams.sorg.apply.group.domain.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.loushang.workflow.util.TimeUtils;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.ProcessLimiteTimeUtil;
import com.inspur.cams.sorg.apply.group.domain.IGroupNameApprovalDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;
/**
 * 社会团体名称核准domain
 * @author yanliangliang
 * 2012年3月19日
 *
 */
public class GroupNameApprovalDomain implements IGroupNameApprovalDomain{

	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;
	
	public static final String PROC_DEF_UNIQUE_ID = "8a898bba3628b96b013628bce1790171";
	public static final String START_ACT_DEF_ID = "act1";
	/**
	 * 保存业务数据
	 * @param somPrepare
	 */
	public String create(SomApply somApply) {
		String time = DateUtil.getTime();
		OrganView organView = BspUtil.getCorpOrgan();
		OrganView deptView = BspUtil.getDeptOrgan();
		OrganView peopleView = BspUtil.getEmpOrgan();
		String areaCode = organView.getOrganCode();
		//1.保存业务数据
		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgStatus("8");
		somOrgan.setSorgType("S");
		somOrgan.setMorgName(organView.getOrganName());
		somOrgan.setMorgArea(areaCode);
		
		ParameterSet set=new ParameterSet();
		set.setParameter("SORG_ID", somOrgan.getSorgId());
		DataSet ds1= somOrganDomain.query(set);
		if(ds1.getCount()>0){
			somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		}else{
			if("1".equals(somOrgan.getIfBranch())){
				ParameterSet pset=new ParameterSet();
				pset.setParameter("CN_NAME", somOrgan.getCnName());
				pset.setParameter("SORG_TYPE", somOrgan.getSorgType());
				pset.setParameter("SORG_STATUS", "15");//异地分支通过
				DataSet ds= somOrganDomain.query(pset);
				if(ds.getCount()>0){
					somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
				}else{
					somOrganDomain.insertAndBuildHis(somOrgan,somApply.getTaskCode());
				}
			}else{
				somOrganDomain.insertAndBuildHis(somOrgan,somApply.getTaskCode());
			}
		}
		// 处理从表信息
		dealSomHeldPeople(somApply);
		dealSomHeldOrgan(somApply);
		dealSomAspchief(somApply);
		//2.启动流程
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map wfMap = WfTaskRequestWrapper.getInstance().create(somApply.getTaskCode(), somOrgan.getCnName() + "申请名称核准");
		List actList = (List) wfMap.get("actList");
		Map map1 = (Map) actList.get(0);
		List assList = (List) map1.get("assList");
		Map map2 = (Map) assList.get(0);
		String assignmentId = (String) map2.get("assignmentId");
		String processId = (String) wfMap.get("processId");
		
		//3.保存业务信息
		somApply.setProcessId(processId);
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_GROUP_NAME_APPROVAL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setIfFinish("0");
		somApply.setAcceptArea(areaCode);
		somApply.setAcceptOrganId(organView.getOrganId());
		somApply.setAcceptOrganName(organView.getOrganName());
		somApply.setAcceptDeptId(deptView.getOrganId());
		somApply.setAcceptDeptName(deptView.getOrganName());
		somApply.setAcceptPeopleId(peopleView.getOrganId());
		somApply.setAcceptPeopleName(peopleView.getOrganName());
		//somApply.setAcceptTime(time);
		
		somApplyDomain.curSomApply(somApply);
		
		somApplyDomain.insert(somApply);
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		if(somApply.getDataSource().equals("ONLINE")){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", somApply.getTaskCode());
			DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
			for(int i = 0;i<ds.getCount();i++){
				SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
				bean.setSorgId(somApply.getSorgId());
				somElectronicDomain.update(bean);
			}
		}
		//返回参数
		return assignmentId;
	}

	/**
	 * 新增名称核准业务并提交流程
	 * @param somPrepare
	 */
	public void createAndSend(SomApply somApply) {
		String assignmentId = create(somApply);
		CommandContext.setContextParameter("assignmentId", assignmentId);
		send(somApply);
	}
	
	/**
	 * 修改业务数据
	 * @param somPrepare
	 */
	public void update(SomApply somApply) {
		
		SomOrgan somOrgan = somApply.getSomOrgan();
		somApplyDomain.updateSomApplyInfo(somOrgan);
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		// 处理从表信息
		dealSomHeldPeople(somApply);
		dealSomHeldOrgan(somApply);
		dealSomAspchief(somApply);
		somApply.setBorgName(somOrgan.getBorgName());
		somApplyDomain.curSomApply(somApply);
		somApplyDomain.update(somApply);
	}
	/**
	 * 修改保存业务并提交流程
	 * @param somPrepare
	 */
	public void updateAndSend(SomApply somApply) {
		update(somApply);
		send(somApply);
	}
	/**
	 * 提交流程
	 * @param somPrepare
	 */
	public void send(SomApply somApply) {
		//1.记录流程历史意见
		somFlowDomain.insertBySomApply(somApply);
		//2.提交流程
		Map context = new HashMap();
		context.put("organId", BspUtil.getDeptStruId());
		context.put("opinionId", somApply.getCurOpinionId());
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		
		//流程结束
		SomOrgan organBean = somApply.getSomOrgan();
		String curActivity = somApply.getCurActivity();
		if(Activity.ACT_AUDITREPORT_CN.equals(curActivity)||Activity.ACT_ACCEPT_CN.equals(curActivity)||Activity.ACT_EXAM_CN.equals(curActivity)||Activity.ACT_CHECK_CN.equals(curActivity)){
			if("0".equals(somApply.getCurOpinionId())){
				organBean.setSorgStatus("10");
				somOrganDomain.updateAndBuildHis(organBean,somApply.getTaskCode());
			}
		}else if(Activity.ACT_AUDIT_CN.equals(curActivity)){
			if("1".equals(somApply.getCurOpinionId())){
				organBean.setSorgStatus("9");
			}
			if("0".equals(somApply.getCurOpinionId())){
				organBean.setSorgStatus("10");
			}
			somOrganDomain.updateAndBuildHis(organBean,somApply.getTaskCode());
		}
		//保存时不记录受理时间，提交时才开始算受理时间
		if(Activity.ACT_ACCEPT_CN.equals(curActivity)){
			somApply.setAcceptTime(DateUtil.getTime());
		}
		//如果环节是补齐补正，清空业务表的初审审核审批意见
		if(Activity.ACT_SUPPLY_CN.equals(curActivity)){
			somApplyDomain.emptyExamToAudit(somApply);
			//补齐补正重新计算超时时间
			ProcessLimiteTimeUtil.reCreateProcessLimit(somApply.getProcessId());
		}
		if(somApply.getCurOpinionId().equals("2")){
			//转补齐补正时将超时时间置无限大
			ProcessLimiteTimeUtil.updateMaxProcessLimit(somApply.getProcessId());
		}
		//维护历史处理意见信息
		somApplyDomain.dealHisOpinion(somApply);
		// 获取下一环节名称
		List actList = (List)wfMap.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			somApply.setCurActivity(actDefName1);
		}else{
			somApply.setCurActivity("");
			somApply.setIfFinish("1");
		}
		// 更新业务信息中的当前信息
		somApplyDomain.emptySomApply(somApply,somApply.getCurActivity());
		somApplyDomain.update(somApply);
	}
	
	// 获取发起人（自然人）
	private void dealSomHeldPeople(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		for (int i = 0; i < somHeldPeopleList.size(); i++) {
			SomHeldPeople somHeldPeople = somHeldPeopleList.get(i);
			if (somHeldPeople.getState() == Record.STATE_NEW) {
				somHeldPeople.setId(IdHelp.getUUID30());
				somHeldPeople.setSorgId(somOrgan.getSorgId());
				somHeldPeople.setTaskCode(somApply.getTaskCode());
				somHeldPeople.setMorgArea(somOrgan.getMorgArea());
				somHeldPeople.setMorgName(somOrgan.getMorgName());
				somHeldPeople.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
				somHeldPeople.setCreateTime(DateUtil.getTime());
				somHeldPeopleDomain.insert(somHeldPeople);
			} else if (somHeldPeople.getState() == Record.STATE_MODIFIED) {
				somHeldPeopleDomain.update(somHeldPeople);
			} else if (somHeldPeople.getState() == Record.STATE_DELETED) {
				somHeldPeopleDomain.delete(somHeldPeople.getId());
			}
		}
	}
	
	// 获取发起人（单位）
	private void dealSomHeldOrgan(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
			if (somHeldOrgan.getState() == Record.STATE_NEW) {
				somHeldOrgan.setId(IdHelp.getUUID30());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setTaskCode(somApply.getTaskCode());
				somHeldOrgan.setMorgArea(somOrgan.getMorgArea());
				somHeldOrgan.setMorgName(somOrgan.getMorgName());
				somHeldOrgan.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
				somHeldOrgan.setCreateTime(DateUtil.getTime());
				somHeldOrganDomain.insert(somHeldOrgan);
			} else if (somHeldOrgan.getState() == Record.STATE_MODIFIED) {
				somHeldOrganDomain.update(somHeldOrgan);
			} else if (somHeldOrgan.getState() == Record.STATE_DELETED) {
				somHeldOrganDomain.delete(somHeldOrgan.getId());
			}
		}
	}
	
	// 获取拟任负责人
	private void dealSomAspchief(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomAspchief> somAspchiefList = somOrgan.getSomAspchiefList();
		for (int i = 0; i < somAspchiefList.size(); i++) {
			SomAspchief somAspchief = somAspchiefList.get(i);
			if (somAspchief.getState() == Record.STATE_NEW) {
				somAspchief.setId(IdHelp.getUUID30());
				somAspchief.setSorgId(somOrgan.getSorgId());
				somAspchief.setTaskCode(somApply.getTaskCode());
				somAspchief.setMorgArea(somOrgan.getMorgArea());
				somAspchief.setMorgName(somOrgan.getMorgName());
				somAspchief.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
				somAspchief.setCreateTime(DateUtil.getTime());
				somAspchiefDomain.insert(somAspchief);
			} else if (somAspchief.getState() == Record.STATE_MODIFIED) {
				somAspchiefDomain.update(somAspchief);
			} else if (somAspchief.getState() == Record.STATE_DELETED) {
				somAspchiefDomain.delete(somAspchief.getId());
			}
		}
	}
}
