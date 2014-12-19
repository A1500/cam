package com.inspur.cams.sorg.check.somcheckflow.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomCheckFlow
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_FLOW" , keyFields = "id")
public class SomCheckFlow extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ACCEPT_OPINION
	@Column(name = "ACCEPT_OPINION")
   private String acceptOpinion;
	//ACCEPT_OPINION_ID
	@Column(name = "ACCEPT_OPINION_ID")
   private String acceptOpinionId;
   //ACCEPT_ORGAN_ID
	@Column(name = "ACCEPT_ORGAN_ID")
   private String acceptOrganId;
   //ACCEPT_DEPT_ID
	@Column(name = "ACCEPT_DEPT_ID")
   private String acceptDeptId;
   //ACCEPT_PEOPLE_ID
	@Column(name = "ACCEPT_PEOPLE_ID")
   private String acceptPeopleId;
	//ACCEPT_PEOPLE_NAME
	@Column(name = "ACCEPT_PEOPLE_NAME")
   private String acceptPeopleName;
   //ACCEPT_DATE
	@Column(name = "ACCEPT_DATE")
   private String acceptDate;
   //CHECK_OPINION
	@Column(name = "CHECK_OPINION")
   private String checkOpinion;
	//CHECK_OPINION_ID
	@Column(name = "CHECK_OPINION_ID")
   private String checkOpinionId;
   //CHECK_ORGAN_ID
	@Column(name = "CHECK_ORGAN_ID")
   private String checkOrganId;
   //CHECK_DEPT_ID
	@Column(name = "CHECK_DEPT_ID")
   private String checkDeptId;
   //CHECK_PEOPLE_ID
	@Column(name = "CHECK_PEOPLE_ID")
   private String checkPeopleId;
	//CHECK_PEOPLE_NAME
	@Column(name = "CHECK_PEOPLE_NAME")
   private String checkPeopleName;
   //CHECK_DATE
	@Column(name = "CHECK_DATE")
   private String checkDate;
   //AUDIT_OPINION
	@Column(name = "AUDIT_OPINION")
   private String auditOpinion;
	//AUDIT_OPINION_ID
	@Column(name = "AUDIT_OPINION_ID")
   private String auditOpinionId;
   //AUDIT_ORGAN_ID
	@Column(name = "AUDIT_ORGAN_ID")
   private String auditOrganId;
   //AUDIT_DEPT_ID
	@Column(name = "AUDIT_DEPT_ID")
   private String auditDeptId;
   //AUDIT_PEOPLE_ID
	@Column(name = "AUDIT_PEOPLE_ID")
   private String auditPeopleId;
	//AUDIT_PEOPLE_NAME
	@Column(name = "AUDIT_PEOPLE_NAME")
   private String auditPeopleName;
   //AUDIT_DATE
	@Column(name = "AUDIT_DATE")
   private String auditDate;
	@Column(name ="Receive_PEOPLE_NAME")
	private String receivePeopleName;
	@Column(name ="Receive_TIME")
	private String receiveTime;
	@Column(name ="CORRECT_PEOPLE_NAME")
	private String correctPeopleName;
	@Column(name ="CORRECT_TIME")
	private String correctTime;
   /**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
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
    * getter for ACCEPT_OPINION
    * @generated
    */
   public String getAcceptOpinion(){
      return this.acceptOpinion;
   }
   /**
    * setter for ACCEPT_OPINION
    * @generated
    */
   public void setAcceptOpinion(String acceptOpinion){
      this.acceptOpinion = acceptOpinion;
   }

   /**
    * getter for ACCEPT_ORGAN_ID
    * @generated
    */
   public String getAcceptOrganId(){
      return this.acceptOrganId;
   }
   /**
    * setter for ACCEPT_ORGAN_ID
    * @generated
    */
   public void setAcceptOrganId(String acceptOrganId){
      this.acceptOrganId = acceptOrganId;
   }

   /**
    * getter for ACCEPT_DEPT_ID
    * @generated
    */
   public String getAcceptDeptId(){
      return this.acceptDeptId;
   }
   /**
    * setter for ACCEPT_DEPT_ID
    * @generated
    */
   public void setAcceptDeptId(String acceptDeptId){
      this.acceptDeptId = acceptDeptId;
   }

   /**
    * getter for ACCEPT_PEOPLE_ID
    * @generated
    */
   public String getAcceptPeopleId(){
      return this.acceptPeopleId;
   }
   /**
    * setter for ACCEPT_PEOPLE_ID
    * @generated
    */
   public void setAcceptPeopleId(String acceptPeopleId){
      this.acceptPeopleId = acceptPeopleId;
   }

   /**
    * getter for ACCEPT_DATE
    * @generated
    */
   public String getAcceptDate(){
      return this.acceptDate;
   }
   /**
    * setter for ACCEPT_DATE
    * @generated
    */
   public void setAcceptDate(String acceptDate){
      this.acceptDate = acceptDate;
   }

   /**
    * getter for CHECK_OPINION
    * @generated
    */
   public String getCheckOpinion(){
      return this.checkOpinion;
   }
   /**
    * setter for CHECK_OPINION
    * @generated
    */
   public void setCheckOpinion(String checkOpinion){
      this.checkOpinion = checkOpinion;
   }

   /**
    * getter for CHECK_ORGAN_ID
    * @generated
    */
   public String getCheckOrganId(){
      return this.checkOrganId;
   }
   /**
    * setter for CHECK_ORGAN_ID
    * @generated
    */
   public void setCheckOrganId(String checkOrganId){
      this.checkOrganId = checkOrganId;
   }

   /**
    * getter for CHECK_DEPT_ID
    * @generated
    */
   public String getCheckDeptId(){
      return this.checkDeptId;
   }
   /**
    * setter for CHECK_DEPT_ID
    * @generated
    */
   public void setCheckDeptId(String checkDeptId){
      this.checkDeptId = checkDeptId;
   }

   /**
    * getter for CHECK_PEOPLE_ID
    * @generated
    */
   public String getCheckPeopleId(){
      return this.checkPeopleId;
   }
   /**
    * setter for CHECK_PEOPLE_ID
    * @generated
    */
   public void setCheckPeopleId(String checkPeopleId){
      this.checkPeopleId = checkPeopleId;
   }

   /**
    * getter for CHECK_DATE
    * @generated
    */
   public String getCheckDate(){
      return this.checkDate;
   }
   /**
    * setter for CHECK_DATE
    * @generated
    */
   public void setCheckDate(String checkDate){
      this.checkDate = checkDate;
   }

   /**
    * getter for AUDIT_OPINION
    * @generated
    */
   public String getAuditOpinion(){
      return this.auditOpinion;
   }
   /**
    * setter for AUDIT_OPINION
    * @generated
    */
   public void setAuditOpinion(String auditOpinion){
      this.auditOpinion = auditOpinion;
   }

   /**
    * getter for AUDIT_ORGAN_ID
    * @generated
    */
   public String getAuditOrganId(){
      return this.auditOrganId;
   }
   /**
    * setter for AUDIT_ORGAN_ID
    * @generated
    */
   public void setAuditOrganId(String auditOrganId){
      this.auditOrganId = auditOrganId;
   }

   /**
    * getter for AUDIT_DEPT_ID
    * @generated
    */
   public String getAuditDeptId(){
      return this.auditDeptId;
   }
   /**
    * setter for AUDIT_DEPT_ID
    * @generated
    */
   public void setAuditDeptId(String auditDeptId){
      this.auditDeptId = auditDeptId;
   }

   /**
    * getter for AUDIT_PEOPLE_ID
    * @generated
    */
   public String getAuditPeopleId(){
      return this.auditPeopleId;
   }
   /**
    * setter for AUDIT_PEOPLE_ID
    * @generated
    */
   public void setAuditPeopleId(String auditPeopleId){
      this.auditPeopleId = auditPeopleId;
   }

   /**
    * getter for AUDIT_DATE
    * @generated
    */
   public String getAuditDate(){
      return this.auditDate;
   }
   /**
    * setter for AUDIT_DATE
    * @generated
    */
   public void setAuditDate(String auditDate){
      this.auditDate = auditDate;
   }
