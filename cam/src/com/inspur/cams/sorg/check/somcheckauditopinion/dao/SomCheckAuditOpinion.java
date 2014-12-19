package com.inspur.cams.sorg.check.somcheckauditopinion.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckAuditOpinion
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_AUDIT_OPINION" , keyFields = "id")
public class SomCheckAuditOpinion extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //AUDIT_OPINION
	@Column(name = "AUDIT_OPINION")
   private String auditOpinion;
   //AUDIT_ORGAN
	@Column(name = "AUDIT_ORGAN")
   private String auditOrgan;
   //AUDIT_PERSON
	@Column(name = "AUDIT_PERSON")
   private String auditPerson;
   //AUDIT_DATE
	@Column(name = "AUDIT_DATE")
   private String auditDate;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
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
    * getter for AUDIT_ORGAN
    * @generated
    */
   public String getAuditOrgan(){
      return this.auditOrgan;
   }
   /**
    * setter for AUDIT_ORGAN
    * @generated
    */
   public void setAuditOrgan(String auditOrgan){
      this.auditOrgan = auditOrgan;
   }

   /**
    * getter for AUDIT_PERSON
    * @generated
    */
   public String getAuditPerson(){
      return this.auditPerson;
   }
   /**
    * setter for AUDIT_PERSON
    * @generated
    */
   public void setAuditPerson(String auditPerson){
      this.auditPerson = auditPerson;
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

   /**
    * getter for PHONE
    * @generated
    */
   public String getPhone(){
      return this.phone;
   }
   /**
    * setter for PHONE
    * @generated
    */
   public void setPhone(String phone){
      this.phone = phone;
   }

}