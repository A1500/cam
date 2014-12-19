package com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title江西业务活动表
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
@Table(tableName = "SOM_JX_CHECK_BUSINESS_ACTIVITY", keyFields = "id")
public class SomJxCheckBusinessActivity extends StatefulDatabean {
	// ID
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// ORGANIZATION_UNIT
	@Column(name = "ORGANIZATION_UNIT")
	private String organizationUnit;
	// REPORT_YEAR
	@Column(name = "REPORT_YEAR")
	private String reportYear;
	// DONATION_INCOME_PY_UNLIMIT

	@Column(name = "DONATION_INCOME_PY_UNLIMIT")
	private String donationIncomePyUnlimit;
	// DONATION_INCOME_PY_LIMIT

	@Column(name = "DONATION_INCOME_PY_LIMIT")
	private String donationIncomePyLimit;
	// DONATION_INCOME_PY_SUM

	@Column(name = "DONATION_INCOME_PY_SUM")
	private String donationIncomePySum;
	// DONATION_INCOME_TY_UNLIMIT

	@Column(name = "DONATION_INCOME_TY_UNLIMIT")
	private String donationIncomeTyUnlimit;
	// DONATION_INCOME_TY_LIMIT

	@Column(name = "DONATION_INCOME_TY_LIMIT")
	private String donationIncomeTyLimit;
	// DONATION_INCOME_TY_SUM

	@Column(name = "DONATION_INCOME_TY_SUM")
	private String donationIncomeTySum;
	// DUES_INCOME_PY_UNLIMIT

	@Column(name = "DUES_INCOME_PY_UNLIMIT")
	private String duesIncomePyUnlimit;
	// DUES_INCOME_PY_LIMIT

	@Column(name = "DUES_INCOME_PY_LIMIT")
	private String duesIncomePyLimit;
	// DUES_INCOME_PY_SUM

	@Column(name = "DUES_INCOME_PY_SUM")
	private String duesIncomePySum;
	// DUES_INCOME_TY_UNLIMIT

	@Column(name = "DUES_INCOME_TY_UNLIMIT")
	private String duesIncomeTyUnlimit;
	// DUES_INCOME_TY_LIMIT

	@Column(name = "DUES_INCOME_TY_LIMIT")
	private String duesIncomeTyLimit;
	// DUES_INCOME_TY_SUM

	@Column(name = "DUES_INCOME_TY_SUM")
	private String duesIncomeTySum;
	// SERVICE_INCOME_PY_UNLIMIT

	@Column(name = "SERVICE_INCOME_PY_UNLIMIT")
	private String serviceIncomePyUnlimit;
	// SERVICE_INCOME_PY_LIMIT

	@Column(name = "SERVICE_INCOME_PY_LIMIT")
	private String serviceIncomePyLimit;
	// SERVICE_INCOME_PY_SUM

	@Column(name = "SERVICE_INCOME_PY_SUM")
	private String serviceIncomePySum;
	// SERVICE_INCOME_TY_UNLIMIT

	@Column(name = "SERVICE_INCOME_TY_UNLIMIT")
	private String serviceIncomeTyUnlimit;
	// SERVICE_INCOME_TY_LIMIT

	@Column(name = "SERVICE_INCOME_TY_LIMIT")
	private String serviceIncomeTyLimit;
	// SERVICE_INCOME_TY_SUM

	@Column(name = "SERVICE_INCOME_TY_SUM")
	private String serviceIncomeTySum;
	// PRODUCT_INCOME_PY_UNLIMIT

	@Column(name = "GOV_BUY_PY_UNLIMIT")
	private String govBuyPyUnlimit;
	// SERVICE_INCOME_PY_LIMIT

	@Column(name = "GOV_BUY_PY_LIMIT")
	private String govBuyPyLimit;
	// SERVICE_INCOME_PY_SUM

	@Column(name = "GOV_BUY_PY_SUM")
	private String govBuyPySum;
	// SERVICE_INCOME_TY_UNLIMIT

	@Column(name = "GOV_BUY_TY_UNLIMIT")
	private String govBuyTyUnlimit;
	// SERVICE_INCOME_TY_LIMIT

	@Column(name = "GOV_BUY_TY_LIMIT")
	private String govBuyTyLimit;
	// SERVICE_INCOME_TY_SUM

	@Column(name = "GOV_BUY_TY_SUM")
	private String govBuyTySum;
	// PRODUCT_INCOME_PY_UNLIMIT

	@Column(name = "PRODUCT_INCOME_PY_UNLIMIT")
	private String productIncomePyUnlimit;
	// PRODUCT_INCOME_PY_LIMIT

	@Column(name = "PRODUCT_INCOME_PY_LIMIT")
	private String productIncomePyLimit;
	// PRODUCT_INCOME_PY_SUM

	@Column(name = "PRODUCT_INCOME_PY_SUM")
	private String productIncomePySum;
	// PRODUCT_INCOME_TY_UNLIMIT

	@Column(name = "PRODUCT_INCOME_TY_UNLIMIT")
	private String productIncomeTyUnlimit;
	// PRODUCT_INCOME_TY_LIMIT

	@Column(name = "PRODUCT_INCOME_TY_LIMIT")
	private String productIncomeTyLimit;
	// PRODUCT_INCOME_TY_SUM

	@Column(name = "PRODUCT_INCOME_TY_SUM")
	private String productIncomeTySum;
	// GOV_GRANTS_PY_UNLIMIT

	@Column(name = "GOV_GRANTS_PY_UNLIMIT")
	private String govGrantsPyUnlimit;
	// GOV_GRANTS_PY_LIMIT

	@Column(name = "GOV_GRANTS_PY_LIMIT")
	private String govGrantsPyLimit;
	// GOV_GRANTS_PY_SUM

	@Column(name = "GOV_GRANTS_PY_SUM")
	private String govGrantsPySum;
	// GOV_GRANTS_TY_UNLIMIT

	@Column(name = "GOV_GRANTS_TY_UNLIMIT")
	private String govGrantsTyUnlimit;
	// GOV_GRANTS_TY_LIMIT

	@Column(name = "GOV_GRANTS_TY_LIMIT")
	private String govGrantsTyLimit;
	// GOV_GRANTS_TY_SUM

	@Column(name = "GOV_GRANTS_TY_SUM")
	private String govGrantsTySum;
	// INV_INCOME_PY_UNLIMIT

	@Column(name = "INV_INCOME_PY_UNLIMIT")
	private String invIncomePyUnlimit;
	// INV_INCOME_PY_LIMIT

	@Column(name = "INV_INCOME_PY_LIMIT")
	private String invIncomePyLimit;
	// INV_INCOME_PY_SUM

	@Column(name = "INV_INCOME_PY_SUM")
	private String invIncomePySum;
	// INV_INCOME_TY_UNLIMIT

	@Column(name = "INV_INCOME_TY_UNLIMIT")
	private String invIncomeTyUnlimit;
	// INV_INCOME_TY_LIMIT

	@Column(name = "INV_INCOME_TY_LIMIT")
	private String invIncomeTyLimit;
	// INV_INCOME_TY_SUM

	@Column(name = "INV_INCOME_TY_SUM")
	private String invIncomeTySum;
	// OTHER_INCOME_PY_UNLIMIT

	@Column(name = "OTHER_INCOME_PY_UNLIMIT")
	private String otherIncomePyUnlimit;
	// OTHER_INCOME_PY_LIMIT

	@Column(name = "OTHER_INCOME_PY_LIMIT")
	private String otherIncomePyLimit;
	// OTHER_INCOME_PY_SUM

	@Column(name = "OTHER_INCOME_PY_SUM")
	private String otherIncomePySum;
	// OTHER_INCOME_TY_UNLIMIT

	@Column(name = "OTHER_INCOME_TY_UNLIMIT")
	private String otherIncomeTyUnlimit;
	// OTHER_INCOME_TY_LIMIT

	@Column(name = "OTHER_INCOME_TY_LIMIT")
	private String otherIncomeTyLimit;
	// OTHER_INCOME_TY_SUM

