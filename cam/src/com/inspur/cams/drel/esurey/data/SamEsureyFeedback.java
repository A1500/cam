package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyFeedback
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_feedback" , keyFields = "feedbackId")
public class SamEsureyFeedback extends StatefulDatabean {
   //填报ID
	@Column(name = "FEEDBACK_ID")
   private String feedbackId;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //姓名
	@Column(name = "NAME")
   private String name;
   //身份证件号码
	@Column(name = "ID_CARD")
   private String idCard;
   //核对流水ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //核对单位ID
	@Column(name = "CHECK_ORG_ID")
   private String checkOrgId;
   //核对单位名称
	@Column(name = "CHECK_ORG")
   private String checkOrg;
   //核对日期
	@Column(name = "CHECK_TIME")
   private String checkTime;
   	//核对单位行政区划
   	@Column(name="CHECK_ORG_AREA")
   	private String checkOrgArea;
   //核对人ID
	@Column(name = "CHECK_ID")
   private String checkId;
   //核对人姓名
	@Column(name = "CHECK_PEOPLE")
   private String checkPeople;
   //提交标志
	@Column(name = "CHECK_FLG")
   private String checkFlg;
   /**
    * getter for 填报ID
    * @generated
    */
   public String getFeedbackId(){
      return this.feedbackId;
   }
   /**
    * setter for 填报ID
    * @generated
    */
   public void setFeedbackId(String feedbackId){
      this.feedbackId = feedbackId;
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
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 身份证件号码
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 身份证件号码
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

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
    * getter for 核对单位ID
    * @generated
    */
   public String getCheckOrgId(){
      return this.checkOrgId;
   }
   /**
    * setter for 核对单位ID
    * @generated
    */
   public void setCheckOrgId(String checkOrgId){
      this.checkOrgId = checkOrgId;
   }

   /**
    * getter for 核对单位名称
    * @generated
    */
   public String getCheckOrg(){
      return this.checkOrg;
   }
   /**
    * setter for 核对单位名称
    * @generated
    */
   public void setCheckOrg(String checkOrg){
      this.checkOrg = checkOrg;
   }

   /**
    * getter for 核对日期
    * @generated
    */
   public String getCheckTime(){
      return this.checkTime;
   }
   /**
    * setter for 核对日期
    * @generated
    */
   public void setCheckTime(String checkTime){
      this.checkTime = checkTime;
   }

   /**
    * getter for 核对人ID
    * @generated
    */
   public String getCheckId(){
      return this.checkId;
   }
   /**
    * setter for 核对人ID
    * @generated
    */
   public void setCheckId(String checkId){
      this.checkId = checkId;
   }

   /**
    * getter for 核对人姓名
    * @generated
    */
   public String getCheckPeople(){
      return this.checkPeople;
   }
   /**
    * setter for 核对人姓名
    * @generated
    */
   public void setCheckPeople(String checkPeople){
      this.checkPeople = checkPeople;
   }

   /**
    * getter for 提交标志
    * @generated
    */
   public String getCheckFlg(){
      return this.checkFlg;
   }
   /**
    * setter for 提交标志
    * @generated
    */
   public void setCheckFlg(String checkFlg){
      this.checkFlg = checkFlg;
   }
public String getCheckOrgArea() {
	return checkOrgArea;
}
public void setCheckOrgArea(String checkOrgArea) {
	this.checkOrgArea = checkOrgArea;
}

}