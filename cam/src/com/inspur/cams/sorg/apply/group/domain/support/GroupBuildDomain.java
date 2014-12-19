package com.inspur.cams.sorg.apply.group.domain.support;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.ProcessLimiteTimeUtil;
import com.inspur.cams.sorg.apply.group.domain.IGroupBuildDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomFee;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFeeDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyPraiseDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;
public class GroupBuildDomain implements IGroupBuildDomain {
	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	@Reference
	private ISomRuleDomain somRuleDomain;
	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomFeeDomain somFeeDomain;
	@Reference
	private ISomPartyMemberDomain somPartyMemberDomain;
	@Reference
	private ISomPartyPraiseDomain somPartyPraiseDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;
	
	public static final String PROC_DEF_UNIQUE_ID = "402881e531b8abfc0131b8c592540008";
	public static final String START_ACT_DEF_ID = "act1";
	
	/**
	 * 保存社会团体成立登记
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
		somApplyDomain.insert(applyBean);
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		if(applyBean.getDataSource().equals("ONLINE")){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", applyBean.getTaskCode());
			DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
			for(int i = 0;i<ds.getCount();i++){
				SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
				bean.setSorgId(applyBean.getSorgId());
				somElectronicDomain.update(bean);
			}
		}

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
		// 调用工作流发送接口
		Map map = WfTaskRequestWrapper.getInstance().createAndSend(applyBean.getTaskCode(),applyBean.getSomOrgan().getCnName() + "的成立申请",context);
		String processId = (String) map.get("processId");
		//set业务意见信息
		applyBean.setProcessId(processId);
		somApplyDomain.emptySomApply(applyBean,Activity.ACT_EXAM_CN);
		applyBean.setAcceptTime(DateUtil.getTime());
		somApplyDomain.insert(applyBean);	
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		if(applyBean.getDataSource().equals("ONLINE")){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", applyBean.getTaskCode());
			DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
			for(int i = 0;i<ds.getCount();i++){
				SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
				bean.setSorgId(applyBean.getSorgId());
				somElectronicDomain.update(bean);
			}
		}
	}
	/**
	 * 更新社会团体成立登记
	 * 
	 * @param dataBean
	 */
	public void updateBuildInfo(SomApply applyBean) {
		SomOrgan somOrgan=applyBean.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		SomRule somRule=somOrgan.getSomRule();
		SomFee somFee=somOrgan.getSomFee();
		SomSession somSession=somOrgan.getSomSession();
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		
		applyBean.setBorgName(somOrgan.getBorgName());
		somApplyDomain.update(applyBean);
		somRuleDomain.update(somRule);
		somFeeDomain.update(somFee);

		somDutyDomain.deleteByTaskCode(applyBean.getTaskCode());
		somSession.setSomDutyList(somDutyList);
		somDutyDomain.regPeople(somSession);
		dealSomPartyMember(applyBean);
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
		somApplyDomain.curSomApply(applyBean);
		somApplyDomain.update(applyBean);
		
	}
	/**
	 * 发送到下一环节
	 */
	@SuppressWarnings("unchecked")
	public void send(SomApply applyBean) {
		//创建意见信息
		somApplyDomain.curSomApply(applyBean);
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
		if(Activity.ACT_EXAM_CN.equals(curActivity)||Activity.ACT_CHECK_CN.equals(curActivity)){
			if("0".equals(applyBean.getCurOpinionId())){
				// 修改社会组织状态
				organBean.setSorgStatus("23");
				somOrganDomain.updateAndBuildHis(organBean,applyBean.getTaskCode());
				// 修改社会组织成员
				somDutyDomain.updateRegStatus("4",applyBean.getTaskCode());
			}
		}else if(Activity.ACT_AUDIT_CN.equals(curActivity)){
			if("1".equals(applyBean.getCurOpinionId())){
				// 修改社会组织状态
				organBean.setSorgStatus("22");
				// 修改社会组织成员
				somDutyDomain.updateRegStatus("1",applyBean.getTaskCode());
			}
			if("0".equals(applyBean.getCurOpinionId())){
				// 修改社会组织状态
				organBean.setSorgStatus("23");
				// 修改社会组织成员
				somDutyDomain.updateRegStatus("4",applyBean.getTaskCode());
			}
			somOrganDomain.updateAndBuildHis(organBean,applyBean.getTaskCode());
		}
		//如果环节是补齐补正，清空业务表的初审审核审批意见
		//如果环节是补齐补正，清空业务表的初审审核审批意见
		if(Activity.ACT_SUPPLY_CN.equals(curActivity)){
			somApplyDomain.emptyExamToAudit(applyBean);
			//补齐补正重新计算超时时间
			ProcessLimiteTimeUtil.reCreateProcessLimit(applyBean.getProcessId());
		}
		if(applyBean.getCurOpinionId().equals("2")){
			//转补齐补正时将超时时间置无限大
			ProcessLimiteTimeUtil.updateMaxProcessLimit(applyBean.getProcessId());
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
			applyBean.setIfFinish("1");
			applyBean.setCurActivity("");
		}
		// 更新业务信息中的当前信息
		somApplyDomain.emptySomApply(applyBean,applyBean.getCurActivity());
		somApplyDomain.update(applyBean);	
	}