	@Column(name = "OTHER_INCOME_TY_SUM")
	private String otherIncomeTySum;
	// INCOME_SUM_PY_UNLIMIT

	@Column(name = "INCOME_SUM_PY_UNLIMIT")
	private String incomeSumPyUnlimit;
	// INCOME_SUM_PY_LIMIT

	@Column(name = "INCOME_SUM_PY_LIMIT")
	private String incomeSumPyLimit;
	// INCOME_SUM_PY_SUM

	@Column(name = "INCOME_SUM_PY_SUM")
	private String incomeSumPySum;
	// INCOME_SUM_TY_UNLIMIT

	@Column(name = "INCOME_SUM_TY_UNLIMIT")
	private String incomeSumTyUnlimit;
	// INCOME_SUM_TY_LIMIT

	@Column(name = "INCOME_SUM_TY_LIMIT")
	private String incomeSumTyLimit;
	// INCOME_SUM_TY_SUM

	@Column(name = "INCOME_SUM_TY_SUM")
	private String incomeSumTySum;
	// BUSINESS_COST_PY_UNLIMIT

	@Column(name = "BUSINESS_COST_PY_UNLIMIT")
	private String businessCostPyUnlimit;
	// BUSINESS_COST_PY_LIMIT

	@Column(name = "BUSINESS_COST_PY_LIMIT")
	private String businessCostPyLimit;
	// BUSINESS_COST_PY_SUN

	@Column(name = "BUSINESS_COST_PY_SUN")
	private String businessCostPySun;
	// BUSINESS_COST_TY_UNLIMIT

	@Column(name = "BUSINESS_COST_TY_UNLIMIT")
	private String businessCostTyUnlimit;
	// BUSINESS_COST_TY_LIMIT

	@Column(name = "BUSINESS_COST_TY_LIMIT")
	private String businessCostTyLimit;
	// BUSINESS_COST_TY_SUM

	@Column(name = "BUSINESS_COST_TY_SUM")
	private String businessCostTySum;
	// STAFF_COST_PY_UNLIMIT

	@Column(name = "STAFF_COST_PY_UNLIMIT")
	private String staffCostPyUnlimit;
	// STAFF_COST_PY_LIMIT

	@Column(name = "STAFF_COST_PY_LIMIT")
	private String staffCostPyLimit;
	// STAFF_COST_PY_SUM

	@Column(name = "STAFF_COST_PY_SUM")
	private String staffCostPySum;
	// STAFF_COST_TY_UNLIMIT

	@Column(name = "STAFF_COST_TY_UNLIMIT")
	private String staffCostTyUnlimit;
	// STAFF_COST_TY_LIMIT

	@Column(name = "STAFF_COST_TY_LIMIT")
	private String staffCostTyLimit;
	// STAFF_COST_TY_SUM

	@Column(name = "STAFF_COST_TY_SUM")
	private String staffCostTySum;
	// RUNNING_COST_PY_UNLIMIT

	@Column(name = "RUNNING_COST_PY_UNLIMIT")
	private String runningCostPyUnlimit;
	// RUNNING_COST_PY_LIMIT

	@Column(name = "RUNNING_COST_PY_LIMIT")
	private String runningCostPyLimit;
	// RUNNING_COST_PY_SUM

	@Column(name = "RUNNING_COST_PY_SUM")
	private String runningCostPySum;
	// RUNNING_COST_TY_UNLIMIT

	@Column(name = "RUNNING_COST_TY_UNLIMIT")
	private String runningCostTyUnlimit;
	// RUNNING_COST_TY_LIMIT

	@Column(name = "RUNNING_COST_TY_LIMIT")
	private String runningCostTyLimit;
	// RUNNING_COST_TY_SUM

	@Column(name = "RUNNING_COST_TY_SUM")
	private String runningCostTySum;
	// DEPRECIATION_ASSETS_PY_UNLIMIT

	@Column(name = "DEPRECIATION_ASSETS_PY_UNLIMIT")
	private String depreciationAssetsPyUnlimit;
	// DEPRECIATION_ASSETS_PY_LIMIT

	@Column(name = "DEPRECIATION_ASSETS_PY_LIMIT")
	private String depreciationAssetsPyLimit;
	// DEPRECIATION_ASSETS_PY_SUM

	@Column(name = "DEPRECIATION_ASSETS_PY_SUM")
	private String depreciationAssetsPySum;
	// DEPRECIATION_ASSETS_TY_UNLIMIT

	@Column(name = "DEPRECIATION_ASSETS_TY_UNLIMIT")
	private String depreciationAssetsTyUnlimit;
	// DEPRECIATION_ASSETS_TY_LIMIT

	@Column(name = "DEPRECIATION_ASSETS_TY_LIMIT")
	private String depreciationAssetsTyLimit;
	// DEPRECIATION_ASSETS_TY_SUM

	@Column(name = "DEPRECIATION_ASSETS_TY_SUM")
	private String depreciationAssetsTySum;
	// TAXES_PY_UNLIMIT

	@Column(name = "TAXES_PY_UNLIMIT")
	private String taxesPyUnlimit;
	// TAXES_PY_LIMIT

	@Column(name = "TAXES_PY_LIMIT")
	private String taxesPyLimit;
	// TAXES_PY_SUM

	@Column(name = "TAXES_PY_SUM")
	private String taxesPySum;
	// TAXES_TY_UNLIMIT

	@Column(name = "TAXES_TY_UNLIMIT")
	private String taxesTyUnlimit;
	// TAXES_TY_LIMIT

	@Column(name = "TAXES_TY_LIMIT")
	private String taxesTyLimit;
	// TAXES_TY_SUM

	@Column(name = "TAXES_TY_SUM")
	private String taxesTySum;
	// MANAGE_COST_PY_UNLIMIT

	@Column(name = "MANAGE_COST_PY_UNLIMIT")
	private String manageCostPyUnlimit;
	// MANAGE_COST_PY_LIMIT

	@Column(name = "MANAGE_COST_PY_LIMIT")
	private String manageCostPyLimit;
	// MANAGE_COST_PY_SUM

	@Column(name = "MANAGE_COST_PY_SUM")
	private String manageCostPySum;
	// MANAGE_COST_TY_UNLIMIT

	@Column(name = "MANAGE_COST_TY_UNLIMIT")
	private String manageCostTyUnlimit;
	// MANAGE_COST_TY_LIMIT

	@Column(name = "MANAGE_COST_TY_LIMIT")
	private String manageCostTyLimit;
	// MANAGE_COST_TY_SUMLIMIT2

	@Column(name = "MANAGE_COST_TY_SUM")
	private String manageCostTySum;
	// RAISING_COST_PY_UNLIMIT

	@Column(name = "RAISING_COST_PY_UNLIMIT")
	private String raisingCostPyUnlimit;
	// RAISING_COST_PY_LIMIT

	@Column(name = "RAISING_COST_PY_LIMIT")
	private String raisingCostPyLimit;
	// RAISING_COST_PY_SUM

	@Column(name = "RAISING_COST_PY_SUM")
	private String raisingCostPySum;
	// RAISING_COST_TY_UNLIMIT

	@Column(name = "RAISING_COST_TY_UNLIMIT")
	private String raisingCostTyUnlimit;
	// RAISING_COST_TY_LIMIT

	@Column(name = "RAISING_COST_TY_LIMIT")
	private String raisingCostTyLimit;
	// RAISING_COST_TY_SUM

	@Column(name = "RAISING_COST_TY_SUM")
	private String raisingCostTySum;
	// OTHER_COST_PY_UNLIMIT

	@Column(name = "OTHER_COST_PY_UNLIMIT")
	private String otherCostPyUnlimit;
	// OTHER_COST_PY_LIMIT

	@Column(name = "OTHER_COST_PY_LIMIT")
	private String otherCostPyLimit;
	// OTHER_COST_PY_SUM

	@Column(name = "OTHER_COST_PY_SUM")
	private String otherCostPySum;
	// OTHER_COST_TY_UNLIMIT

	@Column(name = "OTHER_COST_TY_UNLIMIT")
	private String otherCostTyUnlimit;
	// OTHER_COST_TY_LIMIT

