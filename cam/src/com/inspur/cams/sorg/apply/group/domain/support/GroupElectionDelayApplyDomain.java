package com.inspur.cams.sorg.apply.group.domain.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.share.organization.bean.OrganView;
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
import com.inspur.cams.sorg.apply.group.domain.IGroupElectionDelayApplyDomain;
import com.inspur.cams.sorg.base.dao.jdbc.SomElectionDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomElection;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomMeetingDomain;
import com.inspur.cams.sorg.base.domain.ISomSessionDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;
/**
 * 延期换届选举报批domain
 * @author yanliangliang
 * @date 2012年6月25日
 */
public class GroupElectionDelayApplyDomain implements IGroupElectionDelayApplyDomain {
	@Reference
	private SomElectionDao somElectionDao;

	@Reference
	private ISomMeetingDomain somMeetingDomain;
	
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;

	@Reference
	private ISomApplyDomain somApplyDomain;
	
	@Reference
	private ISomFlowDomain somFlowDomain;
	
	@Reference
	private ISomSessionDomain somSessionDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;
	
	public static final String PROC_DEF_UNIQUE_ID = "402881e5382bdce001382bf70ae80001";
	public static final String START_ACT_DEF_ID = "act1";
	/**
	 * 受理保存
	 * @param somApply
	 * @param somElection
	 */
	public String create(SomApply somApply, SomElection somElection) {
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map wfMap=WfTaskRequestWrapper.getInstance().create(somApply.getTaskCode(), somApply.getSorgName()+"的延期换届选举报批申请");
		List actList = (List) wfMap.get("actList");
		Map map1 = (Map) actList.get(0);
		List assList = (List) map1.get("assList");
		Map map2 = (Map) assList.get(0);
		String assignmentId = (String) map2.get("assignmentId");
		String processId = (String) wfMap.get("processId");
		somApply.setProcessId(processId);
		somApply.setApplyType(ApplyType.SOM_GROUP_ELECTION_CHECK_DELAY);
		
		String areaCode = BspUtil.getCorpOrgan().getOrganCode();
		OrganView organView = BspUtil.getCorpOrgan();
		OrganView deptView = BspUtil.getDeptOrgan();
		OrganView peopleView = BspUtil.getEmpOrgan();
		somApply.setCurActivity(Activity.ACT_ACCEPT_CN);
		somApply.setCurOrganId(BspUtil.getCorpOrganId());
		somApply.setCurOrganName(BspUtil.getOrganName());
		somApply.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setCurDeptId(BspUtil.getDeptOrganId());
		somApply.setCurPeopleId(BspUtil.getEmpOrganId());
		somApply.setIfFinish("0");//是否完结
		somApply.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());
		
