package com.inspur.cams.drel.application.city.cmd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.IdCardCheck;
import com.inspur.cams.drel.application.city.domain.ISamCityApplyDomain;
import com.inspur.cams.drel.comm.SamApplyCheckUtil;
import com.inspur.cams.drel.comm.SamCheckLog;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;
import com.inspur.cams.drel.sam.data.SamPeopleInsurance;
import com.inspur.cams.drel.sam.data.SamPeopleJobs;
import com.inspur.cams.drel.sam.data.SamPeopleType;

/**
 * 城市低保新申请业务Cmd
 * @author yanliangliang
 * @date 2012年5月2日10:41:16
 */
public class SamCityApplyCmd  extends BaseAjaxCommand {
	// 获取SCA组件
	private ISamCityApplyDomain service = ScaComponentFactory.getService(ISamCityApplyDomain.class, "samCityApplyDomain/samCityApplyDomain");
	/**
	 * 保存低保新申请业务信息
	 */
	public void insertInfo() {
		SamApplyInfo applyInfo = getApplyInfo();
		if(applyInfo.getCheckLog().length()> 0 ){
			setReturn("error",applyInfo.getCheckLog().toString());
			return ;
		}else{
			setReturn("error","true");
		}
		applyInfo=service.insertInfo(applyInfo);
		setReturn("familyId",applyInfo.getFamilyId());
		setReturn("applyId",applyInfo.getApplyId());
		setReturn("assignmentId",applyInfo.getAssignmentId());
		setReturn("photoId",applyInfo.getBaseInfoFamily().getPhotoId());
	}
	
	/**
	 * 保存低保新申请业务信息(审核新增的)
	 */
	public void insertInfoFromCheck() {
		SamApplyInfo applyInfo=getApplyInfo();
		if(applyInfo.getCheckLog().length()> 0 ){
			setReturn("error",applyInfo.getCheckLog().toString());
			return ;
		}else{
			setReturn("error","true");
		}
		applyInfo=service.insertInfoFromCheck(applyInfo);
		setReturn("familyId",applyInfo.getFamilyId());
		setReturn("applyId",applyInfo.getApplyId());
		setReturn("assignmentId",applyInfo.getAssignmentId());
		setReturn("photoId",applyInfo.getBaseInfoFamily().getPhotoId());
	}
	/**
	 * 更新低保新申请业务信息(审核新增的)
	 */
	public void updateInfoFromCheck(){
		SamApplyInfo applyInfo=getApplyInfo();
		if(applyInfo.getCheckLog().length()> 0 ){
			setReturn("error",applyInfo.getCheckLog().toString());
			return ;
		}else{
			setReturn("error","true");
		}
		applyInfo=service.updateInfoFromCheck(applyInfo);
		setReturn("familyId",applyInfo.getFamilyId());
		setReturn("applyId",applyInfo.getApplyId());
		setReturn("assignmentId",applyInfo.getAssignmentId());
		setReturn("photoId",applyInfo.getBaseInfoFamily().getPhotoId());
	}
	/**
	 * 受理时提交流程
	 */
	public void submitApply(){
		SamApplyInfo samApplyInfo=getApplyInfo();
		if(samApplyInfo.getCheckLog().length()> 0 ){
			setReturn("error",samApplyInfo.getCheckLog().toString());
			return ;
		}else{
			setReturn("error","true");
		}
		samApplyInfo.setAssignmentId((String)getParameter("assignmentId"));
		service.submitApply(samApplyInfo);
	}
	/**
	 * 更新流程意见
	 */
	public void updateApply(){
		service.updateApply(getCourseInfo());
	}
	
	/**
	 * 发送流程
	 */
	public void sendApply(){
		service.sendApply(getCourseInfo());
	}
	/**
	 * 批量审批
	 */
	public void batchApp(){
		service.batchApp(getBatchApply());
	}
	
	/**
	 * 批量提交
	 */
	public void batchSubmitCheck(){
		service.batchSubmitCheck(getBatchSubmmit());
	}
	/**
	 * 批量保存
	 */
	public void batchSaveCheck(){
		service.batchSaveCheck(getBatchSubmmit());
	}
	
