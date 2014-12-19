package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomSessionOnline
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 @Table(tableName = "SOM_SESSION_ONLINE" , keyFields = "sessionId")
public class SomSessionOnline extends StatefulDatabean {
   //SESSION_ID
   	
	@Column(name = "SESSION_ID")
   private String sessionId;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SORG_ID
   	
	@Column(name = "SORG_ID")
   private String sorgId;
   //SEQ
	@Column(name = "SEQ")
   private String seq;
   //SESSION_NAME
	@Column(name = "SESSION_NAME")
   private String sessionName;
   //START_DATE
	@Column(name = "START_DATE")
   private String startDate;
   //END_DATE
	@Column(name = "END_DATE")
   private String endDate;
   //REAL_END_DATE
	@Column(name = "REAL_END_DATE")
   private String realEndDate;
   //TENURE
	@Column(name = "TENURE")
   private String tenure;
   //DEAL_FLAG
	@Column(name = "DEAL_FLAG")
   private String dealFlag;
   //MORG_NAME
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
	@Column(name = "MORG_AREA")
   private String morgArea;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //DELAY_DATE
	@Column(name = "DELAY_DATE")
   private String delayDate;
   //DELAY_REASON
	@Column(name = "DELAY_REASON")
   private String delayReason;
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
    * getter for SEQ
    * @generated
    */
   public String getSeq(){
      return this.seq;
   }
   /**
    * setter for SEQ
    * @generated
    */
   public void setSeq(String seq){
      this.seq = seq;
   }

   /**
    * getter for SESSION_NAME
    * @generated
    */
   public String getSessionName(){
      return this.sessionName;
   }
   /**
    * setter for SESSION_NAME
    * @generated
    */
   public void setSessionName(String sessionName){
      this.sessionName = sessionName;
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
    * getter for REAL_END_DATE
    * @generated
    */
   public String getRealEndDate(){
      return this.realEndDate;
   }
   /**
    * setter for REAL_END_DATE
    * @generated
    */
   public void setRealEndDate(String realEndDate){
      this.realEndDate = realEndDate;
   }

   /**
    * getter for TENURE
    * @generated
    */
   public String getTenure(){
      return this.tenure;
   }
   /**
    * setter for TENURE
    * @generated
    */
   public void setTenure(String tenure){
      this.tenure = tenure;
   }

   /**
    * getter for DEAL_FLAG
    * @generated
    */
   public String getDealFlag(){
      return this.dealFlag;
   }
   /**
    * setter for DEAL_FLAG
    * @generated
    */
   public void setDealFlag(String dealFlag){
      this.dealFlag = dealFlag;
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
    * getter for DELAY_DATE
    * @generated
    */
   public String getDelayDate(){
      return this.delayDate;
   }
   /**
    * setter for DELAY_DATE
    * @generated
    */
   public void setDelayDate(String delayDate){
      this.delayDate = delayDate;
   }

   /**
    * getter for DELAY_REASON
    * @generated
    */
   public String getDelayReason(){
      return this.delayReason;
   }
   /**
    * setter for DELAY_REASON
    * @generated
    */
   public void setDelayReason(String delayReason){
      this.delayReason = delayReason;
   }

}