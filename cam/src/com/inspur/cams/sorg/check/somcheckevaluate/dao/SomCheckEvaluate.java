package com.inspur.cams.sorg.check.somcheckevaluate.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckEvaluate
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_EVALUATE" , keyFields = "id")
public class SomCheckEvaluate extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //EVAL_LEVEL
	@Column(name = "EVAL_LEVEL")
   private String evalLevel;
   //START_DATE
	@Column(name = "START_DATE")
   private String startDate;
   //END_DATE
	@Column(name = "END_DATE")
   private String endDate;
   //IF_REVENUE_FAVORABLE
	@Column(name = "IF_REVENUE_FAVORABLE")
   private String ifRevenueFavorable;
   //FAVORABLE_TYPE
	@Column(name = "FAVORABLE_TYPE")
   private String favorableType;
   //FAVORABLE_DATE_ORGAN_DOC
	@Column(name = "FAVORABLE_DATE_ORGAN_DOC")
   private String favorableDateOrganDoc;
   //IF_PUNNISH
	@Column(name = "IF_PUNNISH")
   private String ifPunnish;
   //IF_CORRECT
	@Column(name = "IF_CORRECT")
   private String ifCorrect;
   //CORRECT_DESC
	@Column(name = "CORRECT_DESC")
   private String correctDesc;
   //NO_LEVEL
	@Column(name = "NO_LEVEL")
   private String noLevel;
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
    * getter for EVAL_LEVEL
    * @generated
    */
   public String getEvalLevel(){
      return this.evalLevel;
   }
   /**
    * setter for EVAL_LEVEL
    * @generated
    */
   public void setEvalLevel(String evalLevel){
      this.evalLevel = evalLevel;
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
    * getter for END_DATE
    * @generated
    */
   public String getEndDate(){
      return this.endDate;
   }
   /**
    * setter for END_DATE
    * @generated
    */
   public void setEndDate(String endDate){
      this.endDate = endDate;
   }

   /**
    * getter for IF_REVENUE_FAVORABLE
    * @generated
    */
   public String getIfRevenueFavorable(){
      return this.ifRevenueFavorable;
   }
   /**
    * setter for IF_REVENUE_FAVORABLE
    * @generated
    */
   public void setIfRevenueFavorable(String ifRevenueFavorable){
      this.ifRevenueFavorable = ifRevenueFavorable;
   }

   /**
    * getter for FAVORABLE_TYPE
    * @generated
    */
   public String getFavorableType(){
      return this.favorableType;
   }
   /**
    * setter for FAVORABLE_TYPE
    * @generated
    */
   public void setFavorableType(String favorableType){
      this.favorableType = favorableType;
   }

   /**
    * getter for FAVORABLE_DATE_ORGAN_DOC
    * @generated
    */
   public String getFavorableDateOrganDoc(){
      return this.favorableDateOrganDoc;
   }
   /**
    * setter for FAVORABLE_DATE_ORGAN_DOC
    * @generated
    */
   public void setFavorableDateOrganDoc(String favorableDateOrganDoc){
      this.favorableDateOrganDoc = favorableDateOrganDoc;
   }

   /**
    * getter for IF_PUNNISH
    * @generated
    */
   public String getIfPunnish(){
      return this.ifPunnish;
   }
   /**
    * setter for IF_PUNNISH
    * @generated
    */
   public void setIfPunnish(String ifPunnish){
      this.ifPunnish = ifPunnish;
   }

   /**
    * getter for IF_CORRECT
    * @generated
    */
   public String getIfCorrect(){
      return this.ifCorrect;
   }
   /**
    * setter for IF_CORRECT
    * @generated
    */
   public void setIfCorrect(String ifCorrect){
      this.ifCorrect = ifCorrect;
   }

   /**
    * getter for CORRECT_DESC
    * @generated
    */
   public String getCorrectDesc(){
      return this.correctDesc;
   }
   /**
    * setter for CORRECT_DESC
    * @generated
    */
   public void setCorrectDesc(String correctDesc){
      this.correctDesc = correctDesc;
   }

   /**
    * getter for NO_LEVEL
    * @generated
    */
   public String getNoLevel(){
      return this.noLevel;
   }
   /**
    * setter for NO_LEVEL
    * @generated
    */
   public void setNoLevel(String noLevel){
      this.noLevel = noLevel;
   }

}