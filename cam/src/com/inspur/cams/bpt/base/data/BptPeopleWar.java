package com.inspur.cams.bpt.base.data;


import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptPeopleWar
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 @Table(tableName = "BPT_PEOPLE_WAR" , keyFields = "peopleId")
public class BptPeopleWar extends StatefulDatabean {
   //人员ID
   
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //退伍证号
//   	@Rule(value="require")
	@Column(name = "ASDP_NO")
   private String asdpNo;
   //入伍时间
   	@Rule(value="require")
	@Column(name = "CONSCRIPTC_DATE")
   private String conscriptcDate;
   //退伍时间
   	@Rule(value="require")
	@Column(name = "DECRUITMENT_DATE")
   private String decruitmentDate;
    //参加工作时间
   	@Column(name = "TO_WORK_DATE")
   private String toWorkDate;
   //离退休时间
   	@Column(name = "RETIRED_DATE")
   private String retiredDate;
   //原部队（名称）番号
//   	@Rule(value="require")
	@Column(name = "FORCES_NO")
   private String forcesNo;
   //职务（级别）
	@Column(name = "POSITION")
   private String position;
   //健康状况代码
	@Rule(value="require")
	@Column(name = "HEALTH_STATE_CODE")
   private String healthStateCode;
   //生活状况代码
	@Rule(value="require")
	@Column(name = "LIFE_STATE_CODE")
   private String lifeStateCode;
   //参战类别代码
	@Rule(value="require")
	@Column(name = "WAR_TYPE_CODE")
   private String warTypeCode;
   //享受待遇
	@Column(name = "ENJOY_MON")
   private String enjoyMon;
   //备注
	@Column(name = "NOTE")
   private String note;
   //批准日期
	//@Rule(value="require")
	@Column(name = "APPROVAL_DATE")
   private String approvalDate;
   //注销日期（去世，转移）
	@Column(name = "CANCELLATION_DATE")
   private String cancellationDate;
   //初审意见（村居）
//   	@Rule(value="require")
	@Column(name = "CHECK_ADVICE")
   private String checkAdvice;
   //初审人
//   	@Rule(value="require")
	@Column(name = "CHECK_INCHARGE")
   private String checkIncharge;
   //初审时间
//   	@Rule(value="require")
	@Column(name = "CHECK_APPROVE_DATE")
   private String checkApproveDate;
   //复核意见（乡镇）
 //  	@Rule(value="require")
	@Column(name = "ADUIT_ADVICE")
   private String aduitAdvice;
   //复核人
//   	@Rule(value="require")
	@Column(name = "ADUIT_INCHARGE")
   private String aduitIncharge;
   //复核时间
//   	@Rule(value="require")
	@Column(name = "ADUIT_APPROVE_DATE")
   private String aduitApproveDate;
   //审批意见（县）
//   	@Rule(value="require")
	@Column(name = "VERIFY_ADVICE")
   private String verifyAdvice;
   //审批人
//   	@Rule(value="require")
	@Column(name = "VERIFY_INCHARGE")
   private String verifyIncharge;
   //审批时间
//   	@Rule(value="require")
	@Column(name = "VERIFY_DATE")
   private String verifyDate;
   //录入人ID
   
   	@Column(name = "REG_ID")
   private String regId;
   //录入时间
  
	@Column(name = "REG_TIME")
   private String regTime;
   //修改人ID
   	
	@Column(name = "MOD_ID")
   private String modId;
   //修改时间
   
	@Column(name = "MOD_TIME")
   private String modTime;

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 退伍证号
    * @generated
    */
   public String getAsdpNo(){
      return this.asdpNo;
   }
   /**
    * setter for 退伍证号
    * @generated
    */
   public void setAsdpNo(String asdpNo){
      this.asdpNo = asdpNo;
   }

   /**
    * getter for 入伍（参加工作）时间
    * @generated
    */
   public String getConscriptcDate(){
      return this.conscriptcDate;
   }
   /**
    * setter for 入伍（参加工作）时间
    * @generated
    */
   public void setConscriptcDate(String conscriptcDate){
      this.conscriptcDate = conscriptcDate;
   }

   /**
    * getter for 退伍（离退休）时间
    * @generated
    */
   public String getDecruitmentDate(){
      return this.decruitmentDate;
   }
   /**
    * setter for 退伍（离退休）时间
    * @generated
    */
   public void setDecruitmentDate(String decruitmentDate){
      this.decruitmentDate = decruitmentDate;
   }

   /**
    * getter for 原部队（名称）番号
    * @generated
    */
   public String getForcesNo(){
      return this.forcesNo;
   }
   /**
    * setter for 原部队（名称）番号
    * @generated
    */
   public void setForcesNo(String forcesNo){
      this.forcesNo = forcesNo;
   }

   /**
    * getter for 职务（级别）
    * @generated
    */
   public String getPosition(){
      return this.position;
   }
   /**
    * setter for 职务（级别）
    * @generated
    */
   public void setPosition(String position){
      this.position = position;
   }

   /**
    * getter for 健康状况代码
    * @generated
    */
   public String getHealthStateCode(){
      return this.healthStateCode;
   }
   /**
    * setter for 健康状况代码
    * @generated
    */
   public void setHealthStateCode(String healthStateCode){
      this.healthStateCode = healthStateCode;
   }