	@Column(name = "OTHER_COST_TY_LIMIT")
	private String otherCostTyLimit;
	// OTHER_COST_TY_SUM

	@Column(name = "OTHER_COST_TY_SUM")
	private String otherCostTySum;
	// COST_SUM_PY_UNLIMIT

	@Column(name = "COST_SUM_PY_UNLIMIT")
	private String costSumPyUnlimit;
	// COST_SUM_PY_LIMIT

	@Column(name = "COST_SUM_PY_LIMIT")
	private String costSumPyLimit;
	// COST_SUM_PY_SUM

	@Column(name = "COST_SUM_PY_SUM")
	private String costSumPySum;
	// COST_SUM_TY_UNLIMIT

	@Column(name = "COST_SUM_TY_UNLIMIT")
	private String costSumTyUnlimit;
	// COST_SUM_TY_LIMIT

	@Column(name = "COST_SUM_TY_LIMIT")
	private String costSumTyLimit;
	// COST_SUM_TY_SUM

	@Column(name = "COST_SUM_TY_SUM")
	private String costSumTySum;
	// LIMIT_TO_UNLIMIT_PY_UNLIMT

	@Column(name = "LIMIT_TO_UNLIMIT_PY_UNLIMT")
	private String limitToUnlimitPyUnlimt;
	// LIMIT_TO_UNLIMIT_PY_LIMIT

	@Column(name = "LIMIT_TO_UNLIMIT_PY_LIMIT")
	private String limitToUnlimitPyLimit;
	// LIMIT_TO_UNLIMIT_PY_SUM

	@Column(name = "LIMIT_TO_UNLIMIT_PY_SUM")
	private String limitToUnlimitPySum;
	// LIMIT_TO_UNLIMIT_TY_UNLIMIT

	@Column(name = "LIMIT_TO_UNLIMIT_TY_UNLIMIT")
	private String limitToUnlimitTyUnlimit;
	// LIMIT_TO_UNLIMIT_TY_LIMIT

	@Column(name = "LIMIT_TO_UNLIMIT_TY_LIMIT")
	private String limitToUnlimitTyLimit;
	// LIMIT_TO_UNLIMIT_TY_SUM

	@Column(name = "LIMIT_TO_UNLIMIT_TY_SUM")
	private String limitToUnlimitTySum;
	// ASSETS_CHANGE_PY_UNLIMIT

	@Column(name = "ASSETS_CHANGE_PY_UNLIMIT")
	private String assetsChangePyUnlimit;
	// ASSETS_CHANGE_PY_LIMIT

	@Column(name = "ASSETS_CHANGE_PY_LIMIT")
	private String assetsChangePyLimit;
	// ASSETS_CHANGE_PY_SUM

	@Column(name = "ASSETS_CHANGE_PY_SUM")
	private String assetsChangePySum;
	// ASSETS_CHANGE_TY_UNLIMIT

	@Column(name = "ASSETS_CHANGE_TY_UNLIMIT")
	private String assetsChangeTyUnlimit;
	// ASSETS_CHANGE_TY_LIMIT

	@Column(name = "ASSETS_CHANGE_TY_LIMIT")
	private String assetsChangeTyLimit;
	// ASSETS_CHANGE_TY_SUM

	@Column(name = "ASSETS_CHANGE_TY_SUM")
	private String assetsChangeTySum;
	// REMAINING_BALANCE_TY

	@Column(name = "REMAINING_BALANCE_TY")
	private String remainingBalanceTy;

	// PUBLIC_WELFARRE_PY_UNLIMIT
	@Column(name = "PUBLIC_WELFARRE_PY_UNLIMIT")
	private String publicWelfarrePyUnlimit;
	// PUBLIC_WELFARRE_PY_LIMIT
	@Column(name = "PUBLIC_WELFARRE_PY_LIMIT")
	private String publicWelfarrePyLimit;
	// PUBLIC_WELFARRE_PY_SUN
	@Column(name = "PUBLIC_WELFARRE_PY_SUN")
	private String publicWelfarrePySum;
	// PUBLIC_WELFARRE_TY_UNLIMIT
	@Column(name = "PUBLIC_WELFARRE_TY_UNLIMIT")
	private String publicWelfarreTyUnlimit;
	// PUBLIC_WELFARRE_TY_LIMIT
	@Column(name = "PUBLIC_WELFARRE_TY_LIMIT")
	private String publicWelfarreTyLimit;
	// PUBLIC_WELFARRE_TY_SUM
	@Column(name = "PUBLIC_WELFARRE_TY_SUM")
	private String publicWelfarreTySum;

	/**
	 * getter for ID
	 * 
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for ID
	 * 
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for TASK_CODE
	 * 
	 * @generated
	 */
	public String getTaskCode() {
		return this.taskCode;
	}

	/**
	 * setter for TASK_CODE
	 * 
	 * @generated
	 */
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	/**
	 * getter for ORGANIZATION_UNIT
	 * 
	 * @generated
	 */
	public String getOrganizationUnit() {
		return this.organizationUnit;
	}

	/**
	 * setter for ORGANIZATION_UNIT
	 * 
	 * @generated
	 */
	public void setOrganizationUnit(String organizationUnit) {
		this.organizationUnit = organizationUnit;
	}

	/**
	 * getter for REPORT_YEAR
	 * 
	 * @generated
	 */
	public String getReportYear() {
		return this.reportYear;
	}

	/**
	 * setter for REPORT_YEAR
	 * 
	 * @generated
	 */
	public void setReportYear(String reportYear) {
		this.reportYear = reportYear;
	}

