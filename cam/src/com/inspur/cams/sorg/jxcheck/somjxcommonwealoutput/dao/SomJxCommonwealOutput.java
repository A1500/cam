package com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西特设公益支出情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_COMMONWEAL_OUTPUT" , keyFields = "id")
public class SomJxCommonwealOutput extends StatefulDatabean {
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
   //LAST_SUM
   	@Rule(value="number")
	@Column(name = "LAST_SUM")
   private BigDecimal lastSum;
   //CURRENT_PUB
   	@Rule(value="number")
	@Column(name = "CURRENT_PUB")
   private BigDecimal currentPub;
   //CURRENT_PUB_PER
	@Column(name = "CURRENT_PUB_PER")
   private String currentPubPer;
   //INPUT_MONEY
   	@Rule(value="number")
	@Column(name = "INPUT_MONEY")
   private BigDecimal inputMoney;
   //OUTPUT_MONEY
   	@Rule(value="number")
	@Column(name = "OUTPUT_MONEY")
   private BigDecimal outputMoney;
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
    * getter for LAST_SUM
    * @generated
    */
   public BigDecimal getLastSum(){
      return this.lastSum;
   }
   /**
    * setter for LAST_SUM
    * @generated
    */
   public void setLastSum(BigDecimal lastSum){
      this.lastSum = lastSum;
   }

   /**
    * getter for CURRENT_PUB
    * @generated
    */
   public BigDecimal getCurrentPub(){
      return this.currentPub;
   }
   /**
    * setter for CURRENT_PUB
    * @generated
    */
   public void setCurrentPub(BigDecimal currentPub){
      this.currentPub = currentPub;
   }

   /**
    * getter for CURRENT_PUB_PER
    * @generated
    */
   public String getCurrentPubPer(){
      return this.currentPubPer;
   }
   /**
    * setter for CURRENT_PUB_PER
    * @generated
    */
   public void setCurrentPubPer(String currentPubPer){
      this.currentPubPer = currentPubPer;
   }

   /**
    * getter for INPUT_MONEY
    * @generated
    */
   public BigDecimal getInputMoney(){
      return this.inputMoney;
   }
   /**
    * setter for INPUT_MONEY
    * @generated
    */
   public void setInputMoney(BigDecimal inputMoney){
      this.inputMoney = inputMoney;
   }

   /**
    * getter for OUTPUT_MONEY
    * @generated
    */
   public BigDecimal getOutputMoney(){
      return this.outputMoney;
   }
   /**
    * setter for OUTPUT_MONEY
    * @generated
    */
   public void setOutputMoney(BigDecimal outputMoney){
      this.outputMoney = outputMoney;
   }

}