package com.inspur.cams.welfare.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:WealUnitInfo
 * @description:福利企业资格认定业务信息表
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
@Table(tableName = "WEAL_UNIT_INFO", keyFields = "taskCode")
public class WealUnitInfo extends StatefulDatabean {
	// TASK_CODE
	@Rule(value = "require")
	@Column(name = "TASK_CODE")
	private String taskCode;
	// APPLY_TYPE
	@Column(name = "APPLY_TYPE")
	private String applyType;
	// REG_DATE
	@Column(name = "REG_DATE")
	private String regDate;
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
	// LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
	private String legalPeople;
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
	
	@Column(name = "REG_FUND")
	private BigDecimal regFund;
	// REASON
	@Column(name = "REASON")
	private String reason;
	// MAIN_GOODS
	@Column(name = "MAIN_GOODS")
	private String mainGoods;
	// NATIONTAX_REG
	@Column(name = "NATIONTAX_REG")
	private String nationtaxReg;
	// LANDTAX_REG
	@Column(name = "LANDTAX_REG")
	private String landtaxReg;
	// BANK
	@Column(name = "BANK")
	private String bank;
	// ACCOUNT_NO
	@Column(name = "ACCOUNT_NO")
	private String accountNo;
	// LEGAL_PHONE
	@Column(name = "LEGAL_PHONE")
	private String legalPhone;
	@Column(name = "LEGAL_TELPHONE")
	private String legalTelphone;
	@Column(name = "LEGAL_ID_CARD")
	private String legalIdCard;
	// WORKERS_ALL
	
	@Column(name = "WORKERS_ALL")
	private BigDecimal workersAll;
	// WORKERS_HEALTH
	
	@Column(name = "WORKERS_HEALTH")
	private BigDecimal workersHealth;
	// WORKERS_DEFORM
	
	@Column(name = "WORKERS_DEFORM")
	private BigDecimal workersDeform;
	// WORKERS_DEFORM_LIMB
	
	@Column(name = "WORKERS_DEFORM_LIMB")
	private BigDecimal workersDeformLimb;
	// WORKERS_DEFORM_HEAR
	
	@Column(name = "WORKERS_DEFORM_HEAR")
	private BigDecimal workersDeformHear;
	// WORKERS_DEFORM_EYE
	
	@Column(name = "WORKERS_DEFORM_EYE")
	private BigDecimal workersDeformEye;
	// WORKERS_DEFORM_MULTI
	
	@Column(name = "WORKERS_DEFORM_MULTI")
	private BigDecimal workersDeformMulti;
	// SCALE_LIMB
	//
	@Column(name = "SCALE_LIMB")
	private BigDecimal scaleLimb;
	// ASSETS
	
	@Column(name = "ASSETS")
	private BigDecimal assets;
	// INCOME_BUSINESS
	
	@Column(name = "INCOME_BUSINESS")
	private BigDecimal incomeBusiness;
	// ALLCOST
	
	@Column(name = "ALLCOST")
	private BigDecimal allcost;
	// GAIN_BUSINESS
	
	@Column(name = "GAIN_BUSINESS")
	private BigDecimal gainBusiness;
	// ADDINGVALUE
	
	@Column(name = "ADDINGVALUE")
	private BigDecimal addingvalue;
	// TAX_ALL
	
	@Column(name = "TAX_ALL")
	private BigDecimal taxAll;
	// TAX_ADDED
	
	@Column(name = "TAX_ADDED")
	private BigDecimal taxAdded;
	// TAX_BUSINESS
	
	@Column(name = "TAX_BUSINESS")
	private BigDecimal taxBusiness;
	// TAX_INCOME
	
	@Column(name = "TAX_INCOME")
	private BigDecimal taxIncome;
	// TAX_SHOULD_REDUCE
	
	@Column(name = "TAX_SHOULD_REDUCE")
	private BigDecimal taxShouldReduce;
	// TAX_FACT_REDUCE
	
	@Column(name = "TAX_FACT_REDUCE")
	private BigDecimal taxFactReduce;
	// PROFIT
	
	@Column(name = "PROFIT")
	private BigDecimal profit;
	// LOW_WAGE_COUNTY
	
	@Column(name = "LOW_WAGE_COUNTY")
	private BigDecimal lowWageCounty;
	// LOW_WAGE_DEFORM
	
	@Column(name = "LOW_WAGE_DEFORM")
	private BigDecimal lowWageDeform;
	// INCOME_PERWORKER_YEAR
	
