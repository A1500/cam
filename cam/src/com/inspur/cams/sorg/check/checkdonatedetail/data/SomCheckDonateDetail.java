package com.inspur.cams.sorg.check.checkdonatedetail.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckDonateDetail
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_DONATE_DETAIL" , keyFields = "id")
public class SomCheckDonateDetail extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //IF_PUBLIC_FUND
	@Column(name = "IF_PUBLIC_FUND")
   private String ifPublicFund;
   //HOLD_TIME
	@Column(name = "HOLD_TIME")
   private String holdTime;
   //CASH_TOTAL
	@Column(name = "CASH_TOTAL")
   private String cashTotal;
   //CONVERT_CASH
	@Column(name = "CONVERT_CASH")
   private String convertCash;
   //TOTAL
	@Column(name = "TOTAL")
   private String total;
   //ON_CASH_TOTAL
	@Column(name = "ON_CASH_TOTAL")
   private String onCashTotal;
   //ON_CONVERT_CASH
	@Column(name = "ON_CONVERT_CASH")
   private String onConvertCash;
   //ON_TOTAL
	@Column(name = "ON_TOTAL")
   private String onTotal;
   //ON_PER_CASH_TOTAL
	@Column(name = "ON_PER_CASH_TOTAL")
   private String onPerCashTotal;
   //ON_PER_CONVERT
	@Column(name = "ON_PER_CONVERT")
   private String onPerConvert;
   //ON_PER_TOTAL
	@Column(name = "ON_PER_TOTAL")
   private String onPerTotal;
   //ON_ORG_CASH_TOTAL
	@Column(name = "ON_ORG_CASH_TOTAL")
   private String onOrgCashTotal;
   //ON_ORG_CONVERT
	@Column(name = "ON_ORG_CONVERT")
   private String onOrgConvert;
   //ON_ORG_TOTAL
	@Column(name = "ON_ORG_TOTAL")
   private String onOrgTotal;
   //OFF_CASH_TOTAL
	@Column(name = "OFF_CASH_TOTAL")
   private String offCashTotal;
   //OFF_CONVERT_CASH
	@Column(name = "OFF_CONVERT_CASH")
   private String offConvertCash;
   //OFF_TOTAL
	@Column(name = "OFF_TOTAL")
   private String offTotal;
   //OFF_PER_CASH_TOTAL
	@Column(name = "OFF_PER_CASH_TOTAL")
   private String offPerCashTotal;
   //OFF_PER_CONVERT
	@Column(name = "OFF_PER_CONVERT")
   private String offPerConvert;
   //OFF_PER_TOTAL
	@Column(name = "OFF_PER_TOTAL")
   private String offPerTotal;
   //OFF_ORG_CASH_TOTAL
	@Column(name = "OFF_ORG_CASH_TOTAL")
   private String offOrgCashTotal;
   //OFF_ORG_CONVERT
	@Column(name = "OFF_ORG_CONVERT")
   private String offOrgConvert;
   //OFF_ORG_TOTAL
	@Column(name = "OFF_ORG_TOTAL")
   private String offOrgTotal;
   //USE_DETAIL
	@Column(name = "USE_DETAIL")
   private String useDetail;
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
    * getter for IF_PUBLIC_FUND
    * @generated
    */
   public String getIfPublicFund(){
      return this.ifPublicFund;
   }
   /**
    * setter for IF_PUBLIC_FUND
    * @generated
    */
   public void setIfPublicFund(String ifPublicFund){
      this.ifPublicFund = ifPublicFund;
   }

   /**
    * getter for HOLD_TIME
    * @generated
    */
   public String getHoldTime(){
      return this.holdTime;
   }
   /**
    * setter for HOLD_TIME
    * @generated
    */
   public void setHoldTime(String holdTime){
      this.holdTime = holdTime;
   }

   /**
    * getter for CASH_TOTAL
    * @generated
    */
   public String getCashTotal(){
      return this.cashTotal;
   }
   /**
    * setter for CASH_TOTAL
    * @generated
    */
   public void setCashTotal(String cashTotal){
      this.cashTotal = cashTotal;
   }

   /**
    * getter for CONVERT_CASH
    * @generated
    */
   public String getConvertCash(){
      return this.convertCash;
   }
   /**
    * setter for CONVERT_CASH
    * @generated
    */
   public void setConvertCash(String convertCash){
      this.convertCash = convertCash;
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

   /**
    * getter for ON_CASH_TOTAL
    * @generated
    */
   public String getOnCashTotal(){
      return this.onCashTotal;
   }
   /**
    * setter for ON_CASH_TOTAL
    * @generated
    */
   public void setOnCashTotal(String onCashTotal){
      this.onCashTotal = onCashTotal;
   }

   /**
    * getter for ON_CONVERT_CASH
    * @generated
    */
   public String getOnConvertCash(){
      return this.onConvertCash;
   }
   /**
    * setter for ON_CONVERT_CASH
    * @generated
    */
   public void setOnConvertCash(String onConvertCash){
      this.onConvertCash = onConvertCash;
   }

   /**
    * getter for ON_TOTAL
    * @generated
    */
   public String getOnTotal(){
      return this.onTotal;
   }
   /**
    * setter for ON_TOTAL
    * @generated
    */
   public void setOnTotal(String onTotal){
      this.onTotal = onTotal;
   }

   /**
    * getter for ON_PER_CASH_TOTAL
    * @generated
    */
   public String getOnPerCashTotal(){
      return this.onPerCashTotal;
   }
   /**
    * setter for ON_PER_CASH_TOTAL
    * @generated
    */
   public void setOnPerCashTotal(String onPerCashTotal){
      this.onPerCashTotal = onPerCashTotal;
   }

   /**
    * getter for ON_PER_CONVERT
    * @generated
    */
   public String getOnPerConvert(){
      return this.onPerConvert;
   }
   /**
    * setter for ON_PER_CONVERT
    * @generated
    */
   public void setOnPerConvert(String onPerConvert){
      this.onPerConvert = onPerConvert;
   }

   /**
    * getter for ON_PER_TOTAL
    * @generated
    */
   public String getOnPerTotal(){
      return this.onPerTotal;
   }
   /**
    * setter for ON_PER_TOTAL
    * @generated
    */
   public void setOnPerTotal(String onPerTotal){
      this.onPerTotal = onPerTotal;
   }

   /**
    * getter for ON_ORG_CASH_TOTAL
    * @generated
    */
   public String getOnOrgCashTotal(){
      return this.onOrgCashTotal;
   }
   /**
    * setter for ON_ORG_CASH_TOTAL
    * @generated
    */
   public void setOnOrgCashTotal(String onOrgCashTotal){
      this.onOrgCashTotal = onOrgCashTotal;
   }

   /**
    * getter for ON_ORG_CONVERT
    * @generated
    */
   public String getOnOrgConvert(){
      return this.onOrgConvert;
   }
   /**
    * setter for ON_ORG_CONVERT
    * @generated
    */
   public void setOnOrgConvert(String onOrgConvert){
      this.onOrgConvert = onOrgConvert;
   }

   /**
    * getter for ON_ORG_TOTAL
    * @generated
    */
   public String getOnOrgTotal(){
      return this.onOrgTotal;
   }
   /**
    * setter for ON_ORG_TOTAL
    * @generated
    */
   public void setOnOrgTotal(String onOrgTotal){
      this.onOrgTotal = onOrgTotal;
   }

   /**
    * getter for OFF_CASH_TOTAL
    * @generated
    */
   public String getOffCashTotal(){
      return this.offCashTotal;
   }
   /**
    * setter for OFF_CASH_TOTAL
    * @generated
    */
   public void setOffCashTotal(String offCashTotal){
      this.offCashTotal = offCashTotal;
   }

   /**
    * getter for OFF_CONVERT_CASH
    * @generated
    */
   public String getOffConvertCash(){
      return this.offConvertCash;
   }
   /**
    * setter for OFF_CONVERT_CASH
    * @generated
    */
   public void setOffConvertCash(String offConvertCash){
      this.offConvertCash = offConvertCash;
   }

   /**
    * getter for OFF_TOTAL
    * @generated
    */
   public String getOffTotal(){
      return this.offTotal;
   }
   /**
    * setter for OFF_TOTAL
    * @generated
    */
   public void setOffTotal(String offTotal){
      this.offTotal = offTotal;
   }

   /**
    * getter for OFF_PER_CASH_TOTAL
    * @generated
    */
   public String getOffPerCashTotal(){
      return this.offPerCashTotal;
   }
   /**
    * setter for OFF_PER_CASH_TOTAL
    * @generated
    */
   public void setOffPerCashTotal(String offPerCashTotal){
      this.offPerCashTotal = offPerCashTotal;
   }

   /**
    * getter for OFF_PER_CONVERT
    * @generated
    */
   public String getOffPerConvert(){
      return this.offPerConvert;
   }
   /**
    * setter for OFF_PER_CONVERT
    * @generated
    */
   public void setOffPerConvert(String offPerConvert){
      this.offPerConvert = offPerConvert;
   }

   /**
    * getter for OFF_PER_TOTAL
    * @generated
    */
   public String getOffPerTotal(){
      return this.offPerTotal;
   }
   /**
    * setter for OFF_PER_TOTAL
    * @generated
    */
   public void setOffPerTotal(String offPerTotal){
      this.offPerTotal = offPerTotal;
   }

   /**
    * getter for OFF_ORG_CASH_TOTAL
    * @generated
    */
   public String getOffOrgCashTotal(){
      return this.offOrgCashTotal;
   }
   /**
    * setter for OFF_ORG_CASH_TOTAL
    * @generated
    */
   public void setOffOrgCashTotal(String offOrgCashTotal){
      this.offOrgCashTotal = offOrgCashTotal;
   }

   /**
    * getter for OFF_ORG_CONVERT
    * @generated
    */
   public String getOffOrgConvert(){
      return this.offOrgConvert;
   }
   /**
    * setter for OFF_ORG_CONVERT
    * @generated
    */
   public void setOffOrgConvert(String offOrgConvert){
      this.offOrgConvert = offOrgConvert;
   }

   /**
    * getter for OFF_ORG_TOTAL
    * @generated
    */
   public String getOffOrgTotal(){
      return this.offOrgTotal;
   }
   /**
    * setter for OFF_ORG_TOTAL
    * @generated
    */
   public void setOffOrgTotal(String offOrgTotal){
      this.offOrgTotal = offOrgTotal;
   }

   /**
    * getter for USE_DETAIL
    * @generated
    */
   public String getUseDetail(){
      return this.useDetail;
   }
   /**
    * setter for USE_DETAIL
    * @generated
    */
   public void setUseDetail(String useDetail){
      this.useDetail = useDetail;
   }

}