	/**
	 * getter for DONATION_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getDonationIncomePyUnlimit() {
		return this.donationIncomePyUnlimit;
	}

	/**
	 * setter for DONATION_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setDonationIncomePyUnlimit(String donationIncomePyUnlimit) {
		this.donationIncomePyUnlimit = donationIncomePyUnlimit;
	}

	/**
	 * getter for DONATION_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getDonationIncomePyLimit() {
		return this.donationIncomePyLimit;
	}

	/**
	 * setter for DONATION_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setDonationIncomePyLimit(String donationIncomePyLimit) {
		this.donationIncomePyLimit = donationIncomePyLimit;
	}

	/**
	 * getter for DONATION_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public String getDonationIncomePySum() {
		return this.donationIncomePySum;
	}

	/**
	 * setter for DONATION_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public void setDonationIncomePySum(String donationIncomePySum) {
		this.donationIncomePySum = donationIncomePySum;
	}

	/**
	 * getter for DONATION_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getDonationIncomeTyUnlimit() {
		return this.donationIncomeTyUnlimit;
	}

	/**
	 * setter for DONATION_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setDonationIncomeTyUnlimit(String donationIncomeTyUnlimit) {
		this.donationIncomeTyUnlimit = donationIncomeTyUnlimit;
	}

	/**
	 * getter for DONATION_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getDonationIncomeTyLimit() {
		return this.donationIncomeTyLimit;
	}

	/**
	 * setter for DONATION_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setDonationIncomeTyLimit(String donationIncomeTyLimit) {
		this.donationIncomeTyLimit = donationIncomeTyLimit;
	}

	/**
	 * getter for DONATION_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public String getDonationIncomeTySum() {
		return this.donationIncomeTySum;
	}

	/**
	 * setter for DONATION_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public void setDonationIncomeTySum(String donationIncomeTySum) {
		this.donationIncomeTySum = donationIncomeTySum;
	}

	/**
	 * getter for DUES_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getDuesIncomePyUnlimit() {
		return this.duesIncomePyUnlimit;
	}

	/**
	 * setter for DUES_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setDuesIncomePyUnlimit(String duesIncomePyUnlimit) {
		this.duesIncomePyUnlimit = duesIncomePyUnlimit;
	}

	/**
	 * getter for DUES_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getDuesIncomePyLimit() {
		return this.duesIncomePyLimit;
	}

	/**
	 * setter for DUES_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setDuesIncomePyLimit(String duesIncomePyLimit) {
		this.duesIncomePyLimit = duesIncomePyLimit;
	}

	/**
	 * getter for DUES_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public String getDuesIncomePySum() {
		return this.duesIncomePySum;
	}

	/**
	 * setter for DUES_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public void setDuesIncomePySum(String duesIncomePySum) {
		this.duesIncomePySum = duesIncomePySum;
	}

	/**
	 * getter for DUES_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getDuesIncomeTyUnlimit() {
		return this.duesIncomeTyUnlimit;
	}

	/**
	 * setter for DUES_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setDuesIncomeTyUnlimit(String duesIncomeTyUnlimit) {
		this.duesIncomeTyUnlimit = duesIncomeTyUnlimit;
	}

	/**
	 * getter for DUES_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getDuesIncomeTyLimit() {
		return this.duesIncomeTyLimit;
	}

	/**
	 * setter for DUES_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setDuesIncomeTyLimit(String duesIncomeTyLimit) {
		this.duesIncomeTyLimit = duesIncomeTyLimit;
	}

	/**
	 * getter for DUES_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public String getDuesIncomeTySum() {
		return this.duesIncomeTySum;
	}

	/**
	 * setter for DUES_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public void setDuesIncomeTySum(String duesIncomeTySum) {
		this.duesIncomeTySum = duesIncomeTySum;
	}

	/**
	 * getter for SERVICE_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getServiceIncomePyUnlimit() {
		return this.serviceIncomePyUnlimit;
	}

	/**
	 * setter for SERVICE_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setServiceIncomePyUnlimit(String serviceIncomePyUnlimit) {
		this.serviceIncomePyUnlimit = serviceIncomePyUnlimit;
	}

	/**
	 * getter for SERVICE_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getServiceIncomePyLimit() {
		return this.serviceIncomePyLimit;
	}

	/**
	 * setter for SERVICE_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setServiceIncomePyLimit(String serviceIncomePyLimit) {
		this.serviceIncomePyLimit = serviceIncomePyLimit;
	}

	/**
	 * getter for SERVICE_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public String getServiceIncomePySum() {
		return this.serviceIncomePySum;
	}

	/**
	 * setter for SERVICE_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public void setServiceIncomePySum(String serviceIncomePySum) {
		this.serviceIncomePySum = serviceIncomePySum;
	}

	/**
	 * getter for SERVICE_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getServiceIncomeTyUnlimit() {
		return this.serviceIncomeTyUnlimit;
	}

	/**
	 * setter for SERVICE_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setServiceIncomeTyUnlimit(String serviceIncomeTyUnlimit) {
		this.serviceIncomeTyUnlimit = serviceIncomeTyUnlimit;
	}

	/**
	 * getter for SERVICE_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getServiceIncomeTyLimit() {
		return this.serviceIncomeTyLimit;
	}

	/**
	 * setter for SERVICE_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setServiceIncomeTyLimit(String serviceIncomeTyLimit) {
		this.serviceIncomeTyLimit = serviceIncomeTyLimit;
	}

	/**
	 * getter for SERVICE_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public String getServiceIncomeTySum() {
		return this.serviceIncomeTySum;
	}

	/**
	 * setter for SERVICE_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public void setServiceIncomeTySum(String serviceIncomeTySum) {
		this.serviceIncomeTySum = serviceIncomeTySum;
	}

	/**
	 * getter for PRODUCT_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getProductIncomePyUnlimit() {
		return this.productIncomePyUnlimit;
	}

	/**
	 * setter for PRODUCT_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setProductIncomePyUnlimit(String productIncomePyUnlimit) {
		this.productIncomePyUnlimit = productIncomePyUnlimit;
	}

	/**
	 * getter for PRODUCT_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getProductIncomePyLimit() {
		return this.productIncomePyLimit;
	}

	/**
	 * setter for PRODUCT_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setProductIncomePyLimit(String productIncomePyLimit) {
		this.productIncomePyLimit = productIncomePyLimit;
	}

	/**
	 * getter for PRODUCT_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public String getProductIncomePySum() {
		return this.productIncomePySum;
	}

	/**
	 * setter for PRODUCT_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public void setProductIncomePySum(String productIncomePySum) {
		this.productIncomePySum = productIncomePySum;
	}

	/**
	 * getter for PRODUCT_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getProductIncomeTyUnlimit() {
		return this.productIncomeTyUnlimit;
	}

	/**
	 * setter for PRODUCT_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setProductIncomeTyUnlimit(String productIncomeTyUnlimit) {
		this.productIncomeTyUnlimit = productIncomeTyUnlimit;
	}

	/**
	 * getter for PRODUCT_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getProductIncomeTyLimit() {
		return this.productIncomeTyLimit;
	}

	/**
	 * setter for PRODUCT_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setProductIncomeTyLimit(String productIncomeTyLimit) {
		this.productIncomeTyLimit = productIncomeTyLimit;
	}

	/**
	 * getter for PRODUCT_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public String getProductIncomeTySum() {
		return this.productIncomeTySum;
	}

	/**
	 * setter for PRODUCT_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public void setProductIncomeTySum(String productIncomeTySum) {
		this.productIncomeTySum = productIncomeTySum;
	}

	/**
	 * getter for GOV_GRANTS_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getGovGrantsPyUnlimit() {
		return this.govGrantsPyUnlimit;
	}

	/**
	 * setter for GOV_GRANTS_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setGovGrantsPyUnlimit(String govGrantsPyUnlimit) {
		this.govGrantsPyUnlimit = govGrantsPyUnlimit;
	}

	/**
	 * getter for GOV_GRANTS_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getGovGrantsPyLimit() {
		return this.govGrantsPyLimit;
	}

	/**
	 * setter for GOV_GRANTS_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setGovGrantsPyLimit(String govGrantsPyLimit) {
		this.govGrantsPyLimit = govGrantsPyLimit;
	}

	/**
	 * getter for GOV_GRANTS_PY_SUM
	 * 
	 * @generated
	 */
	public String getGovGrantsPySum() {
		return this.govGrantsPySum;
	}

	/**
	 * setter for GOV_GRANTS_PY_SUM
	 * 
	 * @generated
	 */
	public void setGovGrantsPySum(String govGrantsPySum) {
		this.govGrantsPySum = govGrantsPySum;
	}

	/**
	 * getter for GOV_GRANTS_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getGovGrantsTyUnlimit() {
		return this.govGrantsTyUnlimit;
	}

	/**
	 * setter for GOV_GRANTS_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setGovGrantsTyUnlimit(String govGrantsTyUnlimit) {
		this.govGrantsTyUnlimit = govGrantsTyUnlimit;
	}

	/**
	 * getter for GOV_GRANTS_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getGovGrantsTyLimit() {
		return this.govGrantsTyLimit;
	}

	/**
	 * setter for GOV_GRANTS_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setGovGrantsTyLimit(String govGrantsTyLimit) {
		this.govGrantsTyLimit = govGrantsTyLimit;
	}

	/**
	 * getter for GOV_GRANTS_TY_SUM
	 * 
	 * @generated
	 */
	public String getGovGrantsTySum() {
		return this.govGrantsTySum;
	}

	/**
	 * setter for GOV_GRANTS_TY_SUM
	 * 
	 * @generated
	 */
	public void setGovGrantsTySum(String govGrantsTySum) {
		this.govGrantsTySum = govGrantsTySum;
	}

