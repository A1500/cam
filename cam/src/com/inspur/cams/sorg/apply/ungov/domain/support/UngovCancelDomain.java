package com.inspur.cams.sorg.apply.ungov.domain.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.ProcessLimiteTimeUtil;
import com.inspur.cams.sorg.apply.ungov.domain.IUngovCancelDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomLiqpeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;

public class UngovCancelDomain implements IUngovCancelDomain {
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomLiqpeopleDomain somLiqpeopleDomain;
	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;

	/**
	 * 新增注销
	 * 
	 * @param somApply
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String create(SomApply somApply) {
		// 修改社会组织信息
		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrgan.setSorgStatus("31");
		List<SomLiqpeople> somLiqpeopleList = somOrgan.getSomLiqpeopleList();

		// 创建流程
		CommandContext.setContextParameter("procDefUniqueId",
				"402881ec31e65c160131e681fd700048");
		CommandContext.setContextParameter("startActDefUniqueId",
				"402881ec320a33a301320a4860ec003c");
		// 调用工作流创建接口
		Map wfMap = WfTaskRequestWrapper.getInstance().create(
				somApply.getTaskCode(), somOrgan.getCnName() + "的注销申请");
		List actList = (List) wfMap.get("actList");
		Map map1 = (Map) actList.get(0);
		List assList = (List) map1.get("assList");
		Map map2 = (Map) assList.get(0);
		String assignmentId = (String) map2.get("assignmentId");
		String processId = (String) wfMap.get("processId");

		// 保存业务信息
		somApply.setProcessId(processId);
		somApply.setSorgId(somOrgan.getSorgId());
		somApply.setApplyType(ApplyType.SOM_UNGOV_CANCEL);
		somApply.setSorgType(somOrgan.getSorgType());
		somApply.setSorgKind(somOrgan.getSorgKind());
		somApply.setSorgName(somOrgan.getCnName());
		somApply.setIfFinish("0");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAcceptOrganId(BspUtil.getCorpOrganId());
		somApply.setAcceptOrganName(BspUtil.getCorpOrgan().getOrganName());
		somApply.setAcceptDeptId(BspUtil.getDeptOrganId());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptPeopleId(BspUtil.getEmpOrganId());
		somApply.setAcceptPeopleName(BspUtil.getEmpOrgan().getOrganName());
		//somApply.setAcceptTime(DateUtil.getTime());

		somApplyDomain.curSomApply(somApply);

		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		somLiqpeopleDomain.save(somLiqpeopleList);
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
		
		return assignmentId;
	}

	/**
	 * 新增注销并提交流程
	 * 
	 * @param somApply
	 */
	public void createAndSend(SomApply somApply) {
		String assignmentId = create(somApply);
		CommandContext.setContextParameter("assignmentId", assignmentId);
		send(somApply);
	}

	/**
	 * 修改注销
	 * 
	 * @param somApply
	 */
	public void update(SomApply somApply) {
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomLiqpeople> somLiqpeopleList = somOrgan.getSomLiqpeopleList();

		somApplyDomain.curSomApply(somApply);
		
		// 保存所有信息
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		if (somLiqpeopleList != null && somLiqpeopleList.size() > 0) {
			somLiqpeopleDomain.save(somLiqpeopleList);
		}
		somApplyDomain.update(somApply);
	}

	/**
	 * 修改注销并提交流程
	 * 
	 * @param somApply
	 */
	public void updateAndSend(SomApply somApply) {
		update(somApply);
		send(somApply);
	}

	/**
	 * 发送流程
	 * 
	 * @param taskCode
	 */
	@SuppressWarnings("unchecked")
	public void send(SomApply somApply) {
		// 1.记录流程历史意见
		somFlowDomain.insertBySomApply(somApply);
		SomOrgan somOrgan = somApply.getSomOrgan();
		// 2.提交流程
		Map context = new HashMap();
		context.put("ORGANID", BspUtil.getCorpOrganId());
		context.put("opinionId", somApply.getCurOpinionId());
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);

		//流程结束
		String curActivity = somApply.getCurActivity();
		if(Activity.ACT_EXAM_CN.equals(curActivity)||Activity.ACT_CHECK_CN.equals(curActivity)){
			if("0".equals(somApply.getCurOpinionId())){
				// 修改社会组织状态
				somOrgan.setSorgStatus("22");
				somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
			}
		}else if(Activity.ACT_AUDIT_CN.equals(curActivity)){
			if("1".equals(somApply.getCurOpinionId())){
				// 修改社会组织状态
				somOrgan.setSorgStatus("32");
				// 注销社会组织成员
				ParameterSet pset = new ParameterSet();
				pset.setParameter("SORG_ID", somOrgan.getSorgId());
				pset.setParameter("IF_SERVE", "1");
				DataSet dutyDs = somDutyDomain.query(pset);
				for (int i = 0; i < dutyDs.getCount(); i++) {
					SomDuty somDuty = (SomDuty) dutyDs.getRecord(i).toBean(SomDuty.class);
					somDuty.setIfServe("0");
					somDutyDomain.update(somDuty);
				}
			}
			if("0".equals(somApply.getCurOpinionId())){
				// 修改社会组织状态
				somOrgan.setSorgStatus("22");
			}
			somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		}
		//如果环节是补齐补正，清空业务表的初审审核审批意见
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
		//保存时不记录受理时间，提交时才开始算受理时间
		if(Activity.ACT_ACCEPT_CN.equals(curActivity)){
			somApply.setAcceptTime(DateUtil.getTime());
		}
		// 维护社团成立历史处理意见
		somApplyDomain.dealHisOpinion(somApply);
		// 获取下一环节名称
		List actList = (List)wfMap.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			somApply.setCurActivity(actDefName1);
		}else{
			somApply.setCurActivity("");
			somApply.setIfFinish("1");//设为流程完结
		}
	
		somApplyDomain.emptySomApply(somApply,somApply.getCurActivity());
		somApplyDomain.update(somApply);
	}

	/**
	 * 查询社会组织状态
	 */
	public String querySorgStatus(String sorgId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		DataSet ds = somOrganDomain.query(pset);
		SomOrgan somOrgan = (SomOrgan) ds.getRecord(0).toBean(SomOrgan.class);
		return somOrgan.getSorgStatus();
	}

	/**
	 * 根据sorgId，删除社会组织清算组织人员
	 * 
	 * @param sorgId
	 */
	public void delLiqpeopleBySorgId(String sorgId) {
		somLiqpeopleDomain.deleteBySorgId(sorgId);
	}
	
	/**
	 * 获取最后环节processId
	 */
	public String queryProcessId(String id) {
		return somApplyDomain.queryProcessId(id);
	}
}
