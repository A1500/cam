package com.inspur.sdmz.apply.data;


import java.math.BigDecimal;

import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
/*
 *	业务申请对应的bean	
 */

 @Table(tableName = "SAM_APPLY" , keyFields = "applyId")
public class SamApply extends StatefulDatabean {
   //业务申请ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //业务类型
	@Column(name = "APPLY_TYPE")
   private String applyType;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //申请人（投诉人/咨询人）
	@Column(name = "APPLY_PEOPLE")
   private String applyPeople;
   //身份证号码
	@Column(name = "APPLY_IDCARD")
   private String applyIdcard;
   //性别
	@Column(name = "APPLY_SEX")
   private String applySex;
   //家庭人口
   	@Rule(value="number")
	@Column(name = "APPLY_PEOPLE_NUM")
   private BigDecimal applyPeopleNum;
   //联系电话
	@Column(name = "APPLY_TEL")
   private String applyTel;
   //家庭地址
	@Column(name = "APPLY_ADD")
   private String applyAdd;
   //被投诉单位
	@Column(name = "COMPLAINTED_ORG")
   private String complaintedOrg;
   //申请事由（投诉内容/咨询内容）
	@Column(name = "APPLY_REASONS")
   private String applyReasons;
   //申请日期
	@Column(name = "APPLY_DATE")
   private String applyDate;
   //申请方式
	@Column(name = "APPLY_WAY")
   private String applyWay;
   //应办截止日期
	@Column(name = "AGENDA_DEADLINE")
   private String agendaDeadline;
   //受理人姓名
	@Column(name = "ACCEPT_PEOPLE")
   private String acceptPeople;
   //受理人ID
	@Column(name = "ACCEPT_ID")
   private String acceptId;
   //受理单位名称
	@Column(name = "ACCEPT_ORG_NAME")
   private String acceptOrgName;
   //受理单位区划
	@Column(name = "ACCEPT_ORG_AREA")
   private String acceptOrgArea;
   //受理单位ID
	@Column(name = "ACCEPT_ORG")
   private String acceptOrg;
   //当前单位名称
	@Column(name = "CURRENT_ORG_NAME")
   private String currentOrgName;
   //当前单位区划
	@Column(name = "CURRENT_ORG_AREA")
   private String currentOrgArea;
   //当前单位ID
	@Column(name = "CURRENT_ORG")
   private String currentOrg;
   //办理标志
	@Column(name = "HANDLE_SIGN")
   private String handleSign;
   //是否回访
	@Column(name = "RETURN_VISIT")
   private String returnVisit;
   //回访人
	@Column(name = "VISIT_PEOPLE")
   private String visitPeople;
   //回访时间
	@Column(name = "VISIT_TIME")
   private String visitTime;
   //满意度
	@Column(name = "SATIS_DEGREE")
   private String satisDegree;
   //回访结果
	@Column(name = "VISIT_RESULT")
   private String visitResult;
   //家庭成员
	@Column(name = "FAMILY_MEMBER")
   private String familyMember;
	
	//从表中的办理意见一列，下面是非表列
	@Transient
	private String handleOpinion;
	
	//jsp页面上的是否同意传过来的值，作为非表列
	@Transient
	private String agreeState;

	//jsp页面上的单选按钮传过来的值，作为非表列
	@Transient
	private String handleResult;
	
	//jsp页面 上级列表传过来的值，作为非表列
	@Transient
	private String higherOrg;
	
	//jsp页面 上级列表传过来的值，作为非表列
	@Transient
	private String sameOrg;
	//jsp页面 街道传过来的值，作为非表列
	@Transient
	private String street;
	//jsp页面 区传过来的值，作为非表列
	@Transient
	private String area;
	
	//jsp页面下级列表传过来的值，作为非表列
	@Transient
	private String lowerOrg;
	
	//下拉列表中存在的value
	@Transient
	private String value;
	//和test
	@Transient
	private String text;
	
	//明细页面使的结束日期
	@Transient
	private String handleEndDate;
	
	//为更新页面添加一个显示当前受理人的姓名字段，非表列
	@Transient
	private String currentHanPeo;
   /**
    * getter for 业务申请ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for 业务申请ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

  

   /**
    * getter for 家庭ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for 家庭ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
   }

   /**
    * getter for 申请人（投诉人/咨询人）
    * @generated
    */
   public String getApplyPeople(){
      return this.applyPeople;
   }
   /**
    * setter for 申请人（投诉人/咨询人）
    * @generated
    */
   public void setApplyPeople(String applyPeople){
      this.applyPeople = applyPeople;
   }

