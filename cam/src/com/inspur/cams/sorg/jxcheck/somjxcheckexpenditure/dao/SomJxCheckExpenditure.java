package com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:江西公益支出情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_EXPENDITURE" , keyFields = "id")
public class SomJxCheckExpenditure extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //COMM_LAST_SUM
   
	@Column(name = "COMM_LAST_SUM")
   private String commLastSum;
   //COMM_LAST_TOTAL
   
	@Column(name = "COMM_LAST_TOTAL")
   private String commLastTotal;
   //COMM_EXPENDITURE
   
	@Column(name = "COMM_EXPENDITURE")
   private String commExpenditure;
   //COMM_EXP_PUB
   
	@Column(name = "COMM_EXP_PUB")
   private String commExpPub;
   //COMM_EXP_PER
   
	@Column(name = "COMM_EXP_PER")
   private String commExpPer;
   //COMM_EXP_OFF
   
	@Column(name = "COMM_EXP_OFF")
   private String commExpOff;
   //COMM_EXP_PUB_RATIO
	@Column(name = "COMM_EXP_PUB_RATIO")
   private String commExpPubRatio;
   //EXPENDITURE
   
	@Column(name = "EXPENDITURE")
   private String expenditure;
   //EXP_PUB
   
	@Column(name = "EXP_PUB")
   private String expPub;
   //EXP_PER
   
	@Column(name = "EXP_PER")
   private String expPer;
   //EXP_OFF
   
	@Column(name = "EXP_OFF")
   private String expOff;
   //EXP_PUB_RATIO
	@Column(name = "EXP_PUB_RATIO")
   private String expPubRatio;
   //EXP_PER_RATIO
	@Column(name = "EXP_PER_RATIO")
   private String expPerRatio;
   //COMM_EXP_PER_RATIO
	@Column(name = "COMM_EXP_PER_RATIO")
   private String commExpPerRatio;
   //BALANCE
   
	@Column(name = "BALANCE")
   private String balance;
   //LIMIT_TOTAL
   
	@Column(name = "LIMIT_TOTAL")
   private String limitTotal;
   //LIMIT_EXPLAIN
	@Column(name = "LIMIT_EXPLAIN")
   private String limitExplain;
   //UNLIMIT_TOTAL
   
	@Column(name = "UNLIMIT_TOTAL")
   private String unlimitTotal;
   //UNLIMIT_EXPLAIN
	@Column(name = "UNLIMIT_EXPLAIN")
   private String unlimitExplain;
   //PUB_EXPLAIN
	@Column(name = "PUB_EXPLAIN")
   private String pubExplain;
   //PER_OFF_EXPLAIN
	@Column(name = "PER_OFF_EXPLAIN")
   private String perOffExplain;
   //OTHER_EXPLAIN
	@Column(name = "OTHER_EXPLAIN")
   private String otherExplain;
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
    * getter for COMM_LAST_SUM
    * @generated
    */
   public String getCommLastSum(){
      return this.commLastSum;
   }
   /**
    * setter for COMM_LAST_SUM
    * @generated
    */
   public void setCommLastSum(String commLastSum){
      this.commLastSum = commLastSum;
   }

   /**
    * getter for COMM_LAST_TOTAL
    * @generated
    */
   public String getCommLastTotal(){
      return this.commLastTotal;
   }
   /**
    * setter for COMM_LAST_TOTAL
    * @generated
    */
   public void setCommLastTotal(String commLastTotal){
      this.commLastTotal = commLastTotal;
   }

   /**
    * getter for COMM_EXPENDITURE
    * @generated
    */
   public String getCommExpenditure(){
      return this.commExpenditure;
   }
   /**
    * setter for COMM_EXPENDITURE
    * @generated
    */
   public void setCommExpenditure(String commExpenditure){
      this.commExpenditure = commExpenditure;
   }

   /**
    * getter for COMM_EXP_PUB
    * @generated
    */
   public String getCommExpPub(){
      return this.commExpPub;
   }
   /**
    * setter for COMM_EXP_PUB
    * @generated
    */
   public void setCommExpPub(String commExpPub){
      this.commExpPub = commExpPub;
   }

   /**
    * getter for COMM_EXP_PER
    * @generated
    */
   public String getCommExpPer(){
      return this.commExpPer;
   }
   /**
    * setter for COMM_EXP_PER
    * @generated
    */
   public void setCommExpPer(String commExpPer){
      this.commExpPer = commExpPer;
   }

   /**
    * getter for COMM_EXP_OFF
    * @generated
    */
   public String getCommExpOff(){
      return this.commExpOff;
   }
   /**
    * setter for COMM_EXP_OFF
    * @generated
    */
   public void setCommExpOff(String commExpOff){
      this.commExpOff = commExpOff;
   }

   /**
    * getter for COMM_EXP_PUB_RATIO
    * @generated
    */
   public String getCommExpPubRatio(){
      return this.commExpPubRatio;
   }
   /**
    * setter for COMM_EXP_PUB_RATIO
    * @generated
    */
   public void setCommExpPubRatio(String commExpPubRatio){
      this.commExpPubRatio = commExpPubRatio;
   }

   /**
    * getter for EXPENDITURE
    * @generated
    */
   public String getExpenditure(){
      return this.expenditure;
   }
   /**
    * setter for EXPENDITURE
    * @generated
    */
   public void setExpenditure(String expenditure){
      this.expenditure = expenditure;
   }

   /**
    * getter for EXP_PUB
    * @generated
    */
   public String getExpPub(){
      return this.expPub;
   }
   /**
    * setter for EXP_PUB
    * @generated
    */
   public void setExpPub(String expPub){
      this.expPub = expPub;
   }

   /**
    * getter for EXP_PER
    * @generated
    */
   public String getExpPer(){
      return this.expPer;
   }
   /**
    * setter for EXP_PER
    * @generated
    */
   public void setExpPer(String expPer){
      this.expPer = expPer;
   }

   /**
    * getter for EXP_OFF
    * @generated
    */
   public String getExpOff(){
      return this.expOff;
   }
   /**
    * setter for EXP_OFF
    * @generated
    */
   public void setExpOff(String expOff){
      this.expOff = expOff;
   }

   /**
    * getter for EXP_PUB_RATIO
    * @generated
    */
   public String getExpPubRatio(){
      return this.expPubRatio;
   }
   /**
    * setter for EXP_PUB_RATIO
    * @generated
    */
   public void setExpPubRatio(String expPubRatio){
      this.expPubRatio = expPubRatio;
   }

   /**
    * getter for EXP_PER_RATIO
    * @generated
    */
   public String getExpPerRatio(){
      return this.expPerRatio;
   }
   /**
    * setter for EXP_PER_RATIO
    * @generated
    */
   public void setExpPerRatio(String expPerRatio){
      this.expPerRatio = expPerRatio;
   }

   /**
    * getter for COMM_EXP_PER_RATIO
    * @generated
    */
   public String getCommExpPerRatio(){
      return this.commExpPerRatio;
   }
   /**
    * setter for COMM_EXP_PER_RATIO
    * @generated
    */
   public void setCommExpPerRatio(String commExpPerRatio){
      this.commExpPerRatio = commExpPerRatio;
   }

   /**
    * getter for BALANCE
    * @generated
    */
   public String getBalance(){
      return this.balance;
   }
   /**
    * setter for BALANCE
    * @generated
    */
   public void setBalance(String balance){
      this.balance = balance;
   }

   /**
    * getter for LIMIT_TOTAL
    * @generated
    */
   public String getLimitTotal(){
      return this.limitTotal;
   }
   /**
    * setter for LIMIT_TOTAL
    * @generated
    */
   public void setLimitTotal(String limitTotal){
      this.limitTotal = limitTotal;
   }

   /**
    * getter for LIMIT_EXPLAIN
    * @generated
    */
   public String getLimitExplain(){
      return this.limitExplain;
   }
   /**
    * setter for LIMIT_EXPLAIN
    * @generated
    */
   public void setLimitExplain(String limitExplain){
      this.limitExplain = limitExplain;
   }

   /**
    * getter for UNLIMIT_TOTAL
    * @generated
    */
   public String getUnlimitTotal(){
      return this.unlimitTotal;
   }
   /**
    * setter for UNLIMIT_TOTAL
    * @generated
    */
   public void setUnlimitTotal(String unlimitTotal){
      this.unlimitTotal = unlimitTotal;
   }

   /**
    * getter for UNLIMIT_EXPLAIN
    * @generated
    */
   public String getUnlimitExplain(){
      return this.unlimitExplain;
   }
   /**
    * setter for UNLIMIT_EXPLAIN
    * @generated
    */
   public void setUnlimitExplain(String unlimitExplain){
      this.unlimitExplain = unlimitExplain;
   }

   /**
    * getter for PUB_EXPLAIN
    * @generated
    */
   public String getPubExplain(){
      return this.pubExplain;
   }
   /**
    * setter for PUB_EXPLAIN
    * @generated
    */
   public void setPubExplain(String pubExplain){
      this.pubExplain = pubExplain;
   }

   /**
    * getter for PER_OFF_EXPLAIN
    * @generated
    */
   public String getPerOffExplain(){
      return this.perOffExplain;
   }
   /**
    * setter for PER_OFF_EXPLAIN
    * @generated
    */
   public void setPerOffExplain(String perOffExplain){
      this.perOffExplain = perOffExplain;
   }

   /**
    * getter for OTHER_EXPLAIN
    * @generated
    */
   public String getOtherExplain(){
      return this.otherExplain;
   }
   /**
    * setter for OTHER_EXPLAIN
    * @generated
    */
   public void setOtherExplain(String otherExplain){
      this.otherExplain = otherExplain;
   }

}