	/**
	 * getter for INV_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getInvIncomePyUnlimit() {
		return this.invIncomePyUnlimit;
	}

	/**
	 * setter for INV_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setInvIncomePyUnlimit(String invIncomePyUnlimit) {
		this.invIncomePyUnlimit = invIncomePyUnlimit;
	}

	/**
	 * getter for INV_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getInvIncomePyLimit() {
		return this.invIncomePyLimit;
	}

	/**
	 * setter for INV_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setInvIncomePyLimit(String invIncomePyLimit) {
		this.invIncomePyLimit = invIncomePyLimit;
	}

	/**
	 * getter for INV_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public String getInvIncomePySum() {
		return this.invIncomePySum;
	}

	/**
	 * setter for INV_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public void setInvIncomePySum(String invIncomePySum) {
		this.invIncomePySum = invIncomePySum;
	}

	/**
	 * getter for INV_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getInvIncomeTyUnlimit() {
		return this.invIncomeTyUnlimit;
	}

	/**
	 * setter for INV_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setInvIncomeTyUnlimit(String invIncomeTyUnlimit) {
		this.invIncomeTyUnlimit = invIncomeTyUnlimit;
	}

	/**
	 * getter for INV_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getInvIncomeTyLimit() {
		return this.invIncomeTyLimit;
	}

	/**
	 * setter for INV_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setInvIncomeTyLimit(String invIncomeTyLimit) {
		this.invIncomeTyLimit = invIncomeTyLimit;
	}

	/**
	 * getter for INV_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public String getInvIncomeTySum() {
		return this.invIncomeTySum;
	}

	/**
	 * setter for INV_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public void setInvIncomeTySum(String invIncomeTySum) {
		this.invIncomeTySum = invIncomeTySum;
	}

	/**
	 * getter for OTHER_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getOtherIncomePyUnlimit() {
		return this.otherIncomePyUnlimit;
	}

	/**
	 * setter for OTHER_INCOME_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setOtherIncomePyUnlimit(String otherIncomePyUnlimit) {
		this.otherIncomePyUnlimit = otherIncomePyUnlimit;
	}

	/**
	 * getter for OTHER_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getOtherIncomePyLimit() {
		return this.otherIncomePyLimit;
	}

	/**
	 * setter for OTHER_INCOME_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setOtherIncomePyLimit(String otherIncomePyLimit) {
		this.otherIncomePyLimit = otherIncomePyLimit;
	}

	/**
	 * getter for OTHER_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public String getOtherIncomePySum() {
		return this.otherIncomePySum;
	}

	/**
	 * setter for OTHER_INCOME_PY_SUM
	 * 
	 * @generated
	 */
	public void setOtherIncomePySum(String otherIncomePySum) {
		this.otherIncomePySum = otherIncomePySum;
	}

	/**
	 * getter for OTHER_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getOtherIncomeTyUnlimit() {
		return this.otherIncomeTyUnlimit;
	}

	/**
	 * setter for OTHER_INCOME_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setOtherIncomeTyUnlimit(String otherIncomeTyUnlimit) {
		this.otherIncomeTyUnlimit = otherIncomeTyUnlimit;
	}

	/**
	 * getter for OTHER_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getOtherIncomeTyLimit() {
		return this.otherIncomeTyLimit;
	}

	/**
	 * setter for OTHER_INCOME_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setOtherIncomeTyLimit(String otherIncomeTyLimit) {
		this.otherIncomeTyLimit = otherIncomeTyLimit;
	}

	/**
	 * getter for OTHER_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public String getOtherIncomeTySum() {
		return this.otherIncomeTySum;
	}

	/**
	 * setter for OTHER_INCOME_TY_SUM
	 * 
	 * @generated
	 */
	public void setOtherIncomeTySum(String otherIncomeTySum) {
		this.otherIncomeTySum = otherIncomeTySum;
	}

	/**
	 * getter for INCOME_SUM_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getIncomeSumPyUnlimit() {
		return this.incomeSumPyUnlimit;
	}

	/**
	 * setter for INCOME_SUM_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setIncomeSumPyUnlimit(String incomeSumPyUnlimit) {
		this.incomeSumPyUnlimit = incomeSumPyUnlimit;
	}

	/**
	 * getter for INCOME_SUM_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getIncomeSumPyLimit() {
		return this.incomeSumPyLimit;
	}

	/**
	 * setter for INCOME_SUM_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setIncomeSumPyLimit(String incomeSumPyLimit) {
		this.incomeSumPyLimit = incomeSumPyLimit;
	}

	/**
	 * getter for INCOME_SUM_PY_SUM
	 * 
	 * @generated
	 */
	public String getIncomeSumPySum() {
		return this.incomeSumPySum;
	}

	/**
	 * setter for INCOME_SUM_PY_SUM
	 * 
	 * @generated
	 */
	public void setIncomeSumPySum(String incomeSumPySum) {
		this.incomeSumPySum = incomeSumPySum;
	}

	/**
	 * getter for INCOME_SUM_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getIncomeSumTyUnlimit() {
		return this.incomeSumTyUnlimit;
	}

	/**
	 * setter for INCOME_SUM_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setIncomeSumTyUnlimit(String incomeSumTyUnlimit) {
		this.incomeSumTyUnlimit = incomeSumTyUnlimit;
	}

	/**
	 * getter for INCOME_SUM_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getIncomeSumTyLimit() {
		return this.incomeSumTyLimit;
	}

	/**
	 * setter for INCOME_SUM_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setIncomeSumTyLimit(String incomeSumTyLimit) {
		this.incomeSumTyLimit = incomeSumTyLimit;
	}

	/**
	 * getter for INCOME_SUM_TY_SUM
	 * 
	 * @generated
	 */
	public String getIncomeSumTySum() {
		return this.incomeSumTySum;
	}

	/**
	 * setter for INCOME_SUM_TY_SUM
	 * 
	 * @generated
	 */
	public void setIncomeSumTySum(String incomeSumTySum) {
		this.incomeSumTySum = incomeSumTySum;
	}

	/**
	 * getter for BUSINESS_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getBusinessCostPyUnlimit() {
		return this.businessCostPyUnlimit;
	}

	/**
	 * setter for BUSINESS_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setBusinessCostPyUnlimit(String businessCostPyUnlimit) {
		this.businessCostPyUnlimit = businessCostPyUnlimit;
	}

	/**
	 * getter for BUSINESS_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getBusinessCostPyLimit() {
		return this.businessCostPyLimit;
	}

	/**
	 * setter for BUSINESS_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setBusinessCostPyLimit(String businessCostPyLimit) {
		this.businessCostPyLimit = businessCostPyLimit;
	}

	/**
	 * getter for BUSINESS_COST_PY_SUN
	 * 
	 * @generated
	 */
	public String getBusinessCostPySun() {
		return this.businessCostPySun;
	}

	/**
	 * setter for BUSINESS_COST_PY_SUN
	 * 
	 * @generated
	 */
	public void setBusinessCostPySun(String businessCostPySun) {
		this.businessCostPySun = businessCostPySun;
	}

	/**
	 * getter for BUSINESS_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getBusinessCostTyUnlimit() {
		return this.businessCostTyUnlimit;
	}

	/**
	 * setter for BUSINESS_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setBusinessCostTyUnlimit(String businessCostTyUnlimit) {
		this.businessCostTyUnlimit = businessCostTyUnlimit;
	}

	/**
	 * getter for BUSINESS_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getBusinessCostTyLimit() {
		return this.businessCostTyLimit;
	}

	/**
	 * setter for BUSINESS_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setBusinessCostTyLimit(String businessCostTyLimit) {
		this.businessCostTyLimit = businessCostTyLimit;
	}

	/**
	 * getter for BUSINESS_COST_TY_SUM
	 * 
	 * @generated
	 */
	public String getBusinessCostTySum() {
		return this.businessCostTySum;
	}

	/**
	 * setter for BUSINESS_COST_TY_SUM
	 * 
	 * @generated
	 */
	public void setBusinessCostTySum(String businessCostTySum) {
		this.businessCostTySum = businessCostTySum;
	}

	/**
	 * getter for STAFF_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getStaffCostPyUnlimit() {
		return this.staffCostPyUnlimit;
	}

	/**
	 * setter for STAFF_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setStaffCostPyUnlimit(String staffCostPyUnlimit) {
		this.staffCostPyUnlimit = staffCostPyUnlimit;
	}

	/**
	 * getter for STAFF_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getStaffCostPyLimit() {
		return this.staffCostPyLimit;
	}

	/**
	 * setter for STAFF_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setStaffCostPyLimit(String staffCostPyLimit) {
		this.staffCostPyLimit = staffCostPyLimit;
	}

	/**
	 * getter for STAFF_COST_PY_SUM
	 * 
	 * @generated
	 */
	public String getStaffCostPySum() {
		return this.staffCostPySum;
	}

	/**
	 * setter for STAFF_COST_PY_SUM
	 * 
	 * @generated
	 */
	public void setStaffCostPySum(String staffCostPySum) {
		this.staffCostPySum = staffCostPySum;
	}

