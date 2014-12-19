package com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomJxLargeDonation
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_LARGE_DONATION" , keyFields = "id")
public class SomJxLargeDonation extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //DONOR_NAME
	@Column(name = "DONOR_NAME")
   private String donorName;
   //MONEY_CASH
	@Column(name = "MONEY_CASH")
   private String moneyCash;
   //MONEY_PURPOSE
	@Column(name = "MONEY_PURPOSE")
   private String moneyPurpose;
   //GOODS_CASH
	@Column(name = "GOODS_CASH")
   private String goodsCash;
   //GOODS_PURPOSE
	@Column(name = "GOODS_PURPOSE")
   private String goodsPurpose;
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
    * getter for DONOR_NAME
    * @generated
    */
   public String getDonorName(){
      return this.donorName;
   }
   /**
    * setter for DONOR_NAME
    * @generated
    */
   public void setDonorName(String donorName){
      this.donorName = donorName;
   }

   /**
    * getter for MONEY_CASH
    * @generated
    */
   public String getMoneyCash(){
      return this.moneyCash;
   }
   /**
    * setter for MONEY_CASH
    * @generated
    */
   public void setMoneyCash(String moneyCash){
      this.moneyCash = moneyCash;
   }

   /**
    * getter for MONEY_PURPOSE
    * @generated
    */
   public String getMoneyPurpose(){
      return this.moneyPurpose;
   }
   /**
    * setter for MONEY_PURPOSE
    * @generated
    */
   public void setMoneyPurpose(String moneyPurpose){
      this.moneyPurpose = moneyPurpose;
   }

   /**
    * getter for GOODS_CASH
    * @generated
    */
   public String getGoodsCash(){
      return this.goodsCash;
   }
   /**
    * setter for GOODS_CASH
    * @generated
    */
   public void setGoodsCash(String goodsCash){
      this.goodsCash = goodsCash;
   }

   /**
    * getter for GOODS_PURPOSE
    * @generated
    */
   public String getGoodsPurpose(){
      return this.goodsPurpose;
   }
   /**
    * setter for GOODS_PURPOSE
    * @generated
    */
   public void setGoodsPurpose(String goodsPurpose){
      this.goodsPurpose = goodsPurpose;
   }

}