   /**
    * getter for 生活状况代码
    * @generated
    */
   public String getLifeStateCode(){
      return this.lifeStateCode;
   }
   /**
    * setter for 生活状况代码
    * @generated
    */
   public void setLifeStateCode(String lifeStateCode){
      this.lifeStateCode = lifeStateCode;
   }

   /**
    * getter for 参战类别代码
    * @generated
    */
   public String getWarTypeCode(){
      return this.warTypeCode;
   }
   /**
    * setter for 参战类别代码
    * @generated
    */
   public void setWarTypeCode(String warTypeCode){
      this.warTypeCode = warTypeCode;
   }

   /**
    * getter for 享受待遇
    * @generated
    */
   public String getEnjoyMon(){
      return this.enjoyMon;
   }
   /**
    * setter for 享受待遇
    * @generated
    */
   public void setEnjoyMon(String enjoyMon){
      this.enjoyMon = enjoyMon;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for 批准日期
    * @generated
    */
   public String getApprovalDate(){
      return this.approvalDate;
   }
   /**
    * setter for 批准日期
    * @generated
    */
   public void setApprovalDate(String approvalDate){
      this.approvalDate = approvalDate;
   }

   /**
    * getter for 注销日期（去世，转移）
    * @generated
    */
   public String getCancellationDate(){
      return this.cancellationDate;
   }
   /**
    * setter for 注销日期（去世，转移）
    * @generated
    */
   public void setCancellationDate(String cancellationDate){
      this.cancellationDate = cancellationDate;
   }

   /**
    * getter for 初审意见（村居）
    * @generated
    */
   public String getCheckAdvice(){
      return this.checkAdvice;
   }
   /**
    * setter for 初审意见（村居）
    * @generated
    */
   public void setCheckAdvice(String checkAdvice){
      this.checkAdvice = checkAdvice;
   }

   /**
    * getter for 初审人
    * @generated
    */
   public String getCheckIncharge(){
      return this.checkIncharge;
   }
   /**
    * setter for 初审人
    * @generated
    */
   public void setCheckIncharge(String checkIncharge){
      this.checkIncharge = checkIncharge;
   }

   /**
    * getter for 初审时间
    * @generated
    */
   public String getCheckApproveDate(){
      return this.checkApproveDate;
   }
   /**
    * setter for 初审时间
    * @generated
    */
   public void setCheckApproveDate(String checkApproveDate){
      this.checkApproveDate = checkApproveDate;
   }

   /**
    * getter for 复核意见（乡镇）
    * @generated
    */
   public String getAduitAdvice(){
      return this.aduitAdvice;
   }
   /**
    * setter for 复核意见（乡镇）
    * @generated
    */
   public void setAduitAdvice(String aduitAdvice){
      this.aduitAdvice = aduitAdvice;
   }

   /**
    * getter for 复核人
    * @generated
    */
   public String getAduitIncharge(){
      return this.aduitIncharge;
   }
   /**
    * setter for 复核人
    * @generated
    */
   public void setAduitIncharge(String aduitIncharge){
      this.aduitIncharge = aduitIncharge;
   }

   /**
    * getter for 复核时间
    * @generated
    */
   public String getAduitApproveDate(){
      return this.aduitApproveDate;
   }
   /**
    * setter for 复核时间
    * @generated
    */
   public void setAduitApproveDate(String aduitApproveDate){
      this.aduitApproveDate = aduitApproveDate;
   }

   /**
    * getter for 审批意见（县）
    * @generated
    */
   public String getVerifyAdvice(){
      return this.verifyAdvice;
   }
   /**
    * setter for 审批意见（县）
    * @generated
    */
   public void setVerifyAdvice(String verifyAdvice){
      this.verifyAdvice = verifyAdvice;
   }

   /**
    * getter for 审批人
    * @generated
    */
   public String getVerifyIncharge(){
      return this.verifyIncharge;
   }
   /**
    * setter for 审批人
    * @generated
    */
   public void setVerifyIncharge(String verifyIncharge){
      this.verifyIncharge = verifyIncharge;
   }

   /**
    * getter for 审批时间
    * @generated
    */
   public String getVerifyDate(){
      return this.verifyDate;
   }
   /**
    * setter for 审批时间
    * @generated
    */
   public void setVerifyDate(String verifyDate){
      this.verifyDate = verifyDate;
   }

   /**
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 修改人ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }
   /**
    * setter for 修改人ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;
   }

   /**
    * getter for 修改时间
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for 修改时间
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }
	public String getToWorkDate() {
		return toWorkDate;
	}
	/**
	    * setter for 参加工作时间
	    * @generated
	    */
	public void setToWorkDate(String toWorkDate) {
		this.toWorkDate = toWorkDate;
	}
	/**
	    * getter for 离退休时间
	    * @generated
	    */
	public String getRetiredDate() {
		return retiredDate;
	}
	/**
	    * setter for 离退休时间
	    * @generated
	    */
	public void setRetiredDate(String retiredDate) {
		this.retiredDate = retiredDate;
	}

}