	/**
	 * getter for STAFF_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getStaffCostTyUnlimit() {
		return this.staffCostTyUnlimit;
	}

	/**
	 * setter for STAFF_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setStaffCostTyUnlimit(String staffCostTyUnlimit) {
		this.staffCostTyUnlimit = staffCostTyUnlimit;
	}

	/**
	 * getter for STAFF_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getStaffCostTyLimit() {
		return this.staffCostTyLimit;
	}

	/**
	 * setter for STAFF_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setStaffCostTyLimit(String staffCostTyLimit) {
		this.staffCostTyLimit = staffCostTyLimit;
	}

	/**
	 * getter for STAFF_COST_TY_SUM
	 * 
	 * @generated
	 */
	public String getStaffCostTySum() {
		return this.staffCostTySum;
	}

	/**
	 * setter for STAFF_COST_TY_SUM
	 * 
	 * @generated
	 */
	public void setStaffCostTySum(String staffCostTySum) {
		this.staffCostTySum = staffCostTySum;
	}

	/**
	 * getter for RUNNING_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getRunningCostPyUnlimit() {
		return this.runningCostPyUnlimit;
	}

	/**
	 * setter for RUNNING_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setRunningCostPyUnlimit(String runningCostPyUnlimit) {
		this.runningCostPyUnlimit = runningCostPyUnlimit;
	}

	/**
	 * getter for RUNNING_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getRunningCostPyLimit() {
		return this.runningCostPyLimit;
	}

	/**
	 * setter for RUNNING_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setRunningCostPyLimit(String runningCostPyLimit) {
		this.runningCostPyLimit = runningCostPyLimit;
	}

	/**
	 * getter for RUNNING_COST_PY_SUM
	 * 
	 * @generated
	 */
	public String getRunningCostPySum() {
		return this.runningCostPySum;
	}

	/**
	 * setter for RUNNING_COST_PY_SUM
	 * 
	 * @generated
	 */
	public void setRunningCostPySum(String runningCostPySum) {
		this.runningCostPySum = runningCostPySum;
	}

	/**
	 * getter for RUNNING_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getRunningCostTyUnlimit() {
		return this.runningCostTyUnlimit;
	}

	/**
	 * setter for RUNNING_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setRunningCostTyUnlimit(String runningCostTyUnlimit) {
		this.runningCostTyUnlimit = runningCostTyUnlimit;
	}

	/**
	 * getter for RUNNING_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getRunningCostTyLimit() {
		return this.runningCostTyLimit;
	}

	/**
	 * setter for RUNNING_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setRunningCostTyLimit(String runningCostTyLimit) {
		this.runningCostTyLimit = runningCostTyLimit;
	}

	/**
	 * getter for RUNNING_COST_TY_SUM
	 * 
	 * @generated
	 */
	public String getRunningCostTySum() {
		return this.runningCostTySum;
	}

	/**
	 * setter for RUNNING_COST_TY_SUM
	 * 
	 * @generated
	 */
	public void setRunningCostTySum(String runningCostTySum) {
		this.runningCostTySum = runningCostTySum;
	}

	/**
	 * getter for DEPRECIATION_ASSETS_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getDepreciationAssetsPyUnlimit() {
		return this.depreciationAssetsPyUnlimit;
	}

	/**
	 * setter for DEPRECIATION_ASSETS_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setDepreciationAssetsPyUnlimit(
			String depreciationAssetsPyUnlimit) {
		this.depreciationAssetsPyUnlimit = depreciationAssetsPyUnlimit;
	}

	/**
	 * getter for DEPRECIATION_ASSETS_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getDepreciationAssetsPyLimit() {
		return this.depreciationAssetsPyLimit;
	}

	/**
	 * setter for DEPRECIATION_ASSETS_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setDepreciationAssetsPyLimit(
			String depreciationAssetsPyLimit) {
		this.depreciationAssetsPyLimit = depreciationAssetsPyLimit;
	}

	/**
	 * getter for DEPRECIATION_ASSETS_PY_SUM
	 * 
	 * @generated
	 */
	public String getDepreciationAssetsPySum() {
		return this.depreciationAssetsPySum;
	}

	/**
	 * setter for DEPRECIATION_ASSETS_PY_SUM
	 * 
	 * @generated
	 */
	public void setDepreciationAssetsPySum(String depreciationAssetsPySum) {
		this.depreciationAssetsPySum = depreciationAssetsPySum;
	}

	/**
	 * getter for DEPRECIATION_ASSETS_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getDepreciationAssetsTyUnlimit() {
		return this.depreciationAssetsTyUnlimit;
	}

	/**
	 * setter for DEPRECIATION_ASSETS_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setDepreciationAssetsTyUnlimit(
			String depreciationAssetsTyUnlimit) {
		this.depreciationAssetsTyUnlimit = depreciationAssetsTyUnlimit;
	}

	/**
	 * getter for DEPRECIATION_ASSETS_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getDepreciationAssetsTyLimit() {
		return this.depreciationAssetsTyLimit;
	}

	/**
	 * setter for DEPRECIATION_ASSETS_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setDepreciationAssetsTyLimit(
			String depreciationAssetsTyLimit) {
		this.depreciationAssetsTyLimit = depreciationAssetsTyLimit;
	}

	/**
	 * getter for DEPRECIATION_ASSETS_TY_SUM
	 * 
	 * @generated
	 */
	public String getDepreciationAssetsTySum() {
		return this.depreciationAssetsTySum;
	}

	/**
	 * setter for DEPRECIATION_ASSETS_TY_SUM
	 * 
	 * @generated
	 */
	public void setDepreciationAssetsTySum(String depreciationAssetsTySum) {
		this.depreciationAssetsTySum = depreciationAssetsTySum;
	}

	/**
	 * getter for TAXES_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getTaxesPyUnlimit() {
		return this.taxesPyUnlimit;
	}

	/**
	 * setter for TAXES_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setTaxesPyUnlimit(String taxesPyUnlimit) {
		this.taxesPyUnlimit = taxesPyUnlimit;
	}

	/**
	 * getter for TAXES_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getTaxesPyLimit() {
		return this.taxesPyLimit;
	}

	/**
	 * setter for TAXES_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setTaxesPyLimit(String taxesPyLimit) {
		this.taxesPyLimit = taxesPyLimit;
	}

	/**
	 * getter for TAXES_PY_SUM
	 * 
	 * @generated
	 */
	public String getTaxesPySum() {
		return this.taxesPySum;
	}

	/**
	 * setter for TAXES_PY_SUM
	 * 
	 * @generated
	 */
	public void setTaxesPySum(String taxesPySum) {
		this.taxesPySum = taxesPySum;
	}

	/**
	 * getter for TAXES_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getTaxesTyUnlimit() {
		return this.taxesTyUnlimit;
	}

	/**
	 * setter for TAXES_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setTaxesTyUnlimit(String taxesTyUnlimit) {
		this.taxesTyUnlimit = taxesTyUnlimit;
	}

	/**
	 * getter for TAXES_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getTaxesTyLimit() {
		return this.taxesTyLimit;
	}

	/**
	 * setter for TAXES_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setTaxesTyLimit(String taxesTyLimit) {
		this.taxesTyLimit = taxesTyLimit;
	}

	/**
	 * getter for TAXES_TY_SUM
	 * 
	 * @generated
	 */
	public String getTaxesTySum() {
		return this.taxesTySum;
	}

	/**
	 * setter for TAXES_TY_SUM
	 * 
	 * @generated
	 */
	public void setTaxesTySum(String taxesTySum) {
		this.taxesTySum = taxesTySum;
	}

	/**
	 * getter for MANAGE_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getManageCostPyUnlimit() {
		return this.manageCostPyUnlimit;
	}

	/**
	 * setter for MANAGE_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setManageCostPyUnlimit(String manageCostPyUnlimit) {
		this.manageCostPyUnlimit = manageCostPyUnlimit;
	}

	/**
	 * getter for MANAGE_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getManageCostPyLimit() {
		return this.manageCostPyLimit;
	}

	/**
	 * setter for MANAGE_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setManageCostPyLimit(String manageCostPyLimit) {
		this.manageCostPyLimit = manageCostPyLimit;
	}

	/**
	 * getter for MANAGE_COST_PY_SUM
	 * 
	 * @generated
	 */
	public String getManageCostPySum() {
		return this.manageCostPySum;
	}

