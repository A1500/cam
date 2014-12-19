package com.inspur.cams.sorg.apply.fund.domain.support;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.RecordSet;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.workflow.api.WfQuery;
import org.loushang.workflow.api.WfTaskRequestWrapper;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.ProcessLimiteTimeUtil;
import com.inspur.cams.sorg.apply.fund.domain.IFundChangeDomain;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomCert;
import com.inspur.cams.sorg.base.data.SomChange;
import com.inspur.cams.sorg.base.data.SomChangeApply;
import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomPeopleResume;
import com.inspur.cams.sorg.base.data.SomRule;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomCertDomain;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;
import com.inspur.cams.sorg.base.domain.ISomDutyDomain;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;
import com.inspur.cams.sorg.base.domain.ISomFlowDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;
import com.inspur.cams.sorg.base.domain.ISomPeopleResumeDomain;
import com.inspur.cams.sorg.base.domain.ISomRuleDomain;
import com.inspur.cams.sorg.base.domain.ISomSessionDomain;
import com.inspur.cams.sorg.util.Activity;
import com.inspur.cams.sorg.util.SomDutyDuties;
/**
 * 基金会主体变更domain
 * @author yanliangliang
 * @date 2011-8-17
 */
public class FundChangeDomain implements IFundChangeDomain{
	@Reference
	private ISomOrganDomain somOrganDomain;
	@Reference
	private ISomPeopleDomain somPeopleDomain;
	@Reference
	private ISomChangeDomain somChangeDomain;
	@Reference
	private ISomDutyDomain somDutyDomain;
	@Reference
	private ISomApplyDomain somApplyDomain;
	@Reference
	private ISomElectronicDomain somElectronicDomain;
	@Reference
	private ISomFlowDomain somFlowDomain;
	@Reference
	private ISomRuleDomain somRuleDomain;
	@Reference
	private ISomCertDomain somCertDomain;
	@Reference
	private ISomSessionDomain somSessionDomain;
	@Reference
	private ISomPeopleResumeDomain somPeopleResumeDomain;
	@Reference
	private IComExtUserDomain comExtUserDomain;
	public static final String PROC_DEF_UNIQUE_ID = "402881ef31d555a20131d5eff80a0063";
	public static final String START_ACT_DEF_ID = "act1";

