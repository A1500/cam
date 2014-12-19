package com.inspur.cams.welfare.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealFitApply
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 @Table(tableName = "WEAL_FIT_APPLY" , keyFields = "taskCode")
public class WealFitApply extends StatefulDatabean {
	@Transient
	private WealFitInfo wealFitInfo;
	@Transient
	private WealFitChangerecord wealFitChangerecord;
	@Transient
	private WealFitLogoff wealFitLogoff;
   //TASK_CODE
   	@Rule(value="require")
	@Column(name = "TASK_CODE")
   private String taskCode;
   //FIT_ID
   	@Rule(value="require")
	@Column(name = "FIT_ID")
   private String fitId;
   //APPLY_TYPE
   	@Rule(value="require")
	@Column(name = "APPLY_TYPE")
   private String applyType;
   //APPLY_STAUTS
	@Column(name = "APPLY_STAUTS")
   private String applyStauts;
   //ACCEPT_BASE_OPINION
	@Column(name = "ACCEPT_BASE_OPINION")
   private String acceptBaseOpinion;
   //ACCEPT_ADD_OPINION
	@Column(name = "ACCEPT_ADD_OPINION")
   private String acceptAddOpinion;
   //ACCEPT_TIME
	@Column(name = "ACCEPT_TIME")
   private String acceptTime;
   //EXPLORATION_BASE_OPINION
	@Column(name = "EXPLORATION_BASE_OPINION")
   private String explorationBaseOpinion;
   //EXPLORATION_ADD_OPINION
	@Column(name = "EXPLORATION_ADD_OPINION")
   private String explorationAddOpinion;
   //EXPLORATION_TIME
	@Column(name = "EXPLORATION_TIME")
   private String explorationTime;
   //CHARGE_BASE_OPINION
	@Column(name = "CHARGE_BASE_OPINION")
   private String chargeBaseOpinion;
   //CHARGE_ADD_OPINION
	@Column(name = "CHARGE_ADD_OPINION")
   private String chargeAddOpinion;
   //CHARGE_TIME
	@Column(name = "CHARGE_TIME")
   private String chargeTime;
   //CHIEF_BASE_OPINION
	@Column(name = "CHIEF_BASE_OPINION")
   private String chiefBaseOpinion;
   //CHIEF_ADD_OPINION
	@Column(name = "CHIEF_ADD_OPINION")
   private String chiefAddOpinion;
   //CHIEF_TIME
	@Column(name = "CHIEF_TIME")
   private String chiefTime;
   //DIRECTOR_BASE_OPINION
	@Column(name = "DIRECTOR_BASE_OPINION")
   private String directorBaseOpinion;
   //DIRECTOR_ADD_OPINION
	@Column(name = "DIRECTOR_ADD_OPINION")
   private String directorAddOpinion;
   //DIRECTOR_TIME
	@Column(name = "DIRECTOR_TIME")
   private String directorTime;
   //DATA_SOURCE
   	@Rule(value="require")
	@Column(name = "DATA_SOURCE")
   private String dataSource;
   //REG_DATE
   	@Rule(value="require")
	@Column(name = "REG_DATE")
   private String regDate;
   //SUBMIT_TIME
	@Column(name = "SUBMIT_TIME")
   private String submitTime;
   //REJECT_REASON
	@Column(name = "REJECT_REASON")
   private String rejectReason;
   //MORG_NAME
   	@Rule(value="require")
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
   	@Rule(value="require")
	@Column(name = "MORG_AREA")
   private String morgArea;
   	
   private String curActivity;
   private String curOpinionId;
   private String curOpinion;
   private String curPeopleName;
   //ACCEPT
   @Column(name = "ACCEPT")
   private String accept;
   //EXPLORATION
   @Column(name = "EXPLORATION")
   private String exploration;
   //CHARGE
   @Column(name = "CHARGE")
   private String charge;
   //CHIEF
   @Column(name = "CHIEF")
   private String chief;
   //DIRECTOR
   @Column(name = "DIRECTOR")
   private String director;
   
   @Column(name = "IS_PRINT")
   private String isPrint;
   public String getIsPrint() {
	return isPrint;
}
public void setIsPrint(String isPrint) {
	this.isPrint = isPrint;
}
@Column(name = "APPROVE_DATE")
   private String approveDate;
   /**
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   public String getApproveDate() {
	return approveDate;
}
public void setApproveDate(String approveDate) {
	this.approveDate = approveDate;
}
/**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for FIT_ID
    * @generated
    */
   public String getFitId(){
      return this.fitId;
   }
   /**
    * setter for FIT_ID
    * @generated
    */
   public void setFitId(String fitId){
      this.fitId = fitId;
   }