public String getAcceptOpinionId() {
	return acceptOpinionId;
}
public void setAcceptOpinionId(String acceptOpinionId) {
	this.acceptOpinionId = acceptOpinionId;
}
public String getCheckOpinionId() {
	return checkOpinionId;
}
public void setCheckOpinionId(String checkOpinionId) {
	this.checkOpinionId = checkOpinionId;
}
public String getAuditOpinionId() {
	return auditOpinionId;
}
public void setAuditOpinionId(String auditOpinionId) {
	this.auditOpinionId = auditOpinionId;
}
public String getAcceptPeopleName() {
	return acceptPeopleName;
}
public void setAcceptPeopleName(String acceptPeopleName) {
	this.acceptPeopleName = acceptPeopleName;
}
public String getCheckPeopleName() {
	return checkPeopleName;
}
public void setCheckPeopleName(String checkPeopleName) {
	this.checkPeopleName = checkPeopleName;
}
public String getAuditPeopleName() {
	return auditPeopleName;
}
public void setAuditPeopleName(String auditPeopleName) {
	this.auditPeopleName = auditPeopleName;
}
public String getReceivePeopleName() {
	return receivePeopleName;
}
public void setReceivePeopleName(String receivePeopleName) {
	this.receivePeopleName = receivePeopleName;
}
public String getReceiveTime() {
	return receiveTime;
}
public void setReceiveTime(String receiveTime) {
	this.receiveTime = receiveTime;
}
public String getCorrectPeopleName() {
	return correctPeopleName;
}
public void setCorrectPeopleName(String correctPeopleName) {
	this.correctPeopleName = correctPeopleName;
}
public String getCorrectTime() {
	return correctTime;
}
public void setCorrectTime(String correctTime) {
	this.correctTime = correctTime;
}

}