	@Column(name = "INCOME_PERWORKER_YEAR")
	private BigDecimal incomePerworkerYear;
	// INCOME_PERDEDORM_YEAR
	
	@Column(name = "INCOME_PERDEDORM_YEAR")
	private BigDecimal incomePerdedormYear;
	// WORKERS_DEFORM_SECURITY
	
	@Column(name = "WORKERS_DEFORM_SECURITY")
	private BigDecimal workersDeformSecurity;
	// WORKERS_DEFORM_MEDICAL
	
	@Column(name = "WORKERS_DEFORM_MEDICAL")
	private BigDecimal workersDeformMedical;
	// WORKERS_DEFORM_PACT
	
	@Column(name = "WORKERS_DEFORM_PACT")
	private BigDecimal workersDeformPact;
	// WORKERS_DEFORM_PAYBYBANK
	
	@Column(name = "WORKERS_DEFORM_PAYBYBANK")
	private BigDecimal workersDeformPaybybank;
	// TAX_REDUCE
	
	@Column(name = "TAX_REDUCE")
	private BigDecimal taxReduce;
	// TAX_REDUCE_WEAL
	
	@Column(name = "TAX_REDUCE_WEAL")
	private BigDecimal taxReduceWeal;
	// TAX_REDUCE_DONATE
	
	@Column(name = "TAX_REDUCE_DONATE")
	private BigDecimal taxReduceDonate;
	// STEP_FOR_DEFORM
	@Column(name = "STEP_FOR_DEFORM")
	private String stepForDeform;
	// IDEA_FROM_DEFORM
	@Column(name = "IDEA_FROM_DEFORM")
	private String ideaFromDeform;
	// COUNTYNATIONTAX_OPINION
	@Column(name = "COUNTYNATIONTAX_OPINION")
	private String countynationtaxOpinion;
	// COUNTYNATIONTAX_TIME
	@Column(name = "COUNTYNATIONTAX_TIME")
	private String countynationtaxTime;
	// COUNTYLANDTAX_OPINION
	@Column(name = "COUNTYLANDTAX_OPINION")
	private String countylandtaxOpinion;
	// COUNTYLANDTAX_TIME
	@Column(name = "COUNTYLANDTAX_TIME")
	private String countylandtaxTime;
	// CITYNATIONTAX_OPINION
	@Column(name = "CITYNATIONTAX_OPINION")
	private String citynationtaxOpinion;
	// CITYNATIONTAX_TIME
	@Column(name = "CITYNATIONTAX_TIME")
	private String citynationtaxTime;
	// CITYLANDTAX_OPINION
	@Column(name = "CITYLANDTAX_OPINION")
	private String citylandtaxOpinion;
	// CITYLANDTAX_TIME
	@Column(name = "CITYLANDTAX_TIME")
	private String citylandtaxTime;
	// WORKERS_DEFORM_UNEMPLOYED
	@Column(name = "WORKERS_DEFORM_UNEMPLOYED")
	private String workersDeformUnemployed;
	// WORKERS_DEFORM_INJURY
	@Column(name = "WORKERS_DEFORM_INJURY")
	private String workersDeformInjury;

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
	 * getter for APPLY_TYPE
	 * 
	 * @generated
	 */
	public String getApplyType() {
		return this.applyType;
	}

	/**
	 * setter for APPLY_TYPE
	 * 
	 * @generated
	 */
	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	/**
	 * getter for REG_DATE
	 * 
	 * @generated
	 */
	public String getRegDate() {
		return this.regDate;
	}

	/**
	 * setter for REG_DATE
	 * 
	 * @generated
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
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
	 * getter for LEGAL_PEOPLE
	 * 
	 * @generated
	 */
	public String getLegalPeople() {
		return this.legalPeople;
	}

	/**
	 * setter for LEGAL_PEOPLE
	 * 
	 * @generated
	 */
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
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
	 * getter for MAIN_GOODS
	 * 
	 * @generated
	 */
	public String getMainGoods() {
		return this.mainGoods;
	}

	/**
	 * setter for MAIN_GOODS
	 * 
	 * @generated
	 */
	public void setMainGoods(String mainGoods) {
		this.mainGoods = mainGoods;
	}

	/**
	 * getter for NATIONTAX_REG
	 * 
	 * @generated
	 */
	public String getNationtaxReg() {
		return this.nationtaxReg;
	}

	/**
	 * setter for NATIONTAX_REG
	 * 
	 * @generated
	 */
	public void setNationtaxReg(String nationtaxReg) {
		this.nationtaxReg = nationtaxReg;
	}

