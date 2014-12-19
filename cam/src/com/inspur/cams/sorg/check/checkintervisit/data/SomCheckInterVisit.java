package com.inspur.cams.sorg.check.checkintervisit.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 组团出国（境）访问
 * @author yanliangliang
 * @date 2012-1-8
 */
 @Table(tableName = "SOM_CHECK_INTER_VISIT" , keyFields = "id")
public class SomCheckInterVisit extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //VISIT_NATION
	@Column(name = "VISIT_NATION")
   private String visitNation;
   //VISIT_DATE
	@Column(name = "VISIT_DATE")
   private String visitDate;
   //VISIT_NUM
	@Column(name = "VISIT_NUM")
   private String visitNum;
   //VISIT_AIM
	@Column(name = "VISIT_AIM")
   private String visitAim;
   //FEE_SOURCE
	@Column(name = "FEE_SOURCE")
   private String feeSource;
   //INVITE_ORGAN_NAME
	@Column(name = "INVITE_ORGAN_NAME")
   private String inviteOrganName;
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
    * getter for VISIT_NATION
    * @generated
    */
   public String getVisitNation(){
      return this.visitNation;
   }
   /**
    * setter for VISIT_NATION
    * @generated
    */
   public void setVisitNation(String visitNation){
      this.visitNation = visitNation;
   }

   /**
    * getter for VISIT_DATE
    * @generated
    */
   public String getVisitDate(){
      return this.visitDate;
   }
   /**
    * setter for VISIT_DATE
    * @generated
    */
   public void setVisitDate(String visitDate){
      this.visitDate = visitDate;
   }

   /**
    * getter for VISIT_NUM
    * @generated
    */
   public String getVisitNum(){
      return this.visitNum;
   }
   /**
    * setter for VISIT_NUM
    * @generated
    */
   public void setVisitNum(String visitNum){
      this.visitNum = visitNum;
   }

   /**
    * getter for VISIT_AIM
    * @generated
    */
   public String getVisitAim(){
      return this.visitAim;
   }
   /**
    * setter for VISIT_AIM
    * @generated
    */
   public void setVisitAim(String visitAim){
      this.visitAim = visitAim;
   }

   /**
    * getter for FEE_SOURCE
    * @generated
    */
   public String getFeeSource(){
      return this.feeSource;
   }
   /**
    * setter for FEE_SOURCE
    * @generated
    */
   public void setFeeSource(String feeSource){
      this.feeSource = feeSource;
   }

   /**
    * getter for INVITE_ORGAN_NAME
    * @generated
    */
   public String getInviteOrganName(){
      return this.inviteOrganName;
   }
   /**
    * setter for INVITE_ORGAN_NAME
    * @generated
    */
   public void setInviteOrganName(String inviteOrganName){
      this.inviteOrganName = inviteOrganName;
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