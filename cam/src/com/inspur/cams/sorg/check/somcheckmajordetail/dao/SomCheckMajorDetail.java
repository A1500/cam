package com.inspur.cams.sorg.check.somcheckmajordetail.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckMajorDetail
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_MAJOR_DETAIL" , keyFields = "id")
public class SomCheckMajorDetail extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //MAJOR_ID
	@Column(name = "MAJOR_ID")
   private String majorId;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SEQUENCE
	@Column(name = "SEQUENCE")
   private String sequence;
   //PROJECT_NAME
	@Column(name = "PROJECT_NAME")
   private String projectName;
   //INCOME
	@Column(name = "INCOME")
   private String income;
   //TO_PERSON_CASH
	@Column(name = "TO_PERSON_CASH")
   private String toPersonCash;
   //SALARY_CASH
	@Column(name = "SALARY_CASH")
   private String salaryCash;
   //OFFICE_CASH
	@Column(name = "OFFICE_CASH")
   private String officeCash;
   //ASSETS_CASH
	@Column(name = "ASSETS_CASH")
   private String assetsCash;
   //PUBLICITY_CASH
	@Column(name = "PUBLICITY_CASH")
   private String publicityCash;
   //TRAVAL_CASH
	@Column(name = "TRAVAL_CASH")
   private String travalCash;
   //OTHER_CASH
	@Column(name = "OTHER_CASH")
   private String otherCash;
   //MONEY_SUM
	@Column(name = "MONEY_SUM")
   private String moneySum;
   //TOTAL
	@Column(name = "TOTAL")
   private String total;
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
    * getter for MAJOR_ID
    * @generated
    */
   public String getMajorId(){
      return this.majorId;
   }
   /**
    * setter for MAJOR_ID
    * @generated
    */
   public void setMajorId(String majorId){
      this.majorId = majorId;
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
    * getter for SEQUENCE
    * @generated
    */
   public String getSequence(){
      return this.sequence;
   }
   /**
    * setter for SEQUENCE
    * @generated
    */
   public void setSequence(String sequence){
      this.sequence = sequence;
   }

   /**
    * getter for PROJECT_NAME
    * @generated
    */
   public String getProjectName(){
      return this.projectName;
   }
   /**
    * setter for PROJECT_NAME
    * @generated
    */
   public void setProjectName(String projectName){
      this.projectName = projectName;
   }

   /**
    * getter for INCOME
    * @generated
    */
   public String getIncome(){
      return this.income;
   }
   /**
    * setter for INCOME
    * @generated
    */
   public void setIncome(String income){
      this.income = income;
   }

   /**
    * getter for TO_PERSON_CASH
    * @generated
    */
   public String getToPersonCash(){
      return this.toPersonCash;
   }
   /**
    * setter for TO_PERSON_CASH
    * @generated
    */
   public void setToPersonCash(String toPersonCash){
      this.toPersonCash = toPersonCash;
   }

   /**
    * getter for SALARY_CASH
    * @generated
    */
   public String getSalaryCash(){
      return this.salaryCash;
   }
   /**
    * setter for SALARY_CASH
    * @generated
    */
   public void setSalaryCash(String salaryCash){
      this.salaryCash = salaryCash;
   }

   /**
    * getter for OFFICE_CASH
    * @generated
    */
   public String getOfficeCash(){
      return this.officeCash;
   }
   /**
    * setter for OFFICE_CASH
    * @generated
    */
   public void setOfficeCash(String officeCash){
      this.officeCash = officeCash;
   }

   /**
    * getter for ASSETS_CASH
    * @generated
    */
   public String getAssetsCash(){
      return this.assetsCash;
   }
   /**
    * setter for ASSETS_CASH
    * @generated
    */
   public void setAssetsCash(String assetsCash){
      this.assetsCash = assetsCash;
   }

   /**
    * getter for PUBLICITY_CASH
    * @generated
    */
   public String getPublicityCash(){
      return this.publicityCash;
   }
   /**
    * setter for PUBLICITY_CASH
    * @generated
    */
   public void setPublicityCash(String publicityCash){
      this.publicityCash = publicityCash;
   }

   /**
    * getter for TRAVAL_CASH
    * @generated
    */
   public String getTravalCash(){
      return this.travalCash;
   }
   /**
    * setter for TRAVAL_CASH
    * @generated
    */
   public void setTravalCash(String travalCash){
      this.travalCash = travalCash;
   }

   /**
    * getter for OTHER_CASH
    * @generated
    */
   public String getOtherCash(){
      return this.otherCash;
   }
   /**
    * setter for OTHER_CASH
    * @generated
    */
   public void setOtherCash(String otherCash){
      this.otherCash = otherCash;
   }

   /**
    * getter for MONEY_SUM
    * @generated
    */
   public String getMoneySum(){
      return this.moneySum;
   }
   /**
    * setter for MONEY_SUM
    * @generated
    */
   public void setMoneySum(String moneySum){
      this.moneySum = moneySum;
   }

   /**
    * getter for TOTAL
    * @generated
    */
   public String getTotal(){
      return this.total;
   }
   /**
    * setter for TOTAL
    * @generated
    */
   public void setTotal(String total){
      this.total = total;
   }

}