package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptPeopleDependant
 * @description:
 * @author:王宝才
 * @since:2011-05-19
 * @version:1.0
*/
 @Table(tableName = "BPT_PEOPLE_DEPENDANT" , keyFields = "peopleId")
public class BptPeopleDependant extends StatefulDatabean {
   //人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   	
   	//是否正在上学
   	@Rule(value="require")
	@Column(name = "STUDENT_FLAG")
   private String studentFlag;
	
	//是否持证人
   	@Rule(value="require")
	@Column(name = "HOLDER_FLAG")
   private String holderFlag;
   	
   //烈属与烈士关系
   	@Rule(value="require")
	@Column(name = "RELATIONSHIP")
   private String relationship;
   //烈士姓名
   	@Rule(value="require")
	@Column(name = "LEZSW_NAME")
   private String lezswName;
   //烈士性别
   	@Rule(value="require")
	@Column(name = "LEZSW_SEX")
   private String lezswSex;
   //出生日期
   	//@Rule(value="require")
	@Column(name = "LEZSW_BIRTHDAY")
   private String lezswBirthday;
   //烈士入伍时间
	@Column(name = "CONSCRIPT_DATE")
   private String conscriptDate;
   //烈士所在单位
	@Column(name = "WORK_UNIT")
   private String workUnit;
   //烈士职务
	@Column(name = "POSITION")
   private String position;
   //烈士牺牲病故时间
	//@Rule(value="require")
	@Column(name = "DEATH_DATE")
   private String deathDate;
   //烈士牺牲病故地点
	@Column(name = "DEATH_ADDRESS")
   private String deathAddress;
	 //烈士牺牲病故地点
	@Column(name = "BURY_ADDRESS")
   private String buryAddress;
   //烈士牺牲病故原因
	@Column(name = "DEATH_REASON")
   private String deathReason;
   //烈士批准时间
	//@Rule(value="require")
	@Column(name = "LEZSW_APPROVE_DATE")
   private String lezswApproveDate;
   //牺牲病故证书字号
	//@Rule(value="require")
	@Column(name = "LEZSW_CERTIFICATE_ID")
   private String lezswCertificateId;
   //备注
	@Column(name = "NOTE")
   private String note;
   //初审意见（村居）
	@Column(name = "CHECK_ADVICE")
   private String checkAdvice;
   //初审人
	@Column(name = "CHECK_INCHARGE")
   private String checkIncharge;
   //初审时间
	@Column(name = "CHECK_APPROVE_DATE")
   private String checkApproveDate;
   //复核意见（乡镇）
	@Column(name = "ADUIT_ADVICE")
   private String aduitAdvice;
   //复核人
	@Column(name = "ADUIT_INCHARGE")
   private String aduitIncharge;
   //复核时间
	@Column(name = "ADUIT_APPROVE_DATE")
   private String aduitApproveDate;
   //审批意见（县）
	@Column(name = "VERIFY_ADVICE")
   private String verifyAdvice;
   //审批人
	@Column(name = "VERIFY_INCHARGE")
   private String verifyIncharge;
   //审批时间
	@Column(name = "VERIFY__APPROVE_DATE")
   private String verifyApproveDate;
   //批准日期
	@Column(name = "APPROVAL_DATE")
   private String approvalDate;
   //注销日期
	@Column(name = "CANCELLATION_DATE")
   private String cancellationDate;
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
	
   public String getBuryAddress() {
		return buryAddress;
	}
	public void setBuryAddress(String buryAddress) {
		this.buryAddress = buryAddress;
	}
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
    * getter for 烈属与烈士关系
    * @generated
    */
   public String getRelationship(){
      return this.relationship;
   }
   /**
    * setter for 烈属与烈士关系
    * @generated
    */
   public void setRelationship(String relationship){
      this.relationship = relationship;
   }

   /**
    * getter for 烈士姓名
    * @generated
    */
   public String getLezswName(){
      return this.lezswName;
   }
   /**
    * setter for 烈士姓名
    * @generated
    */
   public void setLezswName(String lezswName){
      this.lezswName = lezswName;
   }

