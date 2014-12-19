package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * WealComfortNo
 * @description:最大
 * @author zhanghui
 * 
 */
@Table(tableName = "WEAL_CERT", keyFields = "taskCode")
public class WealCert extends StatefulDatabean {

	
	@Rule(value = "require")
	@Column(name = "TASK_CODE")
	private String taskCode;

	@Column(name = "FIT_ID")
	private String fitId;

	@Column(name = "COMPANY_TYPE")
	private String companyType;

	@Column(name = "CERT_TYPE")
	private String certType;
	
	@Column(name = "ISSUER_PEOPLE")
	private String issuerPeople;
	
	@Column(name = "LICENSE_PEOPLE")
	private String licensePeople;
	
	@Column(name = "SERIAL_NUM")
	private String serialNum;
	
	@Column(name = "COMPANY_NAME")
	private String companyName;
	
	@Column(name = "LEGAL_PEOPLE")
	private String legalPeople;
	
	@Column(name = "ORGAN_TYPE")
	private String organType;
	
	@Column(name = "BUSINESS_SCOPE")
	private String businessScope;
	
	@Column(name = "SITE_AREA")
	private BigDecimal siteArea;
	
	@Column(name = "COMPANY_ADDRESS")
	private String companyAddress;
	
	@Column(name = "START_DATE")
	private String startDate;
	
	@Column(name = "END_DATE")
	private String endDate;

	@Column(name = "SIGN_DATE")
	private String signDate;

	@Column(name = "SIGN_ORGAN")
	private String signOrgan;

	@Column(name = "CERT_STATUS")
	private String certStatus;

	@Column(name = "MORG_NAME")
	private String morgName;

	@Column(name = "MORG_AREA")
	private String morgArea;

	@Column(name = "CANCEL_PEOPLE")
	private String cancelPeople;

	@Column(name = "CANCEL_TIME")
	private String cancelTime;

	@Column(name = "CANCEL_REASON")
	private String cancelReason;

	@Column(name = "APPROVE_DATE")
	private String approveDate;
	
	public String getFitId() {
		return fitId;
	}

	public void setFitId(String fitId) {
		this.fitId = fitId;
	}

	public String getApproveDate() {
		return approveDate;
	}

	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}

	

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getCompanyType() {
		return companyType;
	}

	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}

	public String getCertType() {
		return certType;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	public String getIssuerPeople() {
		return issuerPeople;
	}

	public void setIssuerPeople(String issuerPeople) {
		this.issuerPeople = issuerPeople;
	}

	public String getLicensePeople() {
		return licensePeople;
	}

	public void setLicensePeople(String licensePeople) {
		this.licensePeople = licensePeople;
	}

	public String getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getLegalPeople() {
		return legalPeople;
	}

	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	public String getOrganType() {
		return organType;
	}

	public void setOrganType(String organType) {
		this.organType = organType;
	}

	public String getBusinessScope() {
		return businessScope;
	}

	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
	}

	public BigDecimal getSiteArea() {
		return siteArea;
	}

	public void setSiteArea(BigDecimal siteArea) {
		this.siteArea = siteArea;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getSignDate() {
		return signDate;
	}

	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}

	public String getSignOrgan() {
		return signOrgan;
	}

	public void setSignOrgan(String signOrgan) {
		this.signOrgan = signOrgan;
	}

	public String getCertStatus() {
		return certStatus;
	}

	public void setCertStatus(String certStatus) {
		this.certStatus = certStatus;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getMorgArea() {
		return morgArea;
	}

	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	public String getCancelPeople() {
		return cancelPeople;
	}

	public void setCancelPeople(String cancelPeople) {
		this.cancelPeople = cancelPeople;
	}

	public String getCancelTime() {
		return cancelTime;
	}

	public void setCancelTime(String cancelTime) {
		this.cancelTime = cancelTime;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	


}