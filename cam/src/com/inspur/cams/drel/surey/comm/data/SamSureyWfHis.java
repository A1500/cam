package com.inspur.cams.drel.surey.comm.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamSureyWfHis
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 @Table(tableName = "SAM_SUREY_WF_HIS" , keyFields = "hisId")
public class SamSureyWfHis extends StatefulDatabean {
   //HIS_ID
   	@Rule(value="require")
	@Column(name = "HIS_ID")
   private String hisId;
   //FLOW_ID
   	@Rule(value="require")
	@Column(name = "FLOW_ID")
   private String flowId;
   //ACTIVITY
	@Column(name = "ACTIVITY")
   private String activity;
   //OPINION_CODE
	@Column(name = "OPINION_CODE")
   private String opinionCode;
   //OPINION
	@Column(name = "OPINION")
   private String opinion;
   //ACTIVITY_ORGAN
	@Column(name = "ACTIVITY_ORGAN")
   private String activityOrgan;
   //ACTIVITY_ORGAN_NAME
	@Column(name = "ACTIVITY_ORGAN_NAME")
   private String activityOrganName;
   //ACTIVITY_ORGAN_AREA
	@Column(name = "ACTIVITY_ORGAN_AREA")
   private String activityOrganArea;
   //ACTIVITY_ORGAN_TYPE
	@Column(name = "ACTIVITY_ORGAN_TYPE")
   private String activityOrganType;
   //ACTIVITY_PEOPLE
	@Column(name = "ACTIVITY_PEOPLE")
   private String activityPeople;
   //ACTIVITY_PEOPLE_NAME
	@Column(name = "ACTIVITY_PEOPLE_NAME")
   private String activityPeopleName;
   //ACTIVITY_DEAL_TIME
	@Column(name = "ACTIVITY_DEAL_TIME")
   private String activityDealTime;
   //CUR_ACTIVITY_ET
	@Column(name = "CUR_ACTIVITY_ET")
   private String curActivityEt;
   //CUR_ACTIVITY_ST
	@Column(name = "CUR_ACTIVITY_ST")
   private String curActivitySt;
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
    * getter for ACTIVITY
    * @generated
    */
   public String getActivity(){
      return this.activity;
   }
   /**
    * setter for ACTIVITY
    * @generated
    */
   public void setActivity(String activity){
      this.activity = activity;
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
    * getter for ACTIVITY_ORGAN
    * @generated
    */
   public String getActivityOrgan(){
      return this.activityOrgan;
   }
   /**
    * setter for ACTIVITY_ORGAN
    * @generated
    */
   public void setActivityOrgan(String activityOrgan){
      this.activityOrgan = activityOrgan;
   }

   /**
    * getter for ACTIVITY_ORGAN_NAME
    * @generated
    */
   public String getActivityOrganName(){
      return this.activityOrganName;
   }
   /**
    * setter for ACTIVITY_ORGAN_NAME
    * @generated
    */
   public void setActivityOrganName(String activityOrganName){
      this.activityOrganName = activityOrganName;
   }

   /**
    * getter for ACTIVITY_ORGAN_AREA
    * @generated
    */
   public String getActivityOrganArea(){
      return this.activityOrganArea;
   }
   /**
    * setter for ACTIVITY_ORGAN_AREA
    * @generated
    */
   public void setActivityOrganArea(String activityOrganArea){
      this.activityOrganArea = activityOrganArea;
   }

   /**
    * getter for ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public String getActivityOrganType(){
      return this.activityOrganType;
   }
   /**
    * setter for ACTIVITY_ORGAN_TYPE
    * @generated
    */
   public void setActivityOrganType(String activityOrganType){
      this.activityOrganType = activityOrganType;
   }

   /**
    * getter for ACTIVITY_PEOPLE
    * @generated
    */
   public String getActivityPeople(){
      return this.activityPeople;
   }
   /**
    * setter for ACTIVITY_PEOPLE
    * @generated
    */
   public void setActivityPeople(String activityPeople){
      this.activityPeople = activityPeople;
   }

   /**
    * getter for ACTIVITY_PEOPLE_NAME
    * @generated
    */
   public String getActivityPeopleName(){
      return this.activityPeopleName;
   }
   /**
    * setter for ACTIVITY_PEOPLE_NAME
    * @generated
    */
   public void setActivityPeopleName(String activityPeopleName){
      this.activityPeopleName = activityPeopleName;
   }

   /**
    * getter for ACTIVITY_DEAL_TIME
    * @generated
    */
   public String getActivityDealTime(){
      return this.activityDealTime;
   }
   /**
    * setter for ACTIVITY_DEAL_TIME
    * @generated
    */
   public void setActivityDealTime(String activityDealTime){
      this.activityDealTime = activityDealTime;
   }

   /**
    * getter for CUR_ACTIVITY_ET
    * @generated
    */
   public String getCurActivityEt(){
      return this.curActivityEt;
   }
   /**
    * setter for CUR_ACTIVITY_ET
    * @generated
    */
   public void setCurActivityEt(String curActivityEt){
      this.curActivityEt = curActivityEt;
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

}