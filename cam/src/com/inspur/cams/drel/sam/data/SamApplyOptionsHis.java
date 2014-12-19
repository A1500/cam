package com.inspur.cams.drel.sam.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:申请审批历史意见
 * @description:
 * @author:yanliangliang
 * @since:2012-05-03
 * @version:1.0
*/
 @Table(tableName = "SAM_APPLY_OPTIONS_HIS" , keyFields = "opinionHisId")
public class SamApplyOptionsHis extends StatefulDatabean {
   //OPINION_HIS_ID
	@Column(name = "OPINION_HIS_ID")
   private String opinionHisId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //ACTIVITY_ID
	@Column(name = "ACTIVITY_ID")
   private String activityId;
   //OPINION_ID
	@Column(name = "OPINION_ID")
   private String opinionId;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   //ORGAN_ID
	@Column(name = "ORGAN_ID")
   private String organId;
   //DEPT_ID
	@Column(name = "DEPT_ID")
   private String deptId;
   //PEOPLE_NAME
	@Column(name = "PEOPLE_NAME")
   private String peopleName;
   //PEOPLE_ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //EXAMINE_DATE
	@Column(name = "EXAMINE_DATE")
   private String examineDate;
	//负责人
	private String principal;
	
	private String agent;
   public String getAgent() {
		return agent;
	}
	public void setAgent(String agent) {
		this.agent = agent;
	}
/**
    * getter for OPINION_HIS_ID
    * @generated
    */
   public String getOpinionHisId(){
      return this.opinionHisId;
   }
   /**
    * setter for OPINION_HIS_ID
    * @generated
    */
   public void setOpinionHisId(String opinionHisId){
      this.opinionHisId = opinionHisId;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for ACTIVITY_ID
    * @generated
    */
   public String getActivityId(){
      return this.activityId;
   }
   /**
    * setter for ACTIVITY_ID
    * @generated
    */
   public void setActivityId(String activityId){
      this.activityId = activityId;
   }

   /**
    * getter for OPINION_ID
    * @generated
    */
   public String getOpinionId(){
      return this.opinionId;
   }
   /**
    * setter for OPINION_ID
    * @generated
    */
   public void setOpinionId(String opinionId){
      this.opinionId = opinionId;
   }

   /**
    * getter for REMARKS
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for REMARKS
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }

   /**
    * getter for ORGAN_ID
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for ORGAN_ID
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
   }

   /**
    * getter for DEPT_ID
    * @generated
    */
   public String getDeptId(){
      return this.deptId;
   }
   /**
    * setter for DEPT_ID
    * @generated
    */
   public void setDeptId(String deptId){
      this.deptId = deptId;
   }

   /**
    * getter for PEOPLE_NAME
    * @generated
    */
   public String getPeopleName(){
      return this.peopleName;
   }
   /**
    * setter for PEOPLE_NAME
    * @generated
    */
   public void setPeopleName(String peopleName){
      this.peopleName = peopleName;
   }

   /**
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for EXAMINE_DATE
    * @generated
    */
   public String getExamineDate(){
      return this.examineDate;
   }
   /**
    * setter for EXAMINE_DATE
    * @generated
    */
   public void setExamineDate(String examineDate){
      this.examineDate = examineDate;
   }
public String getPrincipal() {
	return principal;
}
public void setPrincipal(String principal) {
	this.principal = principal;
}

}