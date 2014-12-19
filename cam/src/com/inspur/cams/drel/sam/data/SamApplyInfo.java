package com.inspur.cams.drel.sam.data;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;

/**
 * @title:低保申请审批信息
 * @description:
 * @author:	yanliangliang
 * @since:2012-05-02
 * @version:1.0
 */
@Table(tableName = "SAM_APPLY_INFO" , keyFields = "applyId")
public class SamApplyInfo extends StatefulDatabean {
	@Transient
	private StringBuffer checkLog ;
	//家庭信息
	@Transient
	private BaseinfoFamily baseInfoFamily; 
	//人员信息
	@Transient
	private List<BaseinfoPeople> baseinfoPeopleList = new ArrayList<BaseinfoPeople>();
	//家庭财产信息
	@Transient
	private List<SamFamilyEstate> samFamilyEstateList = new ArrayList<SamFamilyEstate>();
	//家庭房屋信息
	@Transient
	private List<SamFamilyHouse> samFamilyHouseList = new ArrayList<SamFamilyHouse>(); 
	//家庭房屋信息
	@Transient
	private List<SamFamilySupport> samFamilySupportList = new ArrayList<SamFamilySupport>(); 
	//救助类型多选
	@Transient
	private List<SamFamilyAssistance> samFamilyAssistanceList = new ArrayList<SamFamilyAssistance>(); 
	//入户调查
	@Transient
	private List<SamApplySurvey> samApplySurveyList = new ArrayList<SamApplySurvey>(); 
	// 评议结果
	@Transient
	private List<SamApplyDiscussion> samApplyDiscussionList = new ArrayList<SamApplyDiscussion>(); 
	//公示结果
	@Transient
	private List<SamApplyNotice> samApplyNoticeList = new ArrayList<SamApplyNotice>(); 
	//委派实例ID
	@Transient
	private String assignmentId;
	//环节意见
	@Transient
	private SamApplyOptionsHis samApplyOptionsHis;
	//银行信息
	@Transient
	private SamBankAccount samBankAccount; 
	//批量审批的人员Id
	@Transient
	private List<String> applyIdList; 
	
	//批量审批的人员assignmentId
	@Transient
	private List<String> assignmentIdList; 
	
