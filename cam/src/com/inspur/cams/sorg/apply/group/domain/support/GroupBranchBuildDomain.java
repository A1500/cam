package com.inspur.cams.sorg.apply.group.domain.support;

import java.util.ArrayList;
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
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.ProcessLimiteTimeUtil;
import com.inspur.cams.sorg.apply.group.domain.IGroupBranchBuildDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;

/**
 * 社会团体分支成立业务domain实现类
 * @author zhaojin
 * @date 2011-8-23
 */
public class GroupBranchBuildDomain implements IGroupBranchBuildDomain {

	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;

	public static final String PROC_DEF_UNIQUE_ID = "8a898b9d3633517001363351709a0000";
	public static final String START_ACT_DEF_ID = "act9";

	/**
	 * 保存业务数据
	 * @param somPrepare
	 */
	public Map create(SomApply somApply) {
		String time = DateUtil.getTime();
		String areaCode = BspUtil.getCorpOrgan().getOrganCode();
		SomOrgan organBean = somApply.getSomOrgan();
		//1.保存业务数据
		saveBaseInfo(somApply);

		//2.启动流程
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");

		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map wfMap = WfTaskRequestWrapper.getInstance().create(somApply.getTaskCode(), organBean.getCnName() + "成立登记申请");
		String processId = (String) wfMap.get("processId");

		//3.保存业务信息
		somApply.setProcessId(processId);
		somApply.setSorgId(organBean.getSorgId());
		somApply.setApplyType(ApplyType.SOM_GROUP_BRANCH_BUILD);
		somApply.setSorgType(organBean.getSorgType());
		somApply.setSorgName(organBean.getCnName());
		somApply.setBorgName(organBean.getBorgName());
		somApply.setIfFinish("0");
		somApply.setAcceptArea(areaCode);
		somApply.setAcceptOrganId(BspUtil.getCorpOrganId());
		somApply.setAcceptDeptId(BspUtil.getDeptOrganId());
		somApply.setAcceptPeopleId(BspUtil.getEmpOrganId());
		//somApply.setAcceptTime(time);

		somApplyDomain.curSomApply(somApply);
		somApplyDomain.insert(somApply);
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
		return wfMap;
	}

	/**
	 * 新增业务并提交流程
	 * @param somPrepare
	 */
	public void createAndSend(SomApply somApply) {
		Map wfMap = create(somApply);
		somApply.getSomOrgan().setSorgStatus("21");
		somOrganDomain.update(somApply.getSomOrgan());
		String assignmentId = getAssignmentId(wfMap);
		CommandContext.setContextParameter("assignmentId", assignmentId);
		send(somApply);
	}

	/**
	 * 修改业务数据
	 * @param somPrepare
	 */
	public void update(SomApply applyBean) {
		String modPeople = BspUtil.getEmpOrgan().getOrganName();
		String modTime = DateUtil.getTime();
		String morgName = BspUtil.getCorpOrgan().getOrganName();
		String morgArea = BspUtil.getCorpOrgan().getOrganCode();
		//受理单位ID
		String acceptOrganId = BspUtil.getCorpOrganId();
		//受理部门ID
		String acceptDeptId = BspUtil.getDeptOrganId();
		//受理人ID
		String acceptPeopleId = BspUtil.getEmpOrganId();

		SomOrgan somOrgan = applyBean.getSomOrgan();
		somOrgan.setMorgName(morgName);
		somOrgan.setMorgArea(morgArea);
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		String sorgId=somOrgan.getSorgId();
		//处理负责人信息
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		for(int i=0;i<somDutyList.size();i++){
			SomDuty somDuty=somDutyList.get(i);
			somDuty.setIfRenew("0");//是否连任
			somDuty.setRenewNum("0");
			somDuty.setRegStatus("3");//审批中
			somDuty.setCreatePeople(modPeople);
			somDuty.setCreateTime(modTime);
		}
		somSession.setSorgId(sorgId);
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		somDutyDomain.deleteByTaskCode(applyBean.getTaskCode());
		somDutyDomain.regPeople(somSession);
		//更新业务意见信息
		applyBean.setSorgKind(somOrgan.getSorgKind());
		applyBean.setSorgName(somOrgan.getCnName());
		applyBean.setBorgName(somOrgan.getBorgName());
		if(applyBean.getCurActivity().equals(Activity.ACT_REPORT)){
			applyBean.setAcceptOrganId(acceptOrganId);
			applyBean.setAcceptArea(morgArea);
			applyBean.setAcceptDeptId(acceptDeptId);
			applyBean.setAcceptPeopleId(acceptPeopleId);
			applyBean.setAcceptTime(modTime);
		}
		somApplyDomain.curSomApply(applyBean);
		somApplyDomain.update(applyBean);
		somApplyDomain.updateSomApplyInfo(somOrgan);
	}

