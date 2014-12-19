package com.inspur.cams.sorg.base.data;

import java.math.*;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织筹备信息表
 * 
 * @author shgtch
 * @date 2011-8-9
 */
@Table(tableName = "SOM_PREPARE", keyFields = "sorgId")
public class SomPrepare extends StatefulDatabean {
	
	// 社会组织发起人（自然人）
	@Transient
	private List<SomHeldPeople> somHeldPeopleList = new ArrayList<SomHeldPeople>();
	
	// 社会组织发起人（单位）
	@Transient
	private List<SomHeldOrgan> somHeldOrganList = new ArrayList<SomHeldOrgan>();
	
	// 社会组织筹备拟任负责人
	@Transient
	private List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();

	// SORG_ID
	private String sorgId;
	
	// SORG_STATUS
	private String sorgStatus;

	// SORG_TYPE
	private String sorgType;

	// IF_BRANCH
	private String ifBranch;

	// MAIN_SORG_ID
	private String mainSorgId;

	// MAIN_SORG_CODE
	private String mainSorgCode;

	// CN_NAME
	private String cnName;

	// EN_NAME
	private String enName;

	// AB_NAME
	private String abName;

	// SORG_PHONE
	private String sorgPhone;

	// SORG_FAX
	private String sorgFax;

	// SORG_POST
	private String sorgPost;

	// SORG_ADDS
	private String sorgAdds;

	// SORG_WEB
	private String sorgWeb;

	// SORG_EMAIL
	private String sorgEmail;

	// RESIDE_SOURCE
	private String resideSource;

	// RESIDENCE
	private String residence;

	// PURPOSE
	private String purpose;

	// BUSINESS
	private String business;

	// BUSINESS_CODE
	private String businessCode;

	// BUS_SCOPE
	private String busScope;

	// BORG_NAME
	private String borgName;

	// ACT_AREA
	private String actArea;

	// MONEY
	private BigDecimal money;

	// CURRENCY
	private String currency;

	// MONEY_SOURCE
	private String moneySource;

	// UNITS_NUM
	private BigDecimal unitsNum;

	// PEOPLE_NUM
	private BigDecimal peopleNum;

	// BUILD_STATUS
	private String buildStatus;

	// ABSORP_MEMBER
	private String absorpMember;

	// DATA_SOURCE
	private String dataSource;

	// APP_PEOPLE
	private String appPeople;

	// APP_REASON
	private String appReason;

	// APP_PHONE
	private String appPhone;

	// APP_DATE
	private String appDate;

	// MORG_NAME
	private String morgName;

	// MORG_AREA
	private String morgArea;

	// NOTE
	private String note;

	// CREATE_PEOPLE
	private String createPeople;

	// CREATE_TIME
	private String createTime;

	public List<SomHeldPeople> getSomHeldPeopleList() {
		return somHeldPeopleList;
	}

	public void setSomHeldPeopleList(List<SomHeldPeople> somHeldPeopleList) {
		this.somHeldPeopleList = somHeldPeopleList;
	}

	public List<SomHeldOrgan> getSomHeldOrganList() {
		return somHeldOrganList;
	}

	public void setSomHeldOrganList(List<SomHeldOrgan> somHeldOrganList) {
		this.somHeldOrganList = somHeldOrganList;
	}

	public List<SomAspchief> getSomAspchiefList() {
		return somAspchiefList;
	}

	public void setSomAspchiefList(List<SomAspchief> somAspchiefList) {
		this.somAspchiefList = somAspchiefList;
	}

	/**
	 * getter for SORG_ID
	 * 
	 * @generated
	 */
	public String getSorgId() {
		return this.sorgId;
	}

	/**
	 * setter for SORG_ID
	 * 
	 * @generated
	 */
	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	/**
	 * getter for SORG_STATUS
	 * 
	 * @generated
	 */
	public String getSorgStatus() {
		return this.sorgStatus;
	}

	/**
	 * setter for SORG_STATUS
	 * 
	 * @generated
	 */
	public void setSorgStatus(String sorgStatus) {
		this.sorgStatus = sorgStatus;
	}

	/**
	 * getter for SORG_TYPE
	 * 
	 * @generated
	 */
	public String getSorgType() {
		return this.sorgType;
	}

	/**
	 * setter for SORG_TYPE
	 * 
	 * @generated
	 */
	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	/**
	 * getter for IF_BRANCH
	 * 
	 * @generated
	 */
	public String getIfBranch() {
		return this.ifBranch;
	}

	/**
	 * setter for IF_BRANCH
	 * 
	 * @generated
	 */
	public void setIfBranch(String ifBranch) {
		this.ifBranch = ifBranch;
	}

	/**
	 * getter for MAIN_SORG_ID
	 * 
	 * @generated
	 */
	public String getMainSorgId() {
		return this.mainSorgId;
	}

