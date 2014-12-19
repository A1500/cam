package com.inspur.cams.bpt.base.data; 

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptPeopleDisability
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 @Table(tableName = "BPT_PEOPLE_DISABILITY" , keyFields = "peopleId")
public class BptPeopleDisability extends StatefulDatabean {	
   //人员ID
   	@Rule(value="require")   
	@Column(name = "PEOPLE_ID")
   private String peopleId;   
   	
   //入伍时间   
   	//@Rule(value="require")
	@Column(name = "CONSCRIPT_DATE")
   private String conscriptDate;   
   	
   //退伍时间   
   	//@Rule(value="require")
	@Column(name = "VETERANS_DATE")
   private String veteransDate;   
	
	//参加工作时间   
	@Column(name = "TO_WORK_DATE")
   private String toWorkDate;   
	
	  //离退休时间   
	@Column(name = "RETIRED_DATE")
   private String retiredDate;   
	
   //伤残时期代码
   	@Rule(value="require")   
	@Column(name = "DISABILITY_WAR_CODE")
   private String disabilityWarCode; 
  //是否抗美援朝
	@Column(name = "IS_KOREA_WAR")
   private String isKoreaWar; 
   //伤残等级
   //	@Rule(value="require")   
	@Column(name = "DISABILITY_LEVEL_CODE")
   private String disabilityLevelCode;   
  //伤残性质代码
  // 	@Rule(value="require") 
	@Column(name = "DISABILITY_CASE_CODE")
   private String disabilityCaseCode; 
   //伤残属别
   	@Rule(value="require")   
	@Column(name = "DISABILITY_GENUS_CODE")
   private String disabilityGenusCode;   
   //致残时间
   	@Rule(value="require")   
	@Column(name = "DISABILITY_DATE")
   private String disabilityDate;   
   //致残地点
   	@Rule(value="require")   
	@Column(name = "DISABILITY_ADD")
   private String disabilityAdd;   
	//致残时所在单位
	@Column(name = "UINIT_OF_DISABILITY")
	private String uinitOfDisability;
   //致残部位
	@Rule(value="require") 
	@Column(name = "DISABILITY_BODY")
   private String disabilityBody;   
   //致残原因
	@Rule(value="require")   
	@Column(name = "DISABILITY_REASON")
   private String disabilityReason;   
   //备注   
	@Column(name = "NOTE")
   private String note;   
   //批准日期   
	@Column(name = "APPROVE_DATE")
   private String approveDate;   
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
	//部队审批残疾等级
   //	@Rule(value="require")   
	@Column(name = "VERTERANS_LEVEL_CODE")
   private String verteransLevelCode;   
  //部队审批残疾性质
  // 	@Rule(value="require") 
	@Column(name = "VERTERANS_CASE_CODE")
   private String verteransCaseCode; 
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
    * getter for 入伍（参加工作）时间
    * @generated
    */
   public String getConscriptDate(){
      return this.conscriptDate;
   }   
   /** 
    * setter for 入伍（参加工作）时间
    * @generated
    */
   public void setConscriptDate(String conscriptDate){
      this.conscriptDate = conscriptDate;	
   }  
   
   /** 
    * getter for 退伍（离退休）时间
    * @generated
    */
   public String getVeteransDate(){
      return this.veteransDate;
   }   
   /** 
    * setter for 退伍（离退休）时间
    * @generated
    */
   public void setVeteransDate(String veteransDate){
      this.veteransDate = veteransDate;	
   }  
   
   /** 
    * getter for 伤残时期代码
    * @generated
    */
   public String getDisabilityWarCode(){
      return this.disabilityWarCode;
   }   
   /** 
    * setter for 伤残时期代码
    * @generated
    */
   public void setDisabilityWarCode(String disabilityWarCode){
      this.disabilityWarCode = disabilityWarCode;	
   }  
   