   /**
    * getter for 身份证号码
    * @generated
    */
   public String getApplyIdcard(){
      return this.applyIdcard;
   }
   /**
    * setter for 身份证号码
    * @generated
    */
   public void setApplyIdcard(String applyIdcard){
      this.applyIdcard = applyIdcard;
   }

   /**
    * getter for 性别
    * @generated
    */
   public String getApplySex(){
      return this.applySex;
   }
   /**
    * setter for 性别
    * @generated
    */
   public void setApplySex(String applySex){
      this.applySex = applySex;
   }

   /**
    * getter for 家庭人口
    * @generated
    */
   public BigDecimal getApplyPeopleNum(){
      return this.applyPeopleNum;
   }
   /**
    * setter for 家庭人口
    * @generated
    */
   public void setApplyPeopleNum(BigDecimal applyPeopleNum){
      this.applyPeopleNum = applyPeopleNum;
   }

   /**
    * getter for 联系电话
    * @generated
    */
   public String getApplyTel(){
      return this.applyTel;
   }
   /**
    * setter for 联系电话
    * @generated
    */
   public void setApplyTel(String applyTel){
      this.applyTel = applyTel;
   }

   /**
    * getter for 家庭地址
    * @generated
    */
   public String getApplyAdd(){
      return this.applyAdd;
   }
   /**
    * setter for 家庭地址
    * @generated
    */
   public void setApplyAdd(String applyAdd){
      this.applyAdd = applyAdd;
   }

   /**
    * getter for 被投诉单位
    * @generated
    */
   public String getComplaintedOrg(){
      return this.complaintedOrg;
   }
   /**
    * setter for 被投诉单位
    * @generated
    */
   public void setComplaintedOrg(String complaintedOrg){
      this.complaintedOrg = complaintedOrg;
   }

   /**
    * getter for 申请事由（投诉内容/咨询内容）
    * @generated
    */
   public String getApplyReasons(){
      return this.applyReasons;
   }
   /**
    * setter for 申请事由（投诉内容/咨询内容）
    * @generated
    */
   public void setApplyReasons(String applyReasons){
      this.applyReasons = applyReasons;
   }

   /**
    * getter for 申请日期
    * @generated
    */
   public String getApplyDate(){
      return this.applyDate;
   }
   /**
    * setter for 申请日期
    * @generated
    */
   public void setApplyDate(String applyDate){
      this.applyDate = applyDate;
   }

   /**
    * getter for 申请方式
    * @generated
    */
   public String getApplyWay(){
      return this.applyWay;
   }
   /**
    * setter for 申请方式
    * @generated
    */
   public void setApplyWay(String applyWay){
      this.applyWay = applyWay;
   }

   /**
    * getter for 应办截止日期
    * @generated
    */
   public String getAgendaDeadline(){
      return this.agendaDeadline;
   }
   /**
    * setter for 应办截止日期
    * @generated
    */
   public void setAgendaDeadline(String agendaDeadline){
      this.agendaDeadline = agendaDeadline;
   }

   /**
    * getter for 受理人姓名
    * @generated
    */
   public String getAcceptPeople(){
      return this.acceptPeople;
   }
   /**
    * setter for 受理人姓名
    * @generated
    */
   public void setAcceptPeople(String acceptPeople){
      this.acceptPeople = acceptPeople;
   }

   /**
    * getter for 受理人ID
    * @generated
    */
   public String getAcceptId(){
      return this.acceptId;
   }
   /**
    * setter for 受理人ID
    * @generated
    */
   public void setAcceptId(String acceptId){
      this.acceptId = acceptId;
   }

   /**
    * getter for 受理单位名称
    * @generated
    */
   public String getAcceptOrgName(){
      return this.acceptOrgName;
   }
   /**
    * setter for 受理单位名称
    * @generated
    */
   public void setAcceptOrgName(String acceptOrgName){
      this.acceptOrgName = acceptOrgName;
   }

   /**
    * getter for 受理单位区划
    * @generated
    */
   public String getAcceptOrgArea(){
      return this.acceptOrgArea;
   }
   /**
    * setter for 受理单位区划
    * @generated
    */
   public void setAcceptOrgArea(String acceptOrgArea){
      this.acceptOrgArea = acceptOrgArea;
   }

   /**
    * getter for 受理单位ID
    * @generated
    */
   public String getAcceptOrg(){
      return this.acceptOrg;
   }
   /**
    * setter for 受理单位ID
    * @generated
    */
   public void setAcceptOrg(String acceptOrg){
      this.acceptOrg = acceptOrg;
   }