	/**
	 * setter for MANAGE_COST_PY_SUM
	 * 
	 * @generated
	 */
	public void setManageCostPySum(String manageCostPySum) {
		this.manageCostPySum = manageCostPySum;
	}

	/**
	 * getter for MANAGE_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getManageCostTyUnlimit() {
		return this.manageCostTyUnlimit;
	}

	/**
	 * setter for MANAGE_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setManageCostTyUnlimit(String manageCostTyUnlimit) {
		this.manageCostTyUnlimit = manageCostTyUnlimit;
	}

	/**
	 * getter for MANAGE_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getManageCostTyLimit() {
		return this.manageCostTyLimit;
	}

	/**
	 * setter for MANAGE_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setManageCostTyLimit(String manageCostTyLimit) {
		this.manageCostTyLimit = manageCostTyLimit;
	}

	/**
	 * getter for RAISING_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getRaisingCostPyUnlimit() {
		return this.raisingCostPyUnlimit;
	}

	/**
	 * setter for RAISING_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setRaisingCostPyUnlimit(String raisingCostPyUnlimit) {
		this.raisingCostPyUnlimit = raisingCostPyUnlimit;
	}

	/**
	 * getter for RAISING_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getRaisingCostPyLimit() {
		return this.raisingCostPyLimit;
	}

	/**
	 * setter for RAISING_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setRaisingCostPyLimit(String raisingCostPyLimit) {
		this.raisingCostPyLimit = raisingCostPyLimit;
	}

	/**
	 * getter for RAISING_COST_PY_SUM
	 * 
	 * @generated
	 */
	public String getRaisingCostPySum() {
		return this.raisingCostPySum;
	}

	/**
	 * setter for RAISING_COST_PY_SUM
	 * 
	 * @generated
	 */
	public void setRaisingCostPySum(String raisingCostPySum) {
		this.raisingCostPySum = raisingCostPySum;
	}

	/**
	 * getter for RAISING_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getRaisingCostTyUnlimit() {
		return this.raisingCostTyUnlimit;
	}

	/**
	 * setter for RAISING_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setRaisingCostTyUnlimit(String raisingCostTyUnlimit) {
		this.raisingCostTyUnlimit = raisingCostTyUnlimit;
	}

	/**
	 * getter for RAISING_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getRaisingCostTyLimit() {
		return this.raisingCostTyLimit;
	}

	/**
	 * setter for RAISING_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setRaisingCostTyLimit(String raisingCostTyLimit) {
		this.raisingCostTyLimit = raisingCostTyLimit;
	}

	/**
	 * getter for RAISING_COST_TY_SUM
	 * 
	 * @generated
	 */
	public String getRaisingCostTySum() {
		return this.raisingCostTySum;
	}

	/**
	 * setter for RAISING_COST_TY_SUM
	 * 
	 * @generated
	 */
	public void setRaisingCostTySum(String raisingCostTySum) {
		this.raisingCostTySum = raisingCostTySum;
	}

	/**
	 * getter for OTHER_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getOtherCostPyUnlimit() {
		return this.otherCostPyUnlimit;
	}

	/**
	 * setter for OTHER_COST_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setOtherCostPyUnlimit(String otherCostPyUnlimit) {
		this.otherCostPyUnlimit = otherCostPyUnlimit;
	}

	/**
	 * getter for OTHER_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getOtherCostPyLimit() {
		return this.otherCostPyLimit;
	}

	/**
	 * setter for OTHER_COST_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setOtherCostPyLimit(String otherCostPyLimit) {
		this.otherCostPyLimit = otherCostPyLimit;
	}

	/**
	 * getter for OTHER_COST_PY_SUM
	 * 
	 * @generated
	 */
	public String getOtherCostPySum() {
		return this.otherCostPySum;
	}

	/**
	 * setter for OTHER_COST_PY_SUM
	 * 
	 * @generated
	 */
	public void setOtherCostPySum(String otherCostPySum) {
		this.otherCostPySum = otherCostPySum;
	}

	/**
	 * getter for OTHER_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getOtherCostTyUnlimit() {
		return this.otherCostTyUnlimit;
	}

	/**
	 * setter for OTHER_COST_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setOtherCostTyUnlimit(String otherCostTyUnlimit) {
		this.otherCostTyUnlimit = otherCostTyUnlimit;
	}

	/**
	 * getter for OTHER_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getOtherCostTyLimit() {
		return this.otherCostTyLimit;
	}

	/**
	 * setter for OTHER_COST_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setOtherCostTyLimit(String otherCostTyLimit) {
		this.otherCostTyLimit = otherCostTyLimit;
	}

	/**
	 * getter for OTHER_COST_TY_SUM
	 * 
	 * @generated
	 */
	public String getOtherCostTySum() {
		return this.otherCostTySum;
	}

	/**
	 * setter for OTHER_COST_TY_SUM
	 * 
	 * @generated
	 */
	public void setOtherCostTySum(String otherCostTySum) {
		this.otherCostTySum = otherCostTySum;
	}

	/**
	 * getter for COST_SUM_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getCostSumPyUnlimit() {
		return this.costSumPyUnlimit;
	}

	/**
	 * setter for COST_SUM_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setCostSumPyUnlimit(String costSumPyUnlimit) {
		this.costSumPyUnlimit = costSumPyUnlimit;
	}

	/**
	 * getter for COST_SUM_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getCostSumPyLimit() {
		return this.costSumPyLimit;
	}

	/**
	 * setter for COST_SUM_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setCostSumPyLimit(String costSumPyLimit) {
		this.costSumPyLimit = costSumPyLimit;
	}

	/**
	 * getter for COST_SUM_PY_SUM
	 * 
	 * @generated
	 */
	public String getCostSumPySum() {
		return this.costSumPySum;
	}

	/**
	 * setter for COST_SUM_PY_SUM
	 * 
	 * @generated
	 */
	public void setCostSumPySum(String costSumPySum) {
		this.costSumPySum = costSumPySum;
	}

	/**
	 * getter for COST_SUM_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getCostSumTyUnlimit() {
		return this.costSumTyUnlimit;
	}

	/**
	 * setter for COST_SUM_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setCostSumTyUnlimit(String costSumTyUnlimit) {
		this.costSumTyUnlimit = costSumTyUnlimit;
	}

	/**
	 * getter for COST_SUM_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getCostSumTyLimit() {
		return this.costSumTyLimit;
	}

	/**
	 * setter for COST_SUM_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setCostSumTyLimit(String costSumTyLimit) {
		this.costSumTyLimit = costSumTyLimit;
	}

	/**
	 * getter for COST_SUM_TY_SUM
	 * 
	 * @generated
	 */
	public String getCostSumTySum() {
		return this.costSumTySum;
	}

	/**
	 * setter for COST_SUM_TY_SUM
	 * 
	 * @generated
	 */
	public void setCostSumTySum(String costSumTySum) {
		this.costSumTySum = costSumTySum;
	}

	/**
	 * getter for LIMIT_TO_UNLIMIT_PY_UNLIMT
	 * 
	 * @generated
	 */
	public String getLimitToUnlimitPyUnlimt() {
		return this.limitToUnlimitPyUnlimt;
	}

	/**
	 * setter for LIMIT_TO_UNLIMIT_PY_UNLIMT
	 * 
	 * @generated
	 */
	public void setLimitToUnlimitPyUnlimt(String limitToUnlimitPyUnlimt) {
		this.limitToUnlimitPyUnlimt = limitToUnlimitPyUnlimt;
	}

	/**
	 * getter for LIMIT_TO_UNLIMIT_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getLimitToUnlimitPyLimit() {
		return this.limitToUnlimitPyLimit;
	}

	/**
	 * setter for LIMIT_TO_UNLIMIT_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setLimitToUnlimitPyLimit(String limitToUnlimitPyLimit) {
		this.limitToUnlimitPyLimit = limitToUnlimitPyLimit;
	}

	/**
	 * getter for LIMIT_TO_UNLIMIT_PY_SUM
	 * 
	 * @generated
	 */
	public String getLimitToUnlimitPySum() {
		return this.limitToUnlimitPySum;
	}

