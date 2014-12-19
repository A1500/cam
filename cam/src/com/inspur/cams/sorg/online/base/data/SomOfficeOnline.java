package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomOfficeOnline
 * @description:
 * @author:
 * @since:2012-11-26
 * @version:1.0
*/
 @Table(tableName = "SOM_OFFICE_ONLINE" , keyFields = "id")
public class SomOfficeOnline extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //SORG_ID
   	
	@Column(name = "SORG_ID")
   private String sorgId;
   //NAME
	@Column(name = "NAME")
   private String name;
   //PLACE
	@Column(name = "PLACE")
   private String place;
   //POST_CODE
	@Column(name = "POST_CODE")
   private String postCode;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
   //OFFICE_CHIEF
	@Column(name = "OFFICE_CHIEF")
   private String officeChief;
   //DUTIES_DESC
	@Column(name = "DUTIES_DESC")
   private String dutiesDesc;
   //REASON
	@Column(name = "REASON")
   private String reason;
   //PROCESS
	@Column(name = "PROCESS")
   private String process;
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
   //SORG_TYPE
   	
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
   //REG_STATUS
	@Column(name = "REG_STATUS")
   private String regStatus;
   //REG_PEOPLE
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
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
    * getter for NAME
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for NAME
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for PLACE
    * @generated
    */
   public String getPlace(){
      return this.place;
   }
   /**
    * setter for PLACE
    * @generated
    */
   public void setPlace(String place){
      this.place = place;
   }

   /**
    * getter for POST_CODE
    * @generated
    */
   public String getPostCode(){
      return this.postCode;
   }
   /**
    * setter for POST_CODE
    * @generated
    */
   public void setPostCode(String postCode){
      this.postCode = postCode;
   }

   /**
    * getter for PHONE
    * @generated
    */
   public String getPhone(){
      return this.phone;
   }
   /**
    * setter for PHONE
    * @generated
    */
   public void setPhone(String phone){
      this.phone = phone;
   }

   /**
    * getter for OFFICE_CHIEF
    * @generated
    */
   public String getOfficeChief(){
      return this.officeChief;
   }
   /**
    * setter for OFFICE_CHIEF
    * @generated
    */
   public void setOfficeChief(String officeChief){
      this.officeChief = officeChief;
   }

   /**
    * getter for DUTIES_DESC
    * @generated
    */
   public String getDutiesDesc(){
      return this.dutiesDesc;
   }
   /**
    * setter for DUTIES_DESC
    * @generated
    */
   public void setDutiesDesc(String dutiesDesc){
      this.dutiesDesc = dutiesDesc;
   }

   /**
    * getter for REASON
    * @generated
    */
   public String getReason(){
      return this.reason;
   }
   /**
    * setter for REASON
    * @generated
    */
   public void setReason(String reason){
      this.reason = reason;
   }

   /**
    * getter for PROCESS
    * @generated
    */
   public String getProcess(){
      return this.process;
   }
   /**
    * setter for PROCESS
    * @generated
    */
   public void setProcess(String process){
      this.process = process;
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
    * getter for REG_DATE
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for REG_DATE
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
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
    * getter for REG_PEOPLE
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for REG_PEOPLE
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
   }

}