package com.inspur.cams.sorg.apply.fund.domain.support;

import java.util.ArrayList;
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
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.ProcessLimiteTimeUtil;
import com.inspur.cams.sorg.apply.fund.domain.IFundBuildDomain;
import com.inspur.cams.sorg.base.dao.ISomPeopleResumeDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyPraiseDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;

public class FundBuildDomain implements IFundBuildDomain {
	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;	
	@Reference
	private ISomDutyDomain somDutyDomain;
	@Reference
	private ISomRuleDomain somRuleDomain;
	
	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomPeopleResumeDao somPeopleResumeDao;
	@Reference
	private ISomAspchiefDomain somAspchiefDomain;
	@Reference
	private ISomPartyMemberDomain somPartyMemberDomain;
	@Reference
	private ISomPartyPraiseDomain somPartyPraiseDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;
	
	
	public static final String PROC_DEF_UNIQUE_ID = "8a898b9d363e008b01363e008bbf0000";
	public static final String START_ACT_DEF_ID = "act3";
	
	/**
	 * 保存名称核准
	 * 
	 * @param dataBean
	 */
	@SuppressWarnings("unchecked")
	public void insertReportInfo(SomApply applyBean) {	
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
	public void createAndSend(SomApply applyBean) {	
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
		somApplyDomain.dealHisOpinion(applyBean);
		emptySomApply(applyBean,Activity.ACT_WATCH_CN);
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
	public void updateReportInfo(SomApply somApply) {
		OrganView organView = BspUtil.getCorpOrgan();
		OrganView deptView = BspUtil.getDeptOrgan();
		OrganView peopleView = BspUtil.getEmpOrgan();
		
		SomOrgan somOrgan = somApply.getSomOrgan();
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		// 处理从表信息
		dealSomHeldPeople(somApply);
		dealSomHeldOrgan(somApply);
		dealSomAspchief(somApply);
		SomSession somSession=somOrgan.getSomSession();

		somDutyDomain.regPeople(somSession);
		
		somApply.setBorgName(somOrgan.getBorgName());
		somApply.setCurOrganId(organView.getOrganId());
		somApply.setCurOrganName(organView.getOrganName());
		somApply.setCurDeptId(deptView.getOrganId());
		somApply.setCurDeptName(deptView.getOrganName());
		somApply.setCurPeopleId(peopleView.getOrganId());
		somApply.setCurPeopleName(peopleView.getOrganName());
		somApplyDomain.update(somApply);	
		somApplyDomain.updateSomApplyInfo(somOrgan);
	}
	
	/**
	 * 更新并发送流程
	 */
	@SuppressWarnings("unchecked")
	public void updateForSendReport(SomApply applyBean) {
		updateReportInfo(applyBean);
		sendReport(applyBean);
	}	
	
	/**
	 * 保存社会团体成立登记
	 * 
	 * @param dataBean
	 */
	@SuppressWarnings("unchecked")
	public void insertBuildInfo(SomApply applyBean) {		
		//保存相关信息
		insertBuildContent(applyBean);
		somApplyDomain.insert(applyBean);
	}
	/**
	 * 业务信息保存创建并发送
	 */
	@SuppressWarnings("unchecked")
	public void saveAndSendBuild(SomApply applyBean) {	
		insertBuildContent(applyBean);
		send(applyBean);
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
		SomSession somSession=somOrgan.getSomSession();
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		somApplyDomain.update(applyBean);
		somApplyDomain.updateSomApplyInfo(somOrgan);
		somRuleDomain.update(somRule);

		somDutyDomain.deleteByTaskCode(applyBean.getTaskCode());
		somSession.setSomDutyList(somDutyList);
		somDutyDomain.regPeople(somSession);		
	}
	/**
	 * 更新并发送流程
	 */
	@SuppressWarnings("unchecked")
	public void updateForSend(SomApply applyBean) {
		updateBuildInfo(applyBean);
		send(applyBean);
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
	public void sendReport(SomApply applyBean) {
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
		// 维护社团成立历史处理意见
		somApplyDomain.dealHisOpinion(applyBean);
		//保存时不记录受理时间，提交时才开始算受理时间
		String curActivity = applyBean.getCurActivity();
		if(Activity.ACT_ACCEPT_CN.equals(curActivity)){
			applyBean.setAcceptTime(DateUtil.getTime());
		}
		List actList = (List)map.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			applyBean.setCurActivity(actDefName1);
		}else{
			applyBean.setCurActivity("");
		}
	
		emptySomApply(applyBean,applyBean.getCurActivity());
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
		
		if(Activity.ACT_FETCH_CN.equals(curActivity)){//发证环节
			List<SomCert> certList = new ArrayList<SomCert>();
			ParameterSet ps=new ParameterSet();
			ps.setParameter("SORG_ID@=", sorgId);
			ps.setParameter("CERT_STATUS@=","1");
			DataSet certDS = somCertDomain.query(ps);
			for (int i = 0; i < certDS.getCount(); i++) {
				SomCert certBean = (SomCert) certDS.getRecord(i).toBean(SomCert.class);
				certBean.setFetchPeople(applyBean.getMap().get("fetchPeople"));
				certBean.setFetchDate(applyBean.getMap().get("fetchDate"));
				certBean.setFetchPhone(applyBean.getMap().get("fetchPhone"));
				certBean.setIssuePeople(BspUtil.getEmpOrgan().getOrganName());
				certList.add(certBean);
			}
			//更新证书信息表领证人和领证日期
			somCertDomain.batchUpdate(certList);
		}
		if(Activity.ACT_REPORT_CN.equals(curActivity)||Activity.ACT_ACCEPT_CN.equals(curActivity)||Activity.ACT_EXAM_CN.equals(curActivity)||Activity.ACT_CHECK_CN.equals(curActivity)){
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
		List actList = (List)map.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			applyBean.setCurActivity(actDefName1);
		}else{
			applyBean.setIfFinish("1");//设为流程完结
			applyBean.setCurActivity("");
		}
	
		somApplyDomain.emptySomApply(applyBean,applyBean.getCurActivity());
		somApplyDomain.update(applyBean);	
	}

	/**
	 * 打印环节发送
	 */
	@SuppressWarnings("unchecked")
	public void printForSend (SomApply applyBean){
		
		saveRegister(applyBean);
		
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		applyBean.setBorgName(applyBean.getSomOrgan().getBorgName());
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(createPeople);
		//创建流程信息
		somFlowDomain.insertBySomApply(applyBean);
		//查询社会组织
		ParameterSet p = new ParameterSet();
		p.setParameter("SORG_ID@=", applyBean.getSorgId());
		SomOrgan organBean = (SomOrgan) somOrganDomain.query(p).getRecord(0).toBean(SomOrgan.class);
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
		certBean.setSorgCode(organBean.getSorgCode());
		certBean.setOrganCode(organBean.getOrganCode());
		certBean.setBusiness(applyBean.getMap().get("business"));
		certBean.setResidence(organBean.getResidence());
		certBean.setLegalPeople(organBean.getLegalPeople());//法定代表人姓名
		certBean.setActArea(organBean.getActArea());
		certBean.setRegMon(organBean.getRegMon());
		certBean.setBorgName(organBean.getBorgName());
		certBean.setRegDate(organBean.getRegDate());
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
		certBean.setCheckResult(applyBean.getMap().get("checkResult"));
		//维护发证信息
		certBean.setFetchPeople(applyBean.getMap().get("fetchPeople"));
		certBean.setFetchDate(applyBean.getMap().get("fetchDate"));
		certBean.setFetchPhone(applyBean.getMap().get("fetchPhone"));
		//certBean.setSignPeriod(signPeriod);//证件有效期
		somCertDomain.insert(certBean);
		//发送流程
		Map context = new HashMap();
		String struId = BspUtil.getDeptStruId();
		context.put("ORGANID", struId);
		context.put("OPINIONID", applyBean.getCurOpinionId());
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
	
	//保存社会组织相关信息
	private void insertReportContent(SomApply applyBean) {			
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		
		SomOrgan somOrgan=applyBean.getSomOrgan();
		String sorgId=somOrgan.getSorgId();	
		somOrgan.setSorgType("J");
		somOrgan.setSorgStatus("21");
		somOrgan.setIfBranch("0");
		somOrgan.setMorgName(morgName);
		somOrgan.setMorgArea(morgCode);
		somOrganDomain.insert(somOrgan);
		
		applyBean.setSorgId(sorgId);
		applyBean.setApplyType(ApplyType.SOM_FUND_BUILD);
		applyBean.setSorgType("J");
		applyBean.setSorgKind(somOrgan.getSorgKind());
		applyBean.setSorgName(somOrgan.getCnName());
		applyBean.setIfFinish("0");	
		applyBean.setAcceptOrganId(BspUtil.getCorpOrganId());
		applyBean.setAcceptArea(morgCode);
		applyBean.setAcceptDeptId(BspUtil.getDeptOrganId());
		applyBean.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setAcceptPeopleId(BspUtil.getEmpOrganId());
		applyBean.setAcceptPeopleName(createPeople);
		applyBean.setAcceptTime(createTime);
		applyBean.setCurActivity(Activity.ACT_REPORT_CN);
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(createPeople);
		applyBean.setBorgName(somOrgan.getBorgName());
		// 处理从表信息
		dealSomHeldPeople(applyBean);
		dealSomHeldOrgan(applyBean);
		dealSomAspchief(applyBean);
	}
	
	//保存社会组织相关信息
	private void insertBuildContent(SomApply applyBean) {	
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		
		String taskCode=applyBean.getTaskCode();
		
		SomOrgan somOrgan=applyBean.getSomOrgan();
		String sorgId=somOrgan.getSorgId();	
		somOrgan.setBorgName(applyBean.getBorgName());
		somOrgan.setSorgType("J");
		somOrgan.setSorgStatus("21");
		somOrgan.setIfBranch("0");
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
	
		SomSession somSession=somOrgan.getSomSession();

		somSession.setTaskCode(taskCode);
		somSession.setSorgId(sorgId);
		somSession.setSeq("1");
		somDutyDomain.regPeople(somSession);
		
		dealSomHeldPeople(applyBean);
		dealSomHeldOrgan(applyBean);
		dealSomAspchief(applyBean);
		
		applyBean.setSorgId(sorgId);
		applyBean.setApplyType(ApplyType.SOM_FUND_BUILD);
		applyBean.setSorgType("J");
		applyBean.setSorgKind(somOrgan.getSorgKind());
		applyBean.setSorgName(somOrgan.getCnName());
		applyBean.setIfFinish("0");	
		applyBean.setAcceptOrganId(BspUtil.getCorpOrganId());
		applyBean.setAcceptArea(morgCode);
		applyBean.setAcceptDeptId(BspUtil.getDeptOrganId());
		applyBean.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setAcceptPeopleId(BspUtil.getEmpOrganId());
		applyBean.setAcceptPeopleName(createPeople);
		//applyBean.setAcceptTime(createTime);
		applyBean.setBorgName(somOrgan.getBorgName());
		applyBean.setCurActivity(Activity.ACT_ACCEPT_CN);
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());
	}
	/**
	 * 处理备案人员
	 * @param applyBean
	 */
	private void dealSomAspchief(SomApply applyBean) {
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		SomOrgan somOrgan = applyBean.getSomOrgan();
		List<SomAspchief> somAspchiefList=somOrgan.getSomAspchiefList();
		if(somAspchiefList!=null){
			for (int i = 0; i < somAspchiefList.size(); i++) {
				SomAspchief somAspchief =  somAspchiefList.get(i);
				String id=IdHelp.getUUID32();
				if(somAspchief.getId().length() != 32){
					somAspchief.setId(id);
					somAspchief.setSorgId(somOrgan.getSorgId());
					somAspchief.setTaskCode(applyBean.getTaskCode());
					somAspchief.setMorgArea(morgCode);
					somAspchief.setMorgName(morgName);
					somAspchief.setCreatePeople(createPeople);
					somAspchief.setCreateTime(createTime);
					somAspchiefDomain.insert(somAspchief);
				}else{
					id=somAspchief.getId();
					somAspchiefDomain.update(somAspchief);
				}
				//处理简历
				List<SomPeopleResume> somResumeList=somAspchief.getSomPeopleResumeList();			
				if(somResumeList!=null){
					somPeopleResumeDao.deleteResumeByDutyId(id);
					for (int j = 0; j < somResumeList.size(); j++) {
						SomPeopleResume somResume = somResumeList.get(j);
						somResume.setId(IdHelp.getUUID32());
						somResume.setDutyId(id);
						somResume.setTaskCode(applyBean.getTaskCode());
						somPeopleResumeDao.insert(somResume);	
					}		
				}	
			}
		}
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
	/**
	 * 登记发证时保存数据
	 */
	public void saveRegister(SomApply somApply) {
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		String taskCode=somApply.getTaskCode();	
		SomOrgan somOrgan=somApply.getSomOrgan();
		String sorgId=somOrgan.getSorgId();
		//处理章程
		SomRule somRule=somOrgan.getSomRule();
		if(somRule.getRuleId()==null || "".equals(somRule.getRuleId())){
			somRule.setSorgId(sorgId);
			somRule.setTaskCode(taskCode);
			somRule.setRegStatus("1");
			somRuleDomain.insertWithOutMeetingInfo(somRule);
		}else{
			somRuleDomain.update(somRule);
		}
		//处理organ
		somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		SomSession somSession=somOrgan.getSomSession();
		List<SomDuty> somDutyList=somOrgan.getSomDutyList();
		somSession.setSomDutyList(somDutyList);
		somSession.setDealType("insert");
		somDutyDomain.deleteByTaskCode(taskCode);//先删除原来的任职信息
		somDutyDomain.regPeople(somSession);
		somDutyDomain.updateRegStatus("1",somApply.getTaskCode());
		dealSomPartyMember(somApply);
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
