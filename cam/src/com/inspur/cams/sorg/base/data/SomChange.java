package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织变更信息表
 * @author yanliangliang
 * @date 2011-7-13
 */
 @Table(tableName = "SOM_CHANGE" , keyFields = "id")
public class SomChange extends StatefulDatabean {
   //变更信息ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //社会组织ID
   	@Rule(value="require")
	@Column(name = "SORG_ID")
   private String sorgId;
   //业务编号
   	@Rule(value="require")
	@Column(name = "TASK_CODE")
   private String taskCode;
   //变更项目
	@Column(name = "CHANGE_ITEM")
   private String changeItem;
   //项目变更前
	@Column(name = "CHANGE_BEFORE")
   private String changeBefore;
   //项目变更后
	@Column(name = "CHANGE_AFTER")
   private String changeAfter;
   //变更描述
	@Column(name = "CHANGE_DESC")
   private String changeDesc;
   //变更理由
	@Column(name = "CHANGE_REASON")
   private String changeReason;
   //内部履行程序
	@Column(name = "PROCESS")
   private String process;
   //变更状态
	@Column(name = "CHANGE_STATUS")
   private String changeStatus;
   //登记管理机关名称
   	@Rule(value="require")
	@Column(name = "MORG_NAME")
   private String morgName;
   //登记管理机关行政区划
   	@Rule(value="require")
	@Column(name = "MORG_AREA")
   private String morgArea;
   	
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
   public String getLegalDutyId() {
		return legalDutyId;
   }
   public void setLegalDutyId(String legalDutyId) {
		this.legalDutyId = legalDutyId;
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

}