	//APPLY_ID
	@Column(name = "APPLY_ID")
	private String applyId;
	//FAMILY_ID
	@Column(name = "FAMILY_ID")
	private String familyId;
	//FAMILY_NAME
	@Column(name = "FAMILY_NAME")
	private String familyName;
	//FAMILY_CARD_NO
	@Column(name = "FAMILY_CARD_NO")
	private String familyCardNo;
	//PEOPLE_NUM
	@Rule(value="number")
	@Column(name = "PEOPLE_NUM")
	private BigDecimal peopleNum;
	//DOMICILE_CODE
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;
	//ASSISTANCE_NUM
	@Rule(value="number")
	@Column(name = "ASSISTANCE_PEOPLE_NUM")
	private BigDecimal assistancePeopleNum;
	//APPLY_TYPE
	@Column(name = "APPLY_TYPE")
	private String applyType;
	//APPLY_DATE
	@Column(name = "APPLY_DATE")
	private String applyDate;
	//APPLY_REASON
	@Column(name = "APPLY_REASON")
	private String applyReason;
	//ACCEPT_OPINION_ID
	@Column(name = "ACCEPT_OPINION_ID")
	private String acceptOpinionId;
	//ACCEPT_ORGAN_ID
	@Column(name = "ACCEPT_ORGAN_ID")
	private String acceptOrganId;
	//ACCEPT_DEPT_ID
	@Column(name = "ACCEPT_DEPT_ID")
	private String acceptDeptId;
	//ACCEPT_PEOPLE_NAME
	@Column(name = "ACCEPT_PEOPLE_NAME")
	private String acceptPeopleName;
	//ACCEPT_PEOPLE_ID
	@Column(name = "ACCEPT_PEOPLE_ID")
	private String acceptPeopleId;
	//ACCEPT_DATE
	@Column(name = "ACCEPT_DATE")
	private String acceptDate;
	//CHECK_OPINION_ID
	@Column(name = "CHECK_OPINION_ID")
	private String checkOpinionId;
	//CHECK_ORGAN_ID
	@Column(name = "CHECK_ORGAN_ID")
	private String checkOrganId;
	//CHECK_DEPT_ID
	@Column(name = "CHECK_DEPT_ID")
	private String checkDeptId;
	//CHECK_PEOPLE_NAME
	@Column(name = "CHECK_PEOPLE_NAME")
	private String checkPeopleName;
	//CHECK_PEOPLE_ID
	@Column(name = "CHECK_PEOPLE_ID")
	private String checkPeopleId;
	//CHECK_DATE
	@Column(name = "CHECK_DATE")
	private String checkDate;
	//AUDIT_OPINION_ID
	@Column(name = "AUDIT_OPINION_ID")
	private String auditOpinionId;
	//AUDIT_ORGAN_ID
	@Column(name = "AUDIT_ORGAN_ID")
	private String auditOrganId;
	//AUDIT_DEPT_ID
	@Column(name = "AUDIT_DEPT_ID")
	private String auditDeptId;
	//AUDIT_PEOPLE_NAME
	@Column(name = "AUDIT_PEOPLE_NAME")
	private String auditPeopleName;
	//AUDIT_PEOPLE_ID
	@Column(name = "AUDIT_PEOPLE_ID")
	private String auditPeopleId;
	//AUDIT_DATE
	@Column(name = "AUDIT_DATE")
	private String auditDate;
	//IF_CHECK
	@Column(name = "IF_CHECK")
	private String ifCheck;

	private String changeItem;
	private String ensureId;


	private String isFinish;
	private BigDecimal assistanceMoney;
	private String supportWay;
	private String supportOrg;

	private String cardNo;
	private String checkPrincipal;
	private String checkRemarks;
	private String auditPrincipal;
	private String auditRemarks;
	private String beginDate;

	private String curActivityId;
	private String curActivityName;
	private String curOpinion;
	private String finishTime;
	private String domicileName;

	private String checkAgent;
	private String auditAgent;
	private String assistanceMode;
	private BigDecimal assistanceClassMoney;
	private String asisstanceClass;