	/**
	 * 修改保存业务并提交流程
	 * @param somPrepare
	 */
	public void updateAndSend(SomApply somApply) {
		somApply.getSomOrgan().setSorgStatus("21");
		somOrganDomain.update(somApply.getSomOrgan());
		update(somApply);
		send(somApply);
	}

	/**
	 * 更新业务意见信息
	 */
	public void updateApply(SomApply applyBean) {
		//更新业务意见信息
		somApplyDomain.curSomApply(applyBean);
		somApplyDomain.update(applyBean);
	}

	/**
	 * 提交流程
	 * @param somPrepare
	 */
	@SuppressWarnings("unchecked")
	public void send(SomApply somApply) {
		//1.记录流程历史意见
		somApplyDomain.curSomApply(somApply);
		somFlowDomain.insertBySomApply(somApply);

		//2. 调用工作流发送接口
		Map context = new HashMap();
		String struId = BspUtil.getDeptStruId();
		context.put("ORGANID", struId);
		context.put("OPINIONID", somApply.getCurOpinionId());
		Map map = WfTaskRequestWrapper.getInstance().send(context);

		//3. 判断下流程是否结束，结束了给组织机构状态赋值
		String sorgId = somApply.getSorgId();
		String curActivity = somApply.getCurActivity();
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", sorgId);
		DataSet organDS = queryOrgan(pset);
		SomOrgan organBean = (SomOrgan) organDS.getRecord(0).toBean(SomOrgan.class);
		//发证环节
//		if(curActivity.equals(Activity.ACT_FETCH_CN)){
//			// 更新证书信息
//			updateCertInfo(somApply,"1");
//			//设置流程基本信息结束
//			somApply.setIfFinish("1");
//		}

		//流程结束
		if(Activity.ACT_AUDITREPORT_CN.equals(curActivity)||Activity.ACT_ACCEPT_CN.equals(curActivity)||Activity.ACT_EXAM_CN.equals(curActivity)||Activity.ACT_CHECK_CN.equals(curActivity)){
			if("0".equals(somApply.getCurOpinionId())){
				// 修改社会组织状态
				organBean.setSorgStatus("23");
				somOrganDomain.updateAndBuildHis(organBean,somApply.getTaskCode());
				// 修改社会组织成员
				somDutyDomain.updateRegStatus("4",somApply.getTaskCode());
			}
		}else if(Activity.ACT_AUDIT_CN.equals(curActivity)){
			if("1".equals(somApply.getCurOpinionId())){
				// 修改社会组织状态
				organBean.setSorgStatus("22");
				//将登记时间维护上，登记时间为审批通过的时间
				organBean.setRegDate(DateUtil.getDay());
				// 修改社会组织成员
				somDutyDomain.updateRegStatus("1",somApply.getTaskCode());
			}
			if("0".equals(somApply.getCurOpinionId())){
				// 修改社会组织状态
				organBean.setSorgStatus("23");
				// 修改社会组织成员
				somDutyDomain.updateRegStatus("4",somApply.getTaskCode());
			}
			somOrganDomain.updateAndBuildHis(organBean,somApply.getTaskCode());
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
		//保存时不记录受理时间，提交时才开始算受理时间
		if(Activity.ACT_ACCEPT_CN.equals(curActivity)){
			somApply.setAcceptTime(DateUtil.getTime());
		}
		// 维护分支历史意见
		somApplyDomain.dealHisOpinion(somApply);
		// 获取下一环节名称
		List actList = (List)map.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			somApply.setCurActivity(actDefName1);
		}else{
			somApply.setIfFinish("1");
			somApply.setCurActivity("");
		}
		// 更新业务信息中的当前信息
		somApplyDomain.emptySomApply(somApply,somApply.getCurActivity());
		somApplyDomain.update(somApply);
	}

	/**
	 * 发证时更新证书信息
	 * @param somApply
	 * @param certStatus
	 */
	public void updateCertInfo(SomApply somApply,String certStatus){
		List<SomCert> certList = new ArrayList<SomCert>();
		ParameterSet ps=new ParameterSet();
		ps.setParameter("SORG_ID@=", somApply.getSorgId());
		ps.setParameter("CERT_STATUS@=",certStatus);
		DataSet certDS = somCertDomain.query(ps);
		for (int i = 0; i < certDS.getCount(); i++) {
			SomCert certBean = (SomCert) certDS.getRecord(i).toBean(SomCert.class);
			certBean.setFetchPeople(somApply.getMap().get("fetchPeople"));
			certBean.setFetchDate(somApply.getMap().get("fetchDate"));
			certBean.setFetchPhone(somApply.getMap().get("fetchPhone"));
			certBean.setIssuePeople(BspUtil.getEmpOrgan().getOrganName());
			certList.add(certBean);
		}
		somCertDomain.batchUpdate(certList);
	}