	/**
	 * getter for LANDTAX_REG
	 * 
	 * @generated
	 */
	public String getLandtaxReg() {
		return this.landtaxReg;
	}

	/**
	 * setter for LANDTAX_REG
	 * 
	 * @generated
	 */
	public void setLandtaxReg(String landtaxReg) {
		this.landtaxReg = landtaxReg;
	}

	/**
	 * getter for BANK
	 * 
	 * @generated
	 */
	public String getBank() {
		return this.bank;
	}

	/**
	 * setter for BANK
	 * 
	 * @generated
	 */
	public void setBank(String bank) {
		this.bank = bank;
	}

	/**
	 * getter for ACCOUNT_NO
	 * 
	 * @generated
	 */
	public String getAccountNo() {
		return this.accountNo;
	}

	/**
	 * setter for ACCOUNT_NO
	 * 
	 * @generated
	 */
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	/**
	 * getter for LEGAL_PHONE
	 * 
	 * @generated
	 */
	public String getLegalPhone() {
		return this.legalPhone;
	}

	/**
	 * setter for LEGAL_PHONE
	 * 
	 * @generated
	 */
	public void setLegalPhone(String legalPhone) {
		this.legalPhone = legalPhone;
	}

	/**
	 * getter for WORKERS_ALL
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersAll() {
		return this.workersAll;
	}

	/**
	 * setter for WORKERS_ALL
	 * 
	 * @generated
	 */
	public void setWorkersAll(BigDecimal workersAll) {
		this.workersAll = workersAll;
	}

	/**
	 * getter for WORKERS_HEALTH
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersHealth() {
		return this.workersHealth;
	}

	/**
	 * setter for WORKERS_HEALTH
	 * 
	 * @generated
	 */
	public void setWorkersHealth(BigDecimal workersHealth) {
		this.workersHealth = workersHealth;
	}

	/**
	 * getter for WORKERS_DEFORM
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeform() {
		return this.workersDeform;
	}

	/**
	 * setter for WORKERS_DEFORM
	 * 
	 * @generated
	 */
	public void setWorkersDeform(BigDecimal workersDeform) {
		this.workersDeform = workersDeform;
	}

	/**
	 * getter for WORKERS_DEFORM_LIMB
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformLimb() {
		return this.workersDeformLimb;
	}

	/**
	 * setter for WORKERS_DEFORM_LIMB
	 * 
	 * @generated
	 */
	public void setWorkersDeformLimb(BigDecimal workersDeformLimb) {
		this.workersDeformLimb = workersDeformLimb;
	}

	/**
	 * getter for WORKERS_DEFORM_HEAR
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformHear() {
		return this.workersDeformHear;
	}

	/**
	 * setter for WORKERS_DEFORM_HEAR
	 * 
	 * @generated
	 */
	public void setWorkersDeformHear(BigDecimal workersDeformHear) {
		this.workersDeformHear = workersDeformHear;
	}

	/**
	 * getter for WORKERS_DEFORM_EYE
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformEye() {
		return this.workersDeformEye;
	}

	/**
	 * setter for WORKERS_DEFORM_EYE
	 * 
	 * @generated
	 */
	public void setWorkersDeformEye(BigDecimal workersDeformEye) {
		this.workersDeformEye = workersDeformEye;
	}

	/**
	 * getter for WORKERS_DEFORM_MULTI
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformMulti() {
		return this.workersDeformMulti;
	}

	/**
	 * setter for WORKERS_DEFORM_MULTI
	 * 
	 * @generated
	 */
	public void setWorkersDeformMulti(BigDecimal workersDeformMulti) {
		this.workersDeformMulti = workersDeformMulti;
	}

	/**
	 * getter for SCALE_LIMB
	 * 
	 * @generated
	 */
	public BigDecimal getScaleLimb() {
		return this.scaleLimb;
	}

	/**
	 * setter for SCALE_LIMB
	 * 
	 * @generated
	 */
	public void setScaleLimb(BigDecimal scaleLimb) {
		this.scaleLimb = scaleLimb;
	}

	/**
	 * getter for ASSETS
	 * 
	 * @generated
	 */
	public BigDecimal getAssets() {
		return this.assets;
	}

	/**
	 * setter for ASSETS
	 * 
	 * @generated
	 */
	public void setAssets(BigDecimal assets) {
		this.assets = assets;
	}

	/**
	 * getter for INCOME_BUSINESS
	 * 
	 * @generated
	 */
	public BigDecimal getIncomeBusiness() {
		return this.incomeBusiness;
	}

