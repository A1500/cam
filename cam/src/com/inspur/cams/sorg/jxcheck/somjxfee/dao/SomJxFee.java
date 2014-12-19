package com.inspur.cams.sorg.jxcheck.somjxfee.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:江西会费标准备案表
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_FEE" , keyFields = "feeId2")
public class SomJxFee extends StatefulDatabean {
   //FEE_ID2
   	@Rule(value="require")
	@Column(name = "FEE_ID2")
   private String feeId2;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //CN_NAME
	@Column(name = "CN_NAME")
   private String cnName;
   //SORG_CODE
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //BORG_CODE
	@Column(name = "BORG_CODE")
   private String borgCode;
   //MEETING_NUM
	@Column(name = "MEETING_NUM")
   private String meetingNum;
   //MEETING_TIMES
	@Column(name = "MEETING_TIMES")
   private String meetingTimes;
   //SHOULD_NUM
   	@Rule(value="number")
	@Column(name = "SHOULD_NUM")
   private BigDecimal shouldNum;
   //REAL_NUM
   	@Rule(value="number")
	@Column(name = "REAL_NUM")
   private BigDecimal realNum;
   //PASS_NUM
   	@Rule(value="number")
	@Column(name = "PASS_NUM")
   private BigDecimal passNum;
   //NOPASS_NUM
   	@Rule(value="number")
	@Column(name = "NOPASS_NUM")
   private BigDecimal nopassNum;
   //GIVEUP_NUM
   	@Rule(value="number")
	@Column(name = "GIVEUP_NUM")
   private BigDecimal giveupNum;
   //PRESIDENT_RULE
	@Column(name = "PRESIDENT_RULE")
   private String presidentRule;
   //ASSISTANT_RULE
	@Column(name = "ASSISTANT_RULE")
   private String assistantRule;
   //STAND_RULE
	@Column(name = "STAND_RULE")
   private String standRule;
   //COUNCIL_RULE
	@Column(name = "COUNCIL_RULE")
   private String councilRule;
   //UNIT_RULE
	@Column(name = "UNIT_RULE")
   private String unitRule;
   //PEOPLE_RULE
	@Column(name = "PEOPLE_RULE")
   private String peopleRule;
   //MEETING_TIME
	@Column(name = "MEETING_TIME")
   private String meetingTime;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //LEGAL_DATE
	@Column(name = "LEGAL_DATE")
   private String legalDate;
   //MORG_NAME
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_PEOPLE_NAME
	@Column(name = "MORG_PEOPLE_NAME")
   private String morgPeopleName;
   //MORG_DATE
	@Column(name = "MORG_DATE")
   private String morgDate;
   /**
    * getter for FEE_ID2
    * @generated
    */
   public String getFeeId2(){
      return this.feeId2;
   }
   /**
    * setter for FEE_ID2
    * @generated
    */
   public void setFeeId2(String feeId2){
      this.feeId2 = feeId2;
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
    * getter for CN_NAME
    * @generated
    */
   public String getCnName(){
      return this.cnName;
   }
   /**
    * setter for CN_NAME
    * @generated
    */
   public void setCnName(String cnName){
      this.cnName = cnName;
   }

   /**
    * getter for SORG_CODE
    * @generated
    */
   public String getSorgCode(){
      return this.sorgCode;
   }
   /**
    * setter for SORG_CODE
    * @generated
    */
   public void setSorgCode(String sorgCode){
      this.sorgCode = sorgCode;
   }

   /**
    * getter for BORG_CODE
    * @generated
    */
   public String getBorgCode(){
      return this.borgCode;
   }
   /**
    * setter for BORG_CODE
    * @generated
    */
   public void setBorgCode(String borgCode){
      this.borgCode = borgCode;
   }

   /**
    * getter for MEETING_NUM
    * @generated
    */
   public String getMeetingNum(){
      return this.meetingNum;
   }
   /**
    * setter for MEETING_NUM
    * @generated
    */
   public void setMeetingNum(String meetingNum){
      this.meetingNum = meetingNum;
   }

   /**
    * getter for MEETING_TIMES
    * @generated
    */
   public String getMeetingTimes(){
      return this.meetingTimes;
   }
   /**
    * setter for MEETING_TIMES
    * @generated
    */
   public void setMeetingTimes(String meetingTimes){
      this.meetingTimes = meetingTimes;
   }

   /**
    * getter for SHOULD_NUM
    * @generated
    */
   public BigDecimal getShouldNum(){
      return this.shouldNum;
   }
   /**
    * setter for SHOULD_NUM
    * @generated
    */
   public void setShouldNum(BigDecimal shouldNum){
      this.shouldNum = shouldNum;
   }

   /**
    * getter for REAL_NUM
    * @generated
    */
   public BigDecimal getRealNum(){
      return this.realNum;
   }
   /**
    * setter for REAL_NUM
    * @generated
    */
   public void setRealNum(BigDecimal realNum){
      this.realNum = realNum;
   }

   /**
    * getter for PASS_NUM
    * @generated
    */
   public BigDecimal getPassNum(){
      return this.passNum;
   }
   /**
    * setter for PASS_NUM
    * @generated
    */
   public void setPassNum(BigDecimal passNum){
      this.passNum = passNum;
   }

   /**
    * getter for NOPASS_NUM
    * @generated
    */
   public BigDecimal getNopassNum(){
      return this.nopassNum;
   }
   /**
    * setter for NOPASS_NUM
    * @generated
    */
   public void setNopassNum(BigDecimal nopassNum){
      this.nopassNum = nopassNum;
   }

   /**
    * getter for GIVEUP_NUM
    * @generated
    */
   public BigDecimal getGiveupNum(){
      return this.giveupNum;
   }
   /**
    * setter for GIVEUP_NUM
    * @generated
    */
   public void setGiveupNum(BigDecimal giveupNum){
      this.giveupNum = giveupNum;
   }

   /**
    * getter for PRESIDENT_RULE
    * @generated
    */
   public String getPresidentRule(){
      return this.presidentRule;
   }
   /**
    * setter for PRESIDENT_RULE
    * @generated
    */
   public void setPresidentRule(String presidentRule){
      this.presidentRule = presidentRule;
   }

   /**
    * getter for ASSISTANT_RULE
    * @generated
    */
   public String getAssistantRule(){
      return this.assistantRule;
   }
   /**
    * setter for ASSISTANT_RULE
    * @generated
    */
   public void setAssistantRule(String assistantRule){
      this.assistantRule = assistantRule;
   }

   /**
    * getter for STAND_RULE
    * @generated
    */
   public String getStandRule(){
      return this.standRule;
   }
   /**
    * setter for STAND_RULE
    * @generated
    */
   public void setStandRule(String standRule){
      this.standRule = standRule;
   }

   /**
    * getter for COUNCIL_RULE
    * @generated
    */
   public String getCouncilRule(){
      return this.councilRule;
   }
   /**
    * setter for COUNCIL_RULE
    * @generated
    */
   public void setCouncilRule(String councilRule){
      this.councilRule = councilRule;
   }

   /**
    * getter for UNIT_RULE
    * @generated
    */
   public String getUnitRule(){
      return this.unitRule;
   }
   /**
    * setter for UNIT_RULE
    * @generated
    */
   public void setUnitRule(String unitRule){
      this.unitRule = unitRule;
   }

   /**
    * getter for PEOPLE_RULE
    * @generated
    */
   public String getPeopleRule(){
      return this.peopleRule;
   }
   /**
    * setter for PEOPLE_RULE
    * @generated
    */
   public void setPeopleRule(String peopleRule){
      this.peopleRule = peopleRule;
   }

   /**
    * getter for MEETING_TIME
    * @generated
    */
   public String getMeetingTime(){
      return this.meetingTime;
   }
   /**
    * setter for MEETING_TIME
    * @generated
    */
   public void setMeetingTime(String meetingTime){
      this.meetingTime = meetingTime;
   }

   /**
    * getter for LEGAL_PEOPLE
    * @generated
    */
   public String getLegalPeople(){
      return this.legalPeople;
   }
   /**
    * setter for LEGAL_PEOPLE
    * @generated
    */
   public void setLegalPeople(String legalPeople){
      this.legalPeople = legalPeople;
   }

   /**
    * getter for LEGAL_DATE
    * @generated
    */
   public String getLegalDate(){
      return this.legalDate;
   }
   /**
    * setter for LEGAL_DATE
    * @generated
    */
   public void setLegalDate(String legalDate){
      this.legalDate = legalDate;
   }

   /**
    * getter for MORG_NAME
    * @generated
    */
   public String getMorgName(){
      return this.morgName;
   }
   /**
    * setter for MORG_NAME
    * @generated
    */
   public void setMorgName(String morgName){
      this.morgName = morgName;
   }

   /**
    * getter for MORG_PEOPLE_NAME
    * @generated
    */
   public String getMorgPeopleName(){
      return this.morgPeopleName;
   }
   /**
    * setter for MORG_PEOPLE_NAME
    * @generated
    */
   public void setMorgPeopleName(String morgPeopleName){
      this.morgPeopleName = morgPeopleName;
   }

   /**
    * getter for MORG_DATE
    * @generated
    */
   public String getMorgDate(){
      return this.morgDate;
   }
   /**
    * setter for MORG_DATE
    * @generated
    */
   public void setMorgDate(String morgDate){
      this.morgDate = morgDate;
   }

}