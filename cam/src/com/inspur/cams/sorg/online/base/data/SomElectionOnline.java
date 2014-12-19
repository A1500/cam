package com.inspur.cams.sorg.online.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomElectionOnline
 * @description:
 * @author:
 * @since:2012-11-22
 * @version:1.0
*/
 @Table(tableName = "SOM_ELECTION_ONLINE" , keyFields = "electionId")
public class SomElectionOnline extends StatefulDatabean {
   //ELECTION_ID

	@Column(name = "ELECTION_ID")
   private String electionId;
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
   //CHIEF_NUM
   	@Rule(value="number")
	@Column(name = "CHIEF_NUM")
   private BigDecimal chiefNum;
   //COUNCIL_NUM
   	@Rule(value="number")
	@Column(name = "COUNCIL_NUM")
   private BigDecimal councilNum;
   //SUPERVISOR_NUM
   	@Rule(value="number")
	@Column(name = "SUPERVISOR_NUM")
   private BigDecimal supervisorNum;
   //LAST_DATE
	@Column(name = "LAST_DATE")
   private String lastDate;
   //NEXT_DATE
	@Column(name = "NEXT_DATE")
   private String nextDate;
   //IF_MAKE_FEE
	@Column(name = "IF_MAKE_FEE")
   private String ifMakeFee;
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
   //PROCESS
	@Column(name = "PROCESS")
   private String process;
   //DELAY_REASON
	@Column(name = "DELAY_REASON")
   private String delayReason;
   //ELECTION_TYPE
	@Column(name = "ELECTION_TYPE")
   private String electionType;
   //DELAY_DATE
	@Column(name = "DELAY_DATE")
   private String delayDate;
	// 社会组织名称
	private String sorgName;

	// 社会组织登记证号或筹备文号
	private String sorgCode;
   public String getSorgName() {
		return sorgName;
	}
	public void setSorgName(String sorgName) {
		this.sorgName = sorgName;
	}
	public String getSorgCode() {
		return sorgCode;
	}
	public void setSorgCode(String sorgCode) {
		this.sorgCode = sorgCode;
	}
/**
    * getter for ELECTION_ID
    * @generated
    */
   public String getElectionId(){
      return this.electionId;
   }
   /**
    * setter for ELECTION_ID
    * @generated
    */
   public void setElectionId(String electionId){
      this.electionId = electionId;
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
    * getter for CHIEF_NUM
    * @generated
    */
   public BigDecimal getChiefNum(){
      return this.chiefNum;
   }
   /**
    * setter for CHIEF_NUM
    * @generated
    */
   public void setChiefNum(BigDecimal chiefNum){
      this.chiefNum = chiefNum;
   }

   /**
    * getter for COUNCIL_NUM
    * @generated
    */
   public BigDecimal getCouncilNum(){
      return this.councilNum;
   }
   /**
    * setter for COUNCIL_NUM
    * @generated
    */
   public void setCouncilNum(BigDecimal councilNum){
      this.councilNum = councilNum;
   }

   /**
    * getter for SUPERVISOR_NUM
    * @generated
    */
   public BigDecimal getSupervisorNum(){
      return this.supervisorNum;
   }
   /**
    * setter for SUPERVISOR_NUM
    * @generated
    */
   public void setSupervisorNum(BigDecimal supervisorNum){
      this.supervisorNum = supervisorNum;
   }

   /**
    * getter for LAST_DATE
    * @generated
    */
   public String getLastDate(){
      return this.lastDate;
   }
   /**
    * setter for LAST_DATE
    * @generated
    */
   public void setLastDate(String lastDate){
      this.lastDate = lastDate;
   }

   /**
    * getter for NEXT_DATE
    * @generated
    */
   public String getNextDate(){
      return this.nextDate;
   }
   /**
    * setter for NEXT_DATE
    * @generated
    */
   public void setNextDate(String nextDate){
      this.nextDate = nextDate;
   }

   /**
    * getter for IF_MAKE_FEE
    * @generated
    */
   public String getIfMakeFee(){
      return this.ifMakeFee;
   }
   /**
    * setter for IF_MAKE_FEE
    * @generated
    */
   public void setIfMakeFee(String ifMakeFee){
      this.ifMakeFee = ifMakeFee;
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

   /**
    * getter for PROCESS
    * @generated
    */
   public String getProcess(){
      return this.process;
   }
   /**
    * setter for PROCESS
    * @generated
    */
   public void setProcess(String process){
      this.process = process;
   }

   /**
    * getter for DELAY_REASON
    * @generated
    */
   public String getDelayReason(){
      return this.delayReason;
   }
   /**
    * setter for DELAY_REASON
    * @generated
    */
   public void setDelayReason(String delayReason){
      this.delayReason = delayReason;
   }

   /**
    * getter for ELECTION_TYPE
    * @generated
    */
   public String getElectionType(){
      return this.electionType;
   }
   /**
    * setter for ELECTION_TYPE
    * @generated
    */
   public void setElectionType(String electionType){
      this.electionType = electionType;
   }

   /**
    * getter for DELAY_DATE
    * @generated
    */
   public String getDelayDate(){
      return this.delayDate;
   }
   /**
    * setter for DELAY_DATE
    * @generated
    */
   public void setDelayDate(String delayDate){
      this.delayDate = delayDate;
   }

}