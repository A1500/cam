package com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西资产负债表
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_BALANCE_SHEET" , keyFields = "id")
public class SomJxCheckBalanceSheet extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //CA_MONEYFUNDS_S
	@Column(name = "CA_MONEYFUNDS_S")
   private String caMoneyfundsS;
   //CA_LIQUID_INVESTMENT_S
	@Column(name = "CA_LIQUID_INVESTMENT_S")
   private String caLiquidInvestmentS;
   //CA_MONEYFUNDS_E
	@Column(name = "CA_MONEYFUNDS_E")
   private String caMoneyfundsE;
   //CA_LIQUID_INVESTMENT_E
	@Column(name = "CA_LIQUID_INVESTMENT_E")
   private String caLiquidInvestmentE;
   //CA_RECEIVABLES_S
	@Column(name = "CA_RECEIVABLES_S")
   private String caReceivablesS;
   //CA_RECEIVABLES_E
	@Column(name = "CA_RECEIVABLES_E")
   private String caReceivablesE;
   //CA_ADVANCE_MONEY_S
	@Column(name = "CA_ADVANCE_MONEY_S")
   private String caAdvanceMoneyS;
   //CA_ADVANCE_MONEY_E
	@Column(name = "CA_ADVANCE_MONEY_E")
   private String caAdvanceMoneyE;
   //CA_INVENTORY_S
	@Column(name = "CA_INVENTORY_S")
   private String caInventoryS;
   //CA_INVENTORY_E
	@Column(name = "CA_INVENTORY_E")
   private String caInventoryE;
   //CA_DEFERRED_EXPENSES_S
	@Column(name = "CA_DEFERRED_EXPENSES_S")
   private String caDeferredExpensesS;
   //CA_DEFERRED_EXPENSES_E
	@Column(name = "CA_DEFERRED_EXPENSES_E")
   private String caDeferredExpensesE;
   //CA_DEBT_INVESTMENTS_S
	@Column(name = "CA_DEBT_INVESTMENTS_S")
   private String caDebtInvestmentsS;
   //CA_DEBT_INVESTMENTS_E
	@Column(name = "CA_DEBT_INVESTMENTS_E")
   private String caDebtInvestmentsE;
   //CA_OTHERS_S
	@Column(name = "CA_OTHERS_S")
   private String caOthersS;
   //CA_SUM_S
	@Column(name = "CA_SUM_S")
   private String caSumS;
   //CL_SHORTTERM_BORROWING_S
	@Column(name = "CL_SHORTTERM_BORROWING_S")
   private String clShorttermBorrowingS;
   //CL_SHORTTERM_BORROWING_E
	@Column(name = "CL_SHORTTERM_BORROWING_E")
   private String clShorttermBorrowingE;
   //CL_DUES_S
	@Column(name = "CL_DUES_S")
   private String clDuesS;
   //CL_DUES_E
	@Column(name = "CL_DUES_E")
   private String clDuesE;
   //CL_ACCRUED_PAYROLLS_S
	@Column(name = "CL_ACCRUED_PAYROLLS_S")
   private String clAccruedPayrollsS;
   //CL_ACCRUED_PAYROLLS_E
	@Column(name = "CL_ACCRUED_PAYROLLS_E")
   private String clAccruedPayrollsE;
   //CL_TAS_PAYABLE_S
	@Column(name = "CL_TAS_PAYABLE_S")
   private String clTasPayableS;
   //CL_TAS_PAYABLE_E
	@Column(name = "CL_TAS_PAYABLE_E")
   private String clTasPayableE;
   //CL_DEPOSIT_RECEIVED_S
	@Column(name = "CL_DEPOSIT_RECEIVED_S")
   private String clDepositReceivedS;
   //CL_DEPOSIT_RECEIVED_E
	@Column(name = "CL_DEPOSIT_RECEIVED_E")
   private String clDepositReceivedE;
   //CL_ACCRUED_EXPENSES_S
	@Column(name = "CL_ACCRUED_EXPENSES_S")
   private String clAccruedExpensesS;
   //CL_ACCRUED_EXPENSES_E
	@Column(name = "CL_ACCRUED_EXPENSES_E")
   private String clAccruedExpensesE;
   //CL_ACCRUED_LIABILITIES_S
	@Column(name = "CL_ACCRUED_LIABILITIES_S")
   private String clAccruedLiabilitiesS;
   //CL_ACCRUED_LIABILITIES_E
	@Column(name = "CL_ACCRUED_LIABILITIES_E")
   private String clAccruedLiabilitiesE;
   //CL_LONGTERM_DUE_S
	@Column(name = "CL_LONGTERM_DUE_S")
   private String clLongtermDueS;
   //CL_LONGTERM_DUE_E
	@Column(name = "CL_LONGTERM_DUE_E")
   private String clLongtermDueE;
   //CL_OTHERS_S
	@Column(name = "CL_OTHERS_S")
   private String clOthersS;
   //CA_OTHERS_E
	@Column(name = "CA_OTHERS_E")
   private String caOthersE;
   //CA_SUM_E
	@Column(name = "CA_SUM_E")
   private String caSumE;
   //CL_OTHERS_E
	@Column(name = "CL_OTHERS_E")
   private String clOthersE;
   //CL_SUM_S
	@Column(name = "CL_SUM_S")
   private String clSumS;
   //CL_SUM_E
	@Column(name = "CL_SUM_E")
   private String clSumE;
   //PI_LONGTERM_EQUITY_INV_S
	@Column(name = "PI_LONGTERM_EQUITY_INV_S")
   private String piLongtermEquityInvS;
   //PI_LONGTERM_EQUITY_INV_E
	@Column(name = "PI_LONGTERM_EQUITY_INV_E")
   private String piLongtermEquityInvE;
   //PI_LONGTERM_DEBT_INV_S
	@Column(name = "PI_LONGTERM_DEBT_INV_S")
   private String piLongtermDebtInvS;
   //PI_LONGTERM_DEBT_INV_E
	@Column(name = "PI_LONGTERM_DEBT_INV_E")
   private String piLongtermDebtInvE;
   //PI_SUM_S
	@Column(name = "PI_SUM_S")
   private String piSumS;
   //PI_SUM_E
	@Column(name = "PI_SUM_E")
   private String piSumE;
   //LL_LONGTERM_LOANS_S
	@Column(name = "LL_LONGTERM_LOANS_S")
   private String llLongtermLoansS;
   //LL_LONGTERM_LOANS_E
	@Column(name = "LL_LONGTERM_LOANS_E")
   private String llLongtermLoansE;
   //LL_LONGTERM_PAYABLE_S
	@Column(name = "LL_LONGTERM_PAYABLE_S")
   private String llLongtermPayableS;
   //LL_LONGTERM_PAYABLE_E
	@Column(name = "LL_LONGTERM_PAYABLE_E")
   private String llLongtermPayableE;
   //LL_OTHERS_S
	@Column(name = "LL_OTHERS_S")
   private String llOthersS;
   //LL_OTHERS_E
	@Column(name = "LL_OTHERS_E")
   private String llOthersE;
   //LL_SUM_S
	@Column(name = "LL_SUM_S")
   private String llSumS;
   //LL_SUM_E
	@Column(name = "LL_SUM_E")
   private String llSumE;
   //FA_PRIME_COST_S
	@Column(name = "FA_PRIME_COST_S")
   private String faPrimeCostS;
   //FA_PRIME_COST_E
	@Column(name = "FA_PRIME_COST_E")
   private String faPrimeCostE;
   //FA_ACCUMULATED_DEPRECIATION_S
	@Column(name = "FA_ACCUMULATED_DEPRECIATION_S")
   private String faAccumulatedDepreciationS;
   //FA_ACCUMULATED_DEPRECIATION_E
	@Column(name = "FA_ACCUMULATED_DEPRECIATION_E")
   private String faAccumulatedDepreciationE;
   //FA_NET_VALUE_S
	@Column(name = "FA_NET_VALUE_S")
   private String faNetValueS;
   //FA_NET_VALUE_E
	@Column(name = "FA_NET_VALUE_E")
   private String faNetValueE;
   //FA_CONSTRUCTION_IN_PROCESS_S
	@Column(name = "FA_CONSTRUCTION_IN_PROCESS_S")
   private String faConstructionInProcessS;
   //FA_CONSTRUCTION_IN_PROCESS_E
	@Column(name = "FA_CONSTRUCTION_IN_PROCESS_E")
   private String faConstructionInProcessE;
   //FA_CULTURAL_HERITAGE_S
	@Column(name = "FA_CULTURAL_HERITAGE_S")
   private String faCulturalHeritageS;
   //FA_CULTURAL_HERITAGE_E
	@Column(name = "FA_CULTURAL_HERITAGE_E")
   private String faCulturalHeritageE;
   //FA_DISPOSAL_FIXED_ASSETS_S
	@Column(name = "FA_DISPOSAL_FIXED_ASSETS_S")
   private String faDisposalFixedAssetsS;
   //FA_DISPOSAL_FIXED_ASSETS_E
	@Column(name = "FA_DISPOSAL_FIXED_ASSETS_E")
   private String faDisposalFixedAssetsE;
   //FA_SUM_S
	@Column(name = "FA_SUM_S")
   private String faSumS;
   //FA_SUM_E
	@Column(name = "FA_SUM_E")
   private String faSumE;
   //PA_DEBT_S
	@Column(name = "PA_DEBT_S")
   private String paDebtS;
   //PA_DEBT_E
	@Column(name = "PA_DEBT_E")
   private String paDebtE;
   //PA_SUM_S
	@Column(name = "PA_SUM_S")
   private String paSumS;
   //PA_SUM_E
	@Column(name = "PA_SUM_E")
   private String paSumE;
   //INTANGIBLE_ASSETS_S
	@Column(name = "INTANGIBLE_ASSETS_S")
   private String intangibleAssetsS;
   //INTANGIBLE_ASSETS_E
	@Column(name = "INTANGIBLE_ASSETS_E")
   private String intangibleAssetsE;
   //ENTRUSTED_AGENT_ASSETS_S
	@Column(name = "ENTRUSTED_AGENT_ASSETS_S")
   private String entrustedAgentAssetsS;
   //ENTRUSTED_AGENT_ASSETS_E
	@Column(name = "ENTRUSTED_AGENT_ASSETS_E")
   private String entrustedAgentAssetsE;
   //ASSETS_SUM_S
	@Column(name = "ASSETS_SUM_S")
   private String assetsSumS;
   //ASSETS_SUM_E
	@Column(name = "ASSETS_SUM_E")
   private String assetsSumE;
   //UNLIMIT_NET_ASSETS_S
	@Column(name = "UNLIMIT_NET_ASSETS_S")
   private String unlimitNetAssetsS;
   //UNLIMIT_NET_ASSETS_E
	@Column(name = "UNLIMIT_NET_ASSETS_E")
   private String unlimitNetAssetsE;
   //LIMIT_NET_ASSETS_S
	@Column(name = "LIMIT_NET_ASSETS_S")
   private String limitNetAssetsS;
   //LIMIT_NET_ASSETS_E
	@Column(name = "LIMIT_NET_ASSETS_E")
   private String limitNetAssetsE;
   //NET_ASSETS_SUM_S
	@Column(name = "NET_ASSETS_SUM_S")
   private String netAssetsSumS;
   //NET_ASSETS_SUM_E
	@Column(name = "NET_ASSETS_SUM_E")
   private String netAssetsSumE;
   //DEBT_ASSETS_SUM_S
	@Column(name = "DEBT_ASSETS_SUM_S")
   private String debtAssetsSumS;
   //DEBT_ASSETS_SUM_E
	@Column(name = "DEBT_ASSETS_SUM_E")
   private String debtAssetsSumE;
   //ORGANIZATION_UNIT
	@Column(name = "ORGANIZATION_UNIT")
   private String organizationUnit;
   //REPORT_DATE
	@Column(name = "REPORT_DATE")
   private String reportDate;
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
    * getter for CA_MONEYFUNDS_S
    * @generated
    */
   public String getCaMoneyfundsS(){
      return this.caMoneyfundsS;
   }
   /**
    * setter for CA_MONEYFUNDS_S
    * @generated
    */
   public void setCaMoneyfundsS(String caMoneyfundsS){
      this.caMoneyfundsS = caMoneyfundsS;
   }

   /**
    * getter for CA_LIQUID_INVESTMENT_S
    * @generated
    */
   public String getCaLiquidInvestmentS(){
      return this.caLiquidInvestmentS;
   }
   /**
    * setter for CA_LIQUID_INVESTMENT_S
    * @generated
    */
   public void setCaLiquidInvestmentS(String caLiquidInvestmentS){
      this.caLiquidInvestmentS = caLiquidInvestmentS;
   }

   /**
    * getter for CA_MONEYFUNDS_E
    * @generated
    */
   public String getCaMoneyfundsE(){
      return this.caMoneyfundsE;
   }
   /**
    * setter for CA_MONEYFUNDS_E
    * @generated
    */
   public void setCaMoneyfundsE(String caMoneyfundsE){
      this.caMoneyfundsE = caMoneyfundsE;
   }

   /**
    * getter for CA_LIQUID_INVESTMENT_E
    * @generated
    */
   public String getCaLiquidInvestmentE(){
      return this.caLiquidInvestmentE;
   }
   /**
    * setter for CA_LIQUID_INVESTMENT_E
    * @generated
    */
   public void setCaLiquidInvestmentE(String caLiquidInvestmentE){
      this.caLiquidInvestmentE = caLiquidInvestmentE;
   }

   /**
    * getter for CA_RECEIVABLES_S
    * @generated
    */
   public String getCaReceivablesS(){
      return this.caReceivablesS;
   }
   /**
    * setter for CA_RECEIVABLES_S
    * @generated
    */
   public void setCaReceivablesS(String caReceivablesS){
      this.caReceivablesS = caReceivablesS;
   }

   /**
    * getter for CA_RECEIVABLES_E
    * @generated
    */
   public String getCaReceivablesE(){
      return this.caReceivablesE;
   }
   /**
    * setter for CA_RECEIVABLES_E
    * @generated
    */
   public void setCaReceivablesE(String caReceivablesE){
      this.caReceivablesE = caReceivablesE;
   }

   /**
    * getter for CA_ADVANCE_MONEY_S
    * @generated
    */
   public String getCaAdvanceMoneyS(){
      return this.caAdvanceMoneyS;
   }
   /**
    * setter for CA_ADVANCE_MONEY_S
    * @generated
    */
   public void setCaAdvanceMoneyS(String caAdvanceMoneyS){
      this.caAdvanceMoneyS = caAdvanceMoneyS;
   }

   /**
    * getter for CA_ADVANCE_MONEY_E
    * @generated
    */
   public String getCaAdvanceMoneyE(){
      return this.caAdvanceMoneyE;
   }
   /**
    * setter for CA_ADVANCE_MONEY_E
    * @generated
    */
   public void setCaAdvanceMoneyE(String caAdvanceMoneyE){
      this.caAdvanceMoneyE = caAdvanceMoneyE;
   }

   /**
    * getter for CA_INVENTORY_S
    * @generated
    */
   public String getCaInventoryS(){
      return this.caInventoryS;
   }
   /**
    * setter for CA_INVENTORY_S
    * @generated
    */
   public void setCaInventoryS(String caInventoryS){
      this.caInventoryS = caInventoryS;
   }

   /**
    * getter for CA_INVENTORY_E
    * @generated
    */
   public String getCaInventoryE(){
      return this.caInventoryE;
   }
   /**
    * setter for CA_INVENTORY_E
    * @generated
    */
   public void setCaInventoryE(String caInventoryE){
      this.caInventoryE = caInventoryE;
   }

   /**
    * getter for CA_DEFERRED_EXPENSES_S
    * @generated
    */
   public String getCaDeferredExpensesS(){
      return this.caDeferredExpensesS;
   }
   /**
    * setter for CA_DEFERRED_EXPENSES_S
    * @generated
    */
   public void setCaDeferredExpensesS(String caDeferredExpensesS){
      this.caDeferredExpensesS = caDeferredExpensesS;
   }

   /**
    * getter for CA_DEFERRED_EXPENSES_E
    * @generated
    */
   public String getCaDeferredExpensesE(){
      return this.caDeferredExpensesE;
   }
   /**
    * setter for CA_DEFERRED_EXPENSES_E
    * @generated
    */
   public void setCaDeferredExpensesE(String caDeferredExpensesE){
      this.caDeferredExpensesE = caDeferredExpensesE;
   }

   /**
    * getter for CA_DEBT_INVESTMENTS_S
    * @generated
    */
   public String getCaDebtInvestmentsS(){
      return this.caDebtInvestmentsS;
   }
   /**
    * setter for CA_DEBT_INVESTMENTS_S
    * @generated
    */
   public void setCaDebtInvestmentsS(String caDebtInvestmentsS){
      this.caDebtInvestmentsS = caDebtInvestmentsS;
   }

   /**
    * getter for CA_DEBT_INVESTMENTS_E
    * @generated
    */
   public String getCaDebtInvestmentsE(){
      return this.caDebtInvestmentsE;
   }
   /**
    * setter for CA_DEBT_INVESTMENTS_E
    * @generated
    */
   public void setCaDebtInvestmentsE(String caDebtInvestmentsE){
      this.caDebtInvestmentsE = caDebtInvestmentsE;
   }

   /**
    * getter for CA_OTHERS_S
    * @generated
    */
   public String getCaOthersS(){
      return this.caOthersS;
   }
   /**
    * setter for CA_OTHERS_S
    * @generated
    */
   public void setCaOthersS(String caOthersS){
      this.caOthersS = caOthersS;
   }

   /**
    * getter for CA_SUM_S
    * @generated
    */
   public String getCaSumS(){
      return this.caSumS;
   }
   /**
    * setter for CA_SUM_S
    * @generated
    */
   public void setCaSumS(String caSumS){
      this.caSumS = caSumS;
   }

   /**
    * getter for CL_SHORTTERM_BORROWING_S
    * @generated
    */
   public String getClShorttermBorrowingS(){
      return this.clShorttermBorrowingS;
   }
   /**
    * setter for CL_SHORTTERM_BORROWING_S
    * @generated
    */
   public void setClShorttermBorrowingS(String clShorttermBorrowingS){
      this.clShorttermBorrowingS = clShorttermBorrowingS;
   }

   /**
    * getter for CL_SHORTTERM_BORROWING_E
    * @generated
    */
   public String getClShorttermBorrowingE(){
      return this.clShorttermBorrowingE;
   }
   /**
    * setter for CL_SHORTTERM_BORROWING_E
    * @generated
    */
   public void setClShorttermBorrowingE(String clShorttermBorrowingE){
      this.clShorttermBorrowingE = clShorttermBorrowingE;
   }

   /**
    * getter for CL_DUES_S
    * @generated
    */
   public String getClDuesS(){
      return this.clDuesS;
   }
   /**
    * setter for CL_DUES_S
    * @generated
    */
   public void setClDuesS(String clDuesS){
      this.clDuesS = clDuesS;
   }

   /**
    * getter for CL_DUES_E
    * @generated
    */
   public String getClDuesE(){
      return this.clDuesE;
   }
   /**
    * setter for CL_DUES_E
    * @generated
    */
   public void setClDuesE(String clDuesE){
      this.clDuesE = clDuesE;
   }

   /**
    * getter for CL_ACCRUED_PAYROLLS_S
    * @generated
    */
   public String getClAccruedPayrollsS(){
      return this.clAccruedPayrollsS;
   }
   /**
    * setter for CL_ACCRUED_PAYROLLS_S
    * @generated
    */
   public void setClAccruedPayrollsS(String clAccruedPayrollsS){
      this.clAccruedPayrollsS = clAccruedPayrollsS;
   }

   /**
    * getter for CL_ACCRUED_PAYROLLS_E
    * @generated
    */
   public String getClAccruedPayrollsE(){
      return this.clAccruedPayrollsE;
   }
   /**
    * setter for CL_ACCRUED_PAYROLLS_E
    * @generated
    */
   public void setClAccruedPayrollsE(String clAccruedPayrollsE){
      this.clAccruedPayrollsE = clAccruedPayrollsE;
   }

   /**
    * getter for CL_TAS_PAYABLE_S
    * @generated
    */
   public String getClTasPayableS(){
      return this.clTasPayableS;
   }
   /**
    * setter for CL_TAS_PAYABLE_S
    * @generated
    */
   public void setClTasPayableS(String clTasPayableS){
      this.clTasPayableS = clTasPayableS;
   }

   /**
    * getter for CL_TAS_PAYABLE_E
    * @generated
    */
   public String getClTasPayableE(){
      return this.clTasPayableE;
   }
   /**
    * setter for CL_TAS_PAYABLE_E
    * @generated
    */
   public void setClTasPayableE(String clTasPayableE){
      this.clTasPayableE = clTasPayableE;
   }

   /**
    * getter for CL_DEPOSIT_RECEIVED_S
    * @generated
    */
   public String getClDepositReceivedS(){
      return this.clDepositReceivedS;
   }
   /**
    * setter for CL_DEPOSIT_RECEIVED_S
    * @generated
    */
   public void setClDepositReceivedS(String clDepositReceivedS){
      this.clDepositReceivedS = clDepositReceivedS;
   }

   /**
    * getter for CL_DEPOSIT_RECEIVED_E
    * @generated
    */
   public String getClDepositReceivedE(){
      return this.clDepositReceivedE;
   }
   /**
    * setter for CL_DEPOSIT_RECEIVED_E
    * @generated
    */
   public void setClDepositReceivedE(String clDepositReceivedE){
      this.clDepositReceivedE = clDepositReceivedE;
   }

   /**
    * getter for CL_ACCRUED_EXPENSES_S
    * @generated
    */
   public String getClAccruedExpensesS(){
      return this.clAccruedExpensesS;
   }
   /**
    * setter for CL_ACCRUED_EXPENSES_S
    * @generated
    */
   public void setClAccruedExpensesS(String clAccruedExpensesS){
      this.clAccruedExpensesS = clAccruedExpensesS;
   }

   /**
    * getter for CL_ACCRUED_EXPENSES_E
    * @generated
    */
   public String getClAccruedExpensesE(){
      return this.clAccruedExpensesE;
   }
   /**
    * setter for CL_ACCRUED_EXPENSES_E
    * @generated
    */
   public void setClAccruedExpensesE(String clAccruedExpensesE){
      this.clAccruedExpensesE = clAccruedExpensesE;
   }

   /**
    * getter for CL_ACCRUED_LIABILITIES_S
    * @generated
    */
   public String getClAccruedLiabilitiesS(){
      return this.clAccruedLiabilitiesS;
   }
   /**
    * setter for CL_ACCRUED_LIABILITIES_S
    * @generated
    */
   public void setClAccruedLiabilitiesS(String clAccruedLiabilitiesS){
      this.clAccruedLiabilitiesS = clAccruedLiabilitiesS;
   }

   /**
    * getter for CL_ACCRUED_LIABILITIES_E
    * @generated
    */
   public String getClAccruedLiabilitiesE(){
      return this.clAccruedLiabilitiesE;
   }
   /**
    * setter for CL_ACCRUED_LIABILITIES_E
    * @generated
    */
   public void setClAccruedLiabilitiesE(String clAccruedLiabilitiesE){
      this.clAccruedLiabilitiesE = clAccruedLiabilitiesE;
   }

   /**
    * getter for CL_LONGTERM_DUE_S
    * @generated
    */
   public String getClLongtermDueS(){
      return this.clLongtermDueS;
   }
   /**
    * setter for CL_LONGTERM_DUE_S
    * @generated
    */
   public void setClLongtermDueS(String clLongtermDueS){
      this.clLongtermDueS = clLongtermDueS;
   }

   /**
    * getter for CL_LONGTERM_DUE_E
    * @generated
    */
   public String getClLongtermDueE(){
      return this.clLongtermDueE;
   }
   /**
    * setter for CL_LONGTERM_DUE_E
    * @generated
    */
   public void setClLongtermDueE(String clLongtermDueE){
      this.clLongtermDueE = clLongtermDueE;
   }

   /**
    * getter for CL_OTHERS_S
    * @generated
    */
   public String getClOthersS(){
      return this.clOthersS;
   }
   /**
    * setter for CL_OTHERS_S
    * @generated
    */
   public void setClOthersS(String clOthersS){
      this.clOthersS = clOthersS;
   }

   /**
    * getter for CA_OTHERS_E
    * @generated
    */
   public String getCaOthersE(){
      return this.caOthersE;
   }
   /**
    * setter for CA_OTHERS_E
    * @generated
    */
   public void setCaOthersE(String caOthersE){
      this.caOthersE = caOthersE;
   }

   /**
    * getter for CA_SUM_E
    * @generated
    */
   public String getCaSumE(){
      return this.caSumE;
   }
   /**
    * setter for CA_SUM_E
    * @generated
    */
   public void setCaSumE(String caSumE){
      this.caSumE = caSumE;
   }

   /**
    * getter for CL_OTHERS_E
    * @generated
    */
   public String getClOthersE(){
      return this.clOthersE;
   }
   /**
    * setter for CL_OTHERS_E
    * @generated
    */
   public void setClOthersE(String clOthersE){
      this.clOthersE = clOthersE;
   }

   /**
    * getter for CL_SUM_S
    * @generated
    */
   public String getClSumS(){
      return this.clSumS;
   }
   /**
    * setter for CL_SUM_S
    * @generated
    */
   public void setClSumS(String clSumS){
      this.clSumS = clSumS;
   }

   /**
    * getter for CL_SUM_E
    * @generated
    */
   public String getClSumE(){
      return this.clSumE;
   }
   /**
    * setter for CL_SUM_E
    * @generated
    */
   public void setClSumE(String clSumE){
      this.clSumE = clSumE;
   }

   /**
    * getter for PI_LONGTERM_EQUITY_INV_S
    * @generated
    */
   public String getPiLongtermEquityInvS(){
      return this.piLongtermEquityInvS;
   }
   /**
    * setter for PI_LONGTERM_EQUITY_INV_S
    * @generated
    */
   public void setPiLongtermEquityInvS(String piLongtermEquityInvS){
      this.piLongtermEquityInvS = piLongtermEquityInvS;
   }

   /**
    * getter for PI_LONGTERM_EQUITY_INV_E
    * @generated
    */
   public String getPiLongtermEquityInvE(){
      return this.piLongtermEquityInvE;
   }
   /**
    * setter for PI_LONGTERM_EQUITY_INV_E
    * @generated
    */
   public void setPiLongtermEquityInvE(String piLongtermEquityInvE){
      this.piLongtermEquityInvE = piLongtermEquityInvE;
   }

   /**
    * getter for PI_LONGTERM_DEBT_INV_S
    * @generated
    */
   public String getPiLongtermDebtInvS(){
      return this.piLongtermDebtInvS;
   }
   /**
    * setter for PI_LONGTERM_DEBT_INV_S
    * @generated
    */
   public void setPiLongtermDebtInvS(String piLongtermDebtInvS){
      this.piLongtermDebtInvS = piLongtermDebtInvS;
   }

   /**
    * getter for PI_LONGTERM_DEBT_INV_E
    * @generated
    */
   public String getPiLongtermDebtInvE(){
      return this.piLongtermDebtInvE;
   }
   /**
    * setter for PI_LONGTERM_DEBT_INV_E
    * @generated
    */
   public void setPiLongtermDebtInvE(String piLongtermDebtInvE){
      this.piLongtermDebtInvE = piLongtermDebtInvE;
   }

   /**
    * getter for PI_SUM_S
    * @generated
    */
   public String getPiSumS(){
      return this.piSumS;
   }
   /**
    * setter for PI_SUM_S
    * @generated
    */
   public void setPiSumS(String piSumS){
      this.piSumS = piSumS;
   }

   /**
    * getter for PI_SUM_E
    * @generated
    */
   public String getPiSumE(){
      return this.piSumE;
   }
   /**
    * setter for PI_SUM_E
    * @generated
    */
   public void setPiSumE(String piSumE){
      this.piSumE = piSumE;
   }

   /**
    * getter for LL_LONGTERM_LOANS_S
    * @generated
    */
   public String getLlLongtermLoansS(){
      return this.llLongtermLoansS;
   }
   /**
    * setter for LL_LONGTERM_LOANS_S
    * @generated
    */
   public void setLlLongtermLoansS(String llLongtermLoansS){
      this.llLongtermLoansS = llLongtermLoansS;
   }

   /**
    * getter for LL_LONGTERM_LOANS_E
    * @generated
    */
   public String getLlLongtermLoansE(){
      return this.llLongtermLoansE;
   }
   /**
    * setter for LL_LONGTERM_LOANS_E
    * @generated
    */
   public void setLlLongtermLoansE(String llLongtermLoansE){
      this.llLongtermLoansE = llLongtermLoansE;
   }

   /**
    * getter for LL_LONGTERM_PAYABLE_S
    * @generated
    */
   public String getLlLongtermPayableS(){
      return this.llLongtermPayableS;
   }
   /**
    * setter for LL_LONGTERM_PAYABLE_S
    * @generated
    */
   public void setLlLongtermPayableS(String llLongtermPayableS){
      this.llLongtermPayableS = llLongtermPayableS;
   }

   /**
    * getter for LL_LONGTERM_PAYABLE_E
    * @generated
    */
   public String getLlLongtermPayableE(){
      return this.llLongtermPayableE;
   }
   /**
    * setter for LL_LONGTERM_PAYABLE_E
    * @generated
    */
   public void setLlLongtermPayableE(String llLongtermPayableE){
      this.llLongtermPayableE = llLongtermPayableE;
   }

   /**
    * getter for LL_OTHERS_S
    * @generated
    */
   public String getLlOthersS(){
      return this.llOthersS;
   }
   /**
    * setter for LL_OTHERS_S
    * @generated
    */
   public void setLlOthersS(String llOthersS){
      this.llOthersS = llOthersS;
   }

   /**
    * getter for LL_OTHERS_E
    * @generated
    */
   public String getLlOthersE(){
      return this.llOthersE;
   }
   /**
    * setter for LL_OTHERS_E
    * @generated
    */
   public void setLlOthersE(String llOthersE){
      this.llOthersE = llOthersE;
   }

   /**
    * getter for LL_SUM_S
    * @generated
    */
   public String getLlSumS(){
      return this.llSumS;
   }
   /**
    * setter for LL_SUM_S
    * @generated
    */
   public void setLlSumS(String llSumS){
      this.llSumS = llSumS;
   }

   /**
    * getter for LL_SUM_E
    * @generated
    */
   public String getLlSumE(){
      return this.llSumE;
   }
   /**
    * setter for LL_SUM_E
    * @generated
    */
   public void setLlSumE(String llSumE){
      this.llSumE = llSumE;
   }

   /**
    * getter for FA_PRIME_COST_S
    * @generated
    */
   public String getFaPrimeCostS(){
      return this.faPrimeCostS;
   }
   /**
    * setter for FA_PRIME_COST_S
    * @generated
    */
   public void setFaPrimeCostS(String faPrimeCostS){
      this.faPrimeCostS = faPrimeCostS;
   }

   /**
    * getter for FA_PRIME_COST_E
    * @generated
    */
   public String getFaPrimeCostE(){
      return this.faPrimeCostE;
   }
   /**
    * setter for FA_PRIME_COST_E
    * @generated
    */
   public void setFaPrimeCostE(String faPrimeCostE){
      this.faPrimeCostE = faPrimeCostE;
   }

   /**
    * getter for FA_ACCUMULATED_DEPRECIATION_S
    * @generated
    */
   public String getFaAccumulatedDepreciationS(){
      return this.faAccumulatedDepreciationS;
   }
   /**
    * setter for FA_ACCUMULATED_DEPRECIATION_S
    * @generated
    */
   public void setFaAccumulatedDepreciationS(String faAccumulatedDepreciationS){
      this.faAccumulatedDepreciationS = faAccumulatedDepreciationS;
   }

   /**
    * getter for FA_ACCUMULATED_DEPRECIATION_E
    * @generated
    */
   public String getFaAccumulatedDepreciationE(){
      return this.faAccumulatedDepreciationE;
   }
   /**
    * setter for FA_ACCUMULATED_DEPRECIATION_E
    * @generated
    */
   public void setFaAccumulatedDepreciationE(String faAccumulatedDepreciationE){
      this.faAccumulatedDepreciationE = faAccumulatedDepreciationE;
   }

   /**
    * getter for FA_NET_VALUE_S
    * @generated
    */
   public String getFaNetValueS(){
      return this.faNetValueS;
   }
   /**
    * setter for FA_NET_VALUE_S
    * @generated
    */
   public void setFaNetValueS(String faNetValueS){
      this.faNetValueS = faNetValueS;
   }

   /**
    * getter for FA_NET_VALUE_E
    * @generated
    */
   public String getFaNetValueE(){
      return this.faNetValueE;
   }
   /**
    * setter for FA_NET_VALUE_E
    * @generated
    */
   public void setFaNetValueE(String faNetValueE){
      this.faNetValueE = faNetValueE;
   }

   /**
    * getter for FA_CONSTRUCTION_IN_PROCESS_S
    * @generated
    */
   public String getFaConstructionInProcessS(){
      return this.faConstructionInProcessS;
   }
   /**
    * setter for FA_CONSTRUCTION_IN_PROCESS_S
    * @generated
    */
   public void setFaConstructionInProcessS(String faConstructionInProcessS){
      this.faConstructionInProcessS = faConstructionInProcessS;
   }

   /**
    * getter for FA_CONSTRUCTION_IN_PROCESS_E
    * @generated
    */
   public String getFaConstructionInProcessE(){
      return this.faConstructionInProcessE;
   }
   /**
    * setter for FA_CONSTRUCTION_IN_PROCESS_E
    * @generated
    */
   public void setFaConstructionInProcessE(String faConstructionInProcessE){
      this.faConstructionInProcessE = faConstructionInProcessE;
   }

   /**
    * getter for FA_CULTURAL_HERITAGE_S
    * @generated
    */
   public String getFaCulturalHeritageS(){
      return this.faCulturalHeritageS;
   }
   /**
    * setter for FA_CULTURAL_HERITAGE_S
    * @generated
    */
   public void setFaCulturalHeritageS(String faCulturalHeritageS){
      this.faCulturalHeritageS = faCulturalHeritageS;
   }

   /**
    * getter for FA_CULTURAL_HERITAGE_E
    * @generated
    */
   public String getFaCulturalHeritageE(){
      return this.faCulturalHeritageE;
   }
   /**
    * setter for FA_CULTURAL_HERITAGE_E
    * @generated
    */
   public void setFaCulturalHeritageE(String faCulturalHeritageE){
      this.faCulturalHeritageE = faCulturalHeritageE;
   }

   /**
    * getter for FA_DISPOSAL_FIXED_ASSETS_S
    * @generated
    */
   public String getFaDisposalFixedAssetsS(){
      return this.faDisposalFixedAssetsS;
   }
   /**
    * setter for FA_DISPOSAL_FIXED_ASSETS_S
    * @generated
    */
   public void setFaDisposalFixedAssetsS(String faDisposalFixedAssetsS){
      this.faDisposalFixedAssetsS = faDisposalFixedAssetsS;
   }

   /**
    * getter for FA_DISPOSAL_FIXED_ASSETS_E
    * @generated
    */
   public String getFaDisposalFixedAssetsE(){
      return this.faDisposalFixedAssetsE;
   }
   /**
    * setter for FA_DISPOSAL_FIXED_ASSETS_E
    * @generated
    */
   public void setFaDisposalFixedAssetsE(String faDisposalFixedAssetsE){
      this.faDisposalFixedAssetsE = faDisposalFixedAssetsE;
   }

   /**
    * getter for FA_SUM_S
    * @generated
    */
   public String getFaSumS(){
      return this.faSumS;
   }
   /**
    * setter for FA_SUM_S
    * @generated
    */
   public void setFaSumS(String faSumS){
      this.faSumS = faSumS;
   }

   /**
    * getter for FA_SUM_E
    * @generated
    */
   public String getFaSumE(){
      return this.faSumE;
   }
   /**
    * setter for FA_SUM_E
    * @generated
    */
   public void setFaSumE(String faSumE){
      this.faSumE = faSumE;
   }

   /**
    * getter for PA_DEBT_S
    * @generated
    */
   public String getPaDebtS(){
      return this.paDebtS;
   }
   /**
    * setter for PA_DEBT_S
    * @generated
    */
   public void setPaDebtS(String paDebtS){
      this.paDebtS = paDebtS;
   }

   /**
    * getter for PA_DEBT_E
    * @generated
    */
   public String getPaDebtE(){
      return this.paDebtE;
   }
   /**
    * setter for PA_DEBT_E
    * @generated
    */
   public void setPaDebtE(String paDebtE){
      this.paDebtE = paDebtE;
   }

   /**
    * getter for PA_SUM_S
    * @generated
    */
   public String getPaSumS(){
      return this.paSumS;
   }
   /**
    * setter for PA_SUM_S
    * @generated
    */
   public void setPaSumS(String paSumS){
      this.paSumS = paSumS;
   }

   /**
    * getter for PA_SUM_E
    * @generated
    */
   public String getPaSumE(){
      return this.paSumE;
   }
   /**
    * setter for PA_SUM_E
    * @generated
    */
   public void setPaSumE(String paSumE){
      this.paSumE = paSumE;
   }

   /**
    * getter for INTANGIBLE_ASSETS_S
    * @generated
    */
   public String getIntangibleAssetsS(){
      return this.intangibleAssetsS;
   }
   /**
    * setter for INTANGIBLE_ASSETS_S
    * @generated
    */
   public void setIntangibleAssetsS(String intangibleAssetsS){
      this.intangibleAssetsS = intangibleAssetsS;
   }

   /**
    * getter for INTANGIBLE_ASSETS_E
    * @generated
    */
   public String getIntangibleAssetsE(){
      return this.intangibleAssetsE;
   }
   /**
    * setter for INTANGIBLE_ASSETS_E
    * @generated
    */
   public void setIntangibleAssetsE(String intangibleAssetsE){
      this.intangibleAssetsE = intangibleAssetsE;
   }

   /**
    * getter for ENTRUSTED_AGENT_ASSETS_S
    * @generated
    */
   public String getEntrustedAgentAssetsS(){
      return this.entrustedAgentAssetsS;
   }
   /**
    * setter for ENTRUSTED_AGENT_ASSETS_S
    * @generated
    */
   public void setEntrustedAgentAssetsS(String entrustedAgentAssetsS){
      this.entrustedAgentAssetsS = entrustedAgentAssetsS;
   }

   /**
    * getter for ENTRUSTED_AGENT_ASSETS_E
    * @generated
    */
   public String getEntrustedAgentAssetsE(){
      return this.entrustedAgentAssetsE;
   }
   /**
    * setter for ENTRUSTED_AGENT_ASSETS_E
    * @generated
    */
   public void setEntrustedAgentAssetsE(String entrustedAgentAssetsE){
      this.entrustedAgentAssetsE = entrustedAgentAssetsE;
   }

   /**
    * getter for ASSETS_SUM_S
    * @generated
    */
   public String getAssetsSumS(){
      return this.assetsSumS;
   }
   /**
    * setter for ASSETS_SUM_S
    * @generated
    */
   public void setAssetsSumS(String assetsSumS){
      this.assetsSumS = assetsSumS;
   }

   /**
    * getter for ASSETS_SUM_E
    * @generated
    */
   public String getAssetsSumE(){
      return this.assetsSumE;
   }
   /**
    * setter for ASSETS_SUM_E
    * @generated
    */
   public void setAssetsSumE(String assetsSumE){
      this.assetsSumE = assetsSumE;
   }

   /**
    * getter for UNLIMIT_NET_ASSETS_S
    * @generated
    */
   public String getUnlimitNetAssetsS(){
      return this.unlimitNetAssetsS;
   }
   /**
    * setter for UNLIMIT_NET_ASSETS_S
    * @generated
    */
   public void setUnlimitNetAssetsS(String unlimitNetAssetsS){
      this.unlimitNetAssetsS = unlimitNetAssetsS;
   }

   /**
    * getter for UNLIMIT_NET_ASSETS_E
    * @generated
    */
   public String getUnlimitNetAssetsE(){
      return this.unlimitNetAssetsE;
   }
   /**
    * setter for UNLIMIT_NET_ASSETS_E
    * @generated
    */
   public void setUnlimitNetAssetsE(String unlimitNetAssetsE){
      this.unlimitNetAssetsE = unlimitNetAssetsE;
   }

   /**
    * getter for LIMIT_NET_ASSETS_S
    * @generated
    */
   public String getLimitNetAssetsS(){
      return this.limitNetAssetsS;
   }
   /**
    * setter for LIMIT_NET_ASSETS_S
    * @generated
    */
   public void setLimitNetAssetsS(String limitNetAssetsS){
      this.limitNetAssetsS = limitNetAssetsS;
   }

   /**
    * getter for LIMIT_NET_ASSETS_E
    * @generated
    */
   public String getLimitNetAssetsE(){
      return this.limitNetAssetsE;
   }
   /**
    * setter for LIMIT_NET_ASSETS_E
    * @generated
    */
   public void setLimitNetAssetsE(String limitNetAssetsE){
      this.limitNetAssetsE = limitNetAssetsE;
   }

   /**
    * getter for NET_ASSETS_SUM_S
    * @generated
    */
   public String getNetAssetsSumS(){
      return this.netAssetsSumS;
   }
   /**
    * setter for NET_ASSETS_SUM_S
    * @generated
    */
   public void setNetAssetsSumS(String netAssetsSumS){
      this.netAssetsSumS = netAssetsSumS;
   }

   /**
    * getter for NET_ASSETS_SUM_E
    * @generated
    */
   public String getNetAssetsSumE(){
      return this.netAssetsSumE;
   }
   /**
    * setter for NET_ASSETS_SUM_E
    * @generated
    */
   public void setNetAssetsSumE(String netAssetsSumE){
      this.netAssetsSumE = netAssetsSumE;
   }

   /**
    * getter for DEBT_ASSETS_SUM_S
    * @generated
    */
   public String getDebtAssetsSumS(){
      return this.debtAssetsSumS;
   }
   /**
    * setter for DEBT_ASSETS_SUM_S
    * @generated
    */
   public void setDebtAssetsSumS(String debtAssetsSumS){
      this.debtAssetsSumS = debtAssetsSumS;
   }

   /**
    * getter for DEBT_ASSETS_SUM_E
    * @generated
    */
   public String getDebtAssetsSumE(){
      return this.debtAssetsSumE;
   }
   /**
    * setter for DEBT_ASSETS_SUM_E
    * @generated
    */
   public void setDebtAssetsSumE(String debtAssetsSumE){
      this.debtAssetsSumE = debtAssetsSumE;
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

   /**
    * getter for REPORT_DATE
    * @generated
    */
   public String getReportDate(){
      return this.reportDate;
   }
   /**
    * setter for REPORT_DATE
    * @generated
    */
   public void setReportDate(String reportDate){
      this.reportDate = reportDate;
   }

}