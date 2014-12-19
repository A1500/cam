package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureySurvey
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_survey" , keyFields = "surveyId")
public class SamEsureySurvey extends StatefulDatabean {
   //核对流水ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //发起核对日期
	@Column(name = "SURVEY_DATE")
   private String surveyDate;
   //发起单位ID
	@Column(name = "SURVEY_ORG")
   private String surveyOrg;
   //录入人ID
	@Column(name = "REG_ID")
   private String regId;
   //录入时间
	@Column(name = "REG_TIME")
   private String regTime;
   	//核对汇总单位行政区划
   	@Column(name="CHECK_ORG_AREA")
   	private String checkOrgArea;
   //审核人ID
	@Column(name = "CHECK_ID")
   private String checkId;

	//审核单位名称
	@Column(name = "CHECK_ORG_NAME")
    private String checkOrgName;
   //审核时间
	@Column(name = "CHECK_TIME")
   private String checkTime;
   //审核标志
	@Column(name = "CHECK_FLG")
   private String checkFlg;
   //审核说明
	@Column(name = "CHECK_NOTE")
   private String checkNote;
   /**
    * getter for 核对流水ID
    * @generated
    */
   public String getSurveyId(){
      return this.surveyId;
   }
   /**
    * setter for 核对流水ID
    * @generated
    */
   public void setSurveyId(String surveyId){
      this.surveyId = surveyId;
   }

   /**
    * getter for 家庭ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for 家庭ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
   }

   /**
    * getter for 发起核对日期
    * @generated
    */
   public String getSurveyDate(){
      return this.surveyDate;
   }
   /**
    * setter for 发起核对日期
    * @generated
    */
   public void setSurveyDate(String surveyDate){
      this.surveyDate = surveyDate;
   }

   /**
    * getter for 发起单位ID
    * @generated
    */
   public String getSurveyOrg(){
      return this.surveyOrg;
   }
   /**
    * setter for 发起单位ID
    * @generated
    */
   public void setSurveyOrg(String surveyOrg){
      this.surveyOrg = surveyOrg;
   }

   /**
    * getter for 录入人ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for 录入人ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for 录入时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 录入时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 审核人ID
    * @generated
    */
   public String getCheckId(){
      return this.checkId;
   }
   /**
    * setter for 审核人ID
    * @generated
    */
   public void setCheckId(String checkId){
      this.checkId = checkId;
   }

   /**
    * getter for 审核时间
    * @generated
    */
   public String getCheckTime(){
      return this.checkTime;
   }
   /**
    * setter for 审核时间
    * @generated
    */
   public void setCheckTime(String checkTime){
      this.checkTime = checkTime;
   }

   /**
    * getter for 审核标志
    * @generated
    */
   public String getCheckFlg(){
      return this.checkFlg;
   }
   /**
    * setter for 审核标志
    * @generated
    */
   public void setCheckFlg(String checkFlg){
      this.checkFlg = checkFlg;
   }

   /**
    * getter for 审核说明
    * @generated
    */
   public String getCheckNote(){
      return this.checkNote;
   }
   /**
    * setter for 审核说明
    * @generated
    */
   public void setCheckNote(String checkNote){
      this.checkNote = checkNote;
   }
public String getCheckOrgArea() {
	return checkOrgArea;
}
public void setCheckOrgArea(String checkOrgArea) {
	this.checkOrgArea = checkOrgArea;
}
public String getCheckOrgName() {
	return checkOrgName;
}
public void setCheckOrgName(String checkOrgName) {
	this.checkOrgName = checkOrgName;
}

}