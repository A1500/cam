package com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西自律与诚信建设情况
 * 
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
@Table(tableName = "SOM_JX_DISCRIPLINE_INTEGRITY", keyFields = "id")
public class SomJxDiscriplineIntegrity extends StatefulDatabean {
	// ID
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// IF_MEETING_RULE
	@Column(name = "IF_MEETING_RULE")
	private String ifMeetingRule;
	// IF_SUPERVISOR_RULE
	@Column(name = "IF_SUPERVISOR_RULE")
	private String ifSupervisorRule;
	// IF_ACCOUNTANT_RULE
	@Column(name = "IF_ACCOUNTANT_RULE")
	private String ifAccountantRule;
	// IF_WORKING_RULE
	@Column(name = "IF_WORKING_RULE")
	private String ifWorkingRule;
	// IF_PRINT_RULE
	@Column(name = "IF_PRINT_RULE")
	private String ifPrintRule;
	// SERVICE_ITEM
	@Column(name = "SERVICE_ITEM")
	private String serviceItem;
	// SERVICE_CONTENT
	@Column(name = "SERVICE_CONTENT")
	private String serviceContent;
	// CHARGE_ITEM
	@Column(name = "CHARGE_ITEM")
	private String chargeItem;
	// CHARGE_RULE
	@Column(name = "CHARGE_RULE")
	private String chargeRule;
	// CHARGE_CODE
	@Column(name = "CHARGE_CODE")
	private String chargeCode;
	// IF_SERVICE_CHARGE
	@Column(name = "IF_SERVICE_CHARGE")
	private String ifServiceCharge;
	// IF_BUILD_ONWALL
	@Column(name = "IF_BUILD_ONWALL")
	private String ifBuildOnwall;
	// IF_TAX_DONE
	@Column(name = "IF_TAX_DONE")
	private String ifTaxDone;
	// IF_TAX_ONWALL
	@Column(name = "IF_TAX_ONWALL")
	private String ifTaxOnwall;
	// IF_CHARGE_DONE
	@Column(name = "IF_CHARGE_DONE")
	private String ifChargeDone;
	// IF_CHARGE_ONWALL
	@Column(name = "IF_CHARGE_ONWALL")
	private String ifChargeOnwall;
	// IF_SORG_DONE
	@Column(name = "IF_SORG_DONE")
	private String ifSorgDone;
	// IF_SORG_ONWALL
	@Column(name = "IF_SORG_ONWALL")
	private String ifSorgOnwall;
	// IF_ORGAN_ONWALL
	@Column(name = "IF_ORGAN_ONWALL")
	private String ifOrganOnwall;
	// IF_CONTRIBUTE_OPEN
	@Column(name = "IF_CONTRIBUTE_OPEN")
	private String ifContributeOpen;
	// COMMONWEAL_CIRCS
	@Column(name = "COMMONWEAL_CIRCS")
	private String commonwealCircs;
	// IF_CERT_SP
	@Column(name = "IF_CERT_SP")
	private String ifCertSp;
	// IF_CHARGE_RULE
	@Column(name = "IF_CHARGE_RULE")
	private String ifChargeRule;
	// IF_CHARGE_RULE_SP
	@Column(name = "IF_CHARGE_RULE_SP")
	private String ifChargeRuleSp;
	// IF_ACCEPT_CONTRIBUTE
	@Column(name = "IF_ACCEPT_CONTRIBUTE")
	private String ifAcceptContribute;
	// IF_REPORT_FUND
	@Column(name = "IF_REPORT_FUND")
	private String ifReportFund;

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
	 * getter for IF_MEETING_RULE
	 * 
	 * @generated
	 */
	public String getIfMeetingRule() {
		return this.ifMeetingRule;
	}

	/**
	 * setter for IF_MEETING_RULE
	 * 
	 * @generated
	 */
	public void setIfMeetingRule(String ifMeetingRule) {
		this.ifMeetingRule = ifMeetingRule;
	}

	/**
	 * getter for IF_SUPERVISOR_RULE
	 * 
	 * @generated
	 */
	public String getIfSupervisorRule() {
		return this.ifSupervisorRule;
	}

	/**
	 * setter for IF_SUPERVISOR_RULE
	 * 
	 * @generated
	 */
	public void setIfSupervisorRule(String ifSupervisorRule) {
		this.ifSupervisorRule = ifSupervisorRule;
	}