	/**
	 * setter for INCOME_BUSINESS
	 * 
	 * @generated
	 */
	public void setIncomeBusiness(BigDecimal incomeBusiness) {
		this.incomeBusiness = incomeBusiness;
	}

	/**
	 * getter for ALLCOST
	 * 
	 * @generated
	 */
	public BigDecimal getAllcost() {
		return this.allcost;
	}

	/**
	 * setter for ALLCOST
	 * 
	 * @generated
	 */
	public void setAllcost(BigDecimal allcost) {
		this.allcost = allcost;
	}

	/**
	 * getter for GAIN_BUSINESS
	 * 
	 * @generated
	 */
	public BigDecimal getGainBusiness() {
		return this.gainBusiness;
	}

	/**
	 * setter for GAIN_BUSINESS
	 * 
	 * @generated
	 */
	public void setGainBusiness(BigDecimal gainBusiness) {
		this.gainBusiness = gainBusiness;
	}

	/**
	 * getter for ADDINGVALUE
	 * 
	 * @generated
	 */
	public BigDecimal getAddingvalue() {
		return this.addingvalue;
	}

	/**
	 * setter for ADDINGVALUE
	 * 
	 * @generated
	 */
	public void setAddingvalue(BigDecimal addingvalue) {
		this.addingvalue = addingvalue;
	}

	/**
	 * getter for TAX_ALL
	 * 
	 * @generated
	 */
	public BigDecimal getTaxAll() {
		return this.taxAll;
	}

	/**
	 * setter for TAX_ALL
	 * 
	 * @generated
	 */
	public void setTaxAll(BigDecimal taxAll) {
		this.taxAll = taxAll;
	}

	/**
	 * getter for TAX_ADDED
	 * 
	 * @generated
	 */
	public BigDecimal getTaxAdded() {
		return this.taxAdded;
	}

	/**
	 * setter for TAX_ADDED
	 * 
	 * @generated
	 */
	public void setTaxAdded(BigDecimal taxAdded) {
		this.taxAdded = taxAdded;
	}

	/**
	 * getter for TAX_BUSINESS
	 * 
	 * @generated
	 */
	public BigDecimal getTaxBusiness() {
		return this.taxBusiness;
	}

	/**
	 * setter for TAX_BUSINESS
	 * 
	 * @generated
	 */
	public void setTaxBusiness(BigDecimal taxBusiness) {
		this.taxBusiness = taxBusiness;
	}

	/**
	 * getter for TAX_INCOME
	 * 
	 * @generated
	 */
	public BigDecimal getTaxIncome() {
		return this.taxIncome;
	}

	/**
	 * setter for TAX_INCOME
	 * 
	 * @generated
	 */
	public void setTaxIncome(BigDecimal taxIncome) {
		this.taxIncome = taxIncome;
	}

	/**
	 * getter for TAX_SHOULD_REDUCE
	 * 
	 * @generated
	 */
	public BigDecimal getTaxShouldReduce() {
		return this.taxShouldReduce;
	}

	/**
	 * setter for TAX_SHOULD_REDUCE
	 * 
	 * @generated
	 */
	public void setTaxShouldReduce(BigDecimal taxShouldReduce) {
		this.taxShouldReduce = taxShouldReduce;
	}

	/**
	 * getter for TAX_FACT_REDUCE
	 * 
	 * @generated
	 */
	public BigDecimal getTaxFactReduce() {
		return this.taxFactReduce;
	}

	/**
	 * setter for TAX_FACT_REDUCE
	 * 
	 * @generated
	 */
	public void setTaxFactReduce(BigDecimal taxFactReduce) {
		this.taxFactReduce = taxFactReduce;
	}

	/**
	 * getter for PROFIT
	 * 
	 * @generated
	 */
	public BigDecimal getProfit() {
		return this.profit;
	}

	/**
	 * setter for PROFIT
	 * 
	 * @generated
	 */
	public void setProfit(BigDecimal profit) {
		this.profit = profit;
	}

	/**
	 * getter for LOW_WAGE_COUNTY
	 * 
	 * @generated
	 */
	public BigDecimal getLowWageCounty() {
		return this.lowWageCounty;
	}

	/**
	 * setter for LOW_WAGE_COUNTY
	 * 
	 * @generated
	 */
	public void setLowWageCounty(BigDecimal lowWageCounty) {
		this.lowWageCounty = lowWageCounty;
	}

