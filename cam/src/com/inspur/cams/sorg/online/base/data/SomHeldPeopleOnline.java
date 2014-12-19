package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomHeldPeopleOnline
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 @Table(tableName = "SOM_HELD_PEOPLE_ONLINE" , keyFields = "id")
public class SomHeldPeopleOnline extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
   	
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SORG_ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //IF_CHIEF
	@Column(name = "IF_CHIEF")
   private String ifChief;
   //NAME
	@Column(name = "NAME")
   private String name;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //POLITICS
	@Column(name = "POLITICS")
   private String politics;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //WORK_DUTIES
	@Column(name = "WORK_DUTIES")
   private String workDuties;
   //POPULACE
	@Column(name = "POPULACE")
   private String populace;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
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
   //PERSON_UNIT
	@Column(name = "PERSON_UNIT")
   private String personUnit;
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
    * getter for IF_CHIEF
    * @generated
    */
   public String getIfChief(){
      return this.ifChief;
   }
   /**
    * setter for IF_CHIEF
    * @generated
    */
   public void setIfChief(String ifChief){
      this.ifChief = ifChief;
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
    * getter for SEX
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for SEX
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for BIRTHDAY
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }
   /**
    * setter for BIRTHDAY
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;
   }

   /**
    * getter for ID_CARD
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for ID_CARD
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for POLITICS
    * @generated
    */
   public String getPolitics(){
      return this.politics;
   }
   /**
    * setter for POLITICS
    * @generated
    */
   public void setPolitics(String politics){
      this.politics = politics;
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
    * getter for WORK_DUTIES
    * @generated
    */
   public String getWorkDuties(){
      return this.workDuties;
   }
   /**
    * setter for WORK_DUTIES
    * @generated
    */
   public void setWorkDuties(String workDuties){
      this.workDuties = workDuties;
   }

   /**
    * getter for POPULACE
    * @generated
    */
   public String getPopulace(){
      return this.populace;
   }
   /**
    * setter for POPULACE
    * @generated
    */
   public void setPopulace(String populace){
      this.populace = populace;
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
    * getter for PERSON_UNIT
    * @generated
    */
   public String getPersonUnit(){
      return this.personUnit;
   }
   /**
    * setter for PERSON_UNIT
    * @generated
    */
   public void setPersonUnit(String personUnit){
      this.personUnit = personUnit;
   }

}