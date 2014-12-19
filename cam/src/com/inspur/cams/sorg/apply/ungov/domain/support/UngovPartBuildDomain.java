package com.inspur.cams.sorg.apply.ungov.domain.support;

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
import com.inspur.cams.sorg.apply.ungov.domain.IUngovPartBuildDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomOfficeDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyMemberDomain;
import com.inspur.cams.sorg.base.domain.ISomPartyPraiseDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.ApplyType;

public class UngovPartBuildDomain implements IUngovPartBuildDomain {
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
	private ISomHeldPeopleDomain somHeldPeopleDomain;
	@Reference
	private ISomHeldOrganDomain somHeldOrganDomain;
	@Reference
	private ISomOfficeDomain somOfficeDomain;
	@Reference
	private ISomPartyMemberDomain somPartyMemberDomain;
	@Reference
	private ISomPartyPraiseDomain somPartyPraiseDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;
	
	public static final String PROC_DEF_UNIQUE_ID = "8a898b9d363934c4013639411dc90033";
	public static final String START_ACT_DEF_ID = "act3";
	
	/**
	 * 保存民办非企业成立登记
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
		somApplyDomain.emptySomApply(applyBean,Activity.ACT_WATCH_CN);
		//保存时不记录受理时间，提交时才开始算受理时间
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
	 * 业务信息保存创建并发送
	 */
	@SuppressWarnings("unchecked")
	public void saveAndSendBuild(SomApply applyBean) {	
		insertBuildContent(applyBean);	
		send(applyBean);
	}
	/**
	 * 更新民办非企业成立登记
	 * 
	 * @param dataBean
	 */
	public void updateBuildInfo(SomApply applyBean) {
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		
		SomOrgan somOrgan=applyBean.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		SomRule somRule=somOrgan.getSomRule();
		SomSession somSession=somOrgan.getSomSession();
		List<SomHeldPeople> heldPeopleList = somOrgan.getSomHeldPeopleList();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		List<SomOffice> somOfficeList = somOrgan.getSomOfficeList();
		
		somOrgan.setBorgName(applyBean.getBorgName());
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		somApplyDomain.update(applyBean);
		somApplyDomain.updateSomApplyInfo(somOrgan);
		somRuleDomain.update(somRule);
		somHeldPeopleDomain.deleteBySorgId(applyBean.getSorgId());
		for (int i = 0; i < heldPeopleList.size(); i++) {
			SomHeldPeople heldPeopleBean = heldPeopleList.get(i);
			heldPeopleBean.setId(IdHelp.getUUID30());
			heldPeopleBean.setTaskCode(applyBean.getTaskCode());
			heldPeopleBean.setSorgId(somOrgan.getSorgId());
			heldPeopleBean.setIfChief("0");
			heldPeopleBean.setMorgName(morgName);
			heldPeopleBean.setMorgArea(morgCode);
			heldPeopleBean.setCreatePeople(createPeople);
			heldPeopleBean.setCreateTime(createTime);
			somHeldPeopleDomain.insert(heldPeopleBean);
		}
		somHeldOrganDomain.deleteBySorgId(applyBean.getSorgId());
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
				somHeldOrgan.setId(IdHelp.getUUID32());
				somHeldOrgan.setTaskCode(applyBean.getTaskCode());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setMorgName(morgName);
				somHeldOrgan.setMorgArea(morgCode);
				somHeldOrgan.setCreatePeople(createPeople);
				somHeldOrgan.setCreateTime(createTime);
				somHeldOrganDomain.insert(somHeldOrgan);
		}
		for (int i = 0; i < somOfficeList.size(); i++) {
			SomOffice somOffice = somOfficeList.get(i);
			if(somOffice.getId().equals("")){
				somOffice.setId(IdHelp.getUUID30());
				somOffice.setSorgId(somOrgan.getSorgId());
				somOffice.setTaskCode(applyBean.getTaskCode());
				somOffice.setSorgType("M");
				somOffice.setMorgName(morgName);
				somOffice.setMorgArea(morgCode);
				somOffice.setCreatePeople(createPeople);
				somOffice.setCreateTime(createTime);
				somOfficeDomain.insert(somOffice);
			}else{
				if(somOffice.getState() == Record.STATE_MODIFIED){
					somOfficeDomain.update(somOffice);
				}
				if(somOffice.getState() == Record.STATE_DELETED){
					somOfficeDomain.delete(somOffice);
				}
			}
		}
		somDutyDomain.deleteByTaskCode(applyBean.getTaskCode());
		somSession.setSomDutyList(somDutyList);
		somDutyDomain.regUngovPeople(somSession);
		dealSomPartyMember(applyBean);
	}
	/**
	 * 更新并发送流程
	 */
	public void updateForSend(SomApply somApply) {
		updateBuildInfo(somApply);
		//2.发送流程
		send(somApply);
	}
	
	
	/**
	 * 发送到下一环节
	 */
	@SuppressWarnings("unchecked")
	public void send(SomApply applyBean) {
		//1.记录流程历史意见
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
			applyBean.setCurActivity("");
			applyBean.setIfFinish("1");//设为流程完结
		}
		somApplyDomain.emptySomApply(applyBean,applyBean.getCurActivity());
		somApplyDomain.update(applyBean);	
	}

	/**
	 * 打印环节发送
	 */
	public void printForSend (SomApply applyBean){
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());
		
		//查询民办非企业
		ParameterSet p = new ParameterSet();
		p.setParameter("SORG_ID@=", applyBean.getSorgId());
		SomOrgan organBean = (SomOrgan) somOrganDomain.query(p).getRecord(0).toBean(SomOrgan.class);
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
		certBean.setOrganCode(applyBean.getMap().get("organCode"));
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
		certBean.setFetchPeople(applyBean.getMap().get("fetchPeople"));
		certBean.setFetchDate(applyBean.getMap().get("fetchDate"));
		certBean.setFetchPhone(applyBean.getMap().get("fetchPhone"));
		certBean.setIssuePeople(BspUtil.getEmpOrgan().getOrganName());
		//certBean.setSignPeriod(signPeriod);//证件有效期
		somCertDomain.insert(certBean);
		organBean.setSorgCode(applyBean.getMap().get("sorgCode"));
		organBean.setOrganCode(applyBean.getMap().get("organCode"));
		organBean.setRegDate(applyBean.getMap().get("regDate"));
		organBean.setBusinessForPrint(applyBean.getMap().get("business"));
		somOrganDomain.updateAndBuildHis(organBean,applyBean.getTaskCode());
		//发送流程
		send(applyBean);
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
	 * 民办非企业的查询操作
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
	
	
	//保存民办非企业相关信息
	private void insertBuildContent(SomApply applyBean) {	
		SomOrgan somOrgan=applyBean.getSomOrgan();
		List<SomDuty> somDutyList = somOrgan.getSomDutyList();
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		List<SomOffice> somOfficeList = somOrgan.getSomOfficeList();
		SomRule somRule=somOrgan.getSomRule();
		SomSession somSession=somOrgan.getSomSession();
		
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		String taskCode=applyBean.getTaskCode();
		String sorgId=somOrgan.getSorgId();		
		
		somOrgan.setBorgName(applyBean.getBorgName());
		somOrganDomain.updateAndBuildHis(somOrgan,applyBean.getTaskCode());
		somApplyDomain.updateSomApplyInfo(somOrgan);
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
		somDutyDomain.regUngovPeople(somSession);
		somHeldPeopleDomain.deleteBySorgId(applyBean.getSorgId());
		for (int i = 0; i < somHeldPeopleList.size(); i++) {
			SomHeldPeople heldPeopleBean = somHeldPeopleList.get(i);
			heldPeopleBean.setId(IdHelp.getUUID30());
			heldPeopleBean.setTaskCode(applyBean.getTaskCode());
			heldPeopleBean.setSorgId(somOrgan.getSorgId());
			heldPeopleBean.setIfChief("0");
			heldPeopleBean.setMorgName(morgName);
			heldPeopleBean.setMorgArea(morgCode);
			heldPeopleBean.setCreatePeople(createPeople);
			heldPeopleBean.setCreateTime(createTime);
			somHeldPeopleDomain.insert(heldPeopleBean);
		}
		somHeldOrganDomain.deleteBySorgId(applyBean.getSorgId());
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
				somHeldOrgan.setId(IdHelp.getUUID32());
				somHeldOrgan.setTaskCode(applyBean.getTaskCode());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setMorgName(morgName);
				somHeldOrgan.setMorgArea(morgCode);
				somHeldOrgan.setCreatePeople(createPeople);
				somHeldOrgan.setCreateTime(createTime);
				somHeldOrganDomain.insert(somHeldOrgan);
		}
		
		for(int i=0;i<somOfficeList.size();i++){
			SomOffice somOffice=somOfficeList.get(i);
			somOffice.setSorgId(sorgId);
			somOffice.setTaskCode(taskCode);
			somOffice.setSorgType("M");
			somOfficeDomain.insert(somOffice);
		}
		somRule.setSorgId(sorgId);
		somRule.setTaskCode(taskCode);
		somRule.setRegStatus("3");//审批中
		somRuleDomain.insert(somRule);
		applyBean.setSorgId(sorgId);
		applyBean.setApplyType(ApplyType.SOM_UNGOV_BUILD_PARTNERSHIP);
		applyBean.setSorgType("M");
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
		applyBean.setCurActivity(Activity.ACT_ACCEPT_CN);
		applyBean.setCurOrganId(BspUtil.getCorpOrganId());
		applyBean.setCurOrganName(BspUtil.getOrganName());
		applyBean.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		applyBean.setCurDeptId(BspUtil.getDeptOrganId());
		applyBean.setCurPeopleId(BspUtil.getEmpOrganId());
		applyBean.setCurPeopleName(createPeople);
		dealSomPartyMember(applyBean);
	}
	public void updateApply(SomApply applyBean) {
		//当前处理单位ID
		String curOrganId = BspUtil.getCorpOrganId();
		//当前处理部门ID
		String curDeptId = BspUtil.getDeptOrganId();
		//当前处理人
		String curPeopleId = BspUtil.getEmpOrgan().getOrganName();
		//审批人ID
		String auditPeopleId = BspUtil.getEmpOrganId();
		//审批时间
		String auditTime = DateUtil.getTime();
		//更新业务意见信息
		applyBean.setCurOrganId(curOrganId);
		applyBean.setCurDeptId(curDeptId);
		applyBean.setCurPeopleId(curPeopleId);
		//如果是审批环节
		if(applyBean.getCurActivity().equals(Activity.ACT_AUDIT_CN)){
			applyBean.setAuditOrganId(curOrganId);
			applyBean.setAuditDeptId(curDeptId);
			applyBean.setAuditOpinion(applyBean.getCurOpinionId());
			applyBean.setAuditPeopleId(auditPeopleId);
			applyBean.setAuditTime(auditTime);
		}
		somApplyDomain.update(applyBean);
		
	}
	
	// 获取发起人（自然人）
	private void dealSomHeldPeople(SomApply somApply) {
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomHeldPeople> somHeldPeopleList = somOrgan.getSomHeldPeopleList();
		somHeldPeopleDomain.deleteBySorgId(somApply.getSorgId());
		for (int i = 0; i < somHeldPeopleList.size(); i++) {
			SomHeldPeople heldPeopleBean = somHeldPeopleList.get(i);
			heldPeopleBean.setId(IdHelp.getUUID30());
			heldPeopleBean.setTaskCode(somApply.getTaskCode());
			heldPeopleBean.setSorgId(somOrgan.getSorgId());
			heldPeopleBean.setIfChief("0");
			heldPeopleBean.setMorgName(morgName);
			heldPeopleBean.setMorgArea(morgCode);
			heldPeopleBean.setCreatePeople(createPeople);
			heldPeopleBean.setCreateTime(createTime);
			somHeldPeopleDomain.insert(heldPeopleBean);
		}
		
	}
	
	// 获取发起人（单位）
	private void dealSomHeldOrgan(SomApply somApply) {
		String morgName=BspUtil.getCorpOrgan().getOrganName();
		String morgCode=BspUtil.getCorpOrgan().getOrganCode();
		String createPeople=BspUtil.getEmpOrgan().getOrganName();
		String createTime = DateUtil.getTime();
		SomOrgan somOrgan = somApply.getSomOrgan();
		List<SomHeldOrgan> somHeldOrganList = somOrgan.getSomHeldOrganList();
		somHeldOrganDomain.deleteBySorgId(somApply.getSorgId());
		for (int i = 0; i < somHeldOrganList.size(); i++) {
			SomHeldOrgan somHeldOrgan = somHeldOrganList.get(i);
				somHeldOrgan.setId(IdHelp.getUUID32());
				somHeldOrgan.setTaskCode(somApply.getTaskCode());
				somHeldOrgan.setSorgId(somOrgan.getSorgId());
				somHeldOrgan.setMorgName(morgName);
				somHeldOrgan.setMorgArea(morgCode);
				somHeldOrgan.setCreatePeople(createPeople);
				somHeldOrgan.setCreateTime(createTime);
				somHeldOrganDomain.insert(somHeldOrgan);
		}
	}

	public void insertReportInfo(SomApply applyBean) {
		// TODO Auto-generated method stub
		
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