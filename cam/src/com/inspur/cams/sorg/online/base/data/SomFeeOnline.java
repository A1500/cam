package com.inspur.cams.sorg.online.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomFeeOnline
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 @Table(tableName = "SOM_FEE_ONLINE" , keyFields = "feeId")
public class SomFeeOnline extends StatefulDatabean {
   //FEE_ID
   
	@Column(name = "FEE_ID")
   private String feeId;
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
   //FEE
	@Column(name = "FEE")
   private String fee;
   //REG_PEOPLE
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
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
    * getter for FEE_ID
    * @generated
    */
   public String getFeeId(){
      return this.feeId;
   }
   /**
    * setter for FEE_ID
    * @generated
    */
   public void setFeeId(String feeId){
      this.feeId = feeId;
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
    * getter for FEE
    * @generated
    */
   public String getFee(){
      return this.fee;
   }
   /**
    * setter for FEE
    * @generated
    */
   public void setFee(String fee){
      this.fee = fee;
   }

   /**
    * getter for REG_PEOPLE
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for REG_PEOPLE
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
   }

   /**
    * getter for REG_DATE
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for REG_DATE
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
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