   /**
    * getter for APPLY_TYPE
    * @generated
    */
   public String getApplyType(){
      return this.applyType;
   }
   /**
    * setter for APPLY_TYPE
    * @generated
    */
   public void setApplyType(String applyType){
      this.applyType = applyType;
   }

   /**
    * getter for APPLY_STAUTS
    * @generated
    */
   public String getApplyStauts(){
      return this.applyStauts;
   }
   /**
    * setter for APPLY_STAUTS
    * @generated
    */
   public void setApplyStauts(String applyStauts){
      this.applyStauts = applyStauts;
   }

   /**
    * getter for ACCEPT_BASE_OPINION
    * @generated
    */
   public String getAcceptBaseOpinion(){
      return this.acceptBaseOpinion;
   }
   /**
    * setter for ACCEPT_BASE_OPINION
    * @generated
    */
   public void setAcceptBaseOpinion(String acceptBaseOpinion){
      this.acceptBaseOpinion = acceptBaseOpinion;
   }

   /**
    * getter for ACCEPT_ADD_OPINION
    * @generated
    */
   public String getAcceptAddOpinion(){
      return this.acceptAddOpinion;
   }
   /**
    * setter for ACCEPT_ADD_OPINION
    * @generated
    */
   public void setAcceptAddOpinion(String acceptAddOpinion){
      this.acceptAddOpinion = acceptAddOpinion;
   }

   /**
    * getter for ACCEPT_TIME
    * @generated
    */
   public String getAcceptTime(){
      return this.acceptTime;
   }
   /**
    * setter for ACCEPT_TIME
    * @generated
    */
   public void setAcceptTime(String acceptTime){
      this.acceptTime = acceptTime;
   }

   /**
    * getter for EXPLORATION_BASE_OPINION
    * @generated
    */
   public String getExplorationBaseOpinion(){
      return this.explorationBaseOpinion;
   }
   /**
    * setter for EXPLORATION_BASE_OPINION
    * @generated
    */
   public void setExplorationBaseOpinion(String explorationBaseOpinion){
      this.explorationBaseOpinion = explorationBaseOpinion;
   }

   /**
    * getter for EXPLORATION_ADD_OPINION
    * @generated
    */
   public String getExplorationAddOpinion(){
      return this.explorationAddOpinion;
   }
   /**
    * setter for EXPLORATION_ADD_OPINION
    * @generated
    */
   public void setExplorationAddOpinion(String explorationAddOpinion){
      this.explorationAddOpinion = explorationAddOpinion;
   }

   /**
    * getter for EXPLORATION_TIME
    * @generated
    */
   public String getExplorationTime(){
      return this.explorationTime;
   }
   /**
    * setter for EXPLORATION_TIME
    * @generated
    */
   public void setExplorationTime(String explorationTime){
      this.explorationTime = explorationTime;
   }

   /**
    * getter for CHARGE_BASE_OPINION
    * @generated
    */
   public String getChargeBaseOpinion(){
      return this.chargeBaseOpinion;
   }
   /**
    * setter for CHARGE_BASE_OPINION
    * @generated
    */
   public void setChargeBaseOpinion(String chargeBaseOpinion){
      this.chargeBaseOpinion = chargeBaseOpinion;
   }

   /**
    * getter for CHARGE_ADD_OPINION
    * @generated
    */
   public String getChargeAddOpinion(){
      return this.chargeAddOpinion;
   }
   /**
    * setter for CHARGE_ADD_OPINION
    * @generated
    */
   public void setChargeAddOpinion(String chargeAddOpinion){
      this.chargeAddOpinion = chargeAddOpinion;
   }

   /**
    * getter for CHARGE_TIME
    * @generated
    */
   public String getChargeTime(){
      return this.chargeTime;
   }
   /**
    * setter for CHARGE_TIME
    * @generated
    */
   public void setChargeTime(String chargeTime){
      this.chargeTime = chargeTime;
   }

   /**
    * getter for CHIEF_BASE_OPINION
    * @generated
    */
   public String getChiefBaseOpinion(){
      return this.chiefBaseOpinion;
   }
   /**
    * setter for CHIEF_BASE_OPINION
    * @generated
    */
   public void setChiefBaseOpinion(String chiefBaseOpinion){
      this.chiefBaseOpinion = chiefBaseOpinion;
   }

