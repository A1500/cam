package com.inspur.cams.welfare.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:WealUnitStatus
 * @description:福利企业当前状态表
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
@Table(tableName = "WEAL_UNIT_STATUS", keyFields = "unitId")
public class WealUnitStatus extends StatefulDatabean {
	// UNIT_ID
	@Rule(value = "require")
	@Column(name = "UNIT_ID")
	private String unitId;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// STATUS
	@Column(name = "STATUS")
	private String status;
	// NEXT_CHECK
	@Column(name = "NEXT_CHECK")
	private String nextCheck;
	// APPLY_YEAR
	@Column(name = "APPLY_YEAR")
	private String applyYear;
	// SERIAL_NUM
	@Column(name = "SERIAL_NUM")
	private String serialNum;
	// COMPANY_NAME
	@Rule(value = "require")
	@Column(name = "COMPANY_NAME")
	private String companyName;
	// ADDRESS
	@Column(name = "ADDRESS")
	private String address;
	// POST_CODE
	@Column(name = "POST_CODE")
	private String postCode;
	// AGENT_PEOPLE
	@Column(name = "AGENT_PEOPLE")
	private String agentPeople;
	// AGENT_PHONE
	@Column(name = "AGENT_PHONE")
	private String agentPhone;
	// AGENT_EMAIL
	@Column(name = "AGENT_EMAIL")
	private String agentEmail;
	// WEB_ADDRESS
	@Column(name = "WEB_ADDRESS")
	private String webAddress;
	// ECONOMIC_NATURE_CODE
	@Column(name = "ECONOMIC_NATURE_CODE")
	private String economicNatureCode;
	// ECONOMIC_NATURE_NAME
	@Column(name = "ECONOMIC_NATURE_NAME")
	private String economicNatureName;
	// ORGAN_CODE
	@Column(name = "ORGAN_CODE")
	private String organCode;
	// LICENSE_CODE
	@Column(name = "LICENSE_CODE")
	private String licenseCode;
	// REGISTRATION_CODE
	@Column(name = "REGISTRATION_CODE")
	private String registrationCode;
	// FIRST_SCOPE
	@Column(name = "FIRST_SCOPE")
	private String firstScope;
	// SECOND_SCOPE
	@Column(name = "SECOND_SCOPE")
	private String secondScope;
	// REG_FUND
	@Rule(value = "number")
	@Column(name = "REG_FUND")
	private BigDecimal regFund;
	// REASON
	@Column(name = "REASON")
	private String reason;
	// APPROVE_DATE
	@Column(name = "APPROVE_DATE")
	private String approveDate;
	// ISSUEL_ORGAN
	@Column(name = "ISSUEL_ORGAN")
	private String issuelOrgan;
	// ISSUEL_DATE
	@Column(name = "ISSUEL_DATE")
	private String issuelDate;
	// MORG_NAME
	@Rule(value = "require")
	@Column(name = "MORG_NAME")
	private String morgName;
	// MORG_AREA
	@Rule(value = "require")
	@Column(name = "MORG_AREA")
	private String morgArea;
	// LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
	private String legalPeople;
	// LEGAL_PHONE
	@Column(name = "LEGAL_PHONE")
	private String legalPhone;
	@Column(name = "LEGAL_TELPHONE")
	private String legalTelphone;
	@Column(name = "LEGAL_ID_CARD")
	private String legalIdCard;
	
	public String getLegalPhone() {
		return legalPhone;
	}

	public void setLegalPhone(String legalPhone) {
		this.legalPhone = legalPhone;
	}

	public String getLegalTelphone() {
		return legalTelphone;
	}

	public void setLegalTelphone(String legalTelphone) {
		this.legalTelphone = legalTelphone;
	}

	public String getLegalIdCard() {
		return legalIdCard;
	}

	public void setLegalIdCard(String legalIdCard) {
		this.legalIdCard = legalIdCard;
	}

	public String getLegalPeople() {
		return legalPeople;
	}

	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	/**
	 * getter for UNIT_ID
	 * 
	 * @generated
	 */
	public String getUnitId() {
		return this.unitId;
	}

	/**
	 * setter for UNIT_ID
	 * 
	 * @generated
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
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
	 * getter for STATUS
	 * 
	 * @generated
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * setter for STATUS
	 * 
	 * @generated
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * getter for NEXT_CHECK
	 * 
	 * @generated
	 */
	public String getNextCheck() {
		return this.nextCheck;
	}

	/**
	 * setter for NEXT_CHECK
	 * 
	 * @generated
	 */
	public void setNextCheck(String nextCheck) {
		this.nextCheck = nextCheck;
	}

	/**
	 * getter for APPLY_YEAR
	 * 
	 * @generated
	 */
	public String getApplyYear() {
		return this.applyYear;
	}

	/**
	 * setter for APPLY_YEAR
	 * 
	 * @generated
	 */
	public void setApplyYear(String applyYear) {
		this.applyYear = applyYear;
	}

	/**
	 * getter for SERIAL_NUM
	 * 
	 * @generated
	 */
	public String getSerialNum() {
		return this.serialNum;
	}