   /**
    * getter for 烈士性别
    * @generated
    */
   public String getLezswSex(){
      return this.lezswSex;
   }
   /**
    * setter for 烈士性别
    * @generated
    */
   public void setLezswSex(String lezswSex){
      this.lezswSex = lezswSex;
   }

   /**
    * getter for 出生日期
    * @generated
    */
   public String getLezswBirthday(){
      return this.lezswBirthday;
   }
   /**
    * setter for 出生日期
    * @generated
    */
   public void setLezswBirthday(String lezswBirthday){
      this.lezswBirthday = lezswBirthday;
   }

   /**
    * getter for 烈士入伍时间
    * @generated
    */
   public String getConscriptDate(){
      return this.conscriptDate;
   }
   /**
    * setter for 烈士入伍时间
    * @generated
    */
   public void setConscriptDate(String conscriptDate){
      this.conscriptDate = conscriptDate;
   }

   /**
    * getter for 烈士所在单位
    * @generated
    */
   public String getWorkUnit(){
      return this.workUnit;
   }
   /**
    * setter for 烈士所在单位
    * @generated
    */
   public void setWorkUnit(String workUnit){
      this.workUnit = workUnit;
   }

   /**
    * getter for 烈士职务
    * @generated
    */
   public String getPosition(){
      return this.position;
   }
   /**
    * setter for 烈士职务
    * @generated
    */
   public void setPosition(String position){
      this.position = position;
   }

   /**
    * getter for 烈士牺牲病故时间
    * @generated
    */
   public String getDeathDate(){
      return this.deathDate;
   }
   /**
    * setter for 烈士牺牲病故时间
    * @generated
    */
   public void setDeathDate(String deathDate){
      this.deathDate = deathDate;
   }

   /**
    * getter for 烈士牺牲病故地点
    * @generated
    */
   public String getDeathAddress(){
      return this.deathAddress;
   }
   /**
    * setter for 烈士牺牲病故地点
    * @generated
    */
   public void setDeathAddress(String deathAddress){
      this.deathAddress = deathAddress;
   }

   /**
    * getter for 烈士牺牲病故原因
    * @generated
    */
   public String getDeathReason(){
      return this.deathReason;
   }
   /**
    * setter for 烈士牺牲病故原因
    * @generated
    */
   public void setDeathReason(String deathReason){
      this.deathReason = deathReason;
   }

   /**
    * getter for 烈士批准时间
    * @generated
    */
   public String getLezswApproveDate(){
      return this.lezswApproveDate;
   }
   /**
    * setter for 烈士批准时间
    * @generated
    */
   public void setLezswApproveDate(String lezswApproveDate){
      this.lezswApproveDate = lezswApproveDate;
   }

   /**
    * getter for 烈士证书字号
    * @generated
    */
   public String getLezswCertificateId(){
      return this.lezswCertificateId;
   }
   /**
    * setter for 烈士证书字号
    * @generated
    */
   public void setLezswCertificateId(String lezswCertificateId){
      this.lezswCertificateId = lezswCertificateId;
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
   public String getVerifyApproveDate(){
      return this.verifyApproveDate;
   }
   /**
    * setter for 审批时间
    * @generated
    */
   public void setVerifyApproveDate(String verifyApproveDate){
      this.verifyApproveDate = verifyApproveDate;
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
    * getter for 注销日期
    * @generated
    */
   public String getCancellationDate(){
      return this.cancellationDate;
   }
   /**
    * setter for 注销日期
    * @generated
    */
   public void setCancellationDate(String cancellationDate){
      this.cancellationDate = cancellationDate;
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

/**
 * @return the studentFlag
 */
public String getStudentFlag() {
	return studentFlag;
}
/**
 * @param studentFlag the studentFlag to set
 */
public void setStudentFlag(String studentFlag) {
	this.studentFlag = studentFlag;
}
/**
 * @return the holderFlag
 */
public String getHolderFlag() {
	return holderFlag;
}
/**
 * @param holderFlag the holderFlag to set
 */
public void setHolderFlag(String holderFlag) {
	this.holderFlag = holderFlag;
}

}