	public String getAsisstanceClass() {
		return asisstanceClass;
	}
	public void setAsisstanceClass(String asisstanceClass) {
		this.asisstanceClass = asisstanceClass;
	}
	public String getAssistanceMode() {
		return assistanceMode;
	}
	public void setAssistanceMode(String assistanceMode) {
		this.assistanceMode = assistanceMode;
	}
	public BigDecimal getAssistanceClassMoney() {
		return assistanceClassMoney;
	}
	public void setAssistanceClassMoney(BigDecimal assistanceClassMoney) {
		this.assistanceClassMoney = assistanceClassMoney;
	}
	public String getDomicileName() {
		return domicileName;
	}
	public void setDomicileName(String domicileName) {
		this.domicileName = domicileName;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * getter for APPLY_ID
	 * @generated
	 */
	public String getApplyId(){
		return this.applyId;
	}
	/**
	 * setter for APPLY_ID
	 * @generated
	 */
	public void setApplyId(String applyId){
		this.applyId = applyId;
	}

	/**
	 * getter for FAMILY_ID
	 * @generated
	 */
	public String getFamilyId(){
		return this.familyId;
	}
	/**
	 * setter for FAMILY_ID
	 * @generated
	 */
	public void setFamilyId(String familyId){
		this.familyId = familyId;
	}

	/**
	 * getter for FAMILY_NAME
	 * @generated
	 */
	public String getFamilyName(){
		return this.familyName;
	}
	/**
	 * setter for FAMILY_NAME
	 * @generated
	 */
	public void setFamilyName(String familyName){
		this.familyName = familyName;
	}

	/**
	 * getter for FAMILY_CARD_NO
	 * @generated
	 */
	public String getFamilyCardNo(){
		return this.familyCardNo;
	}
	/**
	 * setter for FAMILY_CARD_NO
	 * @generated
	 */
	public void setFamilyCardNo(String familyCardNo){
		this.familyCardNo = familyCardNo;
	}

	/**
	 * getter for PEOPLE_NUM
	 * @generated
	 */
	public BigDecimal getPeopleNum(){
		return this.peopleNum;
	}
	/**
	 * setter for PEOPLE_NUM
	 * @generated
	 */
	public void setPeopleNum(BigDecimal peopleNum){
		this.peopleNum = peopleNum;
	}

	/**
	 * getter for DOMICILE_CODE
	 * @generated
	 */
	public String getDomicileCode(){
		return this.domicileCode;
	}
	/**
	 * setter for DOMICILE_CODE
	 * @generated
	 */
	public void setDomicileCode(String domicileCode){
		this.domicileCode = domicileCode;
	}


	public BigDecimal getAssistancePeopleNum() {
		return assistancePeopleNum;
	}
	public void setAssistancePeopleNum(BigDecimal assistancePeopleNum) {
		this.assistancePeopleNum = assistancePeopleNum;
	}
	public BigDecimal getAssistanceMoney() {
		return assistanceMoney;
	}
	public void setAssistanceMoney(BigDecimal assistanceMoney) {
		this.assistanceMoney = assistanceMoney;
	}
	/**
	 * getter for APPLY_TYPE
	 * @generated
	 */
	public String getApplyType(){
		return this.applyType;
	}
	/**
	 * setter for APPLY_TYPE
	 * @generated
	 */
	public void setApplyType(String applyType){
		this.applyType = applyType;
	}

	/**
	 * getter for APPLY_DATE
	 * @generated
	 */
	public String getApplyDate(){
		return this.applyDate;
	}
	/**
	 * setter for APPLY_DATE
	 * @generated
	 */
	public void setApplyDate(String applyDate){
		this.applyDate = applyDate;
	}

	/**
	 * getter for APPLY_REASON
	 * @generated
	 */
	public String getApplyReason(){
		return this.applyReason;
	}
	/**
	 * setter for APPLY_REASON
	 * @generated
	 */
	public void setApplyReason(String applyReason){
		this.applyReason = applyReason;
	}

	/**
	 * getter for ACCEPT_OPINION_ID
	 * @generated
	 */
	public String getAcceptOpinionId(){
		return this.acceptOpinionId;
	}
	/**
	 * setter for ACCEPT_OPINION_ID
	 * @generated
	 */
	public void setAcceptOpinionId(String acceptOpinionId){
		this.acceptOpinionId = acceptOpinionId;
	}

	/**
	 * getter for ACCEPT_ORGAN_ID
	 * @generated
	 */
	public String getAcceptOrganId(){
		return this.acceptOrganId;
	}
	/**
	 * setter for ACCEPT_ORGAN_ID
	 * @generated
	 */
	public void setAcceptOrganId(String acceptOrganId){
		this.acceptOrganId = acceptOrganId;
	}

	/**
	 * getter for ACCEPT_DEPT_ID
	 * @generated
	 */
	public String getAcceptDeptId(){
		return this.acceptDeptId;
	}
	/**
	 * setter for ACCEPT_DEPT_ID
	 * @generated
	 */
	public void setAcceptDeptId(String acceptDeptId){
		this.acceptDeptId = acceptDeptId;
	}

	/**
	 * getter for ACCEPT_PEOPLE_NAME
	 * @generated
	 */
	public String getAcceptPeopleName(){
		return this.acceptPeopleName;
	}
	/**
	 * setter for ACCEPT_PEOPLE_NAME
	 * @generated
	 */
	public void setAcceptPeopleName(String acceptPeopleName){
		this.acceptPeopleName = acceptPeopleName;
	}

	/**
	 * getter for ACCEPT_PEOPLE_ID
	 * @generated
	 */
	public String getAcceptPeopleId(){
		return this.acceptPeopleId;
	}
	/**
	 * setter for ACCEPT_PEOPLE_ID
	 * @generated
	 */
	public void setAcceptPeopleId(String acceptPeopleId){
		this.acceptPeopleId = acceptPeopleId;
	}

	/**
	 * getter for ACCEPT_DATE
	 * @generated
	 */
	public String getAcceptDate(){
		return this.acceptDate;
	}
	/**
	 * setter for ACCEPT_DATE
	 * @generated
	 */
	public void setAcceptDate(String acceptDate){
		this.acceptDate = acceptDate;
	}

	/**
	 * getter for CHECK_OPINION_ID
	 * @generated
	 */
	public String getCheckOpinionId(){
		return this.checkOpinionId;
	}
	/**
	 * setter for CHECK_OPINION_ID
	 * @generated
	 */
	public void setCheckOpinionId(String checkOpinionId){
		this.checkOpinionId = checkOpinionId;
	}

	/**
	 * getter for CHECK_ORGAN_ID
	 * @generated
	 */
	public String getCheckOrganId(){
		return this.checkOrganId;
	}
	/**
	 * setter for CHECK_ORGAN_ID
	 * @generated
	 */
	public void setCheckOrganId(String checkOrganId){
		this.checkOrganId = checkOrganId;
	}

	/**
	 * getter for CHECK_DEPT_ID
	 * @generated
	 */
	public String getCheckDeptId(){
		return this.checkDeptId;
	}
	/**
	 * setter for CHECK_DEPT_ID
	 * @generated
	 */
	public void setCheckDeptId(String checkDeptId){
		this.checkDeptId = checkDeptId;
	}

	/**
	 * getter for CHECK_PEOPLE_NAME
	 * @generated
	 */
	public String getCheckPeopleName(){
		return this.checkPeopleName;
	}
	/**
	 * setter for CHECK_PEOPLE_NAME
	 * @generated
	 */
	public void setCheckPeopleName(String checkPeopleName){
		this.checkPeopleName = checkPeopleName;
	}

	/**
	 * getter for CHECK_PEOPLE_ID
	 * @generated
	 */
	public String getCheckPeopleId(){
		return this.checkPeopleId;
	}
	/**
	 * setter for CHECK_PEOPLE_ID
	 * @generated
	 */
	public void setCheckPeopleId(String checkPeopleId){
		this.checkPeopleId = checkPeopleId;
	}

	/**
	 * getter for CHECK_DATE
	 * @generated
	 */
	public String getCheckDate(){
		return this.checkDate;
	}
	/**
	 * setter for CHECK_DATE
	 * @generated
	 */
	public void setCheckDate(String checkDate){
		this.checkDate = checkDate;
	}

	/**
	 * getter for AUDIT_OPINION_ID
	 * @generated
	 */
	public String getAuditOpinionId(){
		return this.auditOpinionId;
	}
	/**
	 * setter for AUDIT_OPINION_ID
	 * @generated
	 */
	public void setAuditOpinionId(String auditOpinionId){
		this.auditOpinionId = auditOpinionId;
	}

	/**
	 * getter for AUDIT_ORGAN_ID
	 * @generated
	 */
	public String getAuditOrganId(){
		return this.auditOrganId;
	}
	/**
	 * setter for AUDIT_ORGAN_ID
	 * @generated
	 */
	public void setAuditOrganId(String auditOrganId){
		this.auditOrganId = auditOrganId;
	}

	/**
	 * getter for AUDIT_DEPT_ID
	 * @generated
	 */
	public String getAuditDeptId(){
		return this.auditDeptId;
	}
	/**
	 * setter for AUDIT_DEPT_ID
	 * @generated
	 */
	public void setAuditDeptId(String auditDeptId){
		this.auditDeptId = auditDeptId;
	}

	/**
	 * getter for AUDIT_PEOPLE_NAME
	 * @generated
	 */
	public String getAuditPeopleName(){
		return this.auditPeopleName;
	}
	/**
	 * setter for AUDIT_PEOPLE_NAME
	 * @generated
	 */
	public void setAuditPeopleName(String auditPeopleName){
		this.auditPeopleName = auditPeopleName;
	}

	/**
	 * getter for AUDIT_PEOPLE_ID
	 * @generated
	 */
	public String getAuditPeopleId(){
		return this.auditPeopleId;
	}
	/**
	 * setter for AUDIT_PEOPLE_ID
	 * @generated
	 */
	public void setAuditPeopleId(String auditPeopleId){
		this.auditPeopleId = auditPeopleId;
	}

	/**
	 * getter for AUDIT_DATE
	 * @generated
	 */
	public String getAuditDate(){
		return this.auditDate;
	}
	/**
	 * setter for AUDIT_DATE
	 * @generated
	 */
	public void setAuditDate(String auditDate){
		this.auditDate = auditDate;
	}
	public BaseinfoFamily getBaseInfoFamily() {
		return baseInfoFamily;
	}
	public void setBaseInfoFamily(BaseinfoFamily baseInfoFamily) {
		this.baseInfoFamily = baseInfoFamily;
	}
	public List<BaseinfoPeople> getBaseinfoPeopleList() {
		return baseinfoPeopleList;
	}
	public void setBaseinfoPeopleList(List<BaseinfoPeople> baseinfoPeopleList) {
		this.baseinfoPeopleList = baseinfoPeopleList;
	}
	public List<SamFamilyEstate> getSamFamilyEstateList() {
		return samFamilyEstateList;
	}
	public void setSamFamilyEstateList(List<SamFamilyEstate> samFamilyEstateList) {
		this.samFamilyEstateList = samFamilyEstateList;
	}
	public List<SamFamilyHouse> getSamFamilyHouseList() {
		return samFamilyHouseList;
	}
	public void setSamFamilyHouseList(List<SamFamilyHouse> samFamilyHouseList) {
		this.samFamilyHouseList = samFamilyHouseList;
	}
	public List<SamFamilySupport> getSamFamilySupportList() {
		return samFamilySupportList;
	}
	public void setSamFamilySupportList(List<SamFamilySupport> samFamilySupportList) {
		this.samFamilySupportList = samFamilySupportList;
	}
	public List<SamFamilyAssistance> getSamFamilyAssistanceList() {
		return samFamilyAssistanceList;
	}
	public void setSamFamilyAssistanceList(
			List<SamFamilyAssistance> samFamilyAssistanceList) {
		this.samFamilyAssistanceList = samFamilyAssistanceList;
	}
	public List<SamApplySurvey> getSamApplySurveyList() {
		return samApplySurveyList;
	}
	public void setSamApplySurveyList(List<SamApplySurvey> samApplySurveyList) {
		this.samApplySurveyList = samApplySurveyList;
	}
	public List<SamApplyDiscussion> getSamApplyDiscussionList() {
		return samApplyDiscussionList;
	}
	public void setSamApplyDiscussionList(
			List<SamApplyDiscussion> samApplyDiscussionList) {
		this.samApplyDiscussionList = samApplyDiscussionList;
	}
	public List<SamApplyNotice> getSamApplyNoticeList() {
		return samApplyNoticeList;
	}
	public void setSamApplyNoticeList(List<SamApplyNotice> samApplyNoticeList) {
		this.samApplyNoticeList = samApplyNoticeList;
	}
	public String getAssignmentId() {
		return assignmentId;
	}
	public void setAssignmentId(String assignmentId) {
		this.assignmentId = assignmentId;
	}
	public SamApplyOptionsHis getSamApplyOptionsHis() {
		return samApplyOptionsHis;
	}
	public void setSamApplyOptionsHis(SamApplyOptionsHis samApplyOptionsHis) {
		this.samApplyOptionsHis = samApplyOptionsHis;
	}
	public String getIsFinish() {
		return isFinish;
	}
	public void setIsFinish(String isFinish) {
		this.isFinish = isFinish;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getCheckPrincipal() {
		return checkPrincipal;
	}
	public void setCheckPrincipal(String checkPrincipal) {
		this.checkPrincipal = checkPrincipal;
	}
	public String getCheckRemarks() {
		return checkRemarks;
	}
	public void setCheckRemarks(String checkRemarks) {
		this.checkRemarks = checkRemarks;
	}
	public String getAuditPrincipal() {
		return auditPrincipal;
	}
	public void setAuditPrincipal(String auditPrincipal) {
		this.auditPrincipal = auditPrincipal;
	}
	public String getAuditRemarks() {
		return auditRemarks;
	}
	public void setAuditRemarks(String auditRemarks) {
		this.auditRemarks = auditRemarks;
	}
	public String getSupportWay() {
		return supportWay;
	}
	public void setSupportWay(String supportWay) {
		this.supportWay = supportWay;
	}
	public String getSupportOrg() {
		return supportOrg;
	}
	public void setSupportOrg(String supportOrg) {
		this.supportOrg = supportOrg;
	}
	public String getCurActivityId() {
		return curActivityId;
	}
	public void setCurActivityId(String curActivityId) {
		this.curActivityId = curActivityId;
	}
	public String getCurActivityName() {
		return curActivityName;
	}
	public void setCurActivityName(String curActivityName) {
		this.curActivityName = curActivityName;
	}
	public String getCurOpinion() {
		return curOpinion;
	}
	public void setCurOpinion(String curOpinion) {
		this.curOpinion = curOpinion;
	}
	public String getFinishTime() {
		return finishTime;
	}
	public void setFinishTime(String finishTime) {
		this.finishTime = finishTime;
	}
	public String getCheckAgent() {
		return checkAgent;
	}
	public void setCheckAgent(String checkAgent) {
		this.checkAgent = checkAgent;
	}
	public String getIfCheck() {
		return ifCheck;
	}
	public void setIfCheck(String ifCheck) {
		this.ifCheck = ifCheck;
	}
	public String getAuditAgent() {
		return auditAgent;
	}
	public void setAuditAgent(String auditAgent) {
		this.auditAgent = auditAgent;
	}
	public SamBankAccount getSamBankAccount() {
		return samBankAccount;
	}
	public void setSamBankAccount(SamBankAccount samBankAccount) {
		this.samBankAccount = samBankAccount;
	}
	/**
	 * @return the changeItem
	 */
	public String getChangeItem() {
		return changeItem;
	}
	/**
	 * @param changeItem the changeItem to set
	 */
	public void setChangeItem(String changeItem) {
		this.changeItem = changeItem;
	}
	public List<String> getApplyIdList() {
		return applyIdList;
	}
	public void setApplyIdList(List<String> applyIdList) {
		this.applyIdList = applyIdList;
	}
	public List<String> getAssignmentIdList() {
		return assignmentIdList;
	}
	public void setAssignmentIdList(List<String> assignmentIdList) {
		this.assignmentIdList = assignmentIdList;
	}
	public StringBuffer getCheckLog() {
		return checkLog;
	}
	public void setCheckLog(StringBuffer checkLog) {
		this.checkLog = checkLog;
	}
	public String getEnsureId() {
		return ensureId;
	}
	public void setEnsureId(String ensureId) {
		this.ensureId = ensureId;
	}
	

}