	/**
	 * getter for IF_ACCOUNTANT_RULE
	 * 
	 * @generated
	 */
	public String getIfAccountantRule() {
		return this.ifAccountantRule;
	}

	/**
	 * setter for IF_ACCOUNTANT_RULE
	 * 
	 * @generated
	 */
	public void setIfAccountantRule(String ifAccountantRule) {
		this.ifAccountantRule = ifAccountantRule;
	}

	/**
	 * getter for IF_WORKING_RULE
	 * 
	 * @generated
	 */
	public String getIfWorkingRule() {
		return this.ifWorkingRule;
	}

	/**
	 * setter for IF_WORKING_RULE
	 * 
	 * @generated
	 */
	public void setIfWorkingRule(String ifWorkingRule) {
		this.ifWorkingRule = ifWorkingRule;
	}

	/**
	 * getter for IF_PRINT_RULE
	 * 
	 * @generated
	 */
	public String getIfPrintRule() {
		return this.ifPrintRule;
	}

	/**
	 * setter for IF_PRINT_RULE
	 * 
	 * @generated
	 */
	public void setIfPrintRule(String ifPrintRule) {
		this.ifPrintRule = ifPrintRule;
	}

	/**
	 * getter for SERVICE_ITEM
	 * 
	 * @generated
	 */
	public String getServiceItem() {
		return this.serviceItem;
	}

	/**
	 * setter for SERVICE_ITEM
	 * 
	 * @generated
	 */
	public void setServiceItem(String serviceItem) {
		this.serviceItem = serviceItem;
	}

	/**
	 * getter for SERVICE_CONTENT
	 * 
	 * @generated
	 */
	public String getServiceContent() {
		return this.serviceContent;
	}

	/**
	 * setter for SERVICE_CONTENT
	 * 
	 * @generated
	 */
	public void setServiceContent(String serviceContent) {
		this.serviceContent = serviceContent;
	}

	/**
	 * getter for CHARGE_ITEM
	 * 
	 * @generated
	 */
	public String getChargeItem() {
		return this.chargeItem;
	}

	/**
	 * setter for CHARGE_ITEM
	 * 
	 * @generated
	 */
	public void setChargeItem(String chargeItem) {
		this.chargeItem = chargeItem;
	}

	/**
	 * getter for CHARGE_RULE
	 * 
	 * @generated
	 */
	public String getChargeRule() {
		return this.chargeRule;
	}

	/**
	 * setter for CHARGE_RULE
	 * 
	 * @generated
	 */
	public void setChargeRule(String chargeRule) {
		this.chargeRule = chargeRule;
	}

	/**
	 * getter for CHARGE_CODE
	 * 
	 * @generated
	 */
	public String getChargeCode() {
		return this.chargeCode;
	}

	/**
	 * setter for CHARGE_CODE
	 * 
	 * @generated
	 */
	public void setChargeCode(String chargeCode) {
		this.chargeCode = chargeCode;
	}

	/**
	 * getter for IF_SERVICE_CHARGE
	 * 
	 * @generated
	 */
	public String getIfServiceCharge() {
		return this.ifServiceCharge;
	}

	/**
	 * setter for IF_SERVICE_CHARGE
	 * 
	 * @generated
	 */
	public void setIfServiceCharge(String ifServiceCharge) {
		this.ifServiceCharge = ifServiceCharge;
	}

	/**
	 * getter for IF_BUILD_ONWALL
	 * 
	 * @generated
	 */
	public String getIfBuildOnwall() {
		return this.ifBuildOnwall;
	}

	/**
	 * setter for IF_BUILD_ONWALL
	 * 
	 * @generated
	 */
	public void setIfBuildOnwall(String ifBuildOnwall) {
		this.ifBuildOnwall = ifBuildOnwall;
	}

	/**
	 * getter for IF_TAX_DONE
	 * 
	 * @generated
	 */
	public String getIfTaxDone() {
		return this.ifTaxDone;
	}

	/**
	 * setter for IF_TAX_DONE
	 * 
	 * @generated
	 */
	public void setIfTaxDone(String ifTaxDone) {
		this.ifTaxDone = ifTaxDone;
	}

