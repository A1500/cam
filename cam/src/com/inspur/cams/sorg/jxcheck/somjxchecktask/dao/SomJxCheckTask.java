package com.inspur.cams.sorg.jxcheck.somjxchecktask.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西社会组织年检任务表
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_TASK" , keyFields = "taskId")
public class SomJxCheckTask extends StatefulDatabean {
   //TASK_ID
   	@Rule(value="require")
	@Column(name = "TASK_ID")
   private String taskId;
   //TASK_NAME
	@Column(name = "TASK_NAME")
   private String taskName;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //BATCH_YEAR
	@Column(name = "BATCH_YEAR")
   private String batchYear;
   //VALID_DATE
	@Column(name = "VALID_DATE")
   private String validDate;
   //IF_VALID
	@Column(name = "IF_VALID")
   private String ifValid;
   //ADD_DATE
	@Column(name = "ADD_DATE")
   private String addDate;
   //ADD_PERSONN
	@Column(name = "ADD_PERSONN")
   private String addPersonn;
   //ADD_PERSONN_ID
	@Column(name = "ADD_PERSONN_ID")
   private String addPersonnId;
   //ADD_ORGAN
	@Column(name = "ADD_ORGAN")
   private String addOrgan;
   //ADD_ORGAN_ID
	@Column(name = "ADD_ORGAN_ID")
   private String addOrganId;
   //AREA_CODE
	@Column(name = "AREA_CODE")
   private String areaCode;
   /**
    * getter for TASK_ID
    * @generated
    */
   public String getTaskId(){
      return this.taskId;
   }
   /**
    * setter for TASK_ID
    * @generated
    */
   public void setTaskId(String taskId){
      this.taskId = taskId;
   }

   /**
    * getter for TASK_NAME
    * @generated
    */
   public String getTaskName(){
      return this.taskName;
   }
   /**
    * setter for TASK_NAME
    * @generated
    */
   public void setTaskName(String taskName){
      this.taskName = taskName;
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
    * getter for BATCH_YEAR
    * @generated
    */
   public String getBatchYear(){
      return this.batchYear;
   }
   /**
    * setter for BATCH_YEAR
    * @generated
    */
   public void setBatchYear(String batchYear){
      this.batchYear = batchYear;
   }

   /**
    * getter for VALID_DATE
    * @generated
    */
   public String getValidDate(){
      return this.validDate;
   }
   /**
    * setter for VALID_DATE
    * @generated
    */
   public void setValidDate(String validDate){
      this.validDate = validDate;
   }

   /**
    * getter for IF_VALID
    * @generated
    */
   public String getIfValid(){
      return this.ifValid;
   }
   /**
    * setter for IF_VALID
    * @generated
    */
   public void setIfValid(String ifValid){
      this.ifValid = ifValid;
   }

   /**
    * getter for ADD_DATE
    * @generated
    */
   public String getAddDate(){
      return this.addDate;
   }
   /**
    * setter for ADD_DATE
    * @generated
    */
   public void setAddDate(String addDate){
      this.addDate = addDate;
   }

   /**
    * getter for ADD_PERSONN
    * @generated
    */
   public String getAddPersonn(){
      return this.addPersonn;
   }
   /**
    * setter for ADD_PERSONN
    * @generated
    */
   public void setAddPersonn(String addPersonn){
      this.addPersonn = addPersonn;
   }

   /**
    * getter for ADD_PERSONN_ID
    * @generated
    */
   public String getAddPersonnId(){
      return this.addPersonnId;
   }
   /**
    * setter for ADD_PERSONN_ID
    * @generated
    */
   public void setAddPersonnId(String addPersonnId){
      this.addPersonnId = addPersonnId;
   }

   /**
    * getter for ADD_ORGAN
    * @generated
    */
   public String getAddOrgan(){
      return this.addOrgan;
   }
   /**
    * setter for ADD_ORGAN
    * @generated
    */
   public void setAddOrgan(String addOrgan){
      this.addOrgan = addOrgan;
   }

   /**
    * getter for ADD_ORGAN_ID
    * @generated
    */
   public String getAddOrganId(){
      return this.addOrganId;
   }
   /**
    * setter for ADD_ORGAN_ID
    * @generated
    */
   public void setAddOrganId(String addOrganId){
      this.addOrganId = addOrganId;
   }

   /**
    * getter for AREA_CODE
    * @generated
    */
   public String getAreaCode(){
      return this.areaCode;
   }
   /**
    * setter for AREA_CODE
    * @generated
    */
   public void setAreaCode(String areaCode){
      this.areaCode = areaCode;
   }

}