	/**
	 * setter for LIMIT_TO_UNLIMIT_PY_SUM
	 * 
	 * @generated
	 */
	public void setLimitToUnlimitPySum(String limitToUnlimitPySum) {
		this.limitToUnlimitPySum = limitToUnlimitPySum;
	}

	/**
	 * getter for LIMIT_TO_UNLIMIT_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getLimitToUnlimitTyUnlimit() {
		return this.limitToUnlimitTyUnlimit;
	}

	/**
	 * setter for LIMIT_TO_UNLIMIT_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setLimitToUnlimitTyUnlimit(String limitToUnlimitTyUnlimit) {
		this.limitToUnlimitTyUnlimit = limitToUnlimitTyUnlimit;
	}

	/**
	 * getter for LIMIT_TO_UNLIMIT_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getLimitToUnlimitTyLimit() {
		return this.limitToUnlimitTyLimit;
	}

	/**
	 * setter for LIMIT_TO_UNLIMIT_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setLimitToUnlimitTyLimit(String limitToUnlimitTyLimit) {
		this.limitToUnlimitTyLimit = limitToUnlimitTyLimit;
	}

	/**
	 * getter for LIMIT_TO_UNLIMIT_TY_SUM
	 * 
	 * @generated
	 */
	public String getLimitToUnlimitTySum() {
		return this.limitToUnlimitTySum;
	}

	/**
	 * setter for LIMIT_TO_UNLIMIT_TY_SUM
	 * 
	 * @generated
	 */
	public void setLimitToUnlimitTySum(String limitToUnlimitTySum) {
		this.limitToUnlimitTySum = limitToUnlimitTySum;
	}

	/**
	 * getter for ASSETS_CHANGE_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getAssetsChangePyUnlimit() {
		return this.assetsChangePyUnlimit;
	}

	/**
	 * setter for ASSETS_CHANGE_PY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setAssetsChangePyUnlimit(String assetsChangePyUnlimit) {
		this.assetsChangePyUnlimit = assetsChangePyUnlimit;
	}

	/**
	 * getter for ASSETS_CHANGE_PY_LIMIT
	 * 
	 * @generated
	 */
	public String getAssetsChangePyLimit() {
		return this.assetsChangePyLimit;
	}

	/**
	 * setter for ASSETS_CHANGE_PY_LIMIT
	 * 
	 * @generated
	 */
	public void setAssetsChangePyLimit(String assetsChangePyLimit) {
		this.assetsChangePyLimit = assetsChangePyLimit;
	}

	/**
	 * getter for ASSETS_CHANGE_PY_SUM
	 * 
	 * @generated
	 */
	public String getAssetsChangePySum() {
		return this.assetsChangePySum;
	}

	/**
	 * setter for ASSETS_CHANGE_PY_SUM
	 * 
	 * @generated
	 */
	public void setAssetsChangePySum(String assetsChangePySum) {
		this.assetsChangePySum = assetsChangePySum;
	}

	/**
	 * getter for ASSETS_CHANGE_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public String getAssetsChangeTyUnlimit() {
		return this.assetsChangeTyUnlimit;
	}

	/**
	 * setter for ASSETS_CHANGE_TY_UNLIMIT
	 * 
	 * @generated
	 */
	public void setAssetsChangeTyUnlimit(String assetsChangeTyUnlimit) {
		this.assetsChangeTyUnlimit = assetsChangeTyUnlimit;
	}

	/**
	 * getter for ASSETS_CHANGE_TY_LIMIT
	 * 
	 * @generated
	 */
	public String getAssetsChangeTyLimit() {
		return this.assetsChangeTyLimit;
	}

	/**
	 * setter for ASSETS_CHANGE_TY_LIMIT
	 * 
	 * @generated
	 */
	public void setAssetsChangeTyLimit(String assetsChangeTyLimit) {
		this.assetsChangeTyLimit = assetsChangeTyLimit;
	}

	/**
	 * getter for ASSETS_CHANGE_TY_SUM
	 * 
	 * @generated
	 */
	public String getAssetsChangeTySum() {
		return this.assetsChangeTySum;
	}

	/**
	 * setter for ASSETS_CHANGE_TY_SUM
	 * 
	 * @generated
	 */
	public void setAssetsChangeTySum(String assetsChangeTySum) {
		this.assetsChangeTySum = assetsChangeTySum;
	}

	/**
	 * getter for REMAINING_BALANCE_TY
	 * 
	 * @generated
	 */
	public String getRemainingBalanceTy() {
		return this.remainingBalanceTy;
	}

	/**
	 * setter for REMAINING_BALANCE_TY
	 * 
	 * @generated
	 */
	public void setRemainingBalanceTy(String remainingBalanceTy) {
		this.remainingBalanceTy = remainingBalanceTy;
	}

	public String getGovBuyPyUnlimit() {
		return govBuyPyUnlimit;
	}

	public void setGovBuyPyUnlimit(String govBuyPyUnlimit) {
		this.govBuyPyUnlimit = govBuyPyUnlimit;
	}

	public String getGovBuyPyLimit() {
		return govBuyPyLimit;
	}

	public void setGovBuyPyLimit(String govBuyPyLimit) {
		this.govBuyPyLimit = govBuyPyLimit;
	}

	public String getGovBuyPySum() {
		return govBuyPySum;
	}

	public void setGovBuyPySum(String govBuyPySum) {
		this.govBuyPySum = govBuyPySum;
	}

	public String getGovBuyTyUnlimit() {
		return govBuyTyUnlimit;
	}

	public void setGovBuyTyUnlimit(String govBuyTyUnlimit) {
		this.govBuyTyUnlimit = govBuyTyUnlimit;
	}

	public String getGovBuyTyLimit() {
		return govBuyTyLimit;
	}

	public void setGovBuyTyLimit(String govBuyTyLimit) {
		this.govBuyTyLimit = govBuyTyLimit;
	}

	public String getGovBuyTySum() {
		return govBuyTySum;
	}

	public void setGovBuyTySum(String govBuyTySum) {
		this.govBuyTySum = govBuyTySum;
	}

	public String getPublicWelfarrePyUnlimit() {
		return publicWelfarrePyUnlimit;
	}

	public void setPublicWelfarrePyUnlimit(String publicWelfarrePyUnlimit) {
		this.publicWelfarrePyUnlimit = publicWelfarrePyUnlimit;
	}

	public String getPublicWelfarrePyLimit() {
		return publicWelfarrePyLimit;
	}

	public void setPublicWelfarrePyLimit(String publicWelfarrePyLimit) {
		this.publicWelfarrePyLimit = publicWelfarrePyLimit;
	}

	public String getPublicWelfarrePySum() {
		return publicWelfarrePySum;
	}

	public void setPublicWelfarrePySum(String publicWelfarrePySum) {
		this.publicWelfarrePySum = publicWelfarrePySum;
	}

	public String getPublicWelfarreTyUnlimit() {
		return publicWelfarreTyUnlimit;
	}

	public void setPublicWelfarreTyUnlimit(String publicWelfarreTyUnlimit) {
		this.publicWelfarreTyUnlimit = publicWelfarreTyUnlimit;
	}

	public String getPublicWelfarreTyLimit() {
		return publicWelfarreTyLimit;
	}

	public void setPublicWelfarreTyLimit(String publicWelfarreTyLimit) {
		this.publicWelfarreTyLimit = publicWelfarreTyLimit;
	}

	public String getPublicWelfarreTySum() {
		return publicWelfarreTySum;
	}

	public void setPublicWelfarreTySum(String publicWelfarreTySum) {
		this.publicWelfarreTySum = publicWelfarreTySum;
	}

	public String getManageCostTySum() {
		return manageCostTySum;
	}

	public void setManageCostTySum(String manageCostTySum) {
		this.manageCostTySum = manageCostTySum;
	}

}