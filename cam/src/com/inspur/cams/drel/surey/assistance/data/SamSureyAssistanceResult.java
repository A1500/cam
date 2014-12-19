package com.inspur.cams.drel.surey.assistance.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamSureyAssitanceResult
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 @Table(tableName = "SAM_SUREY_ASSISTANCE_RESULT" , keyFields = "resultId")
public class SamSureyAssistanceResult extends StatefulDatabean {
   //RESULT_ID
   	@Rule(value="require")
	@Column(name = "RESULT_ID")
   private String resultId;
   //SURVEY_ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //PEOPLE_ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //NAME
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //RESULT
	@Column(name = "RESULT")
   private String result;
   //SIGN_ORGAN
	@Column(name = "SIGN_ORGAN")
   private String signOrgan;
   //SIGN_DATE
	@Column(name = "SIGN_DATE")
   private String signDate;
   /**
    * getter for RESULT_ID
    * @generated
    */
   public String getResultId(){
      return this.resultId;
   }
   /**
    * setter for RESULT_ID
    * @generated
    */
   public void setResultId(String resultId){
      this.resultId = resultId;
   }

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
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
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
    * getter for ID_CARD
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for ID_CARD
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for RESULT
    * @generated
    */
   public String getResult(){
      return this.result;
   }
   /**
    * setter for RESULT
    * @generated
    */
   public void setResult(String result){
      this.result = result;
   }

   /**
    * getter for SIGN_ORGAN
    * @generated
    */
   public String getSignOrgan(){
      return this.signOrgan;
   }
   /**
    * setter for SIGN_ORGAN
    * @generated
    */
   public void setSignOrgan(String signOrgan){
      this.signOrgan = signOrgan;
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