	/**
	 * 创建流程并保存信息，不发送流程
	 */
	@SuppressWarnings("unchecked")
	public void createForChange(SomChangeApply somChangeApply) {
		// TODO createForChange
		Map<String, String> map=somChangeApply.getMap();
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map maps=WfTaskRequestWrapper.getInstance().create(somChangeApply.getSomApply().getTaskCode(), map.get("cnName")+"的变更申请");
		String processId = (String)maps.get("processId");
		//创建申请信息
		SomApply somApply=somChangeApply.getSomApply();

		somApply.setProcessId(processId);
		createSomApply(somApply, map);
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

		createInsertChangeInfo(somChangeApply);
	}
	/**
	 * 变更业务流程发送下一步
	 */
	@SuppressWarnings("unchecked")
	public void sendForChange(SomChangeApply somChangeApply) {
		// TODO sendForChange
		//updateSomApply(somChangeApply);
		Map<String, String> map=somChangeApply.getMap();
		Map context = new HashMap();
		String StruId = BspUtil.getDeptStruId();
		//BspUtil.getDeptOrgan().getOrganId();
		context.put("ORGANID", StruId);
		context.put("opinionId", somChangeApply.getSomApply().getCurOpinionId());
		//调用工作流发送接口
		Map maps=WfTaskRequestWrapper.getInstance().send(context);
		Map Query = WfQuery.getActivityDefInfoByActDefUniqueId(map.get("actDefUniqueId"));
		String actDefName = (String)Query.get("actDefName");
		SomApply somApply = somChangeApply.getSomApply();
		somApply.setCurDeptId(BspUtil.getDeptOrganId());
		somApply.setCurOrganId(BspUtil.getCorpOrganId());
		somApply.setCurPeopleId(BspUtil.getEmpOrganId());
		//保存意见
		somFlowDomain.insertBySomApply(somApply);
		//保存时不记录受理时间，提交时才开始算受理时间
		String curActivity = somApply.getCurActivity();
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
		//维护社团历史处理意见信息
		somApplyDomain.dealHisOpinion(somApply);
		//更新申请信息
		map.put("actDefName", actDefName);
		updateForChange(somApply,map,maps);
	}
	/**
	 * 业务流程中的保存发送流程
	  * @param somChangeApply
	 */
	@SuppressWarnings("unchecked")
	public void saveAndSendForChange(SomChangeApply somChangeApply) {
		// TODO saveAndSendForChange
		Map<String, String> map=somChangeApply.getMap();
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map context = new HashMap();
		String StruId = BspUtil.getDeptStruId();
		context.put("ORGANID", StruId);
		Map maps=WfTaskRequestWrapper.getInstance().createAndSend(somChangeApply.getSomApply().getTaskCode(), map.get("cnName")+"的变更申请",context);
		String processId = (String)maps.get("processId");
		//创建申请信息
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setProcessId(processId);
		createSomApply(somApply,map);//
		//保存受理意见
		somFlowDomain.insertBySomApply(somApply);
		//维护基金会历史处理意见信息
		somApplyDomain.dealHisOpinion(somApply);
		//清空当前意见
		clearSomApply(somApply);
		somApply.setCurActivity(Activity.ACT_EXAM_CN);
		somApply.setAcceptTime(DateUtil.getTime());
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

		createInsertChangeInfo(somChangeApply);
	}
	/**
	 * 打印证书环节的相关操作
	 * @param opinion 意见Record
	 * @param map	所需参数
	 */
	@SuppressWarnings("unchecked")
	public void endForChange(SomChangeApply somChangeApply) {
		SomApply somApply = somChangeApply.getSomApply();
		somApply.setCurDeptId(BspUtil.getDeptOrganId());
		somApply.setCurOrganId(BspUtil.getCorpOrganId());
		somApply.setCurPeopleId(BspUtil.getEmpOrganId());
		Map<String, String> map=somChangeApply.getMap();
		// TODO endForChange
		Map context = new HashMap();
		String StruId = BspUtil.getDeptStruId();
		context.put("ORGANID", StruId);
		//调用工作流发送接口
		Map maps=WfTaskRequestWrapper.getInstance().send(context);
		List actList = (List)maps.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			somApply.setCurActivity(actDefName1);
		}else{
			somApply.setIfFinish("1");
			somApply.setCurActivity("");
		}
		//保存意见
		somFlowDomain.insertBySomApply(somApply);
		somApply.setCurActivity(Activity.ACT_INFORM_CN);
		clearSomApply(somApply);
		somApplyDomain.update(somApply);
		//查找到社会组织
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", map.get("sorgId"));
		SomOrgan somOrgan=(SomOrgan)somOrganDomain.queryOrgan(pset).getRecord(0).toBean(SomOrgan.class);
		somOrgan.setBusinessForPrint(map.get("business"));
		somOrganDomain.update(somOrgan);
		//收回旧的证书
		pset.clear();
		pset.setParameter("SORG_ID@=", map.get("sorgId"));
		pset.setParameter("CERT_STATUS@=","1");
		DataSet somcertdataset=somCertDomain.query(pset);
		RecordSet records=somcertdataset.getRecordSet();
		Iterator<Record> certs= records.iterator();
		while(certs.hasNext()){
			SomCert cert=(SomCert)certs.next().toBean(SomCert.class);
			cert.setCertStatus("0");
			cert.setIfReceive("1");
			somCertDomain.update(cert);
		}
		String organType=map.get("organType");
		//创建新的证书
		SomCert somCert=new SomCert();
		somCert.setActArea(somOrgan.getActArea());
		somCert.setBorgName(somOrgan.getBorgName());
		somCert.setBusiness(map.get("business"));
		somCert.setCertStatus("1");//状态为有效
		somCert.setCertType("0");//判断正副本
		somCert.setId(IdHelp.getUUID30());
		if(organType.equals("main")){
			somCert.setIfBranch("0");//是否为分支代表
		}else{
			somCert.setIfBranch("1");
		}
		somCert.setIfReceive("0");//未收缴
		somCert.setIssuePeople(BspUtil.getEmpOrgan().getOrganName());
		somCert.setIssueReason("2");//发证原因
		somCert.setSorgName(somOrgan.getCnName());
		somCert.setTaskCode(somApply.getTaskCode());
		somCert.setIssueReasonDesc(map.get("issueReasonDesc"));//发证原因描述
		somCert.setLegalPeople(somDutyDomain.getLegalPeopleNameBySorgId(map.get("sorgId")));
		somCert.setMorgArea(BspUtil.getOrganCode());
		somCert.setMorgName(BspUtil.getOrganName());
		somCert.setPrintPeople(BspUtil.getEmpOrgan().getOrganName());
		somCert.setPrintTime(DateUtil.getTime());
		somCert.setRegDate(somOrgan.getRegDate());
		somCert.setRegMon(somOrgan.getRegMon());
		somCert.setResidence(somOrgan.getResidence());
		somCert.setSignBeginDate(map.get("beginDate"));
		somCert.setSignEndDate(map.get("endDate"));
		somCert.setSignDate(map.get("PrintDate"));
		somCert.setSignOrgan(BspUtil.getOrganName());
		//somCert.setSignPeriod(signPeriod);有效期
		//维护发证信息
		somCert.setFetchPeople(map.get("fetchPeople"));
		somCert.setFetchDate(map.get("fetchDate"));
		somCert.setFetchPhone(map.get("fetchPhone"));

