package com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西财务情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_FINANCE" , keyFields = "id")
public class SomJxCheckFinance extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //LAST_TOTAL
	@Column(name = "LAST_TOTAL")
   private String lastTotal;
   //EARNING_TOTAL
	@Column(name = "EARNING_TOTAL")
   private String earningTotal;
   //SERVICE_EARNING
	@Column(name = "SERVICE_EARNING")
   private String serviceEarning;
   //ORGAN_EARNING
	@Column(name = "ORGAN_EARNING")
   private String organEarning;
   //FEE_EARNING
	@Column(name = "FEE_EARNING")
   private String feeEarning;
   //ACCEPT_EARNING
	@Column(name = "ACCEPT_EARNING")
   private String acceptEarning;
   //ASSISTANCE_EARNING
	@Column(name = "ASSISTANCE_EARNING")
   private String assistanceEarning;
   //OTHER_EARNING
	@Column(name = "OTHER_EARNING")
   private String otherEarning;
   //CHARGE_TOTAL
	@Column(name = "CHARGE_TOTAL")
   private String chargeTotal;
   //APPLY_CHARGE
	@Column(name = "APPLY_CHARGE")
   private String applyCharge;
   //COMWEAL_CHARGE
	@Column(name = "COMWEAL_CHARGE")
   private String comwealCharge;
   //MANAGE_CHARGE
	@Column(name = "MANAGE_CHARGE")
   private String manageCharge;
   //PAY_CHARGE
	@Column(name = "PAY_CHARGE")
   private String payCharge;
   //OFFICE_CHARGE
	@Column(name = "OFFICE_CHARGE")
   private String officeCharge;
   //OTHER_CHARGE
	@Column(name = "OTHER_CHARGE")
   private String otherCharge;
   //MANAGE_OTHER_CHARGE
	@Column(name = "MANAGE_OTHER_CHARGE")
   private String manageOtherCharge;
   //NET_TOTAL
	@Column(name = "NET_TOTAL")
   private String netTotal;
   //TAX_TOTAL
	@Column(name = "TAX_TOTAL")
   private String taxTotal;
   //SALES_TAX
	@Column(name = "SALES_TAX")
   private String salesTax;
   //INCOME_TAX
	@Column(name = "INCOME_TAX")
   private String incomeTax;
   //OTHER_TAX
	@Column(name = "OTHER_TAX")
   private String otherTax;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTaskCode() {
		return taskCode;
	}
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}
	public String getLastTotal() {
		return lastTotal;
	}
	public void setLastTotal(String lastTotal) {
		this.lastTotal = lastTotal;
	}
	public String getEarningTotal() {
		return earningTotal;
	}
	public void setEarningTotal(String earningTotal) {
		this.earningTotal = earningTotal;
	}
	public String getServiceEarning() {
		return serviceEarning;
	}
	public void setServiceEarning(String serviceEarning) {
		this.serviceEarning = serviceEarning;
	}
	public String getOrganEarning() {
		return organEarning;
	}
	public void setOrganEarning(String organEarning) {
		this.organEarning = organEarning;
	}
	public String getFeeEarning() {
		return feeEarning;
	}
	public void setFeeEarning(String feeEarning) {
		this.feeEarning = feeEarning;
	}
	public String getAcceptEarning() {
		return acceptEarning;
	}
	public void setAcceptEarning(String acceptEarning) {
		this.acceptEarning = acceptEarning;
	}
	public String getAssistanceEarning() {
		return assistanceEarning;
	}
	public void setAssistanceEarning(String assistanceEarning) {
		this.assistanceEarning = assistanceEarning;
	}
	public String getOtherEarning() {
		return otherEarning;
	}
	public void setOtherEarning(String otherEarning) {
		this.otherEarning = otherEarning;
	}
	public String getChargeTotal() {
		return chargeTotal;
	}
	public void setChargeTotal(String chargeTotal) {
		this.chargeTotal = chargeTotal;
	}
	public String getApplyCharge() {
		return applyCharge;
	}
	public void setApplyCharge(String applyCharge) {
		this.applyCharge = applyCharge;
	}
	public String getComwealCharge() {
		return comwealCharge;
	}
	public void setComwealCharge(String comwealCharge) {
		this.comwealCharge = comwealCharge;
	}
	public String getManageCharge() {
		return manageCharge;
	}
	public void setManageCharge(String manageCharge) {
		this.manageCharge = manageCharge;
	}
	public String getPayCharge() {
		return payCharge;
	}
	public void setPayCharge(String payCharge) {
		this.payCharge = payCharge;
	}
	public String getOfficeCharge() {
		return officeCharge;
	}
	public void setOfficeCharge(String officeCharge) {
		this.officeCharge = officeCharge;
	}
	public String getOtherCharge() {
		return otherCharge;
	}
	public void setOtherCharge(String otherCharge) {
		this.otherCharge = otherCharge;
	}
	public String getManageOtherCharge() {
		return manageOtherCharge;
	}
	public void setManageOtherCharge(String manageOtherCharge) {
		this.manageOtherCharge = manageOtherCharge;
	}
	public String getNetTotal() {
		return netTotal;
	}
	public void setNetTotal(String netTotal) {
		this.netTotal = netTotal;
	}
	public String getTaxTotal() {
		return taxTotal;
	}
	public void setTaxTotal(String taxTotal) {
		this.taxTotal = taxTotal;
	}
	public String getSalesTax() {
		return salesTax;
	}
	public void setSalesTax(String salesTax) {
		this.salesTax = salesTax;
	}
	public String getIncomeTax() {
		return incomeTax;
	}
	public void setIncomeTax(String incomeTax) {
		this.incomeTax = incomeTax;
	}
	public String getOtherTax() {
		return otherTax;
	}
	public void setOtherTax(String otherTax) {
		this.otherTax = otherTax;
	}
 

}