package com.inspur.cams.sorg.online.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomRuleOnline
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 @Table(tableName = "SOM_RULE_ONLINE" , keyFields = "ruleId")
public class SomRuleOnline extends StatefulDatabean {
   //RULE_ID
   	
	@Column(name = "RULE_ID")
   private String ruleId;
   //TASK_CODE
   	
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SORG_ID
   	
	@Column(name = "SORG_ID")
   private String sorgId;
   //MEETING_ID
   	
	@Column(name = "MEETING_ID")
   private String meetingId;
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
   //IF_DRAFT
   	
	@Column(name = "IF_DRAFT")
   private String ifDraft;
   //MAIN_QUESTION
	@Column(name = "MAIN_QUESTION")
   private String mainQuestion;
   //REG_STATUS
	@Column(name = "REG_STATUS")
   private String regStatus;
   //MORG_NAME
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
	@Column(name = "MORG_AREA")
   private String morgArea;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   /**
    * getter for RULE_ID
    * @generated
    */
   public String getRuleId(){
      return this.ruleId;
   }
   /**
    * setter for RULE_ID
    * @generated
    */
   public void setRuleId(String ruleId){
      this.ruleId = ruleId;
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
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for MEETING_ID
    * @generated
    */
   public String getMeetingId(){
      return this.meetingId;
   }
   /**
    * setter for MEETING_ID
    * @generated
    */
   public void setMeetingId(String meetingId){
      this.meetingId = meetingId;
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
    * getter for IF_DRAFT
    * @generated
    */
   public String getIfDraft(){
      return this.ifDraft;
   }
   /**
    * setter for IF_DRAFT
    * @generated
    */
   public void setIfDraft(String ifDraft){
      this.ifDraft = ifDraft;
   }

   /**
    * getter for MAIN_QUESTION
    * @generated
    */
   public String getMainQuestion(){
      return this.mainQuestion;
   }
   /**
    * setter for MAIN_QUESTION
    * @generated
    */
   public void setMainQuestion(String mainQuestion){
      this.mainQuestion = mainQuestion;
   }

   /**
    * getter for REG_STATUS
    * @generated
    */
   public String getRegStatus(){
      return this.regStatus;
   }
   /**
    * setter for REG_STATUS
    * @generated
    */
   public void setRegStatus(String regStatus){
      this.regStatus = regStatus;
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
    * getter for MORG_AREA
    * @generated
    */
   public String getMorgArea(){
      return this.morgArea;
   }
   /**
    * setter for MORG_AREA
    * @generated
    */
   public void setMorgArea(String morgArea){
      this.morgArea = morgArea;
   }

   /**
    * getter for CREATE_PEOPLE
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for CREATE_PEOPLE
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

}