	/**
	 * getter for IF_TAX_ONWALL
	 * 
	 * @generated
	 */
	public String getIfTaxOnwall() {
		return this.ifTaxOnwall;
	}

	/**
	 * setter for IF_TAX_ONWALL
	 * 
	 * @generated
	 */
	public void setIfTaxOnwall(String ifTaxOnwall) {
		this.ifTaxOnwall = ifTaxOnwall;
	}

	/**
	 * getter for IF_CHARGE_DONE
	 * 
	 * @generated
	 */
	public String getIfChargeDone() {
		return this.ifChargeDone;
	}

	/**
	 * setter for IF_CHARGE_DONE
	 * 
	 * @generated
	 */
	public void setIfChargeDone(String ifChargeDone) {
		this.ifChargeDone = ifChargeDone;
	}

	/**
	 * getter for IF_CHARGE_ONWALL
	 * 
	 * @generated
	 */
	public String getIfChargeOnwall() {
		return this.ifChargeOnwall;
	}

	/**
	 * setter for IF_CHARGE_ONWALL
	 * 
	 * @generated
	 */
	public void setIfChargeOnwall(String ifChargeOnwall) {
		this.ifChargeOnwall = ifChargeOnwall;
	}

	/**
	 * getter for IF_SORG_DONE
	 * 
	 * @generated
	 */
	public String getIfSorgDone() {
		return this.ifSorgDone;
	}

	/**
	 * setter for IF_SORG_DONE
	 * 
	 * @generated
	 */
	public void setIfSorgDone(String ifSorgDone) {
		this.ifSorgDone = ifSorgDone;
	}

	/**
	 * getter for IF_SORG_ONWALL
	 * 
	 * @generated
	 */
	public String getIfSorgOnwall() {
		return this.ifSorgOnwall;
	}

	/**
	 * setter for IF_SORG_ONWALL
	 * 
	 * @generated
	 */
	public void setIfSorgOnwall(String ifSorgOnwall) {
		this.ifSorgOnwall = ifSorgOnwall;
	}

	/**
	 * getter for IF_ORGAN_ONWALL
	 * 
	 * @generated
	 */
	public String getIfOrganOnwall() {
		return this.ifOrganOnwall;
	}

	/**
	 * setter for IF_ORGAN_ONWALL
	 * 
	 * @generated
	 */
	public void setIfOrganOnwall(String ifOrganOnwall) {
		this.ifOrganOnwall = ifOrganOnwall;
	}

	/**
	 * getter for IF_CONTRIBUTE_OPEN
	 * 
	 * @generated
	 */
	public String getIfContributeOpen() {
		return this.ifContributeOpen;
	}

	/**
	 * setter for IF_CONTRIBUTE_OPEN
	 * 
	 * @generated
	 */
	public void setIfContributeOpen(String ifContributeOpen) {
		this.ifContributeOpen = ifContributeOpen;
	}

	/**
	 * getter for COMMONWEAL_CIRCS
	 * 
	 * @generated
	 */
	public String getCommonwealCircs() {
		return this.commonwealCircs;
	}

	/**
	 * setter for COMMONWEAL_CIRCS
	 * 
	 * @generated
	 */
	public void setCommonwealCircs(String commonwealCircs) {
		this.commonwealCircs = commonwealCircs;
	}

	public String getIfCertSp() {
		return ifCertSp;
	}

	public void setIfCertSp(String ifCertSp) {
		this.ifCertSp = ifCertSp;
	}

	public String getIfChargeRule() {
		return ifChargeRule;
	}

	public void setIfChargeRule(String ifChargeRule) {
		this.ifChargeRule = ifChargeRule;
	}

	public String getIfChargeRuleSp() {
		return ifChargeRuleSp;
	}

	public void setIfChargeRuleSp(String ifChargeRuleSp) {
		this.ifChargeRuleSp = ifChargeRuleSp;
	}

	public String getIfAcceptContribute() {
		return ifAcceptContribute;
	}

	public void setIfAcceptContribute(String ifAcceptContribute) {
		this.ifAcceptContribute = ifAcceptContribute;
	}

	public String getIfReportFund() {
		return ifReportFund;
	}

	public void setIfReportFund(String ifReportFund) {
		this.ifReportFund = ifReportFund;
	}

}