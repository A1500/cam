package com.inspur.cams.sorg.apply.fund.domain.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.sorg.apply.fund.domain.IFundBranchAPCheckDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;
public class FundBranchAPCheckDomain implements IFundBranchAPCheckDomain {
	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;
	
	public static final String PROC_DEF_UNIQUE_ID = "4028b8813390943301339126e163008f";
	public static final String START_ACT_DEF_ID = "act1";
	
	/**
	 * 基金会异地设立分支（代表）机构的审查保存
	 * 
	 * @param dataBean
	 */
	@SuppressWarnings("unchecked")
	public void insertBuildInfo(SomApply applyBean) {		
		//保存相关信息
		insertBuildContent(applyBean);
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map context = new HashMap();
		String struId = BspUtil.getDeptStruId();
		context.put("ORGANID", struId);
			// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().create(applyBean.getTaskCode(),applyBean.getSomOrgan().getCnName() + "的成立申请");
		String processId = (String) map.get("processId");
		applyBean.setProcessId(processId);
		applyBean.setAcceptTime("");
		somApplyDomain.insert(applyBean);

	}
	/**
	 * 业务信息保存创建并发送
	 */
	@SuppressWarnings("unchecked")
	public void saveAndSendBuild(SomApply applyBean) {	
		insertBuildContent(applyBean);	
		//保存意见信息
		somFlowDomain.insertBySomApply(applyBean);
		//创建并发送流程
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map context = new HashMap();
		String struId = BspUtil.getDeptStruId();
		context.put("ORGANID", struId);
		context.put("OPINIONID", applyBean.getCurOpinionId());
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().createAndSend(applyBean.getTaskCode(),applyBean.getSomOrgan().getCnName() + "的成立申请",context);
		String processId = (String) map.get("processId");
		//set业务意见信息
		applyBean.setProcessId(processId);
		emptySomApply(applyBean,Activity.ACT_EXAM_CN);
		somApplyDomain.insert(applyBean);	
		
	}
	/**
	 * 更新基金会异地设立分支（代表）机构的审查受理
	 * 
	 * @param dataBean
	 */
	public void updateBuildInfo(SomApply applyBean) {
		SomOrgan somOrgan=applyBean.getSomOrgan();
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		applyBean.setBorgName(somOrgan.getBorgName());
		somApplyDomain.update(applyBean);
		
	}
	/**
	 * 更新并发送流程
	 */
	@SuppressWarnings("unchecked")
	public void updateForSend(SomApply somApply) {
		updateBuildInfo(somApply);
		send(somApply);
		somApplyDomain.update(somApply);
	}
	
	/**
	 * 更新业务意见信息
	 */
	public void updateApply(SomApply applyBean) {
		//更新业务意见信息
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurPeopleId(BspUtil.getEmpOrgan().getOrganId());
		applyBean.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());
		
