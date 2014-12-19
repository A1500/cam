package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptPhysicalExamination
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 @Table(tableName = "BPT_PHYSICAL_EXAMINATION" , keyFields = "applyId")
public class BptPhysicalExamination extends StatefulDatabean {
	private String applyId; 
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //身份证件发放机关
	@Column(name = "ISSUING_AUTHORITY")
   private String issuingAuthority;
   //上次体检时间
	@Column(name = "LAST_TIME")
   private String lastTime;
   //上次体检结论
	@Column(name = "LAST_CONCLUSION")
   private String lastConclusion;
   //省厅批准残情等级
	@Column(name = "DIS_LEVEL")
   private String disLevel;
   //申请体检理由
	@Column(name = "APPLY_REASON")
   private String applyReason;
   //村（居）委会意见
	@Column(name = "VILLAGE_VIEW")
   private String villageView;
   //时间
	@Column(name = "VILLAGE_TIME")
   private String villageTime;
   //乡镇（街道）民政办意见
	@Column(name = "TWON_VIEW")
   private String twonView;
   //时间
	@Column(name = "TWON_TIME")
   private String twonTime;
   //县（市区）民政局意见
	@Column(name = "COUNTY_VIEW")
   private String countyView;
   //时间
	@Column(name = "COUNTY_TIME")
   private String countyTime;
   //检查情况概述
	@Column(name = "INSPECTION")
   private String inspection;
   //诊断结论
	@Column(name = "CONCLUSION")
   private String conclusion;
   //会诊小组成员签名
	@Column(name = "SIGNATURE")
   private String signature;
   //医院填写时间
	@Column(name = "HOSPITAL_TIME")
   private String hospitalTime;
	   //入伍时间
	@Column(name = "CONSCRIPT_DATE")
   private String conscriptDate;
	   //退伍填写时间
	@Column(name = "DECRUITMENT_DATE")
   private String decruitmentDate;
	//残疾军人原部队番号
   private String disabledArmyNo;
	   //部队番号
	@Column(name = "FORCES_NO")
   private String forcesNo;
	  //退伍证号
	@Column(name = "ASDP_NO")
   private String asdpNo;
   public String getAsdpNo() {
		return asdpNo;
	}
	public void setAsdpNo(String asdpNo) {
		this.asdpNo = asdpNo;
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
    * getter for 身份证件发放机关
    * @generated
    */
   public String getIssuingAuthority(){
      return this.issuingAuthority;
   }
   /**
    * setter for 身份证件发放机关
    * @generated
    */
   public void setIssuingAuthority(String issuingAuthority){
      this.issuingAuthority = issuingAuthority;
   }

   /**
    * getter for 上次体检时间
    * @generated
    */
   public String getLastTime(){
      return this.lastTime;
   }
   /**
    * setter for 上次体检时间
    * @generated
    */
   public void setLastTime(String lastTime){
      this.lastTime = lastTime;
   }

   /**
    * getter for 上次体检结论
    * @generated
    */
   public String getLastConclusion(){
      return this.lastConclusion;
   }
   /**
    * setter for 上次体检结论
    * @generated
    */
   public void setLastConclusion(String lastConclusion){
      this.lastConclusion = lastConclusion;
   }

   /**
    * getter for 省厅批准残情等级
    * @generated
    */
   public String getDisLevel(){
      return this.disLevel;
   }
   /**
    * setter for 省厅批准残情等级
    * @generated
    */
   public void setDisLevel(String disLevel){
      this.disLevel = disLevel;
   }

   /**
    * getter for 申请体检理由
    * @generated
    */
   public String getApplyReason(){
      return this.applyReason;
   }
   /**
    * setter for 申请体检理由
    * @generated
    */
   public void setApplyReason(String applyReason){
      this.applyReason = applyReason;
   }

   /**
    * getter for 村（居）委会意见
    * @generated
    */
   public String getVillageView(){
      return this.villageView;
   }
   /**
    * setter for 村（居）委会意见
    * @generated
    */
   public void setVillageView(String villageView){
      this.villageView = villageView;
   }

   /**
    * getter for 时间
    * @generated
    */
   public String getVillageTime(){
      return this.villageTime;
   }
   /**
    * setter for 时间
    * @generated
    */
   public void setVillageTime(String villageTime){
      this.villageTime = villageTime;
   }

   /**
    * getter for 乡镇（街道）民政办意见
    * @generated
    */
   public String getTwonView(){
      return this.twonView;
   }
   /**
    * setter for 乡镇（街道）民政办意见
    * @generated
    */
   public void setTwonView(String twonView){
      this.twonView = twonView;
   }

   /**
    * getter for 时间
    * @generated
    */
   public String getTwonTime(){
      return this.twonTime;
   }
   /**
    * setter for 时间
    * @generated
    */
   public void setTwonTime(String twonTime){
      this.twonTime = twonTime;
   }

   /**
    * getter for 县（市区）民政局意见
    * @generated
    */
   public String getCountyView(){
      return this.countyView;
   }
   /**
    * setter for 县（市区）民政局意见
    * @generated
    */
   public void setCountyView(String countyView){
      this.countyView = countyView;
   }

   /**
    * getter for 时间
    * @generated
    */
   public String getCountyTime(){
      return this.countyTime;
   }
   /**
    * setter for 时间
    * @generated
    */
   public void setCountyTime(String countyTime){
      this.countyTime = countyTime;
   }

   /**
    * getter for 检查情况概述
    * @generated
    */
   public String getInspection(){
      return this.inspection;
   }
   /**
    * setter for 检查情况概述
    * @generated
    */
   public void setInspection(String inspection){
      this.inspection = inspection;
   }

   /**
    * getter for 诊断结论
    * @generated
    */
   public String getConclusion(){
      return this.conclusion;
   }
   /**
    * setter for 诊断结论
    * @generated
    */
   public void setConclusion(String conclusion){
      this.conclusion = conclusion;
   }

   /**
    * getter for 会诊小组成员签名
    * @generated
    */
   public String getSignature(){
      return this.signature;
   }
   /**
    * setter for 会诊小组成员签名
    * @generated
    */
   public void setSignature(String signature){
      this.signature = signature;
   }

   /**
    * getter for 医院填写时间
    * @generated
    */
   public String getHospitalTime(){
      return this.hospitalTime;
   }
   /**
    * setter for 医院填写时间
    * @generated
    */
   public void setHospitalTime(String hospitalTime){
      this.hospitalTime = hospitalTime;
   }
public String getConscriptDate() {
	return conscriptDate;
}
public void setConscriptDate(String conscriptDate) {
	this.conscriptDate = conscriptDate;
}
public String getDecruitmentDate() {
	return decruitmentDate;
}
public void setDecruitmentDate(String decruitmentDate) {
	this.decruitmentDate = decruitmentDate;
}
public String getForcesNo() {
	return forcesNo;
}
public void setForcesNo(String forcesNo) {
	this.forcesNo = forcesNo;
}
public String getApplyId() {
	return applyId;
}
public void setApplyId(String applyId) {
	this.applyId = applyId;
}
public String getDisabledArmyNo() {
	return disabledArmyNo;
}
public void setDisabledArmyNo(String disabledArmyNo) {
	this.disabledArmyNo = disabledArmyNo;
}

}