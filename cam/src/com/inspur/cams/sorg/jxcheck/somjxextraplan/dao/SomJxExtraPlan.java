package com.inspur.cams.sorg.jxcheck.somjxextraplan.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西特设项目资金和物资使用计划
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_EXTRA_PLAN" , keyFields = "id")
public class SomJxExtraPlan extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //TYPE
	@Column(name = "TYPE")
   private String type;
   //EXPIRY_DATE
	@Column(name = "EXPIRY_DATE")
   private String expiryDate;
   //LEAVE_MONEY
   	@Rule(value="number")
	@Column(name = "LEAVE_MONEY")
   private BigDecimal leaveMoney;
   //LEAVE_GOODS
   	@Rule(value="number")
	@Column(name = "LEAVE_GOODS")
   private BigDecimal leaveGoods;
   //LEAVE_MONEY_TOTAL
   	@Rule(value="number")
	@Column(name = "LEAVE_MONEY_TOTAL")
   private BigDecimal leaveMoneyTotal;
   //LEAVE_GOODS_TOTAL
   	@Rule(value="number")
	@Column(name = "LEAVE_GOODS_TOTAL")
   private BigDecimal leaveGoodsTotal;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //DATE
	@Column(name = "DATE")
   private String date;
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
    * getter for TYPE
    * @generated
    */
   public String getType(){
      return this.type;
   }
   /**
    * setter for TYPE
    * @generated
    */
   public void setType(String type){
      this.type = type;
   }

   /**
    * getter for EXPIRY_DATE
    * @generated
    */
   public String getExpiryDate(){
      return this.expiryDate;
   }
   /**
    * setter for EXPIRY_DATE
    * @generated
    */
   public void setExpiryDate(String expiryDate){
      this.expiryDate = expiryDate;
   }

   /**
    * getter for LEAVE_MONEY
    * @generated
    */
   public BigDecimal getLeaveMoney(){
      return this.leaveMoney;
   }
   /**
    * setter for LEAVE_MONEY
    * @generated
    */
   public void setLeaveMoney(BigDecimal leaveMoney){
      this.leaveMoney = leaveMoney;
   }

   /**
    * getter for LEAVE_GOODS
    * @generated
    */
   public BigDecimal getLeaveGoods(){
      return this.leaveGoods;
   }
   /**
    * setter for LEAVE_GOODS
    * @generated
    */
   public void setLeaveGoods(BigDecimal leaveGoods){
      this.leaveGoods = leaveGoods;
   }

   /**
    * getter for LEAVE_MONEY_TOTAL
    * @generated
    */
   public BigDecimal getLeaveMoneyTotal(){
      return this.leaveMoneyTotal;
   }
   /**
    * setter for LEAVE_MONEY_TOTAL
    * @generated
    */
   public void setLeaveMoneyTotal(BigDecimal leaveMoneyTotal){
      this.leaveMoneyTotal = leaveMoneyTotal;
   }

   /**
    * getter for LEAVE_GOODS_TOTAL
    * @generated
    */
   public BigDecimal getLeaveGoodsTotal(){
      return this.leaveGoodsTotal;
   }
   /**
    * setter for LEAVE_GOODS_TOTAL
    * @generated
    */
   public void setLeaveGoodsTotal(BigDecimal leaveGoodsTotal){
      this.leaveGoodsTotal = leaveGoodsTotal;
   }

   /**
    * getter for LEGAL_PEOPLE
    * @generated
    */
   public String getLegalPeople(){
      return this.legalPeople;
   }
   /**
    * setter for LEGAL_PEOPLE
    * @generated
    */
   public void setLegalPeople(String legalPeople){
      this.legalPeople = legalPeople;
   }

   /**
    * getter for DATE
    * @generated
    */
   public String getDate(){
      return this.date;
   }
   /**
    * setter for DATE
    * @generated
    */
   public void setDate(String date){
      this.date = date;
   }

}