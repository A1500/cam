package com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西特设项目救灾与灾后重建情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_EXTRA_REBUILD" , keyFields = "id")
public class SomJxExtraRebuild extends StatefulDatabean {
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
   //SELF_MONEY
   	@Rule(value="number")
	@Column(name = "SELF_MONEY")
   private BigDecimal selfMoney;
   //REBUILD_ITEM_NUM
   	@Rule(value="number")
	@Column(name = "REBUILD_ITEM_NUM")
   private BigDecimal rebuildItemNum;
   //ITEM_MONEY
   	@Rule(value="number")
	@Column(name = "ITEM_MONEY")
   private BigDecimal itemMoney;
   //USE_MONEY
   	@Rule(value="number")
	@Column(name = "USE_MONEY")
   private BigDecimal useMoney;
   //LEAVE_MONEY
   	@Rule(value="number")
	@Column(name = "LEAVE_MONEY")
   private BigDecimal leaveMoney;
   //PLAN_MONEY
   	@Rule(value="number")
	@Column(name = "PLAN_MONEY")
   private BigDecimal planMoney;
   //FACT_MONEY
   	@Rule(value="number")
	@Column(name = "FACT_MONEY")
   private BigDecimal factMoney;
   //FACT_MONEY_PER
	@Column(name = "FACT_MONEY_PER")
   private String factMoneyPer;
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
    * getter for SELF_MONEY
    * @generated
    */
   public BigDecimal getSelfMoney(){
      return this.selfMoney;
   }
   /**
    * setter for SELF_MONEY
    * @generated
    */
   public void setSelfMoney(BigDecimal selfMoney){
      this.selfMoney = selfMoney;
   }

   /**
    * getter for REBUILD_ITEM_NUM
    * @generated
    */
   public BigDecimal getRebuildItemNum(){
      return this.rebuildItemNum;
   }
   /**
    * setter for REBUILD_ITEM_NUM
    * @generated
    */
   public void setRebuildItemNum(BigDecimal rebuildItemNum){
      this.rebuildItemNum = rebuildItemNum;
   }


   /**
    * getter for ITEM_MONEY
    * @generated
    */
   public BigDecimal getItemMoney(){
      return this.itemMoney;
   }
   /**
    * setter for ITEM_MONEY
    * @generated
    */
   public void setItemMoney(BigDecimal itemMoney){
      this.itemMoney = itemMoney;
   }

   /**
    * getter for USE_MONEY
    * @generated
    */
   public BigDecimal getUseMoney(){
      return this.useMoney;
   }
   /**
    * setter for USE_MONEY
    * @generated
    */
   public void setUseMoney(BigDecimal useMoney){
      this.useMoney = useMoney;
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
    * getter for PLAN_MONEY
    * @generated
    */
   public BigDecimal getPlanMoney(){
      return this.planMoney;
   }
   /**
    * setter for PLAN_MONEY
    * @generated
    */
   public void setPlanMoney(BigDecimal planMoney){
      this.planMoney = planMoney;
   }

   /**
    * getter for FACT_MONEY
    * @generated
    */
   public BigDecimal getFactMoney(){
      return this.factMoney;
   }
   /**
    * setter for FACT_MONEY
    * @generated
    */
   public void setFactMoney(BigDecimal factMoney){
      this.factMoney = factMoney;
   }

   /**
    * getter for FACT_MONEY_PER
    * @generated
    */
   public String getFactMoneyPer(){
      return this.factMoneyPer;
   }
   /**
    * setter for FACT_MONEY_PER
    * @generated
    */
   public void setFactMoneyPer(String factMoneyPer){
      this.factMoneyPer = factMoneyPer;
   }

}