	/**
	 * setter for SERIAL_NUM
	 * 
	 * @generated
	 */
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}

	/**
	 * getter for COMPANY_NAME
	 * 
	 * @generated
	 */
	public String getCompanyName() {
		return this.companyName;
	}

	/**
	 * setter for COMPANY_NAME
	 * 
	 * @generated
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	/**
	 * getter for ADDRESS
	 * 
	 * @generated
	 */
	public String getAddress() {
		return this.address;
	}

	/**
	 * setter for ADDRESS
	 * 
	 * @generated
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * getter for POST_CODE
	 * 
	 * @generated
	 */
	public String getPostCode() {
		return this.postCode;
	}

	/**
	 * setter for POST_CODE
	 * 
	 * @generated
	 */
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	/**
	 * getter for AGENT_PEOPLE
	 * 
	 * @generated
	 */
	public String getAgentPeople() {
		return this.agentPeople;
	}

	/**
	 * setter for AGENT_PEOPLE
	 * 
	 * @generated
	 */
	public void setAgentPeople(String agentPeople) {
		this.agentPeople = agentPeople;
	}

	/**
	 * getter for AGENT_PHONE
	 * 
	 * @generated
	 */
	public String getAgentPhone() {
		return this.agentPhone;
	}

	/**
	 * setter for AGENT_PHONE
	 * 
	 * @generated
	 */
	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}

	/**
	 * getter for AGENT_EMAIL
	 * 
	 * @generated
	 */
	public String getAgentEmail() {
		return this.agentEmail;
	}

	/**
	 * setter for AGENT_EMAIL
	 * 
	 * @generated
	 */
	public void setAgentEmail(String agentEmail) {
		this.agentEmail = agentEmail;
	}

	/**
	 * getter for WEB_ADDRESS
	 * 
	 * @generated
	 */
	public String getWebAddress() {
		return this.webAddress;
	}

	/**
	 * setter for WEB_ADDRESS
	 * 
	 * @generated
	 */
	public void setWebAddress(String webAddress) {
		this.webAddress = webAddress;
	}

	/**
	 * getter for ECONOMIC_NATURE_CODE
	 * 
	 * @generated
	 */
	public String getEconomicNatureCode() {
		return this.economicNatureCode;
	}

	/**
	 * setter for ECONOMIC_NATURE_CODE
	 * 
	 * @generated
	 */
	public void setEconomicNatureCode(String economicNatureCode) {
		this.economicNatureCode = economicNatureCode;
	}

	/**
	 * getter for ECONOMIC_NATURE_NAME
	 * 
	 * @generated
	 */
	public String getEconomicNatureName() {
		return this.economicNatureName;
	}

	/**
	 * setter for ECONOMIC_NATURE_NAME
	 * 
	 * @generated
	 */
	public void setEconomicNatureName(String economicNatureName) {
		this.economicNatureName = economicNatureName;
	}

	/**
	 * getter for ORGAN_CODE
	 * 
	 * @generated
	 */
	public String getOrganCode() {
		return this.organCode;
	}

	/**
	 * setter for ORGAN_CODE
	 * 
	 * @generated
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * getter for LICENSE_CODE
	 * 
	 * @generated
	 */
	public String getLicenseCode() {
		return this.licenseCode;
	}

	/**
	 * setter for LICENSE_CODE
	 * 
	 * @generated
	 */
	public void setLicenseCode(String licenseCode) {
		this.licenseCode = licenseCode;
	}

	/**
	 * getter for REGISTRATION_CODE
	 * 
	 * @generated
	 */
	public String getRegistrationCode() {
		return this.registrationCode;
	}

	/**
	 * setter for REGISTRATION_CODE
	 * 
	 * @generated
	 */
	public void setRegistrationCode(String registrationCode) {
		this.registrationCode = registrationCode;
	}

	/**
	 * getter for FIRST_SCOPE
	 * 
	 * @generated
	 */
	public String getFirstScope() {
		return this.firstScope;
	}

	/**
	 * setter for FIRST_SCOPE
	 * 
	 * @generated
	 */
	public void setFirstScope(String firstScope) {
		this.firstScope = firstScope;
	}

	/**
	 * getter for SECOND_SCOPE
	 * 
	 * @generated
	 */
	public String getSecondScope() {
		return this.secondScope;
	}

	/**
	 * setter for SECOND_SCOPE
	 * 
	 * @generated
	 */
	public void setSecondScope(String secondScope) {
		this.secondScope = secondScope;
	}

	/**
	 * getter for REG_FUND
	 * 
	 * @generated
	 */
	public BigDecimal getRegFund() {
		return this.regFund;
	}

	/**
	 * setter for REG_FUND
	 * 
	 * @generated
	 */
	public void setRegFund(BigDecimal regFund) {
		this.regFund = regFund;
	}

	/**
	 * getter for REASON
	 * 
	 * @generated
	 */
	public String getReason() {
		return this.reason;
	}

	/**
	 * setter for REASON
	 * 
	 * @generated
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * getter for APPROVE_DATE
	 * 
	 * @generated
	 */
	public String getApproveDate() {
		return this.approveDate;
	}

	/**
	 * setter for APPROVE_DATE
	 * 
	 * @generated
	 */
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}

	/**
	 * getter for ISSUEL_ORGAN
	 * 
	 * @generated
	 */
	public String getIssuelOrgan() {
		return this.issuelOrgan;
	}

	/**
	 * setter for ISSUEL_ORGAN
	 * 
	 * @generated
	 */
	public void setIssuelOrgan(String issuelOrgan) {
		this.issuelOrgan = issuelOrgan;
	}

	/**
	 * getter for ISSUEL_DATE
	 * 
	 * @generated
	 */
	public String getIssuelDate() {
		return this.issuelDate;
	}

	/**
	 * setter for ISSUEL_DATE
	 * 
	 * @generated
	 */
	public void setIssuelDate(String issuelDate) {
		this.issuelDate = issuelDate;
	}

	/**
	 * getter for MORG_NAME
	 * 
	 * @generated
	 */
	public String getMorgName() {
		return this.morgName;
	}

	/**
	 * setter for MORG_NAME
	 * 
	 * @generated
	 */
	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	/**
	 * getter for MORG_AREA
	 * 
	 * @generated
	 */
	public String getMorgArea() {
		return this.morgArea;
	}

	/**
	 * setter for MORG_AREA
	 * 
	 * @generated
	 */
	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

}