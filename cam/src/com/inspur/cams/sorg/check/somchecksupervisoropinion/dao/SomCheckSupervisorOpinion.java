package com.inspur.cams.sorg.check.somchecksupervisoropinion.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckSupervisorOpinion
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_SUPERVISOR_OPINION" , keyFields = "id")
public class SomCheckSupervisorOpinion extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //NAME
	@Column(name = "NAME")
   private String name;
   //OPINION
	@Column(name = "OPINION")
   private String opinion;
   //SIGN_DATE
	@Column(name = "SIGN_DATE")
   private String signDate;
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
    * getter for OPINION
    * @generated
    */
   public String getOpinion(){
      return this.opinion;
   }
   /**
    * setter for OPINION
    * @generated
    */
   public void setOpinion(String opinion){
      this.opinion = opinion;
   }

   /**
    * getter for SIGN_DATE
    * @generated
    */
   public String getSignDate(){
      return this.signDate;
   }
   /**
    * setter for SIGN_DATE
    * @generated
    */
   public void setSignDate(String signDate){
      this.signDate = signDate;
   }

}