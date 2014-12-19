package com.inspur.cams.sorg.check.somcheckexpenditure.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckExpenditure
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_EXPENDITURE" , keyFields = "id")
public class SomCheckExpenditure extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //COMM_LAST_SUM
   	@Rule(value="number")
	@Column(name = "COMM_LAST_SUM")
   private BigDecimal commLastSum;
   //COMM_LAST_TOTAL
   	@Rule(value="number")
	@Column(name = "COMM_LAST_TOTAL")
   private BigDecimal commLastTotal;
   //COMM_EXPENDITURE
   	@Rule(value="number")
	@Column(name = "COMM_EXPENDITURE")
   private BigDecimal commExpenditure;
   //COMM_EXP_PUB
   	@Rule(value="number")
	@Column(name = "COMM_EXP_PUB")
   private BigDecimal commExpPub;
   //COMM_EXP_PER
   	@Rule(value="number")
	@Column(name = "COMM_EXP_PER")
   private BigDecimal commExpPer;
   //COMM_EXP_OFF
   	@Rule(value="number")
	@Column(name = "COMM_EXP_OFF")
   private BigDecimal commExpOff;
   //COMM_EXP_PUB_RATIO
	@Column(name = "COMM_EXP_PUB_RATIO")
   private String commExpPubRatio;
   //EXPENDITURE
   	@Rule(value="number")
	@Column(name = "EXPENDITURE")
   private BigDecimal expenditure;
   //EXP_PUB
   	@Rule(value="number")
	@Column(name = "EXP_PUB")
   private BigDecimal expPub;
   //EXP_PER
   	@Rule(value="number")
	@Column(name = "EXP_PER")
   private BigDecimal expPer;
   //EXP_OFF
   	@Rule(value="number")
	@Column(name = "EXP_OFF")
   private BigDecimal expOff;
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
   	@Rule(value="number")
	@Column(name = "BALANCE")
   private BigDecimal balance;
   //LIMIT_TOTAL
   	@Rule(value="number")
	@Column(name = "LIMIT_TOTAL")
   private BigDecimal limitTotal;
   //LIMIT_EXPLAIN
	@Column(name = "LIMIT_EXPLAIN")
   private String limitExplain;
   //UNLIMIT_TOTAL
   	@Rule(value="number")
	@Column(name = "UNLIMIT_TOTAL")
   private BigDecimal unlimitTotal;
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
   public BigDecimal getCommLastSum(){
      return this.commLastSum;
   }
   /**
    * setter for COMM_LAST_SUM
    * @generated
    */
   public void setCommLastSum(BigDecimal commLastSum){
      this.commLastSum = commLastSum;
   }

   /**
    * getter for COMM_LAST_TOTAL
    * @generated
    */
   public BigDecimal getCommLastTotal(){
      return this.commLastTotal;
   }
   /**
    * setter for COMM_LAST_TOTAL
    * @generated
    */
   public void setCommLastTotal(BigDecimal commLastTotal){
      this.commLastTotal = commLastTotal;
   }

   /**
    * getter for COMM_EXPENDITURE
    * @generated
    */
   public BigDecimal getCommExpenditure(){
      return this.commExpenditure;
   }
   /**
    * setter for COMM_EXPENDITURE
    * @generated
    */
   public void setCommExpenditure(BigDecimal commExpenditure){
      this.commExpenditure = commExpenditure;
   }

   /**
    * getter for COMM_EXP_PUB
    * @generated
    */
   public BigDecimal getCommExpPub(){
      return this.commExpPub;
   }
   /**
    * setter for COMM_EXP_PUB
    * @generated
    */
   public void setCommExpPub(BigDecimal commExpPub){
      this.commExpPub = commExpPub;
   }

   /**
    * getter for COMM_EXP_PER
    * @generated
    */
   public BigDecimal getCommExpPer(){
      return this.commExpPer;
   }
   /**
    * setter for COMM_EXP_PER
    * @generated
    */
   public void setCommExpPer(BigDecimal commExpPer){
      this.commExpPer = commExpPer;
   }

   /**
    * getter for COMM_EXP_OFF
    * @generated
    */
   public BigDecimal getCommExpOff(){
      return this.commExpOff;
   }
   /**
    * setter for COMM_EXP_OFF
    * @generated
    */
   public void setCommExpOff(BigDecimal commExpOff){
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
   public BigDecimal getExpenditure(){
      return this.expenditure;
   }
   /**
    * setter for EXPENDITURE
    * @generated
    */
   public void setExpenditure(BigDecimal expenditure){
      this.expenditure = expenditure;
   }

   /**
    * getter for EXP_PUB
    * @generated
    */
   public BigDecimal getExpPub(){
      return this.expPub;
   }
   /**
    * setter for EXP_PUB
    * @generated
    */
   public void setExpPub(BigDecimal expPub){
      this.expPub = expPub;
   }

   /**
    * getter for EXP_PER
    * @generated
    */
   public BigDecimal getExpPer(){
      return this.expPer;
   }
   /**
    * setter for EXP_PER
    * @generated
    */
   public void setExpPer(BigDecimal expPer){
      this.expPer = expPer;
   }

   /**
    * getter for EXP_OFF
    * @generated
    */
   public BigDecimal getExpOff(){
      return this.expOff;
   }
   /**
    * setter for EXP_OFF
    * @generated
    */
   public void setExpOff(BigDecimal expOff){
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
   public BigDecimal getBalance(){
      return this.balance;
   }
   /**
    * setter for BALANCE
    * @generated
    */
   public void setBalance(BigDecimal balance){
      this.balance = balance;
   }

   /**
    * getter for LIMIT_TOTAL
    * @generated
    */
   public BigDecimal getLimitTotal(){
      return this.limitTotal;
   }
   /**
    * setter for LIMIT_TOTAL
    * @generated
    */
   public void setLimitTotal(BigDecimal limitTotal){
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
   public BigDecimal getUnlimitTotal(){
      return this.unlimitTotal;
   }
   /**
    * setter for UNLIMIT_TOTAL
    * @generated
    */
   public void setUnlimitTotal(BigDecimal unlimitTotal){
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