package com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西现金流量表
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_CASH_FLOW" , keyFields = "id")
public class SomJxCheckCashFlow extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //REPORT_YEAR
	@Column(name = "REPORT_YEAR")
   private String reportYear;
   //BA_RECEIVE_DONATIONS
   	
	@Column(name = "BA_RECEIVE_DONATIONS")
   private String baReceiveDonations;
   //BA_GATHER_DUES
   	
	@Column(name = "BA_GATHER_DUES")
   private String baGatherDues;
   //BA_RENDER_SERVICES
   	
	@Column(name = "BA_RENDER_SERVICES")
   private String baRenderServices;
   //BA_SELL_PRODUCT
   	
	@Column(name = "BA_SELL_PRODUCT")
   private String baSellProduct;
   //BA_GOVERNMENT_GRANTS
   	
	@Column(name = "BA_GOVERNMENT_GRANTS")
   private String baGovernmentGrants;
   //BA_INFOLW_OTHERS
   	
	@Column(name = "BA_INFOLW_OTHERS")
   private String baInfolwOthers;
   //BA_INFLOW_SUM
   	
	@Column(name = "BA_INFLOW_SUM")
   private String baInflowSum;
   //BA_DONATED_PAY
   	
	@Column(name = "BA_DONATED_PAY")
   private String baDonatedPay;
   //BA_PAY_EMPLOYEE
   	
	@Column(name = "BA_PAY_EMPLOYEE")
   private String baPayEmployee;
   //BA_PRODUCT_SERVICES
   	
	@Column(name = "BA_PRODUCT_SERVICES")
   private String baProductServices;
   //BA_OUTFLOW_OTHERS
   	
	@Column(name = "BA_OUTFLOW_OTHERS")
   private String baOutflowOthers;
   //BA_OUTFLOW_SUM
   	
	@Column(name = "BA_OUTFLOW_SUM")
   private String baOutflowSum;
   //BA_NET_AMOUNT
   	
	@Column(name = "BA_NET_AMOUNT")
   private String baNetAmount;
   //IA_REGOUPING_OUTLAY
   	
	@Column(name = "IA_REGOUPING_OUTLAY")
   private String iaRegoupingOutlay;
   //IA_MADE_INCOME
   	
	@Column(name = "IA_MADE_INCOME")
   private String iaMadeIncome;
   //IA_INFLOW_ASSETS
   	
	@Column(name = "IA_INFLOW_ASSETS")
   private String iaInflowAssets;
   //IA_INFLOW_OTHERS
   	
	@Column(name = "IA_INFLOW_OTHERS")
   private String iaInflowOthers;
   //IA_INFLOW_SUM
   	
	@Column(name = "IA_INFLOW_SUM")
   private String iaInflowSum;
   //IA_OUTFLOW_ASSETS
   	
	@Column(name = "IA_OUTFLOW_ASSETS")
   private String iaOutflowAssets;
   //IA_OUTFLOW_ABROAD
   	
	@Column(name = "IA_OUTFLOW_ABROAD")
   private String iaOutflowAbroad;
   //IA_OUTFLOW_OTHERS
   	
	@Column(name = "IA_OUTFLOW_OTHERS")
   private String iaOutflowOthers;
   //IA_OUTFLOW_SUM
   	
	@Column(name = "IA_OUTFLOW_SUM")
   private String iaOutflowSum;
   //IA_NET_AMOUNT
   	
	@Column(name = "IA_NET_AMOUNT")
   private String iaNetAmount;
   //FA_INFLOW_LOAN
   	
	@Column(name = "FA_INFLOW_LOAN")
   private String faInflowLoan;
   //FA_INFLOW_OTHERS
   	
	@Column(name = "FA_INFLOW_OTHERS")
   private String faInflowOthers;
   //FA_INFLOW_SUM
   	
	@Column(name = "FA_INFLOW_SUM")
   private String faInflowSum;
   //FA_OUTFLOW_DEBT
   	
	@Column(name = "FA_OUTFLOW_DEBT")
   private String faOutflowDebt;
   //FA_OUTFLOW_RATIO
   	
	@Column(name = "FA_OUTFLOW_RATIO")
   private String faOutflowRatio;
   //FA_OUTFLOW_OTHERS
   	
	@Column(name = "FA_OUTFLOW_OTHERS")
   private String faOutflowOthers;
   //FA_OUTFLOW_SUM
   	
	@Column(name = "FA_OUTFLOW_SUM")
   private String faOutflowSum;
   //FA_NET_AMOUNT
   	
	@Column(name = "FA_NET_AMOUNT")
   private String faNetAmount;
   //EXCHANGE_RATE_MOVEMENT
   	
	@Column(name = "EXCHANGE_RATE_MOVEMENT")
   private String exchangeRateMovement;
   //NET_REVALUEATION
   	
	@Column(name = "NET_REVALUEATION")
   private String netRevalueation;
   //ORGANIZATION_UNIT
	@Column(name = "ORGANIZATION_UNIT")
   private String organizationUnit;
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
    * getter for REPORT_YEAR
    * @generated
    */
   public String getReportYear(){
      return this.reportYear;
   }
   /**
    * setter for REPORT_YEAR
    * @generated
    */
   public void setReportYear(String reportYear){
      this.reportYear = reportYear;
   }

   /**
    * getter for BA_RECEIVE_DONATIONS
    * @generated
    */
   public String getBaReceiveDonations(){
      return this.baReceiveDonations;
   }
   /**
    * setter for BA_RECEIVE_DONATIONS
    * @generated
    */
   public void setBaReceiveDonations(String baReceiveDonations){
      this.baReceiveDonations = baReceiveDonations;
   }

   /**
    * getter for BA_GATHER_DUES
    * @generated
    */
   public String getBaGatherDues(){
      return this.baGatherDues;
   }
   /**
    * setter for BA_GATHER_DUES
    * @generated
    */
   public void setBaGatherDues(String baGatherDues){
      this.baGatherDues = baGatherDues;
   }

   /**
    * getter for BA_RENDER_SERVICES
    * @generated
    */
   public String getBaRenderServices(){
      return this.baRenderServices;
   }
   /**
    * setter for BA_RENDER_SERVICES
    * @generated
    */
   public void setBaRenderServices(String baRenderServices){
      this.baRenderServices = baRenderServices;
   }

   /**
    * getter for BA_SELL_PRODUCT
    * @generated
    */
   public String getBaSellProduct(){
      return this.baSellProduct;
   }
   /**
    * setter for BA_SELL_PRODUCT
    * @generated
    */
   public void setBaSellProduct(String baSellProduct){
      this.baSellProduct = baSellProduct;
   }

   /**
    * getter for BA_GOVERNMENT_GRANTS
    * @generated
    */
   public String getBaGovernmentGrants(){
      return this.baGovernmentGrants;
   }
   /**
    * setter for BA_GOVERNMENT_GRANTS
    * @generated
    */
   public void setBaGovernmentGrants(String baGovernmentGrants){
      this.baGovernmentGrants = baGovernmentGrants;
   }

   /**
    * getter for BA_INFOLW_OTHERS
    * @generated
    */
   public String getBaInfolwOthers(){
      return this.baInfolwOthers;
   }
   /**
    * setter for BA_INFOLW_OTHERS
    * @generated
    */
   public void setBaInfolwOthers(String baInfolwOthers){
      this.baInfolwOthers = baInfolwOthers;
   }

   /**
    * getter for BA_INFLOW_SUM
    * @generated
    */
   public String getBaInflowSum(){
      return this.baInflowSum;
   }
   /**
    * setter for BA_INFLOW_SUM
    * @generated
    */
   public void setBaInflowSum(String baInflowSum){
      this.baInflowSum = baInflowSum;
   }

   /**
    * getter for BA_DONATED_PAY
    * @generated
    */
   public String getBaDonatedPay(){
      return this.baDonatedPay;
   }
   /**
    * setter for BA_DONATED_PAY
    * @generated
    */
   public void setBaDonatedPay(String baDonatedPay){
      this.baDonatedPay = baDonatedPay;
   }

   /**
    * getter for BA_PAY_EMPLOYEE
    * @generated
    */
   public String getBaPayEmployee(){
      return this.baPayEmployee;
   }
   /**
    * setter for BA_PAY_EMPLOYEE
    * @generated
    */
   public void setBaPayEmployee(String baPayEmployee){
      this.baPayEmployee = baPayEmployee;
   }

   /**
    * getter for BA_PRODUCT_SERVICES
    * @generated
    */
   public String getBaProductServices(){
      return this.baProductServices;
   }
   /**
    * setter for BA_PRODUCT_SERVICES
    * @generated
    */
   public void setBaProductServices(String baProductServices){
      this.baProductServices = baProductServices;
   }

   /**
    * getter for BA_OUTFLOW_OTHERS
    * @generated
    */
   public String getBaOutflowOthers(){
      return this.baOutflowOthers;
   }
   /**
    * setter for BA_OUTFLOW_OTHERS
    * @generated
    */
   public void setBaOutflowOthers(String baOutflowOthers){
      this.baOutflowOthers = baOutflowOthers;
   }

   /**
    * getter for BA_OUTFLOW_SUM
    * @generated
    */
   public String getBaOutflowSum(){
      return this.baOutflowSum;
   }
   /**
    * setter for BA_OUTFLOW_SUM
    * @generated
    */
   public void setBaOutflowSum(String baOutflowSum){
      this.baOutflowSum = baOutflowSum;
   }

   /**
    * getter for BA_NET_AMOUNT
    * @generated
    */
   public String getBaNetAmount(){
      return this.baNetAmount;
   }
   /**
    * setter for BA_NET_AMOUNT
    * @generated
    */
   public void setBaNetAmount(String baNetAmount){
      this.baNetAmount = baNetAmount;
   }

   /**
    * getter for IA_REGOUPING_OUTLAY
    * @generated
    */
   public String getIaRegoupingOutlay(){
      return this.iaRegoupingOutlay;
   }
   /**
    * setter for IA_REGOUPING_OUTLAY
    * @generated
    */
   public void setIaRegoupingOutlay(String iaRegoupingOutlay){
      this.iaRegoupingOutlay = iaRegoupingOutlay;
   }

   /**
    * getter for IA_MADE_INCOME
    * @generated
    */
   public String getIaMadeIncome(){
      return this.iaMadeIncome;
   }
   /**
    * setter for IA_MADE_INCOME
    * @generated
    */
   public void setIaMadeIncome(String iaMadeIncome){
      this.iaMadeIncome = iaMadeIncome;
   }

   /**
    * getter for IA_INFLOW_ASSETS
    * @generated
    */
   public String getIaInflowAssets(){
      return this.iaInflowAssets;
   }
   /**
    * setter for IA_INFLOW_ASSETS
    * @generated
    */
   public void setIaInflowAssets(String iaInflowAssets){
      this.iaInflowAssets = iaInflowAssets;
   }

   /**
    * getter for IA_INFLOW_OTHERS
    * @generated
    */
   public String getIaInflowOthers(){
      return this.iaInflowOthers;
   }
   /**
    * setter for IA_INFLOW_OTHERS
    * @generated
    */
   public void setIaInflowOthers(String iaInflowOthers){
      this.iaInflowOthers = iaInflowOthers;
   }

   /**
    * getter for IA_INFLOW_SUM
    * @generated
    */
   public String getIaInflowSum(){
      return this.iaInflowSum;
   }
   /**
    * setter for IA_INFLOW_SUM
    * @generated
    */
   public void setIaInflowSum(String iaInflowSum){
      this.iaInflowSum = iaInflowSum;
   }

   /**
    * getter for IA_OUTFLOW_ASSETS
    * @generated
    */
   public String getIaOutflowAssets(){
      return this.iaOutflowAssets;
   }
   /**
    * setter for IA_OUTFLOW_ASSETS
    * @generated
    */
   public void setIaOutflowAssets(String iaOutflowAssets){
      this.iaOutflowAssets = iaOutflowAssets;
   }

   /**
    * getter for IA_OUTFLOW_ABROAD
    * @generated
    */
   public String getIaOutflowAbroad(){
      return this.iaOutflowAbroad;
   }
   /**
    * setter for IA_OUTFLOW_ABROAD
    * @generated
    */
   public void setIaOutflowAbroad(String iaOutflowAbroad){
      this.iaOutflowAbroad = iaOutflowAbroad;
   }

   /**
    * getter for IA_OUTFLOW_OTHERS
    * @generated
    */
   public String getIaOutflowOthers(){
      return this.iaOutflowOthers;
   }
   /**
    * setter for IA_OUTFLOW_OTHERS
    * @generated
    */
   public void setIaOutflowOthers(String iaOutflowOthers){
      this.iaOutflowOthers = iaOutflowOthers;
   }

   /**
    * getter for IA_OUTFLOW_SUM
    * @generated
    */
   public String getIaOutflowSum(){
      return this.iaOutflowSum;
   }
   /**
    * setter for IA_OUTFLOW_SUM
    * @generated
    */
   public void setIaOutflowSum(String iaOutflowSum){
      this.iaOutflowSum = iaOutflowSum;
   }

   /**
    * getter for IA_NET_AMOUNT
    * @generated
    */
   public String getIaNetAmount(){
      return this.iaNetAmount;
   }
   /**
    * setter for IA_NET_AMOUNT
    * @generated
    */
   public void setIaNetAmount(String iaNetAmount){
      this.iaNetAmount = iaNetAmount;
   }

   /**
    * getter for FA_INFLOW_LOAN
    * @generated
    */
   public String getFaInflowLoan(){
      return this.faInflowLoan;
   }
   /**
    * setter for FA_INFLOW_LOAN
    * @generated
    */
   public void setFaInflowLoan(String faInflowLoan){
      this.faInflowLoan = faInflowLoan;
   }

   /**
    * getter for FA_INFLOW_OTHERS
    * @generated
    */
   public String getFaInflowOthers(){
      return this.faInflowOthers;
   }
   /**
    * setter for FA_INFLOW_OTHERS
    * @generated
    */
   public void setFaInflowOthers(String faInflowOthers){
      this.faInflowOthers = faInflowOthers;
   }

   /**
    * getter for FA_INFLOW_SUM
    * @generated
    */
   public String getFaInflowSum(){
      return this.faInflowSum;
   }
   /**
    * setter for FA_INFLOW_SUM
    * @generated
    */
   public void setFaInflowSum(String faInflowSum){
      this.faInflowSum = faInflowSum;
   }

   /**
    * getter for FA_OUTFLOW_DEBT
    * @generated
    */
   public String getFaOutflowDebt(){
      return this.faOutflowDebt;
   }
   /**
    * setter for FA_OUTFLOW_DEBT
    * @generated
    */
   public void setFaOutflowDebt(String faOutflowDebt){
      this.faOutflowDebt = faOutflowDebt;
   }

   /**
    * getter for FA_OUTFLOW_RATIO
    * @generated
    */
   public String getFaOutflowRatio(){
      return this.faOutflowRatio;
   }
   /**
    * setter for FA_OUTFLOW_RATIO
    * @generated
    */
   public void setFaOutflowRatio(String faOutflowRatio){
      this.faOutflowRatio = faOutflowRatio;
   }

   /**
    * getter for FA_OUTFLOW_OTHERS
    * @generated
    */
   public String getFaOutflowOthers(){
      return this.faOutflowOthers;
   }
   /**
    * setter for FA_OUTFLOW_OTHERS
    * @generated
    */
   public void setFaOutflowOthers(String faOutflowOthers){
      this.faOutflowOthers = faOutflowOthers;
   }

   /**
    * getter for FA_OUTFLOW_SUM
    * @generated
    */
   public String getFaOutflowSum(){
      return this.faOutflowSum;
   }
   /**
    * setter for FA_OUTFLOW_SUM
    * @generated
    */
   public void setFaOutflowSum(String faOutflowSum){
      this.faOutflowSum = faOutflowSum;
   }

   /**
    * getter for FA_NET_AMOUNT
    * @generated
    */
   public String getFaNetAmount(){
      return this.faNetAmount;
   }
   /**
    * setter for FA_NET_AMOUNT
    * @generated
    */
   public void setFaNetAmount(String faNetAmount){
      this.faNetAmount = faNetAmount;
   }

   /**
    * getter for EXCHANGE_RATE_MOVEMENT
    * @generated
    */
   public String getExchangeRateMovement(){
      return this.exchangeRateMovement;
   }
   /**
    * setter for EXCHANGE_RATE_MOVEMENT
    * @generated
    */
   public void setExchangeRateMovement(String exchangeRateMovement){
      this.exchangeRateMovement = exchangeRateMovement;
   }

   /**
    * getter for NET_REVALUEATION
    * @generated
    */
   public String getNetRevalueation(){
      return this.netRevalueation;
   }
   /**
    * setter for NET_REVALUEATION
    * @generated
    */
   public void setNetRevalueation(String netRevalueation){
      this.netRevalueation = netRevalueation;
   }

   /**
    * getter for ORGANIZATION_UNIT
    * @generated
    */
   public String getOrganizationUnit(){
      return this.organizationUnit;
   }
   /**
    * setter for ORGANIZATION_UNIT
    * @generated
    */
   public void setOrganizationUnit(String organizationUnit){
      this.organizationUnit = organizationUnit;
   }

}