		somApplyDomain.update(applyBean);
		
	}
	/**
	 * 发送到下一环节
	 */
	@SuppressWarnings("unchecked")
	public void send(SomApply applyBean) {
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(createPeople);
		//创建意见信息
		somFlowDomain.insertBySomApply(applyBean);
		// 调用工作流发送接口
		Map context = new HashMap();
		String struId = BspUtil.getDeptStruId();
		context.put("ORGANID", struId);
		context.put("OPINIONID", applyBean.getCurOpinionId());
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		// 判断下流程是否结束，结束了给组织机构状态赋值
		String sorgId = applyBean.getSorgId();
		String curActivity = applyBean.getCurActivity();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		DataSet organDS = queryOrgan(pset);
		SomOrgan organBean = (SomOrgan) organDS.getRecord(0).toBean(SomOrgan.class);
		// 获得任职信息
		pset.clear();
		pset.setParameter("TASK_CODE", applyBean.getTaskCode());
		//流程结束
		if(Activity.ACT_EXAM_CN.equals(curActivity)||Activity.ACT_CHECK_CN.equals(curActivity)||Activity.ACT_ACCEPT_CN.equals(curActivity)){
			if("0".equals(applyBean.getCurOpinionId())){
				// 修改社会组织状态
				organBean.setSorgStatus("16");
				somOrganDomain.updateAndBuildHis(organBean,applyBean.getTaskCode());
			}
		}
		if (Activity.ACT_AUDIT_CN.equals(curActivity)) { 
			if ("1".equals(applyBean.getCurOpinionId())) {
				// 修改社会组织状态
				organBean.setSorgStatus("15");
			} else if ("0".equals(applyBean.getCurOpinionId())) {
				// 修改社会组织状态
				organBean.setSorgStatus("16");
			}
			somOrganDomain.updateAndBuildHis(organBean,applyBean.getTaskCode());
		} 
		//如果环节是补齐补正，清空业务表的初审审核审批意见
		if(Activity.ACT_SUPPLY_CN.equals(curActivity)){
			somApplyDomain.emptyExamToAudit(applyBean);
		}
		//保存时不记录受理时间，提交时才开始算受理时间
		if(Activity.ACT_ACCEPT_CN.equals(curActivity)){
			applyBean.setAcceptTime(DateUtil.getTime());
		}
		// 维护社团成立历史处理意见
		somApplyDomain.dealHisOpinion(applyBean);
		// 获取下一环节名称
		List actList = (List)map.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			applyBean.setCurActivity(actDefName1);
		}else{
			applyBean.setCurActivity("");
		}
		// 更新业务信息中的当前信息
		emptySomApply(applyBean,applyBean.getCurActivity());
		somApplyDomain.update(applyBean);	
	}

	
	/**
	 * 获取最后环节processId
	 */
	public String queryProcessId(String id) {
		return somApplyDomain.queryProcessId(id);
	}
	
	/**
	 * 通过processId获取taskCode
	 */
	public SomApply queryTaskCode(String processId){
		return somApplyDomain.queryTaskCodeByProcessId(processId);
	}
	
	
	/**
	 * 社会组织的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryOrgan(ParameterSet pset) {
		return somOrganDomain.query(pset);
	}
	/**
	 * 主体基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMain(ParameterSet pset) {
		pset.setParameter("IF_BRANCH@=", "0");
		return queryOrgan(pset);
	}
	/**
	 * 业务流程意见表查询
	 */
	public DataSet queryFlow(ParameterSet pset){
		return somFlowDomain.query(pset);
	}
	
	/**
	 * 保存社会组织相关信息
	 */
	private void insertBuildContent(SomApply applyBean) {	
		SomOrgan somOrgan=applyBean.getSomOrgan();
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		String sorgId=somOrgan.getSorgId();	
		
		//保存社会组织基本信息
		somOrgan.setSorgStatus("14");
		somOrgan.setMorgName(morgName);
		somOrgan.setMorgArea(morgCode);
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		
		
		//保存业务表基本信息
		applyBean.setSorgId(sorgId);
		applyBean.setApplyType(ApplyType.SOM_FUND_BRANCH_ANOTHER_PLACE_CHECK);
		applyBean.setSorgType("J");
		applyBean.setSorgKind(somOrgan.getSorgKind());
		applyBean.setSorgName(somOrgan.getCnName());
		applyBean.setBorgName(somOrgan.getBorgName());
		applyBean.setIfFinish("0");
		applyBean.setAcceptOrganId(BspUtil.getCorpOrganId());
		applyBean.setAcceptArea(morgCode);
		applyBean.setAcceptDeptId(BspUtil.getDeptOrganId());
		applyBean.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setAcceptPeopleId(BspUtil.getEmpOrganId());
		applyBean.setAcceptPeopleName(createPeople);
		applyBean.setAcceptTime(createTime);
		applyBean.setCurActivity(Activity.ACT_ACCEPT_CN);
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(createPeople);
	}
	/**
	 * 更新业务信息中的当前信息
	 * @param applyBean 业务信息
	 * @param activityName 当前环节名称
	 */
	private void emptySomApply(SomApply applyBean, String activityName) {
		applyBean.setCurActivity(activityName);
		applyBean.setCurOrganId("");
		applyBean.setCurDeptId("");
		applyBean.setCurPeopleId("");
		applyBean.setCurOpinion("");
		applyBean.setCurOpinionId("");
	}
	
}
