package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealFitProductivepower
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 @Table(tableName = "WEAL_FIT_PRODUCTIVEPOWER" , keyFields = "produceId")
public class WealFitProductivepower extends StatefulDatabean {
   //PRODUCE_ID
   	@Rule(value="require")
	@Column(name = "PRODUCE_ID")
   private String produceId;
   //TASK_CODE
   	@Rule(value="require")
	@Column(name = "TASK_CODE")
   private String taskCode;
   //PRODUCT_CODE
	@Column(name = "PRODUCT_CODE")
   private String productCode;
   //PRODUCT_NAME
	@Column(name = "PRODUCT_NAME")
   private String productName;
   //PRODUCT_NUM
   	@Rule(value="number")
	@Column(name = "PRODUCT_NUM")
   private BigDecimal productNum;
   //PRODUCT_VALUE
   	@Rule(value="number")
	@Column(name = "PRODUCT_VALUE")
   private BigDecimal productValue;
   /**
    * getter for PRODUCE_ID
    * @generated
    */
   public String getProduceId(){
      return this.produceId;
   }
   /**
    * setter for PRODUCE_ID
    * @generated
    */
   public void setProduceId(String produceId){
      this.produceId = produceId;
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
    * getter for PRODUCT_CODE
    * @generated
    */
   public String getProductCode(){
      return this.productCode;
   }
   /**
    * setter for PRODUCT_CODE
    * @generated
    */
   public void setProductCode(String productCode){
      this.productCode = productCode;
   }

   /**
    * getter for PRODUCT_NAME
    * @generated
    */
   public String getProductName(){
      return this.productName;
   }
   /**
    * setter for PRODUCT_NAME
    * @generated
    */
   public void setProductName(String productName){
      this.productName = productName;
   }

   /**
    * getter for PRODUCT_NUM
    * @generated
    */
   public BigDecimal getProductNum(){
      return this.productNum;
   }
   /**
    * setter for PRODUCT_NUM
    * @generated
    */
   public void setProductNum(BigDecimal productNum){
      this.productNum = productNum;
   }

   /**
    * getter for PRODUCT_VALUE
    * @generated
    */
   public BigDecimal getProductValue(){
      return this.productValue;
   }
   /**
    * setter for PRODUCT_VALUE
    * @generated
    */
   public void setProductValue(BigDecimal productValue){
      this.productValue = productValue;
   }

}