	/**
	 * getter for LOW_WAGE_DEFORM
	 * 
	 * @generated
	 */
	public BigDecimal getLowWageDeform() {
		return this.lowWageDeform;
	}

	/**
	 * setter for LOW_WAGE_DEFORM
	 * 
	 * @generated
	 */
	public void setLowWageDeform(BigDecimal lowWageDeform) {
		this.lowWageDeform = lowWageDeform;
	}

	/**
	 * getter for INCOME_PERWORKER_YEAR
	 * 
	 * @generated
	 */
	public BigDecimal getIncomePerworkerYear() {
		return this.incomePerworkerYear;
	}

	/**
	 * setter for INCOME_PERWORKER_YEAR
	 * 
	 * @generated
	 */
	public void setIncomePerworkerYear(BigDecimal incomePerworkerYear) {
		this.incomePerworkerYear = incomePerworkerYear;
	}

	/**
	 * getter for INCOME_PERDEDORM_YEAR
	 * 
	 * @generated
	 */
	public BigDecimal getIncomePerdedormYear() {
		return this.incomePerdedormYear;
	}

	/**
	 * setter for INCOME_PERDEDORM_YEAR
	 * 
	 * @generated
	 */
	public void setIncomePerdedormYear(BigDecimal incomePerdedormYear) {
		this.incomePerdedormYear = incomePerdedormYear;
	}

	/**
	 * getter for WORKERS_DEFORM_SECURITY
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformSecurity() {
		return this.workersDeformSecurity;
	}

	/**
	 * setter for WORKERS_DEFORM_SECURITY
	 * 
	 * @generated
	 */
	public void setWorkersDeformSecurity(BigDecimal workersDeformSecurity) {
		this.workersDeformSecurity = workersDeformSecurity;
	}

	/**
	 * getter for WORKERS_DEFORM_MEDICAL
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformMedical() {
		return this.workersDeformMedical;
	}

	/**
	 * setter for WORKERS_DEFORM_MEDICAL
	 * 
	 * @generated
	 */
	public void setWorkersDeformMedical(BigDecimal workersDeformMedical) {
		this.workersDeformMedical = workersDeformMedical;
	}

	/**
	 * getter for WORKERS_DEFORM_PACT
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformPact() {
		return this.workersDeformPact;
	}

	/**
	 * setter for WORKERS_DEFORM_PACT
	 * 
	 * @generated
	 */
	public void setWorkersDeformPact(BigDecimal workersDeformPact) {
		this.workersDeformPact = workersDeformPact;
	}

	/**
	 * getter for WORKERS_DEFORM_PAYBYBANK
	 * 
	 * @generated
	 */
	public BigDecimal getWorkersDeformPaybybank() {
		return this.workersDeformPaybybank;
	}

	/**
	 * setter for WORKERS_DEFORM_PAYBYBANK
	 * 
	 * @generated
	 */
	public void setWorkersDeformPaybybank(BigDecimal workersDeformPaybybank) {
		this.workersDeformPaybybank = workersDeformPaybybank;
	}

	/**
	 * getter for TAX_REDUCE
	 * 
	 * @generated
	 */
	public BigDecimal getTaxReduce() {
		return this.taxReduce;
	}

	/**
	 * setter for TAX_REDUCE
	 * 
	 * @generated
	 */
	public void setTaxReduce(BigDecimal taxReduce) {
		this.taxReduce = taxReduce;
	}

	/**
	 * getter for TAX_REDUCE_WEAL
	 * 
	 * @generated
	 */
	public BigDecimal getTaxReduceWeal() {
		return this.taxReduceWeal;
	}

	/**
	 * setter for TAX_REDUCE_WEAL
	 * 
	 * @generated
	 */
	public void setTaxReduceWeal(BigDecimal taxReduceWeal) {
		this.taxReduceWeal = taxReduceWeal;
	}

	/**
	 * getter for TAX_REDUCE_DONATE
	 * 
	 * @generated
	 */
	public BigDecimal getTaxReduceDonate() {
		return this.taxReduceDonate;
	}

	/**
	 * setter for TAX_REDUCE_DONATE
	 * 
	 * @generated
	 */
	public void setTaxReduceDonate(BigDecimal taxReduceDonate) {
		this.taxReduceDonate = taxReduceDonate;
	}

	/**
	 * getter for STEP_FOR_DEFORM
	 * 
	 * @generated
	 */
	public String getStepForDeform() {
		return this.stepForDeform;
	}

