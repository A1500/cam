package com.inspur.cams.drel.application.country.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.drel.application.country.domain.ISamCountryChangeDomain;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
import com.inspur.cams.drel.sam.data.SamApplySurvey;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
/**
 * 农村低保复查变更业务Cmd
 * @author yanliangliang
 * @date 2012年5月29日14:15:07
 */
public class SamCountryChangeCmd extends BaseAjaxCommand {
	// 获取SCA组件
	private ISamCountryChangeDomain service = ScaComponentFactory.getService(ISamCountryChangeDomain.class,
			"samCountryChangeDomain/samCountryChangeDomain");
	/**
	 * 保存低保复查变更业务信息
	 */
	public void insertInfo() {
		SamApplyInfo applyInfo=service.insertInfo(getApplyInfo());
		setReturn("familyId",applyInfo.getFamilyId());
		setReturn("applyId",applyInfo.getApplyId());
		setReturn("assignmentId",applyInfo.getAssignmentId());
		setReturn("photoId",applyInfo.getBaseInfoFamily().getPhotoId());
	}
	/**
	 * 保存复查变更业务信息(审核新增的)
	 */
	public void insertInfoFromCheck() {
		SamApplyInfo applyInfo=service.insertInfoFromCheck(getApplyInfo());
		setReturn("familyId",applyInfo.getFamilyId());
		setReturn("applyId",applyInfo.getApplyId());
		setReturn("assignmentId",applyInfo.getAssignmentId());
		setReturn("photoId",applyInfo.getBaseInfoFamily().getPhotoId());
	}
	/**
	 * 更新复查变更业务信息(审核新增的)
	 */
	public void updateInfoFromCheck(){
		SamApplyInfo applyInfo=service.updateInfoFromCheck(getApplyInfo());
		setReturn("familyId",applyInfo.getFamilyId());
		setReturn("applyId",applyInfo.getApplyId());
		setReturn("assignmentId",applyInfo.getAssignmentId());
		setReturn("photoId",applyInfo.getBaseInfoFamily().getPhotoId());
	}
	/**
	 * 复查变更受理时提交流程
	 */
	public void submitApply(){
		SamApplyInfo samApplyInfo=getApplyInfo();
		samApplyInfo.setAssignmentId((String)getParameter("assignmentId"));
		service.submitApply(samApplyInfo);
	}
	/**
	 * 更改申请人时保存人员申请人关系
	 */
	public void updatePeopleRelationshipType(){
		Record[] peoples = (Record[])getParameter("peoples");
		service.updatePeopleRelationshipType(peoples);
	}
	/**
	 * 更新低保家庭成员状态信息
	 */
	public void updatePeopleStats(){
		String peopleId = (String) getParameter("peopleId");
		String familyId = (String) getParameter("familyId");
		String personalStatsTag = (String) getParameter("personalStatsTag");
		String assistanceModeValue = (String) getParameter("assistanceModeValue");
		String applyId = (String) getParameter("applyId");
		
		BaseinfoFamily baseinfoFamily=service.updatePeopleStats(peopleId,familyId,personalStatsTag,assistanceModeValue,applyId);
		setReturn("assistancePeopleNum",baseinfoFamily.getAssistancePeopleNum());
		setReturn("yearIncome",baseinfoFamily.getYearIncome());
		setReturn("yearAverageIncome",baseinfoFamily.getYearAverageIncome());	
		setReturn("peopleNum",baseinfoFamily.getPeopleNum());
		setReturn("monthIncome",baseinfoFamily.getMonthIncome());
		setReturn("monthAverageIncome",baseinfoFamily.getMonthAverageIncome());	
		if("10".equals(assistanceModeValue)){
			setReturn("assistanceMoney",baseinfoFamily.getAssistanceMoney());
		}else{
			setReturn("assistanceMoney","null");
		}
	}
	/**
	 * 更新流程意见
	 */
	public void updateApply(){
		service.updateApply(getApplyInfo());
	}
	
	/**
	 * 发送流程
	 */
	public void sendApply(){
		service.sendApply(getApplyInfo());
	}
	
	/**
	 * 保存区县内变更
	 */
	public void saveInChange(){
		service.saveInChange(getApplyInfo());
	}
	/**
	 * 批量审批
	 */
	public void batchApp(){
		service.batchApp(getBatchApply());
	}
// TODO ################################################               私有方法               #########################################
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
	 * 封装低保复查变更业务
	 * @return
	 */
	private SamApplyInfo getApplyInfo() {
		Record applyRecord = (Record) getParameter("applyRecord");
		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
		//处理家庭
		Record familyRecord = (Record) getParameter("familyRecord");
		BaseinfoFamily baseinfoFamily=(BaseinfoFamily)familyRecord.toBean(BaseinfoFamily.class);
		samApplyInfo.setBaseInfoFamily(baseinfoFamily);
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
		if(bankAccount != null ){
			SamBankAccount bank=(SamBankAccount)bankAccount.toBean(SamBankAccount.class);
			samApplyInfo.setSamBankAccount(bank);
		}
		return samApplyInfo;
	}	
	/**
//	 * 封装流程过程中的信息
//	 * @return
//	 */
//	private SamApplyInfo getCourseInfo() {
//		//处理业务主表
//		Record applyRecord = (Record) getParameter("applyRecord");
//		SamApplyInfo samApplyInfo=(SamApplyInfo)applyRecord.toBean(SamApplyInfo.class);
//		//处理家庭
//		Record familyRecord = (Record) getParameter("familyRecord");
//		BaseinfoFamily baseinfoFamily=(BaseinfoFamily)familyRecord.toBean(BaseinfoFamily.class);
//		samApplyInfo.setBaseInfoFamily(baseinfoFamily);
//		//处理入户调查
//		Record surveyRecord = (Record) getParameter("surveyRecord");
//		if(surveyRecord != null ){
//			SamApplySurvey samApplySurvey=(SamApplySurvey)surveyRecord.toBean(SamApplySurvey.class);
//			List<SamApplySurvey> samApplySurveyList = new ArrayList<SamApplySurvey>(); 
//			samApplySurveyList.add(samApplySurvey);
//			samApplyInfo.setSamApplySurveyList(samApplySurveyList);
//		}
//		//处理公示结果
//		Record noticeRecord = (Record) getParameter("noticeRecord");
//		if(noticeRecord != null ){
//			SamApplyNotice samApplyNotice=(SamApplyNotice)noticeRecord.toBean(SamApplyNotice.class);
//			List<SamApplyNotice> samApplyNoticeList = new ArrayList<SamApplyNotice>(); 
//			samApplyNoticeList.add(samApplyNotice);
//			samApplyInfo.setSamApplyNoticeList(samApplyNoticeList);
//		}
//		
//		return samApplyInfo;
//	}
}
