package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomChangeOnline
 * @description:
 * @author:
 * @since:2012-11-12
 * @version:1.0
*/
 @Table(tableName = "SOM_CHANGE_ONLINE" , keyFields = "id")
public class SomChangeOnline extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //SORG_ID
   	
	@Column(name = "SORG_ID")
   private String sorgId;
   //TASK_CODE
   	
	@Column(name = "TASK_CODE")
   private String taskCode;
   //CHANGE_ITEM
	@Column(name = "CHANGE_ITEM")
   private String changeItem;
   //CHANGE_BEFORE
	@Column(name = "CHANGE_BEFORE")
   private String changeBefore;
   //CHANGE_AFTER
	@Column(name = "CHANGE_AFTER")
   private String changeAfter;
   //CHANGE_DESC
	@Column(name = "CHANGE_DESC")
   private String changeDesc;
   //CHANGE_REASON
	@Column(name = "CHANGE_REASON")
   private String changeReason;
   //PROCESS
	@Column(name = "PROCESS")
   private String process;
   //CHANGE_STATUS
	@Column(name = "CHANGE_STATUS")
   private String changeStatus;
   //MORG_NAME
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
	@Column(name = "MORG_AREA")
   private String morgArea;
   //LEGAL_DUTY_ID
	@Column(name = "LEGAL_DUTY_ID")
   private String legalDutyId;
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
    * getter for CHANGE_ITEM
    * @generated
    */
   public String getChangeItem(){
      return this.changeItem;
   }
   /**
    * setter for CHANGE_ITEM
    * @generated
    */
   public void setChangeItem(String changeItem){
      this.changeItem = changeItem;
   }

   /**
    * getter for CHANGE_BEFORE
    * @generated
    */
   public String getChangeBefore(){
      return this.changeBefore;
   }
   /**
    * setter for CHANGE_BEFORE
    * @generated
    */
   public void setChangeBefore(String changeBefore){
      this.changeBefore = changeBefore;
   }

   /**
    * getter for CHANGE_AFTER
    * @generated
    */
   public String getChangeAfter(){
      return this.changeAfter;
   }
   /**
    * setter for CHANGE_AFTER
    * @generated
    */
   public void setChangeAfter(String changeAfter){
      this.changeAfter = changeAfter;
   }

   /**
    * getter for CHANGE_DESC
    * @generated
    */
   public String getChangeDesc(){
      return this.changeDesc;
   }
   /**
    * setter for CHANGE_DESC
    * @generated
    */
   public void setChangeDesc(String changeDesc){
      this.changeDesc = changeDesc;
   }

   /**
    * getter for CHANGE_REASON
    * @generated
    */
   public String getChangeReason(){
      return this.changeReason;
   }
   /**
    * setter for CHANGE_REASON
    * @generated
    */
   public void setChangeReason(String changeReason){
      this.changeReason = changeReason;
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
    * getter for CHANGE_STATUS
    * @generated
    */
   public String getChangeStatus(){
      return this.changeStatus;
   }
   /**
    * setter for CHANGE_STATUS
    * @generated
    */
   public void setChangeStatus(String changeStatus){
      this.changeStatus = changeStatus;
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
    * getter for LEGAL_DUTY_ID
    * @generated
    */
   public String getLegalDutyId(){
      return this.legalDutyId;
   }
   /**
    * setter for LEGAL_DUTY_ID
    * @generated
    */
   public void setLegalDutyId(String legalDutyId){
      this.legalDutyId = legalDutyId;
   }

}