	/**
	 * setter for STEP_FOR_DEFORM
	 * 
	 * @generated
	 */
	public void setStepForDeform(String stepForDeform) {
		this.stepForDeform = stepForDeform;
	}

	/**
	 * getter for IDEA_FROM_DEFORM
	 * 
	 * @generated
	 */
	public String getIdeaFromDeform() {
		return this.ideaFromDeform;
	}

	/**
	 * setter for IDEA_FROM_DEFORM
	 * 
	 * @generated
	 */
	public void setIdeaFromDeform(String ideaFromDeform) {
		this.ideaFromDeform = ideaFromDeform;
	}

	/**
	 * getter for COUNTYNATIONTAX_OPINION
	 * 
	 * @generated
	 */
	public String getCountynationtaxOpinion() {
		return this.countynationtaxOpinion;
	}

	/**
	 * setter for COUNTYNATIONTAX_OPINION
	 * 
	 * @generated
	 */
	public void setCountynationtaxOpinion(String countynationtaxOpinion) {
		this.countynationtaxOpinion = countynationtaxOpinion;
	}

	/**
	 * getter for COUNTYNATIONTAX_TIME
	 * 
	 * @generated
	 */
	public String getCountynationtaxTime() {
		return this.countynationtaxTime;
	}

	/**
	 * setter for COUNTYNATIONTAX_TIME
	 * 
	 * @generated
	 */
	public void setCountynationtaxTime(String countynationtaxTime) {
		this.countynationtaxTime = countynationtaxTime;
	}

	/**
	 * getter for COUNTYLANDTAX_OPINION
	 * 
	 * @generated
	 */
	public String getCountylandtaxOpinion() {
		return this.countylandtaxOpinion;
	}

	/**
	 * setter for COUNTYLANDTAX_OPINION
	 * 
	 * @generated
	 */
	public void setCountylandtaxOpinion(String countylandtaxOpinion) {
		this.countylandtaxOpinion = countylandtaxOpinion;
	}

	/**
	 * getter for COUNTYLANDTAX_TIME
	 * 
	 * @generated
	 */
	public String getCountylandtaxTime() {
		return this.countylandtaxTime;
	}

	/**
	 * setter for COUNTYLANDTAX_TIME
	 * 
	 * @generated
	 */
	public void setCountylandtaxTime(String countylandtaxTime) {
		this.countylandtaxTime = countylandtaxTime;
	}

	/**
	 * getter for CITYNATIONTAX_OPINION
	 * 
	 * @generated
	 */
	public String getCitynationtaxOpinion() {
		return this.citynationtaxOpinion;
	}

	/**
	 * setter for CITYNATIONTAX_OPINION
	 * 
	 * @generated
	 */
	public void setCitynationtaxOpinion(String citynationtaxOpinion) {
		this.citynationtaxOpinion = citynationtaxOpinion;
	}

	/**
	 * getter for CITYNATIONTAX_TIME
	 * 
	 * @generated
	 */
	public String getCitynationtaxTime() {
		return this.citynationtaxTime;
	}

	/**
	 * setter for CITYNATIONTAX_TIME
	 * 
	 * @generated
	 */
	public void setCitynationtaxTime(String citynationtaxTime) {
		this.citynationtaxTime = citynationtaxTime;
	}

	/**
	 * getter for CITYLANDTAX_OPINION
	 * 
	 * @generated
	 */
	public String getCitylandtaxOpinion() {
		return this.citylandtaxOpinion;
	}

	/**
	 * setter for CITYLANDTAX_OPINION
	 * 
	 * @generated
	 */
	public void setCitylandtaxOpinion(String citylandtaxOpinion) {
		this.citylandtaxOpinion = citylandtaxOpinion;
	}

	/**
	 * getter for CITYLANDTAX_TIME
	 * 
	 * @generated
	 */
	public String getCitylandtaxTime() {
		return this.citylandtaxTime;
	}

	/**
	 * setter for CITYLANDTAX_TIME
	 * 
	 * @generated
	 */
	public void setCitylandtaxTime(String citylandtaxTime) {
		this.citylandtaxTime = citylandtaxTime;
	}

	public String getWorkersDeformUnemployed() {
		return workersDeformUnemployed;
	}

	public void setWorkersDeformUnemployed(String workersDeformUnemployed) {
		this.workersDeformUnemployed = workersDeformUnemployed;
	}

	public String getWorkersDeformInjury() {
		return workersDeformInjury;
	}

	public void setWorkersDeformInjury(String workersDeformInjury) {
		this.workersDeformInjury = workersDeformInjury;
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

}