	private void saveBaseInfo(SomApply somApply){
		//录入人
		String createPeople = BspUtil.getEmpOrgan().getOrganName();
		//录入时间
		String createTime = DateUtil.getTime();
		//登记管理机关名称
		String morgName = BspUtil.getCorpOrgan().getOrganName();
		//登记管理机关行政区划
		String morgArea = BspUtil.getCorpOrgan().getOrganCode();
		String taskCode=somApply.getTaskCode();
		//set法人信息
		SomOrgan somOrgan = somApply.getSomOrgan();
		String sorgId=somOrgan.getSorgId();
		somOrgan.setSorgType("S");
		//somOrgan.setSorgStatus("21");
		somOrgan.setIfBranch("1");
		somOrgan.setMorgName(morgName);
		somOrgan.setMorgArea(morgArea);
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		//处理负责人信息
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		for(int i=0;i<somDutyList.size();i++){
			SomDuty somDuty=somDutyList.get(i);
			somDuty.setIfRenew("0");//是否连任
			somDuty.setRenewNum("0");
			somDuty.setRegStatus("3");//审批中
			somDuty.setCreatePeople(createPeople);
			somDuty.setCreateTime(createTime);
		}
		somSession.setTaskCode(taskCode);
		somSession.setSorgId(sorgId);
		somSession.setSeq("1");//顺序号
		somSession.setSomDutyList(somDutyList);
		somDutyDomain.regPeople(somSession);
	}



	public void printForSend(SomApply somApply){
		String sorgCode=somApply.getMap().get("sorgCode");
		//创建流程信息
		somApplyDomain.curSomApply(somApply);
		somFlowDomain.insertBySomApply(somApply);
		//查询社会组织
		ParameterSet p = new ParameterSet();
		p.setParameter("SORG_ID@=", somApply.getSorgId());
		SomOrgan organBean = (SomOrgan) somOrganDomain.query(p).getRecord(0).toBean(SomOrgan.class);
		organBean.setSorgCode(sorgCode);
		organBean.setBusinessForPrint(somApply.getMap().get("business"));
		somOrganDomain.updateAndBuildHis(organBean,somApply.getTaskCode());
		//创建新的证书
		SomCert certBean = new SomCert();
		certBean.setId(IdHelp.getUUID30());
		certBean.setTaskCode(somApply.getTaskCode());
		certBean.setSorgId(organBean.getSorgId());
		certBean.setSorgKind(organBean.getSorgKind());
		certBean.setSorgType(organBean.getSorgType());
		certBean.setSorgName(organBean.getCnName());
		certBean.setIfBranch(organBean.getIfBranch());
		certBean.setSorgCode(sorgCode);
		certBean.setOrganCode(organBean.getOrganCode());
		certBean.setBusiness(somApply.getMap().get("business"));
		certBean.setResidence(organBean.getResidence());
		certBean.setLegalPeople(somDutyDomain.getBranchChargePeopleName(somApply.getTaskCode()));
		certBean.setActArea(somApply.getMap().get("actArea"));

		certBean.setRegMon(organBean.getRegMon());
		certBean.setBorgName(organBean.getBorgName());
		certBean.setRegDate(organBean.getRegDate());
		//正本
		certBean.setCertType("0");
		certBean.setSignBeginDate(somApply.getMap().get("beginDate"));
		certBean.setSignEndDate(somApply.getMap().get("endDate"));
		certBean.setSignDate(somApply.getMap().get("PrintDate"));
		certBean.setSignOrgan(BspUtil.getCorpOrgan().getOrganName());
		certBean.setIssueReason("1");
		certBean.setIssueReasonDesc(somApply.getMap().get("issueReasonDesc"));
		certBean.setPrintPeople(BspUtil.getEmpOrgan().getOrganName());
		certBean.setPrintTime(DateUtil.getTime());
		certBean.setCertStatus("1");
		certBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		certBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		certBean.setIfReceive("0");
		certBean.setTaskCode(somApply.getTaskCode());
		//维护发证信息
		certBean.setFetchPeople(somApply.getMap().get("fetchPeople"));
		certBean.setFetchDate(somApply.getMap().get("fetchDate"));
		certBean.setFetchPhone(somApply.getMap().get("fetchPhone"));
		certBean.setIssuePeople(BspUtil.getEmpOrgan().getOrganName());
		//certBean.setSignPeriod(signPeriod);//证件有效期
		somCertDomain.insert(certBean);

		//发送流程
		Map context = new HashMap();
		String struId = BspUtil.getDeptStruId();
		context.put("ORGANID", struId);
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().send(context);
		List actList = (List)map.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			somApply.setCurActivity(actDefName1);
		}else{
			somApply.setIfFinish("1");
			somApply.setCurActivity("");
		}
		somApplyDomain.emptySomApply(somApply,somApply.getCurActivity());
		somApplyDomain.update(somApply);
	}


	public String getAssignmentId(Map wfMap){
		String assignmentId = "";
		List actList = (List)wfMap.get("actList");
		Map actMap = (Map)actList.get(0);
		List assList = (List)actMap.get("assList");
		Map assMap = (Map)assList.get(0);
		assignmentId = (String) assMap.get("assignmentId");
		return assignmentId;
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
}