	/**
	 * 打印环节发送
	 */
	@SuppressWarnings("unchecked")
	public void printForSend (SomApply applyBean){
		//创建流程信息
		somApplyDomain.curSomApply(applyBean);
		somFlowDomain.insertBySomApply(applyBean);
		//查询社会组织
		ParameterSet p = new ParameterSet();
		p.setParameter("SORG_ID@=", applyBean.getSorgId());
		SomOrgan organBean = (SomOrgan) somOrganDomain.query(p).getRecord(0).toBean(SomOrgan.class);
		organBean.setOrganCode(applyBean.getMap().get("organCode"));
		organBean.setSorgCode(applyBean.getMap().get("sorgCode"));
		organBean.setRegDate(applyBean.getMap().get("regDate"));
		//维护打印证书上显示的业务范围
		organBean.setBusinessForPrint(applyBean.getMap().get("business"));
		somOrganDomain.updateAndBuildHis(organBean,applyBean.getTaskCode());
		//创建新的证书
		SomCert certBean = new SomCert();
		certBean.setId(IdHelp.getUUID30());
		certBean.setTaskCode(applyBean.getTaskCode());
		certBean.setSorgId(organBean.getSorgId());
		certBean.setSorgKind(organBean.getSorgKind());
		certBean.setSorgType(organBean.getSorgType());
		certBean.setSorgName(organBean.getCnName());
		certBean.setIfBranch(organBean.getIfBranch());
		certBean.setSorgCode(applyBean.getMap().get("sorgCode"));
		certBean.setOrganCode(organBean.getOrganCode());
		certBean.setBusiness(applyBean.getMap().get("business"));
		certBean.setResidence(organBean.getResidence());
		certBean.setLegalPeople(somDutyDomain.getLegalPeopleName(applyBean.getTaskCode()));//法定代表人姓名
		certBean.setActArea(organBean.getActArea());
		certBean.setRegMon(organBean.getRegMon());
		certBean.setBorgName(organBean.getBorgName());
		certBean.setRegDate(applyBean.getMap().get("regDate"));
		certBean.setCertType("0");
		certBean.setSignBeginDate(applyBean.getMap().get("beginDate"));
		certBean.setSignEndDate(applyBean.getMap().get("endDate"));
		certBean.setSignDate(applyBean.getMap().get("PrintDate"));
		certBean.setSignOrgan(BspUtil.getCorpOrgan().getOrganName());
		certBean.setIssueReason("1");
		certBean.setIssueReasonDesc(applyBean.getMap().get("issueReasonDesc"));
		certBean.setPrintPeople(BspUtil.getEmpOrgan().getOrganName());
		certBean.setPrintTime(DateUtil.getTime());
		certBean.setCertStatus("1");
		certBean.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		certBean.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		certBean.setIfReceive("0");
		//维护发证信息
		certBean.setFetchPeople(applyBean.getMap().get("fetchPeople"));
		certBean.setFetchDate(applyBean.getMap().get("fetchDate"));
		certBean.setFetchPhone(applyBean.getMap().get("fetchPhone"));
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
			applyBean.setCurActivity(actDefName1);
		}else{
			applyBean.setIfFinish("1");
			applyBean.setCurActivity("");
		}
		somApplyDomain.emptySomApply(applyBean,applyBean.getCurActivity());
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
	 * 通过processId获取photoId
	 */
	public String queryPhotoId(String processId) {
		return somApplyDomain.queryPhotoIdByProcessId(processId);
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
	 * 分支基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryBranch(ParameterSet pset) {
		pset.setParameter("IF_BRANCH@=", "1");
		DataSet ds = queryOrgan(pset);
		if (ds.getCount() > 0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record = ds.getRecord(i);
				ParameterSet p = new ParameterSet();
				p.setParameter("SORG_ID@=", record.get("mainSorgId"));
				record.set("name", queryMain(p).getRecord(0).get("cnName"));
			}
		}
		return ds;
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
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		SomRule somRule=somOrgan.getSomRule();
		SomFee somFee=somOrgan.getSomFee();
		SomSession somSession=somOrgan.getSomSession();
		
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		String taskCode=applyBean.getTaskCode();
		String sorgId=somOrgan.getSorgId();	
		
		//保存社会组织基本信息
		somOrgan.setSorgStatus("21");
		somOrgan.setMorgName(morgName);
		somOrgan.setMorgArea(morgCode);
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		
		//保存届次和任职基本信息
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
		//因为是根据换届信息选择的，sessionid有值，session还没有插入过，所以需要此处置状态进行插入
		somSession.setDealType("insert");
		somDutyDomain.regPeople(somSession);
		
		//保存章程基本信息
		somRule.setSorgId(sorgId);
		somRule.setTaskCode(taskCode);
		somRule.setRuleId(IdHelp.getUUID32());
		somRule.setMorgName(morgName);
		somRule.setMorgArea(morgCode);
		somRule.setCreatePeople(createPeople);
		somRule.setCreateTime(createTime);
		somRule.setRegStatus("3");//审批中
		somRuleDomain.insertWithOutMeetingInfo(somRule);
		
		//保存会费标准基本信息
		somFee.setSorgId(sorgId);
		somFee.setTaskCode(taskCode);
		somFee.setFeeId(IdHelp.getUUID32());
		somFee.setMorgName(morgName);
		somFee.setMorgArea(morgCode);
		somFee.setCreatePeople(createPeople);
		somFee.setCreateTime(createTime);
		somFee.setRegStatus("3");//审批中
		somFeeDomain.insertWithOutMeetingInfo(somFee);
		
		dealSomPartyMember(applyBean);
		
		//保存业务表基本信息
		applyBean.setSorgId(sorgId);
		applyBean.setApplyType(ApplyType.SOM_GROUP_BUILD);
		applyBean.setSorgType("S");
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
		//applyBean.setAcceptTime(createTime);
		applyBean.setCurActivity(Activity.ACT_ACCEPT_CN);
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(createPeople);
		if(applyBean.getDataSource().equals("ONLINE")){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("TASK_CODE", applyBean.getTaskCode());
			DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
			for(int i = 0;i<ds.getCount();i++){
				SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
				bean.setSorgId(applyBean.getSorgId());
				somElectronicDomain.update(bean);
			}
		}
	}
	/**
	 * 保存照片并返回照片Id
	 */
	public String savePhoto(String photoText) {
		return somPeopleDomain.savePhoto(photoText);
	}