		somCert.setSorgCode(somOrgan.getSorgCode());
		somCert.setSorgId(map.get("sorgId"));
		somCert.setSorgKind(somOrgan.getSorgKind());
		somCert.setSorgType(map.get("sorgType"));
		somCertDomain.insert(somCert);
	}
	/**
	 * 保存人员信息和成员信息
	 * @param people 人员bean
	 * @param map	所需参数
	 */
	public void savePeopleAndMember(SomDuty people, Map<String, String> map) {
		// TODO savePeopleAndMember
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		String peopleId=somPeopleDomain.create(people.getSomPeople());
		// 维护任职信息
		people.setDutyId(map.get("legalDutyId"));
		somDutyDomain.changeOldDutyIdToNew(people);
		people.setTaskCode(map.get("taskCode1"));
		people.setSorgId(map.get("sorgId"));
		people.setPeopleId(peopleId);
		people.setRegStatus("3");
		people.setIfServe("1");
		people.setSorgType("J");//基金会
		people.setSorgDuties(SomDutyDuties.SOM_LEGAL_PEOPLE);
		people.setCreateTime(DateUtil.getTime());
		people.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		people.setMorgName(corpOrgan.getOrganName());
		people.setMorgArea(corpOrgan.getOrganCode());
		somDutyDomain.insert(people);
	}
	/**
	 * 最后环节获取processId
	 * @param id assignmentId
	 * @return
	 */
	public String queryProcessId(String id) {
		// TODO queryProcessId
		return somApplyDomain.queryProcessId(id);
	}
	/**
	 * 更新申请信息数据
	 * @param somApply
	 */
	@SuppressWarnings("unchecked")
	private void updateForChange(SomApply somApply,Map<String, String> map, Map maps) {

		//如果环节是补齐补正，清空业务表的初审审核审批意见
		if(map.get("actDefName").equals(Activity.ACT_SUPPLY_CN)){
			somApplyDomain.emptyExamToAudit(somApply);
		}
		//包括 社会组织  变更信息 申请信息 会议信息 负责人和法人信息
		if(map.get("actDefName").equals(Activity.ACT_AUDIT_CN)){
			if(somApply.getCurOpinionId().equals("1")){	//审批意见同意
				somApply.setCurActivity(Activity.ACT_INFORM_CN);//设置环节为打印证书
				updateChangeInfo(somApply,map,"update");
			}else if(somApply.getCurOpinionId().equals("0")){//审批意见不同意
				somApply.setCurActivity(Activity.ACT_INFORM_CN);//设置环节为通知申请人
				updateChangeInfo(somApply,map,"cancel");
			}
		}else{
			if(map.get("actDefName").equals(Activity.ACT_FETCH_CN)){
				ParameterSet pset1=new ParameterSet();
				pset1.setParameter("SORG_ID@=", somApply.getSorgId());
				pset1.setParameter("CERT_STATUS@=","1");
				DataSet somcertdataset=somCertDomain.query(pset1);
				RecordSet certsRecord=somcertdataset.getRecordSet();
				Iterator<Record> certs= certsRecord.iterator();
				while(certs.hasNext()){
					SomCert cert=(SomCert)certs.next().toBean(SomCert.class);
					cert.setFetchPeople(map.get("fetchPeople"));
					cert.setFetchDate(map.get("fetchDate"));
					cert.setFetchPhone(map.get("fetchPhone"));
					somCertDomain.update(cert);
				}
				somApply.setIfFinish("1");//设为流程完结
				somApply.setCurActivity("");
			}else if(map.get("actDefName").equals(Activity.ACT_INFORM_CN)){
				ParameterSet flowps=new ParameterSet();
				flowps.setParameter("TASK_CODE@=",somApply.getTaskCode());
				flowps.setParameter("ACTIVITY@=",Activity.ACT_AUDIT_CN);
				flowps.setParameter("OPINION_ID@=","1");
				DataSet flowdataset=somFlowDomain.query(flowps);
				if(flowdataset.getCount()==0){
					somApply.setIfFinish("1");//设为流程完结
					updateChangeInfo(somApply,map,"cancel");
				}
			}
		}
		List actList = (List)maps.get("actList");
		if(actList != null){
			Map actMap = (Map) actList.get(0);
			String actDefName1 = (String)actMap.get("actDefName");
			somApply.setCurActivity(actDefName1);
		}else{
			somApply.setCurActivity("");
		}
		clearSomApply(somApply);
		somApplyDomain.update(somApply);
	}
	/**
	 * 删除变更时做的操作
	 * @param id
	 * @param changeItem
	 * @param sorgId
	 */
	public void deleteForChange(String id, String changeItem, String sorgId,String taskCode) {
		 String name=null;
		 if(changeItem.equals("0")){
			 name="名称变更修改后的章程（草案）";
		 }else if(changeItem.equals("1")){
			 name="新住所产权或使用权证明";
		 }else if(changeItem.equals("2")){
			 name="原法定代表人任期内的财务审计报告";
		 }else if(changeItem.equals("3")){
			 name="业务范围变更修改后的章程（草案）";
		 }else if(changeItem.equals("4")){
			 name="会计师所出具的验资报告";
		 }else if(changeItem.equals("5")){
			 name="业务主管单位交接双方意见,业务主管单位变更修改后的章程（草案）";
		 }

		 ParameterSet pset=new ParameterSet();
		 pset.setParameter("task_code@=",taskCode);
		 pset.setParameter("CATALOG_CODE@in",name);
		 DataSet DataSet = somElectronicDomain.query(pset);
		 RecordSet records=DataSet.getRecordSet();
		Iterator<Record> files= records.iterator();
		while(files.hasNext()){
			SomElectronic somElectronic=(SomElectronic)files.next().toBean(SomElectronic.class);
			somElectronicDomain.deleteById(somElectronic.getElectronicId());
		}
	}
	/**
	 * 修改页面的保存按钮
	 * @param somApply
	 */
	public void updateSomApply(SomChangeApply somChangeApply) {
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setCurOrganId(BspUtil.getCorpOrganId());
		somApply.setCurDeptId(BspUtil.getDeptOrganId());
		somApply.setCurPeopleId(BspUtil.getEmpOrganId());
		somApplyDomain.update(somApply);

		List<SomChange> changeList=somChangeApply.getSomChange();
		//清除原来的变更内容
		somChangeDomain.deleteChangeByTaskCode(somApply.getTaskCode());
		for(int i=0;i<changeList.size();i++){
			SomChange change=changeList.get(i);
			change.setTaskCode(somApply.getTaskCode());
			change.setId(IdHelp.getUUID30());
			change.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			change.setMorgName( BspUtil.getCorpOrgan().getOrganName());
			change.setSorgId(somApply.getSorgId());
			change.setChangeStatus("0");
			somChangeDomain.insert(change);//插入变更信息
		}
		Map<String, String> map=somChangeApply.getMap();
		map.put("taskCode1", somApply.getTaskCode());
		map.put("sorgId", somApply.getSorgId());

		SomRule somRule=somChangeApply.getSomRule();
		if(somRule!=null){
			if(somRule.getRuleId() != null && !"".equals(somRule.getRuleId())){
				somRuleDomain.update(somRule);
			}else{
				forInsertRule(somRule,map);
			}
		}
		SomDuty people=somChangeApply.getSomLegalPeople();
		somDutyDomain.reNewPeopleInfo(somApply.getTaskCode());
		if(people != null){
			savePeopleAndMember(people,map);
		}
	}
	/**
	 * 通过processId获得somApply
	 */
	public SomApply getSomApplyByProcessId(String id) {
		return somApplyDomain.queryTaskCodeByProcessId(id);
	}
	/**
	 * 创建业务信息
	 * @param somApply
	 * @param map
	 */
	private void createSomApply(SomApply somApply, Map<String, String> map) {
		somApply.setSorgId(map.get("sorgId"));
		somApply.setApplyType(map.get("applyType"));//业务种类为变更
		somApply.setSorgType(map.get("sorgType"));
		somApply.setSorgKind(map.get("sorgKind"));
		somApply.setSorgName(map.get("cnName"));
		somApply.setIfFinish("0");//是否完结
		somApply.setAcceptOrganId(BspUtil.getCorpOrganId());
		somApply.setAcceptArea(BspUtil.getOrganCode());
		somApply.setAcceptDeptId(BspUtil.getDeptOrganId());
		somApply.setAcceptDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setAcceptPeopleId(BspUtil.getEmpOrganId());
		somApply.setAcceptPeopleName(BspUtil.getEmpOrgan().getOrganName());
		//somApply.setAcceptTime(DateUtil.getTime());
		somApply.setAcceptOpinion(somApply.getCurOpinion());
		somApply.setAcceptOpinionId(somApply.getCurOpinionId());
		somApply.setCurActivity(Activity.ACT_ACCEPT_CN);
		somApply.setCurOrganId(BspUtil.getCorpOrganId());
		somApply.setCurOrganName(BspUtil.getOrganName());
		somApply.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setCurDeptId(BspUtil.getDeptOrganId());
		somApply.setCurPeopleId(BspUtil.getEmpOrganId());
		somApply.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());
	}
	/**
	 * 清空业务信息
	 * @param somApply
	 */
	private void clearSomApply(SomApply somApply){
		somApply.setCurOpinionId("");
		somApply.setCurOpinion("");
		somApply.setCurOrganId("");
		somApply.setCurDeptId("");
		somApply.setCurPeopleId("");
	}
	public String getLegalPeopleNameByTaskCode(String sorgId) {
		return somDutyDomain.getLegalPeopleNameBySorgId(sorgId);
	}
	/**
	 * 保存章程信息
	 * @param somRule
	 * @param map
	 */
	private void forInsertRule(SomRule somRule,Map<String, String> map) {

		somRule.setSorgId(map.get("sorgId"));
		somRule.setTaskCode(map.get("taskCode1"));
		somRule.setRegStatus("3");//审批中
		somRuleDomain.insert(somRule);
	}
	/**
	 * 保存变更信息
	 * @param somChangeApply
	 */
	private void createInsertChangeInfo(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		for(int i=0;i<changes.size();i++){
			SomChange change=changes.get(i);
			change.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			change.setId(IdHelp.getUUID30());
			change.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			change.setMorgName( BspUtil.getCorpOrgan().getOrganName());
			change.setSorgId(map.get("sorgId"));
			change.setChangeStatus("0");
			somChangeDomain.insert(change);//插入变更信息
		}
		SomDuty people=somChangeApply.getSomLegalPeople();
		if(people != null){
				savePeopleAndMember(people,map);
		}
		SomRule somRule=somChangeApply.getSomRule();
		if(somRule!=null){
			forInsertRule(somRule,map);
		}

	}
	public void saveFlow(SomApply somApply){
		somApply.setCurOrganId(BspUtil.getCorpOrganId());
		somApply.setCurOrganName(BspUtil.getOrganName());
		somApply.setCurDeptId(BspUtil.getDeptOrganId());
		somApply.setCurDeptName(BspUtil.getDeptOrgan().getOrganName());
		somApply.setCurPeopleId(BspUtil.getEmpOrganId());
		somApply.setCurPeopleName(BspUtil.getEmpOrgan().getOrganName());

		somApplyDomain.update(somApply);
	}

	/**
	 * 更新变更相应信息
	 * @param somApply
	 * @param map
	 * @param flag 是同意还是不同意
	 */
	private void updateChangeInfo(SomApply somApply, Map<String, String> map,String flag) {
		ParameterSet pset=new ParameterSet();
		pset.setParameter("SORG_ID@=", somApply.getSorgId());
		DataSet DataSet = somOrganDomain.query(pset);
		Record record =(Record)  DataSet.getRecord(0);
		SomOrgan somOrgan= (SomOrgan) record.toBean(SomOrgan.class);//社会组织
		ParameterSet changePSET=new ParameterSet();
		changePSET.setParameter("TASK_CODE@=",somApply.getTaskCode());
		DataSet changeDataset = somChangeDomain.query(changePSET);
		RecordSet records=changeDataset.getRecordSet();
		Iterator<Record> changes= records.iterator();//变更
		String leaPeopleId=map.get("leaPeopleId");

		if(flag.equals("update")){
			while(changes.hasNext()){
				Record change=(Record)changes.next();
				SomChange somchange=(SomChange)change.toBean(SomChange.class);
				somchange.setChangeStatus("1");//变为已变更
				somChangeDomain.update(somchange);
				//对社会组织进行更新
				if(somchange.getChangeItem().equals("0")){//名称

 	String newCnName = somchange.getChangeAfter();
					String oldCnName = somOrgan.getCnName();
					somOrgan.setCnName(somchange.getChangeAfter());
					somApplyDomain.updateSomApplyInfo(somOrgan);

					//主体名称变更在审批通过时需要更新分支的名称
					ParameterSet psetBranch=new ParameterSet();
					psetBranch.setParameter("MAIN_SORG_ID@=", somApply.getSorgId());
					DataSet branchDataSet = somOrganDomain.query(psetBranch);
					for(int i=0;i<branchDataSet.getCount();i++){
						Record branchRecord =(Record)  branchDataSet.getRecord(i);
						SomOrgan somOrganBranch= (SomOrgan) branchRecord.toBean(SomOrgan.class);//社会组织
						String branchName = somOrganBranch.getCnName();
						branchName = branchName.replace(oldCnName, newCnName);
						somOrganBranch.setCnName(branchName);
						somOrganDomain.update(somOrganBranch);
					}

					String changgebefore=somchange.getChangeBefore();
					String changgeafter=somchange.getChangeAfter();

					//somApplyDomain.updateSomApplyInfo(somOrgan);

					comExtUserDomain.updateSomExtuserBychangge(changgebefore, changgeafter);
				}else if(somchange.getChangeItem().equals("1")){ //住所变更
					somOrgan.setResidence(somchange.getChangeAfter());//变更住所
				}else if(somchange.getChangeItem().equals("2")){//变更法定代表人
					somOrgan.setLegalPeople(somchange.getChangeAfter());
				}else if(somchange.getChangeItem().equals("3")){//变更业务范围
					somOrgan.setBusiness(somchange.getChangeAfter());//变更业务范围
				}else if(somchange.getChangeItem().equals("4")){ //资金变更
					String[] s=somchange.getChangeAfter().split(";",-1);
					if(s[0]!=null &&!"".endsWith(s[0])){
						somOrgan.setMoneySource(s[0]);//资金来源
					}if(s[1]!=null &&!"".endsWith(s[1])){
						somOrgan.setRegMon(s[1]);//变更注册资金
					}
				}else if(somchange.getChangeItem().equals("5")){//变更宗旨
					somOrgan.setPurpose(somchange.getChangeAfter());
				}else if(somchange.getChangeItem().equals("6")){//变更类型
					somOrgan.setSorgKind(somchange.getChangeAfter());
				}
			}
			//法定代表人
			if(leaPeopleId!=null){
				pset.clear();
				pset.setParameter("SORG_ID",somApply.getSorgId());
				pset.setParameter("IF_SERVE", "1");
				pset.setParameter("REG_STATUS", "1");//有效的
				pset.setParameter("SORG_DUTIES", SomDutyDuties.SOM_LEGAL_PEOPLE);
				DataSet memberDatasets=somDutyDomain.queryPeople(pset);
				RecordSet memrecords=memberDatasets.getRecordSet();
				Iterator<Record> mems= memrecords.iterator();//变更
				while(mems.hasNext()){
					SomDuty somDuty=(SomDuty)mems.next().toBean(SomDuty.class);
					somDuty.setIfServe("0");//卸任
					somDuty.setRegStatus("2");//备案状态为历史
					somDuty.setEndDate(DateUtil.getDay());
					somDutyDomain.update(somDuty);
				}
				pset.clear();
				pset.setParameter("SORG_ID",map.get("sorgId"));
				pset.setParameter("TASK_CODE",somApply.getTaskCode());
				pset.setParameter("SORG_DUTIES", SomDutyDuties.SOM_LEGAL_PEOPLE);
				DataSet legalMemDataset=somDutyDomain.queryPeople(pset);
				if(legalMemDataset.getCount() > 0){
					Record legalMemRecord =(Record)  legalMemDataset.getRecord(0);
					SomDuty somleaMember=(SomDuty)legalMemRecord.toBean(SomDuty.class);
					somleaMember.setIfServe("1");//在任
					somleaMember.setRegStatus("1");//备案状态为有效
					somDutyDomain.update(somleaMember);
				}else{
					throw new RuntimeException("数据异常！");
				}
			}
			somOrganDomain.updateAndBuildHis(somOrgan,somApply.getTaskCode());
		}else if(flag.equals("cancel")){
			while(changes.hasNext()){
				Record change=(Record)changes.next();
				SomChange somchange=(SomChange)change.toBean(SomChange.class);
				somchange.setChangeStatus("2");//审批未通过
				somChangeDomain.update(somchange);
			}
			//法定代表人
			if(leaPeopleId!=null){
				pset.clear();
				pset.setParameter("SORG_ID",map.get("sorgId"));
				pset.setParameter("TASK_CODE",somApply.getTaskCode());
				pset.setParameter("SORG_DUTIES", SomDutyDuties.SOM_LEGAL_PEOPLE);
				DataSet legalMemDataset=somDutyDomain.queryPeople(pset);
				if(legalMemDataset.getCount() > 0){
					Record legalMemRecord =(Record)  legalMemDataset.getRecord(0);
					SomDuty somleaMember=(SomDuty)legalMemRecord.toBean(SomDuty.class);
					somleaMember.setRegStatus("4");
					somDutyDomain.update(somleaMember);
				}else{
					throw new RuntimeException("数据异常！");
				}
			}
		}


	}
	/**
	 * @title 内网预受理保存变更信息
	 */
	public void savePreChangeOnline(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map maps=WfTaskRequestWrapper.getInstance().create(somChangeApply.getSomApply().getTaskCode(), map.get("cnName")+"的变更申请");
		String processId = (String)maps.get("processId");
		//创建申请信息
		SomApply somApply=somChangeApply.getSomApply();

		somApply.setProcessId(processId);
		createSomApply(somApply, map);
		somApplyDomain.insert(somApply);

		createInsertChangeInfoOnline(somChangeApply);
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", somApply.getTaskCode());
		DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
		for(int i = 0;i<ds.getCount();i++){
			SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
			bean.setSorgId(somApply.getSorgId());
			somElectronicDomain.update(bean);
		}
	}
	/**
	 * 保存外网的变更信息
	 * @param somChangeApply
	 */
	private void createInsertChangeInfoOnline(SomChangeApply somChangeApply) {
		Map<String, String> map=somChangeApply.getMap();
		List<SomChange> changes=somChangeApply.getSomChange();
		SomDuty people=somChangeApply.getSomLegalPeople();
		String legalDutyId ="";
		if(people != null){
			legalDutyId=savePeopleAndMemberOnline(somChangeApply);
		}
		for(int i=0;i<changes.size();i++){
			SomChange change=changes.get(i);
			change.setTaskCode(somChangeApply.getSomApply().getTaskCode());
			change.setId(IdHelp.getUUID30());
			change.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
			change.setMorgName( BspUtil.getCorpOrgan().getOrganName());
			change.setSorgId(map.get("sorgId"));
			change.setChangeStatus("0");
			change.setLegalDutyId(legalDutyId);
			somChangeDomain.insert(change);//插入变更信息
		}

		SomRule somRule=somChangeApply.getSomRule();
		if(somRule!=null){
			forInsertRule(somRule,map);
		}
	}
	/**
	 * 保存人员信息和成员信息
	 * @param people 人员bean
	 * @param map	所需参数
	 */
	public String savePeopleAndMemberOnline(SomChangeApply somChangeApply) {
		//获取当前届次信息
		DataSet dset=somSessionDomain.getCurrentSession(somChangeApply.getSomApply().getSorgId());
		if (dset==null||dset.getCount()<1) {
			return null;
		}
		SomSession somSession=(SomSession)dset.getRecord(0).toBean(SomSession.class);

		String legalDutyId = "";
		Map<String, String> map=somChangeApply.getMap();
		SomDuty people=somChangeApply.getSomLegalPeople();
		List<SomPeopleResume> peopleResumes=somChangeApply.getPeopleResumes();
		String taskCode = somChangeApply.getSomApply().getTaskCode();
		OrganView corpOrgan = BspUtil.getCorpOrgan();
		String sorgDuties = people.getSorgDuties();
		String peopleId=somPeopleDomain.create(people.getSomPeople());
		// 维护任职信息
		people.setDutyId(map.get("legalDutyId"));
		somDutyDomain.changeOldDutyIdToNew(people);
		legalDutyId = people.getDutyId();
		people.setTaskCode(map.get("taskCode1"));
		people.setSorgId(map.get("sorgId"));
		people.setSessionId(somSession.getSessionId());
		people.setPeopleId(peopleId);
		people.setRegStatus("3");
		people.setIfServe("1");
		people.setSorgType("J");//社会团体
		people.setSorgDuties(SomDutyDuties.SOM_LEGAL_PEOPLE);
		people.setCreateTime(DateUtil.getTime());
		people.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		people.setMorgName(corpOrgan.getOrganName());
		people.setMorgArea(corpOrgan.getOrganCode());
		if(peopleResumes!=null){
			for (int i = 0; i < peopleResumes.size(); i++) {
				SomPeopleResume somPeopleResume = peopleResumes.get(i);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setTaskCode(taskCode);
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setDutyId(people.getDutyId());
				somPeopleResumeDomain.insert(somPeopleResume);
			}
		}
		somDutyDomain.insert(people);
		people.setSorgDuties(sorgDuties);
		people.setDutyId(IdHelp.getUUID32());
		people.setRegStatus("1");
		if(peopleResumes!=null){
			for (int i = 0; i < peopleResumes.size(); i++) {
				SomPeopleResume somPeopleResume = peopleResumes.get(i);
				somPeopleResume.setId(IdHelp.getUUID32());
				somPeopleResume.setTaskCode(taskCode);
				somPeopleResume.setPeopleId(peopleId);
				somPeopleResume.setDutyId(people.getDutyId());
				somPeopleResumeDomain.insert(somPeopleResume);
			}
		}
		somDutyDomain.insert(people);
		return legalDutyId;
	}
	public void saveAndSendForChangeOnline(SomChangeApply somChangeApply) {
		// TODO saveAndSendForChange
		Map<String, String> map=somChangeApply.getMap();
		Map actDefMap = WfQuery.getActDefInfoByProcDefUniqueIdAndActDefId(PROC_DEF_UNIQUE_ID,START_ACT_DEF_ID);
		String actDefUniqueId = (String)actDefMap.get("actDefUniqueId");
		CommandContext.setContextParameter("procDefUniqueId",PROC_DEF_UNIQUE_ID);
		CommandContext.setContextParameter("startActDefUniqueId",actDefUniqueId);
		Map context = new HashMap();
		String StruId = BspUtil.getDeptStruId();
		context.put("ORGANID", StruId);
		Map maps=WfTaskRequestWrapper.getInstance().createAndSend(somChangeApply.getSomApply().getTaskCode(), map.get("cnName")+"的变更申请",context);
		String processId = (String)maps.get("processId");
		//创建申请信息
		SomApply somApply=somChangeApply.getSomApply();
		somApply.setProcessId(processId);
		createSomApply(somApply,map);//
		//保存受理意见
		somFlowDomain.insertBySomApply(somApply);
		//维护基金会历史处理意见信息
		somApplyDomain.dealHisOpinion(somApply);
		//清空当前意见
		clearSomApply(somApply);
		somApply.setCurActivity(Activity.ACT_EXAM_CN);
		somApply.setAcceptTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
		createInsertChangeInfoOnline(somChangeApply);
		//网上申请的将电子档案表的sorgId更新为系统中已经存在的组织的sorgId
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE", somApply.getTaskCode());
		DataSet ds = somElectronicDomain.queryElectronicOnly(pset);
		for(int i = 0;i<ds.getCount();i++){
			SomElectronic bean = (SomElectronic) ds.getRecord(i).toBean(SomElectronic.class);
			bean.setSorgId(somApply.getSorgId());
			somElectronicDomain.update(bean);
		}
	}
}
