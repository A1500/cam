package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
/**
 * @title:BptPeopleDemobilizedIllness
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 @Table(tableName = "BPT_PEOPLE_DEMOBILIZED_ILLNESS" , keyFields = "peopleId")
public class BptPeopleDemobilizedIllness extends StatefulDatabean {
   //人员ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //入伍时间
   	@Rule(value="require")
	@Column(name = "CONSCRIPT_DATE")
   private String conscriptDate;
   //退伍时间
   	@Rule(value="require")
	@Column(name = "DECRUITMENT_DATE")
   private String decruitmentDate;
   //原部队番号
   //	@Rule(value="require")
	@Column(name = "FORCES_NO")
   private String forcesNo;
   //职务
	@Column(name = "POSITION")
   private String position;
   //退伍证号
	//@Rule(value="require")
	@Column(name = "ASDP_NO")
   private String asdpNo;
   //患病信息
	@Rule(value="require")
	@Column(name = "ILLESS_INFO")
   private String illessInfo;
	//健康状况
	@Column(name = "HEALTH_STATE_CODE")
   private String healthStateCode;
   //身体状况
	@Rule(value="require")
	@Column(name = "PHYSICLAL_STATUS")
   private String physiclalStatus;
   //家庭经济状况
//	@Rule(value="require")
	@Column(name = "FAMILY_ECONOMICS")
   private String familyEconomics;
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
   //备注
	@Column(name = "NOTE")
   private String note;
	
	//提交标志
	@Column(name = "COMMIT_FLAG")
   private String commitFlag;
	//是否参战
	@Rule(value="require")
	@Column(name = "IS_WAR")
   private String isWar;
	//是否涉核
	@Rule(value="require")
	@Column(name = "IS_INNUCLEAR")
   private String isInnuclear;
	
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
    * getter for 入伍时间
    * @generated
    */
   public String getConscriptDate(){
      return this.conscriptDate;
   }
   /**
    * setter for 入伍时间
    * @generated
    */
   public void setConscriptDate(String conscriptDate){
      this.conscriptDate = conscriptDate;
   }

   /**
    * getter for 退伍时间
    * @generated
    */
   public String getDecruitmentDate(){
      return this.decruitmentDate;
   }
   /**
    * setter for 退伍时间
    * @generated
    */
   public void setDecruitmentDate(String decruitmentDate){
      this.decruitmentDate = decruitmentDate;
   }

   /**
    * getter for 原部队番号
    * @generated
    */
   public String getForcesNo(){
      return this.forcesNo;
   }
   /**
    * setter for 原部队番号
    * @generated
    */
   public void setForcesNo(String forcesNo){
      this.forcesNo = forcesNo;
   }

   /**
    * getter for 职务
    * @generated
    */
   public String getPosition(){
      return this.position;
   }
   /**
    * setter for 职务
    * @generated
    */
   public void setPosition(String position){
      this.position = position;
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
    * getter for 患病信息
    * @generated
    */
   public String getIllessInfo(){
      return this.illessInfo;
   }
   /**
    * setter for 患病信息
    * @generated
    */
   public void setIllessInfo(String illessInfo){
      this.illessInfo = illessInfo;
   }

   /**
    * getter for 身体状况
    * @generated
    */
   public String getPhysiclalStatus(){
      return this.physiclalStatus;
   }
   /**
    * setter for 身体状况
    * @generated
    */
   public void setPhysiclalStatus(String physiclalStatus){
      this.physiclalStatus = physiclalStatus;
   }

   /**
    * getter for 家庭经济状况
    * @generated
    */
   public String getFamilyEconomics(){
      return this.familyEconomics;
   }
   /**
    * setter for 家庭经济状况
    * @generated
    */
   public void setFamilyEconomics(String familyEconomics){
      this.familyEconomics = familyEconomics;
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
	 * @return the commitFlag
	 */
	public String getCommitFlag() {
		return commitFlag;
	}
	
	/**
	 * @param commitFlag the commitFlag to set
	 */
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
	}
	public String getIsWar() {
		return isWar;
	}
	public void setIsWar(String isWar) {
		this.isWar = isWar;
	}
	public String getIsInnuclear() {
		return isInnuclear;
	}
	public void setIsInnuclear(String isInnuclear) {
		this.isInnuclear = isInnuclear;
	}
	public String getHealthStateCode() {
		return healthStateCode;
	}
	public void setHealthStateCode(String healthStateCode) {
		this.healthStateCode = healthStateCode;
	}
}