	/**
	 * 更新照片
	 */
	public String updatePhoto(String photoId, String photoText) {
		return somPeopleDomain.updatePhoto(photoId, photoText);
	}
	// 获取党员
	private void dealSomPartyMember(SomApply somApply) {
		String morgName = BspUtil.getCorpOrgan().getOrganName();
		String morgArea = BspUtil.getCorpOrgan().getOrganCode();
		String regPeopleOrganId = BspUtil.getEmpOrganId();
		String regPeople = BspUtil.getEmpOrgan().getOrganName();
		String regDate = DateUtil.getDay();
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomPartyMember> somPartyMemberList = somOrgan.getSomPartyMemberList();
		somPartyMemberDomain.deleteBySorgId(somOrgan.getSorgId());
		for (int i = 0; i < somPartyMemberList.size(); i++) {
			SomPartyMember somPartyMember = somPartyMemberList.get(i);
			somPartyMember.setMorgArea(morgArea);
			somPartyMember.setMorgName(morgName);
			somPartyMember.setRegPeopleOrganId(regPeopleOrganId);
			somPartyMember.setRegPeople(regPeople);
			somPartyMember.setRegDate(regDate);
			somPartyMemberDomain.insert(somPartyMember);
			//somPartyPraiseDomain.deleteByMemberId(somPartyMember.getMemberId());
			List<SomPartyPraise> somPartyPraiseList=somPartyMember.getSomPartyPraiseList();
			for (int j = 0; j < somPartyPraiseList.size(); j++) {
				SomPartyPraise somPartyPraise=somPartyPraiseList.get(j);
				if (somPartyPraise.getMemberId().equals(somPartyMember.getMemberId())) {
					if(somPartyPraise.getPraiseId()==null ||"".equals(somPartyPraise.getPraiseId())){
						somPartyPraise.setPraiseId(IdHelp.getUUID32());
						somPartyPraiseDomain.insert(somPartyPraise);
					}else{
						somPartyPraiseDomain.update(somPartyPraise);
					}
				}
			}
		}
	}
}
