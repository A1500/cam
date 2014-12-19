package com.inspur.cams.sorg.assess.assesstask.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomAssessTask
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 @Table(tableName = "SOM_ASSESS_TASK" , keyFields = "taskId")
public class SomAssessTask extends StatefulDatabean {
   //TASK_ID
	@Column(name = "TASK_ID")
   private String taskId;
   //SORG_CODE
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //SORG_NAME
	@Column(name = "SORG_NAME")
   private String sorgName;
   //ORGAN_NAME
	@Column(name = "ORGAN_NAME")
   private String organName;
   //ORGAN_AREA_CODE
	@Column(name = "ORGAN_AREA_CODE")
   private String organAreaCode;
   //START_DATE
	@Column(name = "START_DATE")
   private String startDate;
   //IF_END
	@Column(name = "IF_END")
   private String ifEnd;
   //ASSESS_TYPE
	@Column(name = "ASSESS_TYPE")
   private String assessType;
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
    * getter for SORG_CODE
    * @generated
    */
   public String getSorgCode(){
      return this.sorgCode;
   }
   /**
    * setter for SORG_CODE
    * @generated
    */
   public void setSorgCode(String sorgCode){
      this.sorgCode = sorgCode;
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
    * getter for SORG_NAME
    * @generated
    */
   public String getSorgName(){
      return this.sorgName;
   }
   /**
    * setter for SORG_NAME
    * @generated
    */
   public void setSorgName(String sorgName){
      this.sorgName = sorgName;
   }

   /**
    * getter for ORGAN_NAME
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for ORGAN_NAME
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for ORGAN_AREA_CODE
    * @generated
    */
   public String getOrganAreaCode(){
      return this.organAreaCode;
   }
   /**
    * setter for ORGAN_AREA_CODE
    * @generated
    */
   public void setOrganAreaCode(String organAreaCode){
      this.organAreaCode = organAreaCode;
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
    * getter for IF_END
    * @generated
    */
   public String getIfEnd(){
      return this.ifEnd;
   }
   /**
    * setter for IF_END
    * @generated
    */
   public void setIfEnd(String ifEnd){
      this.ifEnd = ifEnd;
   }

   /**
    * getter for ASSESS_TYPE
    * @generated
    */
   public String getAssessType(){
      return this.assessType;
   }
   /**
    * setter for ASSESS_TYPE
    * @generated
    */
   public void setAssessType(String assessType){
      this.assessType = assessType;
   }

}