package com.inspur.cams.sorg.check.checkinterorg.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 参加国际组织
 * @author yanliangliang
 * @date 2012-1-8
 */
 @Table(tableName = "SOM_CHECK_INTER_ORG" , keyFields = "id")
public class SomCheckInterOrg extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ORG_CN_NAME
	@Column(name = "ORG_CN_NAME")
   private String orgCnName;
   //ORG_EN_NAME
	@Column(name = "ORG_EN_NAME")
   private String orgEnName;
   //ORG_TYPE
	@Column(name = "ORG_TYPE")
   private String orgType;
   //JOIN_DATE
	@Column(name = "JOIN_DATE")
   private String joinDate;
   //FEE
	@Column(name = "FEE")
   private String fee;
   //DUTY_TYPE
	@Column(name = "DUTY_TYPE")
   private String dutyType;
   //DUTY_PERIOD
	@Column(name = "DUTY_PERIOD")
   private String dutyPeriod;
   //AUDIT_ORGAN_NAME
	@Column(name = "AUDIT_ORGAN_NAME")
   private String auditOrganName;
	@Column(name = "SEQ")
	private String seq;
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
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
    * getter for ORG_CN_NAME
    * @generated
    */
   public String getOrgCnName(){
      return this.orgCnName;
   }
   /**
    * setter for ORG_CN_NAME
    * @generated
    */
   public void setOrgCnName(String orgCnName){
      this.orgCnName = orgCnName;
   }

   /**
    * getter for ORG_EN_NAME
    * @generated
    */
   public String getOrgEnName(){
      return this.orgEnName;
   }
   /**
    * setter for ORG_EN_NAME
    * @generated
    */
   public void setOrgEnName(String orgEnName){
      this.orgEnName = orgEnName;
   }

   /**
    * getter for ORG_TYPE
    * @generated
    */
   public String getOrgType(){
      return this.orgType;
   }
   /**
    * setter for ORG_TYPE
    * @generated
    */
   public void setOrgType(String orgType){
      this.orgType = orgType;
   }

   /**
    * getter for JOIN_DATE
    * @generated
    */
   public String getJoinDate(){
      return this.joinDate;
   }
   /**
    * setter for JOIN_DATE
    * @generated
    */
   public void setJoinDate(String joinDate){
      this.joinDate = joinDate;
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
    * getter for DUTY_TYPE
    * @generated
    */
   public String getDutyType(){
      return this.dutyType;
   }
   /**
    * setter for DUTY_TYPE
    * @generated
    */
   public void setDutyType(String dutyType){
      this.dutyType = dutyType;
   }

   /**
    * getter for DUTY_PERIOD
    * @generated
    */
   public String getDutyPeriod(){
      return this.dutyPeriod;
   }
   /**
    * setter for DUTY_PERIOD
    * @generated
    */
   public void setDutyPeriod(String dutyPeriod){
      this.dutyPeriod = dutyPeriod;
   }

   /**
    * getter for AUDIT_ORGAN_NAME
    * @generated
    */
   public String getAuditOrganName(){
      return this.auditOrganName;
   }
   /**
    * setter for AUDIT_ORGAN_NAME
    * @generated
    */
   public void setAuditOrganName(String auditOrganName){
      this.auditOrganName = auditOrganName;
   }

}