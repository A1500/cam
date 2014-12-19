package com.inspur.cams.drel.sam.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:入户调查
 * @description:
 * @author:yanliangliang
 * @since:2012-05-03
 * @version:1.0
*/
 @Table(tableName = "SAM_APPLY_SURVEY" , keyFields = "surveyId")
public class SamApplySurvey extends StatefulDatabean {
   //SURVEY_ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //ACTIVITY_ID
	@Column(name = "ACTIVITY_ID")
   private String activityId;
   //SURVEY_DATE
	@Column(name = "SURVEY_DATE")
   private String surveyDate;
   //SURVEY_PEOPLE
	@Column(name = "SURVEY_PEOPLE")
   private String surveyPeople;
   //SURVEY_RESULT
	@Column(name = "SURVEY_RESULT")
   private String surveyResult;
   //SURVEY_CONTENTS
	@Column(name = "SURVEY_CONTENTS")
   private String surveyContents;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   /**
    * getter for SURVEY_ID
    * @generated
    */
   public String getSurveyId(){
      return this.surveyId;
   }
   /**
    * setter for SURVEY_ID
    * @generated
    */
   public void setSurveyId(String surveyId){
      this.surveyId = surveyId;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for ACTIVITY_ID
    * @generated
    */
   public String getActivityId(){
      return this.activityId;
   }
   /**
    * setter for ACTIVITY_ID
    * @generated
    */
   public void setActivityId(String activityId){
      this.activityId = activityId;
   }

   /**
    * getter for SURVEY_DATE
    * @generated
    */
   public String getSurveyDate(){
      return this.surveyDate;
   }
   /**
    * setter for SURVEY_DATE
    * @generated
    */
   public void setSurveyDate(String surveyDate){
      this.surveyDate = surveyDate;
   }

   /**
    * getter for SURVEY_PEOPLE
    * @generated
    */
   public String getSurveyPeople(){
      return this.surveyPeople;
   }
   /**
    * setter for SURVEY_PEOPLE
    * @generated
    */
   public void setSurveyPeople(String surveyPeople){
      this.surveyPeople = surveyPeople;
   }

   /**
    * getter for SURVEY_RESULT
    * @generated
    */
   public String getSurveyResult(){
      return this.surveyResult;
   }
   /**
    * setter for SURVEY_RESULT
    * @generated
    */
   public void setSurveyResult(String surveyResult){
      this.surveyResult = surveyResult;
   }

   /**
    * getter for SURVEY_CONTENTS
    * @generated
    */
   public String getSurveyContents(){
      return this.surveyContents;
   }
   /**
    * setter for SURVEY_CONTENTS
    * @generated
    */
   public void setSurveyContents(String surveyContents){
      this.surveyContents = surveyContents;
   }

   /**
    * getter for REMARKS
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for REMARKS
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }

}