   /**
    * getter for CHIEF_ADD_OPINION
    * @generated
    */
   public String getChiefAddOpinion(){
      return this.chiefAddOpinion;
   }
   /**
    * setter for CHIEF_ADD_OPINION
    * @generated
    */
   public void setChiefAddOpinion(String chiefAddOpinion){
      this.chiefAddOpinion = chiefAddOpinion;
   }

   /**
    * getter for CHIEF_TIME
    * @generated
    */
   public String getChiefTime(){
      return this.chiefTime;
   }
   /**
    * setter for CHIEF_TIME
    * @generated
    */
   public void setChiefTime(String chiefTime){
      this.chiefTime = chiefTime;
   }

   /**
    * getter for DIRECTOR_BASE_OPINION
    * @generated
    */
   public String getDirectorBaseOpinion(){
      return this.directorBaseOpinion;
   }
   /**
    * setter for DIRECTOR_BASE_OPINION
    * @generated
    */
   public void setDirectorBaseOpinion(String directorBaseOpinion){
      this.directorBaseOpinion = directorBaseOpinion;
   }

   /**
    * getter for DIRECTOR_ADD_OPINION
    * @generated
    */
   public String getDirectorAddOpinion(){
      return this.directorAddOpinion;
   }
   /**
    * setter for DIRECTOR_ADD_OPINION
    * @generated
    */
   public void setDirectorAddOpinion(String directorAddOpinion){
      this.directorAddOpinion = directorAddOpinion;
   }

   /**
    * getter for DIRECTOR_TIME
    * @generated
    */
   public String getDirectorTime(){
      return this.directorTime;
   }
   /**
    * setter for DIRECTOR_TIME
    * @generated
    */
   public void setDirectorTime(String directorTime){
      this.directorTime = directorTime;
   }

   /**
    * getter for DATA_SOURCE
    * @generated
    */
   public String getDataSource(){
      return this.dataSource;
   }
   /**
    * setter for DATA_SOURCE
    * @generated
    */
   public void setDataSource(String dataSource){
      this.dataSource = dataSource;
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
    * getter for SUBMIT_TIME
    * @generated
    */
   public String getSubmitTime(){
      return this.submitTime;
   }
   /**
    * setter for SUBMIT_TIME
    * @generated
    */
   public void setSubmitTime(String submitTime){
      this.submitTime = submitTime;
   }

   /**
    * getter for REJECT_REASON
    * @generated
    */
   public String getRejectReason(){
      return this.rejectReason;
   }
   /**
    * setter for REJECT_REASON
    * @generated
    */
   public void setRejectReason(String rejectReason){
      this.rejectReason = rejectReason;
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
public WealFitInfo getWealFitInfo() {
	return wealFitInfo;
}
public void setWealFitInfo(WealFitInfo wealFitInfo) {
	this.wealFitInfo = wealFitInfo;
}
public WealFitChangerecord getWealFitChangerecord() {
	return wealFitChangerecord;
}
public void setWealFitChangerecord(WealFitChangerecord wealFitChangerecord) {
	this.wealFitChangerecord = wealFitChangerecord;
}
public WealFitLogoff getWealFitLogoff() {
	return wealFitLogoff;
}
public void setWealFitLogoff(WealFitLogoff wealFitLogoff) {
	this.wealFitLogoff = wealFitLogoff;
}
public String getCurActivity() {
	return curActivity;
}
public void setCurActivity(String curActivity) {
	this.curActivity = curActivity;
}
public String getCurOpinionId() {
	return curOpinionId;
}
public void setCurOpinionId(String curOpinionId) {
	this.curOpinionId = curOpinionId;
}
public String getCurOpinion() {
	return curOpinion;
}
public void setCurOpinion(String curOpinion) {
	this.curOpinion = curOpinion;
}
public String getCurPeopleName() {
	return curPeopleName;
}
public void setCurPeopleName(String curPeopleName) {
	this.curPeopleName = curPeopleName;
}
public String getAccept() {
	return accept;
}
public void setAccept(String accept) {
	this.accept = accept;
}
public String getExploration() {
	return exploration;
}
public void setExploration(String exploration) {
	this.exploration = exploration;
}
public String getCharge() {
	return charge;
}
public void setCharge(String charge) {
	this.charge = charge;
}
public String getChief() {
	return chief;
}
public void setChief(String chief) {
	this.chief = chief;
}
public String getDirector() {
	return director;
}
public void setDirector(String director) {
	this.director = director;
}

}