	/**
	 * 保存低保家庭成员信息
	 */
	public void insertPeopleInfo() {
		String assistanceModeValue = (String) getParameter("assistanceModeValue");
		String isChangeUpdate = (String) getParameter("isChangeUpdate");
		
		BaseinfoPeople baseinfoPeople = getPeopleInfo();
		if(baseinfoPeople.getCheckLog().length()> 0 && !"1".equals(isChangeUpdate !=null?isChangeUpdate :"0")) {
			setReturn("error",baseinfoPeople.getCheckLog().toString());
			return ;
		}else{
			setReturn("error","true");
		}
		BaseinfoFamily baseinfoFamily=service.insertPeopleInfo(baseinfoPeople,(String)getParameter("applyId"),assistanceModeValue);
		setReturn("assistancePeopleNum",baseinfoFamily.getAssistancePeopleNum());
		setReturn("monthIncome",baseinfoFamily.getMonthIncome());
		setReturn("monthAverageIncome",baseinfoFamily.getMonthAverageIncome());
		setReturn("peopleNum",baseinfoFamily.getPeopleNum());
		setReturn("yearIncome",baseinfoFamily.getYearIncome());
		setReturn("yearAverageIncome",baseinfoFamily.getYearAverageIncome());
		if("10".equals(assistanceModeValue)){
			setReturn("assistanceMoney",baseinfoFamily.getAssistanceMoney());
		}else{
			setReturn("assistanceMoney","null");
		}
		
	}
	/**
	 * 删除低保家庭成员信息
	 */
	public void deletePeopleInfo() {
		String delId = (String) getParameter("delId");
		String familyId = (String) getParameter("familyId");
		String applyId = (String) getParameter("applyId");
		String assistanceModeValue = (String) getParameter("assistanceModeValue");
		BaseinfoFamily baseinfoFamily=service.deletePeopleInfo(delId,familyId,applyId,assistanceModeValue);
		setReturn("assistancePeopleNum",baseinfoFamily.getAssistancePeopleNum());
		setReturn("monthIncome",baseinfoFamily.getMonthIncome());
		setReturn("monthAverageIncome",baseinfoFamily.getMonthAverageIncome());
		setReturn("peopleNum",baseinfoFamily.getPeopleNum());
		setReturn("yearIncome",baseinfoFamily.getYearIncome());
		setReturn("yearAverageIncome",baseinfoFamily.getYearAverageIncome());
		if("10".equals(assistanceModeValue)){
			setReturn("assistanceMoney",baseinfoFamily.getAssistanceMoney());
		}else{
			setReturn("assistanceMoney","null");
		}
	}
	/**
	 * 身份证校验
	 */
	public void checkIDCard(){
		String idCard=(String)getParameter("cardNo");
		Map<String,String> map=service.checkIDCard(idCard);
		setReturn("familyId",map.get("familyId"));
		setReturn("errorFlag",map.get("errorFlag"));
		setReturn("peopleId",map.get("peopleId"));
		setReturn("personalStatsTag",map.get("personalStatsTag"));
	}
	/**
	 * 获取当前救助标准
	 */
	public void getLowStandards(){
		ParameterSet pset = getParameterSet();
		setReturn("lowStandards",service.getLowStandards(pset));
	}
	/**
	 * 补差计算户月保障金
	 */
	public void getAssistanceMoney(){
		ParameterSet pset = getParameterSet();
		setReturn("assistanceMoney",service.getAssistanceMoney(pset));
	}
// TODO ################################################               私有方法               #########################################################
	/**
	 * 封装批量审批的数据
	 */
	private SamApplyInfo getBatchApply() {
		Record applyRecord = (Record) getParameter("applyRecord");
		Record auditSurvey = (Record) getParameter("surveyRecord");
		Record auditNotice = (Record) getParameter("auditRecord");
		String applyId = (String) getParameter("applyIds");
		String assignmentId = (String) getParameter("assignmentIds");
		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
		List<SamApplyNotice> samApplyNoticeList = new ArrayList<SamApplyNotice>(); 
		samApplyNoticeList.add(
				(SamApplyNotice)auditNotice.toBean(SamApplyNotice.class) );
		samApplyInfo.setSamApplyNoticeList(samApplyNoticeList);
		
		List<SamApplySurvey> samApplySurveyList = new ArrayList<SamApplySurvey>(); 
		samApplySurveyList.add(
				(SamApplySurvey)auditSurvey.toBean(SamApplySurvey.class));
		samApplyInfo.setSamApplySurveyList(samApplySurveyList);
		
		String[] applyIds = applyId.split(";");
		String[] assignmentIds = assignmentId.split(";");
		List<String> applyIdList = new ArrayList<String>(); 
		for (int i = 0; i < applyIds.length; i++) {
			applyIdList.add(applyIds[i]);
		}
		List<String> assignmentIdList = new ArrayList<String>(); 
		for (int i = 0; i < assignmentIds.length; i++) {
			assignmentIdList.add(assignmentIds[i]);
		}
		samApplyInfo.setApplyIdList(applyIdList);
		samApplyInfo.setAssignmentIdList(assignmentIdList);
		return samApplyInfo;
	}
	
