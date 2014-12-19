package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomHeldOrganOnline
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 @Table(tableName = "SOM_HELD_ORGAN_ONLINE" , keyFields = "id")
public class SomHeldOrganOnline extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
   	
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SORG_ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //NAME
   	
	@Column(name = "NAME")
   private String name;
   //SITUATION
	@Column(name = "SITUATION")
   private String situation;
   //HELDORGAN_PEOPLE
	@Column(name = "HELDORGAN_PEOPLE")
   private String heldorganPeople;
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
    * getter for SITUATION
    * @generated
    */
   public String getSituation(){
      return this.situation;
   }
   /**
    * setter for SITUATION
    * @generated
    */
   public void setSituation(String situation){
      this.situation = situation;
   }

   /**
    * getter for HELDORGAN_PEOPLE
    * @generated
    */
   public String getHeldorganPeople(){
      return this.heldorganPeople;
   }
   /**
    * setter for HELDORGAN_PEOPLE
    * @generated
    */
   public void setHeldorganPeople(String heldorganPeople){
      this.heldorganPeople = heldorganPeople;
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

}