   /** 
    * getter for 伤残等级
    * @generated
    */
   public String getDisabilityLevelCode(){
      return this.disabilityLevelCode;
   }   
   /** 
    * setter for 伤残等级
    * @generated
    */
   public void setDisabilityLevelCode(String disabilityLevelCode){
      this.disabilityLevelCode = disabilityLevelCode;	
   }  
   
   /** 
    * getter for 伤残属别
    * @generated
    */
   public String getDisabilityGenusCode(){
      return this.disabilityGenusCode;
   }   
   /** 
    * setter for 伤残属别
    * @generated
    */
   public void setDisabilityGenusCode(String disabilityGenusCode){
      this.disabilityGenusCode = disabilityGenusCode;	
   }  
   
   /** 
    * getter for 致残时间
    * @generated
    */
   public String getDisabilityDate(){
      return this.disabilityDate;
   }   
   /** 
    * setter for 致残时间
    * @generated
    */
   public void setDisabilityDate(String disabilityDate){
      this.disabilityDate = disabilityDate;	
   }  
   
   /** 
    * getter for 致残地点
    * @generated
    */
   public String getDisabilityAdd(){
      return this.disabilityAdd;
   }   
   /** 
    * setter for 致残地点
    * @generated
    */
   public void setDisabilityAdd(String disabilityAdd){
      this.disabilityAdd = disabilityAdd;	
   }  
   
   /** 
    * getter for 致残部位
    * @generated
    */
   public String getDisabilityBody(){
      return this.disabilityBody;
   }   
   /** 
    * setter for 致残部位
    * @generated
    */
   public void setDisabilityBody(String disabilityBody){
      this.disabilityBody = disabilityBody;	
   }  
   
   /** 
    * getter for 致残原因
    * @generated
    */
   public String getDisabilityReason(){
      return this.disabilityReason;
   }   
   /** 
    * setter for 致残原因
    * @generated
    */
   public void setDisabilityReason(String disabilityReason){
      this.disabilityReason = disabilityReason;	
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
   public String getApproveDate(){
      return this.approveDate;
   }   
   /** 
    * setter for 批准日期
    * @generated
    */
   public void setApproveDate(String approveDate){
      this.approveDate = approveDate;	
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
    * getter for 致残时所在单位
    */
	public String getUinitOfDisability() {
		return uinitOfDisability;
	}
	
	   /**
	    * setter for 致残时所在单位
	    */
	public void setUinitOfDisability(String uinitOfDisability) {
		this.uinitOfDisability = uinitOfDisability;
	}
	/**
	 * @return the disabilityCaseCode
	 */
	public String getDisabilityCaseCode() {
		return disabilityCaseCode;
	}
	/**
	 * @param disabilityCaseCode the disabilityCaseCode to set
	 */
	public void setDisabilityCaseCode(String disabilityCaseCode) {
		this.disabilityCaseCode = disabilityCaseCode;
	}
	/**
	 * @return the toWorkDate
	 */
	public String getToWorkDate() {
		return toWorkDate;
	}
	/**
	 * @param toWorkDate the toWorkDate to set
	 */
	public void setToWorkDate(String toWorkDate) {
		this.toWorkDate = toWorkDate;
	}
	/**
	 * @return the retiredDate
	 */
	public String getRetiredDate() {
		return retiredDate;
	}
	/**
	 * @param retiredDate the retiredDate to set
	 */
	public void setRetiredDate(String retiredDate) {
		this.retiredDate = retiredDate;
	}
	public String getIsKoreaWar() {
		return isKoreaWar;
	}
	public void setIsKoreaWar(String isKoreaWar) {
		this.isKoreaWar = isKoreaWar;
	}
	public String getVerteransLevelCode() {
		return verteransLevelCode;
	}
	public void setVerteransLevelCode(String verteransLevelCode) {
		this.verteransLevelCode = verteransLevelCode;
	}
	public String getVerteransCaseCode() {
		return verteransCaseCode;
	}
	public void setVerteransCaseCode(String verteransCaseCode) {
		this.verteransCaseCode = verteransCaseCode;
	}  
      
}