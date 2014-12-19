package com.inspur.cams.sorg.check.somcheckmajor.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckMajor
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_MAJOR" , keyFields = "majorId")
public class SomCheckMajor extends StatefulDatabean {
   //MAJOR_ID
	@Column(name = "MAJOR_ID")
   private String majorId;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SEQUENCE
	@Column(name = "SEQUENCE")
   private String sequence;
   //PROJECT_NAME
	@Column(name = "PROJECT_NAME")
   private String projectName;
   //ZAHLUNGSZIEL
	@Column(name = "ZAHLUNGSZIEL")
   private String zahlungsziel;
   //EXPENDITURE_CASH
	@Column(name = "EXPENDITURE_CASH")
   private String expenditureCash;
   //RATIO
	@Column(name = "RATIO")
   private String ratio;
   //PURPOSE
	@Column(name = "PURPOSE")
   private String purpose;
   /**
    * getter for MAJOR_ID
    * @generated
    */
   public String getMajorId(){
      return this.majorId;
   }
   /**
    * setter for MAJOR_ID
    * @generated
    */
   public void setMajorId(String majorId){
      this.majorId = majorId;
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
    * getter for SEQUENCE
    * @generated
    */
   public String getSequence(){
      return this.sequence;
   }
   /**
    * setter for SEQUENCE
    * @generated
    */
   public void setSequence(String sequence){
      this.sequence = sequence;
   }

   /**
    * getter for PROJECT_NAME
    * @generated
    */
   public String getProjectName(){
      return this.projectName;
   }
   /**
    * setter for PROJECT_NAME
    * @generated
    */
   public void setProjectName(String projectName){
      this.projectName = projectName;
   }

   /**
    * getter for ZAHLUNGSZIEL
    * @generated
    */
   public String getZahlungsziel(){
      return this.zahlungsziel;
   }
   /**
    * setter for ZAHLUNGSZIEL
    * @generated
    */
   public void setZahlungsziel(String zahlungsziel){
      this.zahlungsziel = zahlungsziel;
   }

   /**
    * getter for EXPENDITURE_CASH
    * @generated
    */
   public String getExpenditureCash(){
      return this.expenditureCash;
   }
   /**
    * setter for EXPENDITURE_CASH
    * @generated
    */
   public void setExpenditureCash(String expenditureCash){
      this.expenditureCash = expenditureCash;
   }

   /**
    * getter for RATIO
    * @generated
    */
   public String getRatio(){
      return this.ratio;
   }
   /**
    * setter for RATIO
    * @generated
    */
   public void setRatio(String ratio){
      this.ratio = ratio;
   }

   /**
    * getter for PURPOSE
    * @generated
    */
   public String getPurpose(){
      return this.purpose;
   }
   /**
    * setter for PURPOSE
    * @generated
    */
   public void setPurpose(String purpose){
      this.purpose = purpose;
   }

}