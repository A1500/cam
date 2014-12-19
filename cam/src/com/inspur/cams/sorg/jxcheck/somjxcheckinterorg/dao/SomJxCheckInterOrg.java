package com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西参加国际组织
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_INTER_ORG" , keyFields = "id")
public class SomJxCheckInterOrg extends StatefulDatabean {
   //ID
   	@Rule(value="require")
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
   //JOIN_DATE
	@Column(name = "JOIN_DATE")
   private String joinDate;
   //DUTY_TYPE
	@Column(name = "DUTY_TYPE")
   private String dutyType;
   //AUDIT_ORGAN_NAME
	@Column(name = "AUDIT_ORGAN_NAME")
   private String auditOrganName;
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