package com.inspur.cams.sorg.jxcheck.somjxextrarebuildconcrete.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomJxExtraRebuildConcrete
 * @description:
 * @author:
 * @since:2012-01-16
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_EXTRA_REBUILD_CONCRETE" , keyFields = "id")
public class SomJxExtraRebuildConcrete extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //TYPE
	@Column(name = "TYPE")
   private String type;
   //ACTIVITY_NAME
	@Column(name = "ACTIVITY_NAME")
   private String activityName;
   //JOIN_TYPE
	@Column(name = "JOIN_TYPE")
   private String joinType;
   //OPEN_DATE_START
	@Column(name = "OPEN_DATE_START")
   private String openDateStart;
   //OPEN_DATE_END
	@Column(name = "OPEN_DATE_END")
   private String openDateEnd;
   //ACTIVITY_DES
	@Column(name = "ACTIVITY_DES")
   private String activityDes;
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
    * getter for TYPE
    * @generated
    */
   public String getType(){
      return this.type;
   }
   /**
    * setter for TYPE
    * @generated
    */
   public void setType(String type){
      this.type = type;
   }

   /**
    * getter for ACTIVITY_NAME
    * @generated
    */
   public String getActivityName(){
      return this.activityName;
   }
   /**
    * setter for ACTIVITY_NAME
    * @generated
    */
   public void setActivityName(String activityName){
      this.activityName = activityName;
   }

   /**
    * getter for JOIN_TYPE
    * @generated
    */
   public String getJoinType(){
      return this.joinType;
   }
   /**
    * setter for JOIN_TYPE
    * @generated
    */
   public void setJoinType(String joinType){
      this.joinType = joinType;
   }

   /**
    * getter for OPEN_DATE_START
    * @generated
    */
   public String getOpenDateStart(){
      return this.openDateStart;
   }
   /**
    * setter for OPEN_DATE_START
    * @generated
    */
   public void setOpenDateStart(String openDateStart){
      this.openDateStart = openDateStart;
   }

   /**
    * getter for OPEN_DATE_END
    * @generated
    */
   public String getOpenDateEnd(){
      return this.openDateEnd;
   }
   /**
    * setter for OPEN_DATE_END
    * @generated
    */
   public void setOpenDateEnd(String openDateEnd){
      this.openDateEnd = openDateEnd;
   }

   /**
    * getter for ACTIVITY_DES
    * @generated
    */
   public String getActivityDes(){
      return this.activityDes;
   }
   /**
    * setter for ACTIVITY_DES
    * @generated
    */
   public void setActivityDes(String activityDes){
      this.activityDes = activityDes;
   }

}