	/**
	 * setter for MAIN_SORG_ID
	 * 
	 * @generated
	 */
	public void setMainSorgId(String mainSorgId) {
		this.mainSorgId = mainSorgId;
	}

	/**
	 * getter for MAIN_SORG_CODE
	 * 
	 * @generated
	 */
	public String getMainSorgCode() {
		return this.mainSorgCode;
	}

	/**
	 * setter for MAIN_SORG_CODE
	 * 
	 * @generated
	 */
	public void setMainSorgCode(String mainSorgCode) {
		this.mainSorgCode = mainSorgCode;
	}

	/**
	 * getter for CN_NAME
	 * 
	 * @generated
	 */
	public String getCnName() {
		return this.cnName;
	}

	/**
	 * setter for CN_NAME
	 * 
	 * @generated
	 */
	public void setCnName(String cnName) {
		this.cnName = cnName;
	}

	/**
	 * getter for EN_NAME
	 * 
	 * @generated
	 */
	public String getEnName() {
		return this.enName;
	}

	/**
	 * setter for EN_NAME
	 * 
	 * @generated
	 */
	public void setEnName(String enName) {
		this.enName = enName;
	}

	/**
	 * getter for AB_NAME
	 * 
	 * @generated
	 */
	public String getAbName() {
		return this.abName;
	}

	/**
	 * setter for AB_NAME
	 * 
	 * @generated
	 */
	public void setAbName(String abName) {
		this.abName = abName;
	}

	/**
	 * getter for SORG_PHONE
	 * 
	 * @generated
	 */
	public String getSorgPhone() {
		return this.sorgPhone;
	}

	/**
	 * setter for SORG_PHONE
	 * 
	 * @generated
	 */
	public void setSorgPhone(String sorgPhone) {
		this.sorgPhone = sorgPhone;
	}

	/**
	 * getter for SORG_FAX
	 * 
	 * @generated
	 */
	public String getSorgFax() {
		return this.sorgFax;
	}

	/**
	 * setter for SORG_FAX
	 * 
	 * @generated
	 */
	public void setSorgFax(String sorgFax) {
		this.sorgFax = sorgFax;
	}

	/**
	 * getter for SORG_POST
	 * 
	 * @generated
	 */
	public String getSorgPost() {
		return this.sorgPost;
	}

	/**
	 * setter for SORG_POST
	 * 
	 * @generated
	 */
	public void setSorgPost(String sorgPost) {
		this.sorgPost = sorgPost;
	}

	/**
	 * getter for SORG_ADDS
	 * 
	 * @generated
	 */
	public String getSorgAdds() {
		return this.sorgAdds;
	}

	/**
	 * setter for SORG_ADDS
	 * 
	 * @generated
	 */
	public void setSorgAdds(String sorgAdds) {
		this.sorgAdds = sorgAdds;
	}

	/**
	 * getter for SORG_WEB
	 * 
	 * @generated
	 */
	public String getSorgWeb() {
		return this.sorgWeb;
	}

	/**
	 * setter for SORG_WEB
	 * 
	 * @generated
	 */
	public void setSorgWeb(String sorgWeb) {
		this.sorgWeb = sorgWeb;
	}

	/**
	 * getter for SORG_EMAIL
	 * 
	 * @generated
	 */
	public String getSorgEmail() {
		return this.sorgEmail;
	}

	/**
	 * setter for SORG_EMAIL
	 * 
	 * @generated
	 */
	public void setSorgEmail(String sorgEmail) {
		this.sorgEmail = sorgEmail;
	}

	/**
	 * getter for RESIDE_SOURCE
	 * 
	 * @generated
	 */
	public String getResideSource() {
		return this.resideSource;
	}

	/**
	 * setter for RESIDE_SOURCE
	 * 
	 * @generated
	 */
	public void setResideSource(String resideSource) {
		this.resideSource = resideSource;
	}

	/**
	 * getter for RESIDENCE
	 * 
	 * @generated
	 */
	public String getResidence() {
		return this.residence;
	}

	/**
	 * setter for RESIDENCE
	 * 
	 * @generated
	 */
	public void setResidence(String residence) {
		this.residence = residence;
	}

	/**
	 * getter for PURPOSE
	 * 
	 * @generated
	 */
	public String getPurpose() {
		return this.purpose;
	}

	/**
	 * setter for PURPOSE
	 * 
	 * @generated
	 */
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	/**
	 * getter for BUSINESS
	 * 
	 * @generated
	 */
	public String getBusiness() {
		return this.business;
	}

	/**
	 * setter for BUSINESS
	 * 
	 * @generated
	 */
	public void setBusiness(String business) {
		this.business = business;
	}

	/**
	 * getter for BUSINESS_CODE
	 * 
	 * @generated
	 */
	public String getBusinessCode() {
		return this.businessCode;
	}

	/**
	 * setter for BUSINESS_CODE
	 * 
	 * @generated
	 */
	public void setBusinessCode(String businessCode) {
		this.businessCode = businessCode;
	}