   /**
    * getter for 当前单位名称
    * @generated
    */
   public String getCurrentOrgName(){
      return this.currentOrgName;
   }
   /**
    * setter for 当前单位名称
    * @generated
    */
   public void setCurrentOrgName(String currentOrgName){
      this.currentOrgName = currentOrgName;
   }

   /**
    * getter for 当前单位区划
    * @generated
    */
   public String getCurrentOrgArea(){
      return this.currentOrgArea;
   }
   /**
    * setter for 当前单位区划
    * @generated
    */
   public void setCurrentOrgArea(String currentOrgArea){
      this.currentOrgArea = currentOrgArea;
   }

   /**
    * getter for 当前单位ID
    * @generated
    */
   public String getCurrentOrg(){
      return this.currentOrg;
   }
   /**
    * setter for 当前单位ID
    * @generated
    */
   public void setCurrentOrg(String currentOrg){
      this.currentOrg = currentOrg;
   }

   /**
    * getter for 办理标志
    * @generated
    */
   public String getHandleSign(){
      return this.handleSign;
   }
   /**
    * setter for 办理标志
    * @generated
    */
   public void setHandleSign(String handleSign){
      this.handleSign = handleSign;
   }

   /**
    * getter for 是否回访
    * @generated
    */
   public String getReturnVisit(){
      return this.returnVisit;
   }
   /**
    * setter for 是否回访
    * @generated
    */
   public void setReturnVisit(String returnVisit){
      this.returnVisit = returnVisit;
   }

   /**
    * getter for 回访人
    * @generated
    */
   public String getVisitPeople(){
      return this.visitPeople;
   }
   /**
    * setter for 回访人
    * @generated
    */
   public void setVisitPeople(String visitPeople){
      this.visitPeople = visitPeople;
   }

   /**
    * getter for 回访时间
    * @generated
    */
   public String getVisitTime(){
      return this.visitTime;
   }
   /**
    * setter for 回访时间
    * @generated
    */
   public void setVisitTime(String visitTime){
      this.visitTime = visitTime;
   }

   /**
    * getter for 满意度
    * @generated
    */
   public String getSatisDegree(){
      return this.satisDegree;
   }
   /**
    * setter for 满意度
    * @generated
    */
   public void setSatisDegree(String satisDegree){
      this.satisDegree = satisDegree;
   }

   /**
    * getter for 回访结果
    * @generated
    */
   public String getVisitResult(){
      return this.visitResult;
   }
   /**
    * setter for 回访结果
    * @generated
    */
   public void setVisitResult(String visitResult){
      this.visitResult = visitResult;
   }

   /**
    * getter for 家庭成员
    * @generated
    */
   public String getFamilyMember(){
      return this.familyMember;
   }
   /**
    * setter for 家庭成员
    * @generated
    */
   public void setFamilyMember(String familyMember){
      this.familyMember = familyMember;
   }
public String getHandleOpinion() {
	return handleOpinion;
}
public void setHandleOpinion(String handleOpinion) {
	this.handleOpinion = handleOpinion;
}
public String getAgreeState() {
	return agreeState;
}
public void setAgreeState(String agreeState) {
	this.agreeState = agreeState;
}
public String getHandleResult() {
	return handleResult;
}
public void setHandleResult(String handleResult) {
	this.handleResult = handleResult;
}
public String getHigherOrg() {
	return higherOrg;
}
public void setHigherOrg(String higherOrg) {
	this.higherOrg = higherOrg;
}
public String getSameOrg() {
	return sameOrg;
}
public void setSameOrg(String sameOrg) {
	this.sameOrg = sameOrg;
}
public String getStreet() {
	return street;
}
public void setStreet(String street) {
	this.street = street;
}
public String getArea() {
	return area;
}
public void setArea(String area) {
	this.area = area;
}
public String getLowerOrg() {
	return lowerOrg;
}
public void setLowerOrg(String lowerOrg) {
	this.lowerOrg = lowerOrg;
}
public String getValue() {
	return value;
}
public void setValue(String value) {
	this.value = value;
}
public String getText() {
	return text;
}
public void setText(String text) {
	this.text = text;
}
public String getHandleEndDate() {
	return handleEndDate;
}
public void setHandleEndDate(String handleEndDate) {
	this.handleEndDate = handleEndDate;
}
public String getCurrentHanPeo() {
	return currentHanPeo;
}
public void setCurrentHanPeo(String currentHanPeo) {
	this.currentHanPeo = currentHanPeo;
}
public String getApplyType() {
	return applyType;
}
public void setApplyType(String applyType) {
	this.applyType = applyType;
}

}