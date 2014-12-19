package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomDutyOnline
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 @Table(tableName = "SOM_DUTY_ONLINE" , keyFields = "dutyId")
public class SomDutyOnline extends StatefulDatabean {
   //DUTY_ID
   	
	@Column(name = "DUTY_ID")
   private String dutyId;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SORG_ID
   	
	@Column(name = "SORG_ID")
   private String sorgId;
   //PEOPLE_ID
   	
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //SESSION_ID
	@Column(name = "SESSION_ID")
   private String sessionId;
   //SORG_DUTIES
	@Column(name = "SORG_DUTIES")
   private String sorgDuties;
   //START_DATE
	@Column(name = "START_DATE")
   private String startDate;
   //END_DATE
	@Column(name = "END_DATE")
   private String endDate;
   //PROGRESS
	@Column(name = "PROGRESS")
   private String progress;
   //IF_RENEW
	@Column(name = "IF_RENEW")
   private String ifRenew;
   //RENEW_NUM
	@Column(name = "RENEW_NUM")
   private String renewNum;
   //IF_SERVE
	@Column(name = "IF_SERVE")
   private String ifServe;
   //SORG_OPINION
	@Column(name = "SORG_OPINION")
   private String sorgOpinion;
   //SORG_CHECK_DATE
	@Column(name = "SORG_CHECK_DATE")
   private String sorgCheckDate;
   //BORG_NAME
	@Column(name = "BORG_NAME")
   private String borgName;
   //BORG_CHECK_DATE
	@Column(name = "BORG_CHECK_DATE")
   private String borgCheckDate;
   //BORG_OPINION
	@Column(name = "BORG_OPINION")
   private String borgOpinion;
   //MORG_NAME
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
	@Column(name = "MORG_AREA")
   private String morgArea;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //WORK_OPINION
	@Column(name = "WORK_OPINION")
   private String workOpinion;
   //WORK_CHECK_DATE
	@Column(name = "WORK_CHECK_DATE")
   private String workCheckDate;
   //REG_STATUS
	@Column(name = "REG_STATUS")
   private String regStatus;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //PROMISE_ORGAN
	@Column(name = "PROMISE_ORGAN")
   private String promiseOrgan;
   //PROMISE_CODE
	@Column(name = "PROMISE_CODE")
   private String promiseCode;
   //PROMISE_DATE
	@Column(name = "PROMISE_DATE")
   private String promiseDate;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   //OTHER_DUTIES
	@Column(name = "OTHER_DUTIES")
   private String otherDuties;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   /**
    * getter for DUTY_ID
    * @generated
    */
   public String getDutyId(){
      return this.dutyId;
   }
   /**
    * setter for DUTY_ID
    * @generated
    */
   public void setDutyId(String dutyId){
      this.dutyId = dutyId;
   }

   /**
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for SESSION_ID
    * @generated
    */
   public String getSessionId(){
      return this.sessionId;
   }
   /**
    * setter for SESSION_ID
    * @generated
    */
   public void setSessionId(String sessionId){
      this.sessionId = sessionId;
   }

   /**
    * getter for SORG_DUTIES
    * @generated
    */
   public String getSorgDuties(){
      return this.sorgDuties;
   }
   /**
    * setter for SORG_DUTIES
    * @generated
    */
   public void setSorgDuties(String sorgDuties){
      this.sorgDuties = sorgDuties;
   }

   /**
    * getter for START_DATE
    * @generated
    */
   public String getStartDate(){
      return this.startDate;
   }
   /**
    * setter for START_DATE
    * @generated
    */
   public void setStartDate(String startDate){
      this.startDate = startDate;
   }

   /**
    * getter for END_DATE
    * @generated
    */
   public String getEndDate(){
      return this.endDate;
   }
   /**
    * setter for END_DATE
    * @generated
    */
   public void setEndDate(String endDate){
      this.endDate = endDate;
   }

   /**
    * getter for PROGRESS
    * @generated
    */
   public String getProgress(){
      return this.progress;
   }
   /**
    * setter for PROGRESS
    * @generated
    */
   public void setProgress(String progress){
      this.progress = progress;
   }

   /**
    * getter for IF_RENEW
    * @generated
    */
   public String getIfRenew(){
      return this.ifRenew;
   }
   /**
    * setter for IF_RENEW
    * @generated
    */
   public void setIfRenew(String ifRenew){
      this.ifRenew = ifRenew;
   }

   /**
    * getter for RENEW_NUM
    * @generated
    */
   public String getRenewNum(){
      return this.renewNum;
   }
   /**
    * setter for RENEW_NUM
    * @generated
    */
   public void setRenewNum(String renewNum){
      this.renewNum = renewNum;
   }

   /**
    * getter for IF_SERVE
    * @generated
    */
   public String getIfServe(){
      return this.ifServe;
   }
   /**
    * setter for IF_SERVE
    * @generated
    */
   public void setIfServe(String ifServe){
      this.ifServe = ifServe;
   }