	/**
	 * getter for BUS_SCOPE
	 * 
	 * @generated
	 */
	public String getBusScope() {
		return this.busScope;
	}

	/**
	 * setter for BUS_SCOPE
	 * 
	 * @generated
	 */
	public void setBusScope(String busScope) {
		this.busScope = busScope;
	}

	/**
	 * getter for BORG_NAME
	 * 
	 * @generated
	 */
	public String getBorgName() {
		return this.borgName;
	}

	/**
	 * setter for BORG_NAME
	 * 
	 * @generated
	 */
	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}

	/**
	 * getter for ACT_AREA
	 * 
	 * @generated
	 */
	public String getActArea() {
		return this.actArea;
	}

	/**
	 * setter for ACT_AREA
	 * 
	 * @generated
	 */
	public void setActArea(String actArea) {
		this.actArea = actArea;
	}

	/**
	 * getter for MONEY
	 * 
	 * @generated
	 */
	public BigDecimal getMoney() {
		return this.money;
	}

	/**
	 * setter for MONEY
	 * 
	 * @generated
	 */
	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	/**
	 * getter for CURRENCY
	 * 
	 * @generated
	 */
	public String getCurrency() {
		return this.currency;
	}

	/**
	 * setter for CURRENCY
	 * 
	 * @generated
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
	}

	/**
	 * getter for MONEY_SOURCE
	 * 
	 * @generated
	 */
	public String getMoneySource() {
		return this.moneySource;
	}

	/**
	 * setter for MONEY_SOURCE
	 * 
	 * @generated
	 */
	public void setMoneySource(String moneySource) {
		this.moneySource = moneySource;
	}

	/**
	 * getter for UNITS_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getUnitsNum() {
		return this.unitsNum;
	}

	/**
	 * setter for UNITS_NUM
	 * 
	 * @generated
	 */
	public void setUnitsNum(BigDecimal unitsNum) {
		this.unitsNum = unitsNum;
	}

	/**
	 * getter for PEOPLE_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getPeopleNum() {
		return this.peopleNum;
	}

	/**
	 * setter for PEOPLE_NUM
	 * 
	 * @generated
	 */
	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}

	/**
	 * getter for BUILD_STATUS
	 * 
	 * @generated
	 */
	public String getBuildStatus() {
		return this.buildStatus;
	}

	/**
	 * setter for BUILD_STATUS
	 * 
	 * @generated
	 */
	public void setBuildStatus(String buildStatus) {
		this.buildStatus = buildStatus;
	}

	/**
	 * getter for ABSORP_MEMBER
	 * 
	 * @generated
	 */
	public String getAbsorpMember() {
		return this.absorpMember;
	}

	/**
	 * setter for ABSORP_MEMBER
	 * 
	 * @generated
	 */
	public void setAbsorpMember(String absorpMember) {
		this.absorpMember = absorpMember;
	}

	/**
	 * getter for DATA_SOURCE
	 * 
	 * @generated
	 */
	public String getDataSource() {
		return this.dataSource;
	}

	/**
	 * setter for DATA_SOURCE
	 * 
	 * @generated
	 */
	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	/**
	 * getter for APP_PEOPLE
	 * 
	 * @generated
	 */
	public String getAppPeople() {
		return this.appPeople;
	}

	/**
	 * setter for APP_PEOPLE
	 * 
	 * @generated
	 */
	public void setAppPeople(String appPeople) {
		this.appPeople = appPeople;
	}

	/**
	 * getter for APP_REASON
	 * 
	 * @generated
	 */
	public String getAppReason() {
		return this.appReason;
	}

	/**
	 * setter for APP_REASON
	 * 
	 * @generated
	 */
	public void setAppReason(String appReason) {
		this.appReason = appReason;
	}

	/**
	 * getter for APP_PHONE
	 * 
	 * @generated
	 */
	public String getAppPhone() {
		return this.appPhone;
	}

	/**
	 * setter for APP_PHONE
	 * 
	 * @generated
	 */
	public void setAppPhone(String appPhone) {
		this.appPhone = appPhone;
	}

	/**
	 * getter for APP_DATE
	 * 
	 * @generated
	 */
	public String getAppDate() {
		return this.appDate;
	}

	/**
	 * setter for APP_DATE
	 * 
	 * @generated
	 */
	public void setAppDate(String appDate) {
		this.appDate = appDate;
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

	/**
	 * getter for NOTE
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for NOTE
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * getter for CREATE_PEOPLE
	 * 
	 * @generated
	 */
	public String getCreatePeople() {
		return this.createPeople;
	}

	/**
	 * setter for CREATE_PEOPLE
	 * 
	 * @generated
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * getter for CREATE_TIME
	 * 
	 * @generated
	 */
	public String getCreateTime() {
		return this.createTime;
	}

	/**
	 * setter for CREATE_TIME
	 * 
	 * @generated
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}