package com.inspur.cams.drel.surey.comm.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamSurey
 * @description:
 * @author:
 * @since:2011-10-01
 * @version:1.0
*/
 @Table(tableName = "SAM_SUREY" , keyFields = "surveyId")
public class SamSurey extends StatefulDatabean {
   //SURVEY_ID
   	@Rule(value="require")
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //SURVEY_TYPE
	@Column(name = "SURVEY_TYPE")
   private String surveyType;
   //ASSISTANCE_TYPE
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;
   //APPLY_TITLE
	@Column(name = "APPLY_TITLE")
   private String applyTitle;
   //APPLY_CONTENT
	@Column(name = "APPLY_CONTENT")
   private String applyContent;
   //APPLY_ORGAN
	@Column(name = "APPLY_ORGAN")
   private String applyOrgan;
   //APPLY_ORGAN_TYPE
	@Column(name = "APPLY_ORGAN_TYPE")
   private String applyOrganType;
   //APPLY_ORGAN_AREA
	@Column(name = "APPLY_ORGAN_AREA")
   private String applyOrganArea;
   //APPLY_DATE
	@Column(name = "APPLY_DATE")
   private String applyDate;
   //SURVEY_ORGAN
	@Column(name = "SURVEY_ORGAN")
   private String surveyOrgan;
   //SURVEY_ORGAN_AREA
	@Column(name = "SURVEY_ORGAN_AREA")
   private String surveyOrganArea;
   //SURVEY_ORGAN_TYPE
	@Column(name = "SURVEY_ORGAN_TYPE")
   private String surveyOrganType;
   //SURVEY_DATE
	@Column(name = "SURVEY_DATE")
   private String surveyDate;
   //SURVEY_RESULT
	@Column(name = "SURVEY_RESULT")
   private String surveyResult;
   //APPLY_ORGAN_NAME
	@Column(name = "APPLY_ORGAN_NAME")
   private String applyOrganName;
   //SURVEY_ORGAN_NAME
	@Column(name = "SURVEY_ORGAN_NAME")
   private String surveyOrganName;
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
    * getter for SURVEY_TYPE
    * @generated
    */
   public String getSurveyType(){
      return this.surveyType;
   }
   /**
    * setter for SURVEY_TYPE
    * @generated
    */
   public void setSurveyType(String surveyType){
      this.surveyType = surveyType;
   }

   /**
    * getter for ASSISTANCE_TYPE
    * @generated
    */
   public String getAssistanceType(){
      return this.assistanceType;
   }
   /**
    * setter for ASSISTANCE_TYPE
    * @generated
    */
   public void setAssistanceType(String assistanceType){
      this.assistanceType = assistanceType;
   }

   /**
    * getter for APPLY_TITLE
    * @generated
    */
   public String getApplyTitle(){
      return this.applyTitle;
   }
   /**
    * setter for APPLY_TITLE
    * @generated
    */
   public void setApplyTitle(String applyTitle){
      this.applyTitle = applyTitle;
   }

   /**
    * getter for APPLY_CONTENT
    * @generated
    */
   public String getApplyContent(){
      return this.applyContent;
   }
   /**
    * setter for APPLY_CONTENT
    * @generated
    */
   public void setApplyContent(String applyContent){
      this.applyContent = applyContent;
   }

   /**
    * getter for APPLY_ORGAN
    * @generated
    */
   public String getApplyOrgan(){
      return this.applyOrgan;
   }
   /**
    * setter for APPLY_ORGAN
    * @generated
    */
   public void setApplyOrgan(String applyOrgan){
      this.applyOrgan = applyOrgan;
   }

   /**
    * getter for APPLY_ORGAN_TYPE
    * @generated
    */
   public String getApplyOrganType(){
      return this.applyOrganType;
   }
   /**
    * setter for APPLY_ORGAN_TYPE
    * @generated
    */
   public void setApplyOrganType(String applyOrganType){
      this.applyOrganType = applyOrganType;
   }

   /**
    * getter for APPLY_ORGAN_AREA
    * @generated
    */
   public String getApplyOrganArea(){
      return this.applyOrganArea;
   }
   /**
    * setter for APPLY_ORGAN_AREA
    * @generated
    */
   public void setApplyOrganArea(String applyOrganArea){
      this.applyOrganArea = applyOrganArea;
   }

   /**
    * getter for APPLY_DATE
    * @generated
    */
   public String getApplyDate(){
      return this.applyDate;
   }
   /**
    * setter for APPLY_DATE
    * @generated
    */
   public void setApplyDate(String applyDate){
      this.applyDate = applyDate;
   }

   /**
    * getter for SURVEY_ORGAN
    * @generated
    */
   public String getSurveyOrgan(){
      return this.surveyOrgan;
   }
   /**
    * setter for SURVEY_ORGAN
    * @generated
    */
   public void setSurveyOrgan(String surveyOrgan){
      this.surveyOrgan = surveyOrgan;
   }

   /**
    * getter for SURVEY_ORGAN_AREA
    * @generated
    */
   public String getSurveyOrganArea(){
      return this.surveyOrganArea;
   }
   /**
    * setter for SURVEY_ORGAN_AREA
    * @generated
    */
   public void setSurveyOrganArea(String surveyOrganArea){
      this.surveyOrganArea = surveyOrganArea;
   }

   /**
    * getter for SURVEY_ORGAN_TYPE
    * @generated
    */
   public String getSurveyOrganType(){
      return this.surveyOrganType;
   }
   /**
    * setter for SURVEY_ORGAN_TYPE
    * @generated
    */
   public void setSurveyOrganType(String surveyOrganType){
      this.surveyOrganType = surveyOrganType;
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
    * getter for APPLY_ORGAN_NAME
    * @generated
    */
   public String getApplyOrganName(){
      return this.applyOrganName;
   }
   /**
    * setter for APPLY_ORGAN_NAME
    * @generated
    */
   public void setApplyOrganName(String applyOrganName){
      this.applyOrganName = applyOrganName;
   }

   /**
    * getter for SURVEY_ORGAN_NAME
    * @generated
    */
   public String getSurveyOrganName(){
      return this.surveyOrganName;
   }
   /**
    * setter for SURVEY_ORGAN_NAME
    * @generated
    */
   public void setSurveyOrganName(String surveyOrganName){
      this.surveyOrganName = surveyOrganName;
   }

}