package com.inspur.cams.drel.surey.assistance.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamSureyWfAssitanceHis
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 @Table(tableName = "SAM_SUREY_WF_ASSISTANCE_HIS" , keyFields = "hisId")
public class SamSureyWfAssistanceHis extends StatefulDatabean {
   //HIS_ID
   	@Rule(value="require")
	@Column(name = "HIS_ID")
   private String hisId;
   //SURVEY_RESULT
	@Column(name = "SURVEY_RESULT")
   private String surveyResult;
   //SIGN_ORGAN
	@Column(name = "SIGN_ORGAN")
   private String signOrgan;
   //SIGN_DATE
	@Column(name = "SIGN_DATE")
   private String signDate;
   /**
    * getter for HIS_ID
    * @generated
    */
   public String getHisId(){
      return this.hisId;
   }
   /**
    * setter for HIS_ID
    * @generated
    */
   public void setHisId(String hisId){
      this.hisId = hisId;
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