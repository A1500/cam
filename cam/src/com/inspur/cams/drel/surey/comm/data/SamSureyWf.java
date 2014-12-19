package com.inspur.cams.drel.surey.comm.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamSureyWf
 * @description:
 * @author:
 * @since:2011-10-09
 * @version:1.0
*/
 @Table(tableName = "SAM_SUREY_WF" , keyFields = "flowId")
public class SamSureyWf extends StatefulDatabean {
   //FLOW_ID
   	@Rule(value="require")
	@Column(name = "FLOW_ID")
   private String flowId;
   //SURVEY_ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //SURVEY_TYPE
	@Column(name = "SURVEY_TYPE")
   private String surveyType;
   //APPLY_TITLE
	@Column(name = "APPLY_TITLE")
   private String applyTitle;
   //NAME
   	@Rule(value="require")
	@Column(name = "NAME")
   private String name;
   //ID_CARD_TYPE
	@Column(name = "ID_CARD_TYPE")
   private String idCardType;
   //ID_CARD
   	@Rule(value="require")
	@Column(name = "ID_CARD")
   private String idCard;
   //DOMICILE_CODE
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //APANAGE_CODE
	@Column(name = "APANAGE_CODE")
   private String apanageCode;
   //CUR_ACTIVITY
	@Column(name = "CUR_ACTIVITY")
   private String curActivity;
   //CUR_STATUS
	@Column(name = "CUR_STATUS")
   private String curStatus;
   //CUR_ACTIVITY_ORGAN
	@Column(name = "CUR_ACTIVITY_ORGAN")
   private String curActivityOrgan;
   //CUR_ACTIVITY_ORGAN_NAME
	@Column(name = "CUR_ACTIVITY_ORGAN_NAME")
   private String curActivityOrganName;
   //CUR_ACTIVITY_ORGAN_TYPE
	@Column(name = "CUR_ACTIVITY_ORGAN_TYPE")
   private String curActivityOrganType;
   //CUR_ACTIVITY_AREA
	@Column(name = "CUR_ACTIVITY_AREA")
   private String curActivityArea;
   //PRE_ACTIVITY
	@Column(name = "PRE_ACTIVITY")
   private String preActivity;
   //PRE_ACTIVITY_AREA
	@Column(name = "PRE_ACTIVITY_AREA")
   private String preActivityArea;
   //PRE_ACTIVITY_ORGAN
	@Column(name = "PRE_ACTIVITY_ORGAN")
   private String preActivityOrgan;
   //PRE_ACTIVITY_ORGAN_TYPE
	@Column(name = "PRE_ACTIVITY_ORGAN_TYPE")
   private String preActivityOrganType;
   //PARENT_FLOW_ID
	@Column(name = "PARENT_FLOW_ID")
   private String parentFlowId;
   //IS_FINISH
	@Column(name = "IS_FINISH")
   private String isFinish;
   //CUR_ACTIVITY_ST
	@Column(name = "CUR_ACTIVITY_ST")
   private String curActivitySt;
   //OPINION_CODE
	@Column(name = "OPINION_CODE")
   private String opinionCode;
   //OPINION
	@Column(name = "OPINION")
   private String opinion;
   //NEXT_ACTIVITY
	@Column(name = "NEXT_ACTIVITY")
   private String nextActivity;
   //NEXT_ACTIVITY_AREA
	@Column(name = "NEXT_ACTIVITY_AREA")
   private String nextActivityArea;
   //NEXT_ACTIVITY_ORGAN
	@Column(name = "NEXT_ACTIVITY_ORGAN")
   private String nextActivityOrgan;
   //NEXT_ACTIVITY_ORGAN_TYPE
	@Column(name = "NEXT_ACTIVITY_ORGAN_TYPE")
   private String nextActivityOrganType;
   //PRE_ACTIVITY_ORGAN_NAME
	@Column(name = "PRE_ACTIVITY_ORGAN_NAME")
   private String preActivityOrganName;
   //NEXT_ACTIVITY_ORGAN_NAME
	@Column(name = "NEXT_ACTIVITY_ORGAN_NAME")
   private String nextActivityOrganName;
   //ASSISTANCE_TYPE
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;
   /**
    * getter for FLOW_ID
    * @generated
    */
   public String getFlowId(){
      return this.flowId;
   }
   /**
    * setter for FLOW_ID
    * @generated
    */
   public void setFlowId(String flowId){
      this.flowId = flowId;
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
    * getter for ID_CARD_TYPE
    * @generated
    */
   public String getIdCardType(){
      return this.idCardType;
   }
   /**
    * setter for ID_CARD_TYPE
    * @generated
    */
   public void setIdCardType(String idCardType){
      this.idCardType = idCardType;
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
    * getter for DOMICILE_CODE
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for DOMICILE_CODE
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for APANAGE_CODE
    * @generated
    */
   public String getApanageCode(){
      return this.apanageCode;
   }
   /**
    * setter for APANAGE_CODE
    * @generated
    */
   public void setApanageCode(String apanageCode){
      this.apanageCode = apanageCode;
   }

   /**
    * getter for CUR_ACTIVITY
    * @generated
    */
   public String getCurActivity(){
      return this.curActivity;
   }
   /**
    * setter for CUR_ACTIVITY
    * @generated
    */
   public void setCurActivity(String curActivity){
      this.curActivity = curActivity;
   }

   /**
    * getter for CUR_STATUS
    * @generated
    */
   public String getCurStatus(){
      return this.curStatus;
   }
   /**
    * setter for CUR_STATUS
    * @generated
    */
   public void setCurStatus(String curStatus){
      this.curStatus = curStatus;
   }

   /**
    * getter for CUR_ACTIVITY_ORGAN
    * @generated
    */
   public String getCurActivityOrgan(){
      return this.curActivityOrgan;
   }
   /**
    * setter for CUR_ACTIVITY_ORGAN
    * @generated
    */
   public void setCurActivityOrgan(String curActivityOrgan){
      this.curActivityOrgan = curActivityOrgan;
   }

   /**
    * getter for CUR_ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public String getCurActivityOrganType(){
      return this.curActivityOrganType;
   }
   /**
    * setter for CUR_ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public void setCurActivityOrganType(String curActivityOrganType){
      this.curActivityOrganType = curActivityOrganType;
   }

   /**
    * getter for CUR_ACTIVITY_AREA
    * @generated
    */
   public String getCurActivityArea(){
      return this.curActivityArea;
   }
   /**
    * setter for CUR_ACTIVITY_AREA
    * @generated
    */
   public void setCurActivityArea(String curActivityArea){
      this.curActivityArea = curActivityArea;
   }

   /**
    * getter for PRE_ACTIVITY
    * @generated
    */
   public String getPreActivity(){
      return this.preActivity;
   }
   /**
    * setter for PRE_ACTIVITY
    * @generated
    */
   public void setPreActivity(String preActivity){
      this.preActivity = preActivity;
   }

   /**
    * getter for PRE_ACTIVITY_AREA
    * @generated
    */
   public String getPreActivityArea(){
      return this.preActivityArea;
   }
   /**
    * setter for PRE_ACTIVITY_AREA
    * @generated
    */
   public void setPreActivityArea(String preActivityArea){
      this.preActivityArea = preActivityArea;
   }

   /**
    * getter for PRE_ACTIVITY_ORGAN
    * @generated
    */
   public String getPreActivityOrgan(){
      return this.preActivityOrgan;
   }
   /**
    * setter for PRE_ACTIVITY_ORGAN
    * @generated
    */
   public void setPreActivityOrgan(String preActivityOrgan){
      this.preActivityOrgan = preActivityOrgan;
   }

   /**
    * getter for PRE_ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public String getPreActivityOrganType(){
      return this.preActivityOrganType;
   }
   /**
    * setter for PRE_ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public void setPreActivityOrganType(String preActivityOrganType){
      this.preActivityOrganType = preActivityOrganType;
   }

   /**
    * getter for PARENT_FLOW_ID
    * @generated
    */
   public String getParentFlowId(){
      return this.parentFlowId;
   }
   /**
    * setter for PARENT_FLOW_ID
    * @generated
    */
   public void setParentFlowId(String parentFlowId){
      this.parentFlowId = parentFlowId;
   }

   /**
    * getter for IS_FINISH
    * @generated
    */
   public String getIsFinish(){
      return this.isFinish;
   }
   /**
    * setter for IS_FINISH
    * @generated
    */
   public void setIsFinish(String isFinish){
      this.isFinish = isFinish;
   }

   /**
    * getter for CUR_ACTIVITY_ST
    * @generated
    */
   public String getCurActivitySt(){
      return this.curActivitySt;
   }
   /**
    * setter for CUR_ACTIVITY_ST
    * @generated
    */
   public void setCurActivitySt(String curActivitySt){
      this.curActivitySt = curActivitySt;
   }

   /**
    * getter for OPINION_CODE
    * @generated
    */
   public String getOpinionCode(){
      return this.opinionCode;
   }
   /**
    * setter for OPINION_CODE
    * @generated
    */
   public void setOpinionCode(String opinionCode){
      this.opinionCode = opinionCode;
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
    * getter for NEXT_ACTIVITY
    * @generated
    */
   public String getNextActivity(){
      return this.nextActivity;
   }
   /**
    * setter for NEXT_ACTIVITY
    * @generated
    */
   public void setNextActivity(String nextActivity){
      this.nextActivity = nextActivity;
   }

   /**
    * getter for NEXT_ACTIVITY_AREA
    * @generated
    */
   public String getNextActivityArea(){
      return this.nextActivityArea;
   }
   /**
    * setter for NEXT_ACTIVITY_AREA
    * @generated
    */
   public void setNextActivityArea(String nextActivityArea){
      this.nextActivityArea = nextActivityArea;
   }

   /**
    * getter for NEXT_ACTIVITY_ORGAN
    * @generated
    */
   public String getNextActivityOrgan(){
      return this.nextActivityOrgan;
   }
   /**
    * setter for NEXT_ACTIVITY_ORGAN
    * @generated
    */
   public void setNextActivityOrgan(String nextActivityOrgan){
      this.nextActivityOrgan = nextActivityOrgan;
   }

   /**
    * getter for NEXT_ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public String getNextActivityOrganType(){
      return this.nextActivityOrganType;
   }
   /**
    * setter for NEXT_ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public void setNextActivityOrganType(String nextActivityOrganType){
      this.nextActivityOrganType = nextActivityOrganType;
   }

   /**
    * getter for PRE_ACTIVITY_ORGAN_NAME
    * @generated
    */
   public String getPreActivityOrganName(){
      return this.preActivityOrganName;
   }
   /**
    * setter for PRE_ACTIVITY_ORGAN_NAME
    * @generated
    */
   public void setPreActivityOrganName(String preActivityOrganName){
      this.preActivityOrganName = preActivityOrganName;
   }

   /**
    * getter for NEXT_ACTIVITY_ORGAN_NAME
    * @generated
    */
   public String getNextActivityOrganName(){
      return this.nextActivityOrganName;
   }
   /**
    * setter for NEXT_ACTIVITY_ORGAN_NAME
    * @generated
    */
   public void setNextActivityOrganName(String nextActivityOrganName){
      this.nextActivityOrganName = nextActivityOrganName;
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
public String getCurActivityOrganName() {
	return curActivityOrganName;
}
public void setCurActivityOrganName(String curActivityOrganName) {
	this.curActivityOrganName = curActivityOrganName;
}

}