	/**
	 * 封装批量审批的数据
	 */
	private SamApplyInfo getBatchSubmmit() {
		String applyId = (String) getParameter("applyIds");
		String assignmentId = (String) getParameter("assignmentIds");
		
		
		Record acceptNoticeRecord = (Record) getParameter("acceptNoticeRecord");
		Record acceptSurveyRecord = (Record) getParameter("acceptSurveyRecord");
		Record acceptDiscussionRecord = (Record) getParameter("acceptDiscussionRecord");
		
		Record checkSurveyRecord = (Record) getParameter("checkSurveyRecord");
		Record checkNoticeRecord = (Record) getParameter("checkNoticeRecord");
		Record applyRecord = (Record) getParameter("applyRecord");
		
		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
		
		
		List<SamApplyNotice> samApplyNoticeList = new ArrayList<SamApplyNotice>(); 
		samApplyNoticeList.add(
				(SamApplyNotice)acceptNoticeRecord.toBean(SamApplyNotice.class) );
		samApplyNoticeList.add(
				(SamApplyNotice)checkNoticeRecord.toBean(SamApplyNotice.class) );
		samApplyInfo.setSamApplyNoticeList(samApplyNoticeList);
		
		List<SamApplySurvey> samApplySurveyList = new ArrayList<SamApplySurvey>(); 
		
		samApplySurveyList.add(
				(SamApplySurvey)acceptSurveyRecord.toBean(SamApplySurvey.class));
		samApplySurveyList.add(
				(SamApplySurvey)checkSurveyRecord.toBean(SamApplySurvey.class));
		samApplyInfo.setSamApplySurveyList(samApplySurveyList);
		
		
		List<SamApplyDiscussion> SamApplyDiscussionList = new ArrayList<SamApplyDiscussion>(); 
		
		SamApplyDiscussionList.add(
				(SamApplyDiscussion)acceptDiscussionRecord.toBean(SamApplyDiscussion.class));
		samApplyInfo.setSamApplyDiscussionList(SamApplyDiscussionList);
		
		String[] applyIds = applyId.split(";");
		String[] assignmentIds = assignmentId.split(";");
		List<String> applyIdList = new ArrayList<String>(); 
		for (int i = 0; i < applyIds.length; i++) {
			applyIdList.add(applyIds[i]);
		}
		List<String> assignmentIdList = new ArrayList<String>(); 
		for (int i = 0; i < assignmentIds.length; i++) {
			assignmentIdList.add(assignmentIds[i]);
		}
		samApplyInfo.setApplyIdList(applyIdList);
		samApplyInfo.setAssignmentIdList(assignmentIdList);
		return samApplyInfo;
	}
	/**
	 * 封装低保新申请业务
	 * @return
	 */
	private SamApplyInfo getApplyInfo() {
		StringBuffer checkLog = new StringBuffer("");
		
		Record applyRecord = (Record) getParameter("applyRecord");
		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
		//处理家庭
		Record familyRecord = (Record) getParameter("familyRecord");
		BaseinfoFamily baseinfoFamily=(BaseinfoFamily)familyRecord.toBean(BaseinfoFamily.class);
		samApplyInfo.setBaseInfoFamily(baseinfoFamily);
		
		//校验身份证号
		String idCard = samApplyInfo.getBaseInfoFamily().getFamilyCardNo();
		if(!IdCardCheck.isValidatedAllIdcard(idCard)){
			checkLog.append("户主姓名："+baseinfoFamily.getFamilyName()+"身份证号不合法，请检查！");
		}
		//校验此人能否进行录入
		SamApplyCheckUtil samApplyCheckUtil;
		try {
			samApplyCheckUtil = new SamApplyCheckUtil();
			SamCheckLog samCheckLog= samApplyCheckUtil.queryExistApply(baseinfoFamily.getFamilyCardNo(),samApplyInfo.getApplyId());
			if(!samCheckLog.isResult()){
				checkLog.append(samCheckLog.getContext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//处理多选
		Record[] AssistanceRecords = (Record[])getParameter("AssistanceRecords");
		if(AssistanceRecords != null){
			List<SamFamilyAssistance> samFamilyAssistanceList = new ArrayList<SamFamilyAssistance>();
			for(int i=0;i<AssistanceRecords.length;i++){
				SamFamilyAssistance samFamilyAssistance=(SamFamilyAssistance)AssistanceRecords[i].toBean(SamFamilyAssistance.class);
				samFamilyAssistanceList.add(samFamilyAssistance);
			}
			samApplyInfo.setSamFamilyAssistanceList(samFamilyAssistanceList);
		}
		//处理入户调查
		Record[] acceptSurveyRecords = (Record[]) getParameter("acceptSurveyRecord");
		List<SamApplySurvey> samApplySurveyList = new ArrayList<SamApplySurvey>(); 
		if(acceptSurveyRecords != null){
			for(int i=0;i<acceptSurveyRecords.length;i++){
				SamApplySurvey samApplySurvey=(SamApplySurvey)acceptSurveyRecords[i].toBean(SamApplySurvey.class);
				samApplySurveyList.add(samApplySurvey);
			}
		}
		//处理评议结果
		Record[] acceptDiscussionRecords = (Record[]) getParameter("acceptDiscussionRecord");
		if(acceptDiscussionRecords != null){
			List<SamApplyDiscussion> samApplyDiscussionList = new ArrayList<SamApplyDiscussion>(); 
			for(int i=0;i<acceptDiscussionRecords.length;i++){
				SamApplyDiscussion samApplyDiscussion=(SamApplyDiscussion)acceptDiscussionRecords[i].toBean(SamApplyDiscussion.class);
				samApplyDiscussionList.add(samApplyDiscussion);
			}
			samApplyInfo.setSamApplyDiscussionList(samApplyDiscussionList);
		}
		//处理公告
		Record[] acceptNoticeRecords =(Record[]) getParameter("acceptNoticeRecord");
		List<SamApplyNotice> samApplyNoticeList = new ArrayList<SamApplyNotice>(); 
		if(acceptNoticeRecords != null){
			for(int i=0;i<acceptNoticeRecords.length;i++){
				SamApplyNotice samApplyNotice=(SamApplyNotice)acceptNoticeRecords[i].toBean(SamApplyNotice.class);
				samApplyNoticeList.add(samApplyNotice);
			}
		}
		
		//受理审核时用到
		//处理入户调查
		Record surveyRecord = (Record) getParameter("surveyRecord");
		if(surveyRecord != null ){
			SamApplySurvey samApplySurvey=(SamApplySurvey)surveyRecord.toBean(SamApplySurvey.class);
			samApplySurveyList.add(samApplySurvey);
		}
		samApplyInfo.setSamApplySurveyList(samApplySurveyList);
		//处理公示结果
		Record noticeRecord = (Record) getParameter("noticeRecord");
		if(noticeRecord != null ){
			SamApplyNotice samApplyNotice=(SamApplyNotice)noticeRecord.toBean(SamApplyNotice.class);
			samApplyNoticeList.add(samApplyNotice);
		}
		samApplyInfo.setSamApplyNoticeList(samApplyNoticeList);
		//处理银行信息
		Record bankAccount=(Record)getParameter("bankAccount");
		SamBankAccount bank=(SamBankAccount)bankAccount.toBean(SamBankAccount.class);
		samApplyInfo.setSamBankAccount(bank);
		
		samApplyInfo.setCheckLog(checkLog);
		return samApplyInfo;
	}
	/**
	 * 封装流程过程中的信息
	 * @return
	 */
	private SamApplyInfo getCourseInfo() {
		//处理业务主表
		Record applyRecord = (Record) getParameter("applyRecord");
		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
		//处理家庭
		Record familyRecord = (Record) getParameter("familyRecord");
		BaseinfoFamily baseinfoFamily=(BaseinfoFamily)familyRecord.toBean(BaseinfoFamily.class);
		samApplyInfo.setBaseInfoFamily(baseinfoFamily);
		//处理入户调查
		Record surveyRecord = (Record) getParameter("surveyRecord");
		SamApplySurvey samApplySurvey=(SamApplySurvey)surveyRecord.toBean(SamApplySurvey.class);
		List<SamApplySurvey> samApplySurveyList = new ArrayList<SamApplySurvey>(); 
		samApplySurveyList.add(samApplySurvey);
		samApplyInfo.setSamApplySurveyList(samApplySurveyList);
		//处理公示结果
		Record noticeRecord = (Record) getParameter("noticeRecord");
		SamApplyNotice samApplyNotice=(SamApplyNotice)noticeRecord.toBean(SamApplyNotice.class);
		List<SamApplyNotice> samApplyNoticeList = new ArrayList<SamApplyNotice>(); 
		samApplyNoticeList.add(samApplyNotice);
		samApplyInfo.setSamApplyNoticeList(samApplyNoticeList);
		
		return samApplyInfo;
	}
	/**
	 * 封装低保家庭成员信息
	 * @return
	 */
	private BaseinfoPeople getPeopleInfo() {
		StringBuffer checkLog = new StringBuffer();
		//家庭成员信息
		Record baseinfoPeopleRecord = (Record) getParameter("baseinfoPeopleRecord");
		BaseinfoPeople baseinfoPeople=(BaseinfoPeople)baseinfoPeopleRecord.toBean(BaseinfoPeople.class);
		
		//校验身份证号
		String idCard = baseinfoPeople.getIdCard();
		if(!IdCardCheck.isValidatedAllIdcard(idCard)){
			checkLog.append("姓名："+baseinfoPeople.getName()+"身份证号不合法，请检查！");
		}
		//校验此人能否进行录入
		SamApplyCheckUtil samApplyCheckUtil;
		try {
			samApplyCheckUtil = new SamApplyCheckUtil();
			SamCheckLog samCheckLog= samApplyCheckUtil.queryExistApply(idCard,(String)getParameter("applyId"));
			if(!samCheckLog.isResult()){
				checkLog.append(samCheckLog.getContext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//人员类型信息
		Record[] peopleTypeRecords = (Record[])getParameter("peopleTypeRecords");
		List<SamPeopleType> samPeopleTypeList = new ArrayList<SamPeopleType>();
		if(peopleTypeRecords != null){
			for(int i=0;i<peopleTypeRecords.length;i++){
				SamPeopleType peopleType=(SamPeopleType)peopleTypeRecords[i].toBean(SamPeopleType.class);
				samPeopleTypeList.add(peopleType);
			}
		}
		baseinfoPeople.setSamPeopleTypeList(samPeopleTypeList);
		//家庭成员扩展信息
		Record peopleExtendRecord = (Record) getParameter("peopleExtendRecord");
		SamPeopleExtend peopleExtend=(SamPeopleExtend)peopleExtendRecord.toBean(SamPeopleExtend.class);
		baseinfoPeople.setSamPeopleExtend(peopleExtend);
		//疾病信息
		Record peopleDiseaseRecord = (Record) getParameter("peopleDiseaseRecord");
		if(peopleDiseaseRecord!=null){
			SamPeopleDisease peopleDisease=(SamPeopleDisease)peopleDiseaseRecord.toBean(SamPeopleDisease.class);
			baseinfoPeople.setSamPeopleDisease(peopleDisease);
		}
		//残疾信息
		Record peopleDisabilityRecord = (Record) getParameter("peopleDisabilityRecord");
		if(peopleDisabilityRecord!=null){
			SamPeopleDisability peopleDisability=(SamPeopleDisability)peopleDisabilityRecord.toBean(SamPeopleDisability.class);
			baseinfoPeople.setSamPeopleDisability(peopleDisability);
		}
		//教育信息
		Record peopleEduRecord = (Record) getParameter("peopleEduRecord");
		SamPeopleEdu peopleEdu=(SamPeopleEdu)peopleEduRecord.toBean(SamPeopleEdu.class);
		baseinfoPeople.setSamPeopleEdu(peopleEdu);
		//就业信息
		Record peopleJobsRecord = (Record) getParameter("peopleJobsRecord");
		if(peopleJobsRecord != null){
			SamPeopleJobs peopleJobs=(SamPeopleJobs)peopleJobsRecord.toBean(SamPeopleJobs.class);
			baseinfoPeople.setSamPeopleJobs(peopleJobs);
		}
		//人员保障性支出信息
		Record[] peopleInsuranceRecords = (Record[])getParameter("peopleInsuranceRecords");
		List<SamPeopleInsurance> peopleInsuranceList = new ArrayList<SamPeopleInsurance>();
		if(peopleInsuranceRecords != null){
			for(int i=0;i<peopleInsuranceRecords.length;i++){
				SamPeopleInsurance peopleInsurance=(SamPeopleInsurance)peopleInsuranceRecords[i].toBean(SamPeopleInsurance.class);
				peopleInsuranceList.add(peopleInsurance);
			}
		}
		baseinfoPeople.setSamPeopleInsuranceList(peopleInsuranceList);
		baseinfoPeople.setCheckLog(checkLog);
		
		return baseinfoPeople;
	}
}