   /**
    * getter for SORG_OPINION
    * @generated
    */
   public String getSorgOpinion(){
      return this.sorgOpinion;
   }
   /**
    * setter for SORG_OPINION
    * @generated
    */
   public void setSorgOpinion(String sorgOpinion){
      this.sorgOpinion = sorgOpinion;
   }

   /**
    * getter for SORG_CHECK_DATE
    * @generated
    */
   public String getSorgCheckDate(){
      return this.sorgCheckDate;
   }
   /**
    * setter for SORG_CHECK_DATE
    * @generated
    */
   public void setSorgCheckDate(String sorgCheckDate){
      this.sorgCheckDate = sorgCheckDate;
   }

   /**
    * getter for BORG_NAME
    * @generated
    */
   public String getBorgName(){
      return this.borgName;
   }
   /**
    * setter for BORG_NAME
    * @generated
    */
   public void setBorgName(String borgName){
      this.borgName = borgName;
   }

   /**
    * getter for BORG_CHECK_DATE
    * @generated
    */
   public String getBorgCheckDate(){
      return this.borgCheckDate;
   }
   /**
    * setter for BORG_CHECK_DATE
    * @generated
    */
   public void setBorgCheckDate(String borgCheckDate){
      this.borgCheckDate = borgCheckDate;
   }

   /**
    * getter for BORG_OPINION
    * @generated
    */
   public String getBorgOpinion(){
      return this.borgOpinion;
   }
   /**
    * setter for BORG_OPINION
    * @generated
    */
   public void setBorgOpinion(String borgOpinion){
      this.borgOpinion = borgOpinion;
   }

   /**
    * getter for MORG_NAME
    * @generated
    */
   public String getMorgName(){
      return this.morgName;
   }
   /**
    * setter for MORG_NAME
    * @generated
    */
   public void setMorgName(String morgName){
      this.morgName = morgName;
   }

   /**
    * getter for MORG_AREA
    * @generated
    */
   public String getMorgArea(){
      return this.morgArea;
   }
   /**
    * setter for MORG_AREA
    * @generated
    */
   public void setMorgArea(String morgArea){
      this.morgArea = morgArea;
   }

   /**
    * getter for WORK_NAME
    * @generated
    */
   public String getWorkName(){
      return this.workName;
   }
   /**
    * setter for WORK_NAME
    * @generated
    */
   public void setWorkName(String workName){
      this.workName = workName;
   }

   /**
    * getter for WORK_OPINION
    * @generated
    */
   public String getWorkOpinion(){
      return this.workOpinion;
   }
   /**
    * setter for WORK_OPINION
    * @generated
    */
   public void setWorkOpinion(String workOpinion){
      this.workOpinion = workOpinion;
   }

   /**
    * getter for WORK_CHECK_DATE
    * @generated
    */
   public String getWorkCheckDate(){
      return this.workCheckDate;
   }
   /**
    * setter for WORK_CHECK_DATE
    * @generated
    */
   public void setWorkCheckDate(String workCheckDate){
      this.workCheckDate = workCheckDate;
   }

   /**
    * getter for REG_STATUS
    * @generated
    */
   public String getRegStatus(){
      return this.regStatus;
   }
   /**
    * setter for REG_STATUS
    * @generated
    */
   public void setRegStatus(String regStatus){
      this.regStatus = regStatus;
   }

   /**
    * getter for CREATE_PEOPLE
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for CREATE_PEOPLE
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

   /**
    * getter for PROMISE_ORGAN
    * @generated
    */
   public String getPromiseOrgan(){
      return this.promiseOrgan;
   }
   /**
    * setter for PROMISE_ORGAN
    * @generated
    */
   public void setPromiseOrgan(String promiseOrgan){
      this.promiseOrgan = promiseOrgan;
   }

   /**
    * getter for PROMISE_CODE
    * @generated
    */
   public String getPromiseCode(){
      return this.promiseCode;
   }
   /**
    * setter for PROMISE_CODE
    * @generated
    */
   public void setPromiseCode(String promiseCode){
      this.promiseCode = promiseCode;
   }

   /**
    * getter for PROMISE_DATE
    * @generated
    */
   public String getPromiseDate(){
      return this.promiseDate;
   }
   /**
    * setter for PROMISE_DATE
    * @generated
    */
   public void setPromiseDate(String promiseDate){
      this.promiseDate = promiseDate;
   }

   /**
    * getter for NOTE
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for NOTE
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for OTHER_DUTIES
    * @generated
    */
   public String getOtherDuties(){
      return this.otherDuties;
   }
   /**
    * setter for OTHER_DUTIES
    * @generated
    */
   public void setOtherDuties(String otherDuties){
      this.otherDuties = otherDuties;
   }

   /**
    * getter for SORG_TYPE
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for SORG_TYPE
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

}