		if("".equals(somApply.getDataSource())){
			somApply.setDataSource("LOCAL");
		}
		somApply.setAcceptArea(areaCode);
		somApply.setAcceptOrganId(organView.getOrganId());
		somApply.setAcceptOrganName(organView.getOrganName());
		somApply.setAcceptDeptId(deptView.getOrganId());
		somApply.setAcceptDeptName(deptView.getOrganName());
		somApply.setAcceptPeopleId(peopleView.getOrganId());
		somApply.setAcceptPeopleName(peopleView.getOrganName());
		//somApply.setAcceptTime(DateUtil.getTime());
		somApplyDomain.curSomApply(somApply);
		somApplyDomain.insert(somApply);
		// 维护选举信息
		insert(somElection);
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
	 * 受理提交
	 * @param somApply
	 * @param somElection
	 */
	public void createAndSend(SomApply somApply, SomElection somElection) {
		String assignmentId = create(somApply,somElection);
		CommandContext.setContextParameter("assignmentId", assignmentId);
		send(somApply);
	}
	/**
	 * 受理更新保存
	 * @param somApply
	 * @param somElection
	 */
	public void update(SomApply somApply, SomElection somElection) {
		somApplyDomain.update(somApply);
		update(somElection);
	}
	/**
	 * 提交流程
	 * @param somPrepare
	 */
	@SuppressWarnings("unchecked")
	public void send(SomApply somApply) {
		somApplyDomain.curSomApply(somApply);
		//1.记录流程历史意见
		somFlowDomain.insertBySomApply(somApply);
		//2.提交流程
		Map context = new HashMap();
		context.put("organId", BspUtil.getDeptStruId());
		context.put("opinionId", somApply.getCurOpinionId()); 
		Map wfMap = WfTaskRequestWrapper.getInstance().send(context);
		
		String curActivity = somApply.getCurActivity();
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
		if(Activity.ACT_INFORM_CN.equals(curActivity)){
				somApply.setIfFinish("1");
		}
		//保存时不记录受理时间，提交时才开始算受理时间
		if(Activity.ACT_ACCEPT_CN.equals(curActivity)){
			somApply.setAcceptTime(DateUtil.getTime());
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
//*****************************************************************************************************************
//*****************************************************************************************************************
	/**
	 * 保存换届审批信息
	 */
	private void insert(SomElection somElection) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		OrganView empOrgan = BspUtil.getEmpOrgan();
		String time = DateUtil.getTime();
		// 保存会议信息
		SomMeeting somMeeting = new SomMeeting();
		somMeeting.setMeetingId(IdHelp.getUUID32());
		somMeeting.setSorgId(somElection.getSorgId());
		somMeeting.setMeetingName(somElection.getMeetingName());
		somMeeting.setMeetingPlace(somElection.getMeetingPlace());
		somMeeting.setMeetingDate(somElection.getMeetingDate());
		somMeeting.setMainPeople(somElection.getMainPeople());
		somMeeting.setLinkPeople(somElection.getLinkPeople());
		somMeeting.setLinkPhone(somElection.getLinkPhone());
		somMeeting.setMorgName(corpOrgan.getOrganName());
		somMeeting.setMorgArea(corpOrgan.getOrganCode());
		somMeeting.setCreatePeople(empOrgan.getOrganName());
		somMeeting.setCreateTime(time);
		somMeetingDomain.insert(somMeeting);
		// 保存选举信息
		somElection.setElectionId(IdHelp.getUUID32());
		somElection.setMeetingId(somMeeting.getMeetingId());
		somElection.setMorgName(corpOrgan.getOrganName());
		somElection.setMorgArea(corpOrgan.getOrganCode());
		somElection.setCreatePeople(empOrgan.getOrganName());
		somElection.setCreateTime(time);
		somElectionDao.insert(somElection);
	}
	/**
	 *  更新换届审批信息
	 * @param somElection
	 */
	private void update(SomElection somElection) {
		SomMeeting somMeeting = somMeetingDomain.get(somElection.getMeetingId());
		somMeeting.setMeetingName(somElection.getMeetingName());
		somMeeting.setMeetingPlace(somElection.getMeetingPlace());
		somMeeting.setMeetingDate(somElection.getMeetingDate());
		somMeeting.setMainPeople(somElection.getMainPeople());
		somMeeting.setLinkPeople(somElection.getLinkPeople());
		somMeeting.setLinkPhone(somElection.getLinkPhone());
		somMeetingDomain.update(somMeeting);
		somElectionDao.update(somElection);
	}
	
	/**
	 * 更新界次信息中的延期相关字段
	 * @param somElection
	 */
	public void updateSomSession(SomElection somElection){
		//更改当前界次的办理提前/延期标识字段状态，1:提前2:延期
		DataSet currentSessionDataSet = somSessionDomain.getCurrentSession(somElection.getSorgId());
		if (currentSessionDataSet.getCount() > 0) {
			SomSession currentSession = (SomSession) currentSessionDataSet.getRecord(0).toBean(SomSession.class);
			currentSession.setDealFlag("2");
			currentSession.setDelayDate(somElection.getDelayDate());
			currentSession.setDelayReason(somElection.getDelayReason());
			somSessionDomain.update(currentSession);
		}
	}
}
