package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptDisabilityProvinceMigrat
 * @description:优抚人员省内迁移
 * @author:
 * @since:2011-08-04
 * @version:1.0
 */
@Table(tableName = "BPT_PROVINCE_MIGRATE", keyFields = "applyId")
public class BptProvinceMigrate extends StatefulDatabean {
	// 申请ID
	@Rule(value = "require")
	@Column(name = "APPLY_ID")
	private String applyId;
	// 人员ID
	@Rule(value = "require")
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// 业务类型
	@Column(name = "SERVICE_TYPE")
	private String serviceType;
	// 抚恤金已发至月份
	@Column(name = "ALLOWANCE_MONTH")
	private String allowanceMonth;
	// 申请时间
	@Column(name = "APPLY_DATE")
	private String applyDate;
	// 申请机构
	@Column(name = "APPLY_ORGANIZATION")
	private String applyOrganization;
	// 迁入地行政区划
	@Column(name = "INGOING_CODE")
	private String ingoingCode;
	// 迁出地县级受理人员
	@Column(name = "OUT_TOWN_CHECK_PEOPLE")
	private String outTownCheckPeople;
	// 迁出地县级受理时间
	@Column(name = "OUT_TOWN_CHECK_DATE")
	private String outTownCheckDate;
	// 迁出地县级受理联系电话
	@Column(name = "OUT_TOWN_CHECK_PHONE")
	private String outTownCheckPhone;
	// 迁出地县级审核负责人
	@Column(name = "OUT_TOWN_ADUIT_INCHARGE")
	private String outTownAduitIncharge;
	// 迁出地县级审核时间
	@Column(name = "OUT_TOWN_ADUIT_APPROVE_DATE")
	private String outTownAduitApproveDate;
	// 迁出地县级审核意见
	@Column(name = "OUT_TOWN_ADUIT_ADVICE")
	private String outTownAduitAdvice;
	// 迁出地市级受理人员
	@Column(name = "OUT_CITY_CHECK_PEOPLE")
	private String outCityCheckPeople;
	// 迁出地市级受理时间
	@Column(name = "OUT_CITY_CHECK_DATE")
	private String outCityCheckDate;
	// 迁出地市级受理意见
	@Column(name = "OUT_CITY_CHECK_ADVICE")
	private String outCityCheckAdvice;
	// 迁出地市级受理联系电话
	@Column(name = "OUT_CITY_CHECK_PHONE")
	private String outCityCheckPhone;
	// 迁出地市级审核负责人
	@Column(name = "OUT_CITY_ADUIT_INCHARGE")
	private String outCityAduitIncharge;
	// 迁出地市级审核时间
	@Column(name = "OUT_CITY_ADUIT_APPROVE_DATE")
	private String outCityAduitApproveDate;
	// 迁出地市级审核意见
	@Column(name = "OUT_CITY_ADUIT_ADVICE")
	private String outCityAduitAdvice;
	// 迁入地县级受理人员
	@Column(name = "IN_TOWN_CHECK_PEOPLE")
	private String inTownCheckPeople;
	// 迁入地县级受理时间
	@Column(name = "IN_TOWN_CHECK_DATE")
	private String inTownCheckDate;
	// 迁入地县级受理意见
	@Column(name = "IN_TOWN_CHECK_ADVICE")
	private String inTownCheckAdvice;
	// 迁入地县级受理联系电话
	@Column(name = "IN_TOWN_CHECK_PHONE")
	private String inTownCheckPhone;
	// 迁入地县级审核负责人
	@Column(name = "IN_TOWN_ADUIT_INCHARGE")
	private String inTownAduitIncharge;
	// 迁入地县级审核时间
	@Column(name = "IN_TOWN_ADUIT_APPROVE_DATE")
	private String inTownAduitApproveDate;
	// 迁入地县级审核意见
	@Column(name = "IN_TOWN_ADUIT_ADVICE")
	private String inTownAduitAdvice;
	// 迁入地市级受理人员
	@Column(name = "IN_CITY_CHECK_PEOPLE")
	private String inCityCheckPeople;
	// 迁入地市级受理时间
	@Column(name = "IN_CITY_CHECK_DATE")
	private String inCityCheckDate;
	// 迁入地市级受理意见
	@Column(name = "IN_CITY_CHECK_ADVICE")
	private String inCityCheckAdvice;
	// 迁入地市级受理联系电话
	@Column(name = "IN_CITY_CHECK_PHONE")
	private String inCityCheckPhone;
	// 迁入地市级审核负责人
	@Column(name = "IN_CITY_ADUIT_INCHARGE")
	private String inCityAduitIncharge;
	// 迁入地市级审核时间
	@Column(name = "IN_CITY_ADUIT_APPROVE_DATE")
	private String inCityAduitApproveDate;
	// 迁入地市级审核意见
	@Column(name = "IN_CITY_ADUIT_ADVICE")
	private String inCityAduitAdvice;
	// 备注
	@Column(name = "NOTE")
	private String note;
	// 发起标志
	@Column(name = "COMMIT_FLAG")
	private String commitFlag;

	// 迁入地属地行政区划
	//@Rule(value = "require")
	@Column(name = "IN_DOMICILE_CODE")
	private String inDomicileCode;
	// 迁入地住址行政区划
	//@Rule(value = "require")
	@Column(name = "IN_APANAGE_CODE")
	private String inApanageCode;
	
	// 迁出地属地行政区划
	//@Rule(value = "require")
	@Column(name = "OUT_DOMICILE_CODE")
	private String outDomicileCode;

	// 迁入地户口地址
	@Column(name = "IN_DOMICILE_ADDRESS")
	private String inDomicileAddress;

	// 迁入地实际住址
	@Column(name = "IN_APANAGE_ADDRESS")
	private String inApanageAddress;

	/**
	 * getter for 申请ID
	 * 
	 * @generated
	 */
	public String getApplyId() {
		return this.applyId;
	}

	/**
	 * setter for 申请ID
	 * 
	 * @generated
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * getter for 人员ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for 人员ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * getter for 业务类型
	 * 
	 * @generated
	 */
	public String getServiceType() {
		return this.serviceType;
	}

	/**
	 * setter for 业务类型
	 * 
	 * @generated
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	/**
	 * getter for 抚恤金已发至月份
	 * 
	 * @generated
	 */
	public String getAllowanceMonth() {
		return this.allowanceMonth;
	}

	/**
	 * setter for 抚恤金已发至月份
	 * 
	 * @generated
	 */
	public void setAllowanceMonth(String allowanceMonth) {
		this.allowanceMonth = allowanceMonth;
	}

	/**
	 * getter for 申请时间
	 * 
	 * @generated
	 */
	public String getApplyDate() {
		return this.applyDate;
	}

	/**
	 * setter for 申请时间
	 * 
	 * @generated
	 */
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	/**
	 * getter for 申请机构
	 * 
	 * @generated
	 */
	public String getApplyOrganization() {
		return this.applyOrganization;
	}

	/**
	 * setter for 申请机构
	 * 
	 * @generated
	 */
	public void setApplyOrganization(String applyOrganization) {
		this.applyOrganization = applyOrganization;
	}

	/**
	 * getter for 迁入地行政区划
	 * 
	 * @generated
	 */
	public String getIngoingCode() {
		return this.ingoingCode;
	}

	/**
	 * setter for 迁入地行政区划
	 * 
	 * @generated
	 */
	public void setIngoingCode(String ingoingCode) {
		this.ingoingCode = ingoingCode;
	}

	/**
	 * getter for 迁出地县级受理人员
	 * 
	 * @generated
	 */
	public String getOutTownCheckPeople() {
		return this.outTownCheckPeople;
	}

	/**
	 * setter for 迁出地县级受理人员
	 * 
	 * @generated
	 */
	public void setOutTownCheckPeople(String outTownCheckPeople) {
		this.outTownCheckPeople = outTownCheckPeople;
	}

	/**
	 * getter for 迁出地县级受理时间
	 * 
	 * @generated
	 */
	public String getOutTownCheckDate() {
		return this.outTownCheckDate;
	}

	/**
	 * setter for 迁出地县级受理时间
	 * 
	 * @generated
	 */
	public void setOutTownCheckDate(String outTownCheckDate) {
		this.outTownCheckDate = outTownCheckDate;
	}

	/**
	 * getter for 迁出地县级受理联系电话
	 * 
	 * @generated
	 */
	public String getOutTownCheckPhone() {
		return this.outTownCheckPhone;
	}

	/**
	 * setter for 迁出地县级受理联系电话
	 * 
	 * @generated
	 */
	public void setOutTownCheckPhone(String outTownCheckPhone) {
		this.outTownCheckPhone = outTownCheckPhone;
	}

	/**
	 * getter for 迁出地县级审核负责人
	 * 
	 * @generated
	 */
	public String getOutTownAduitIncharge() {
		return this.outTownAduitIncharge;
	}

	/**
	 * setter for 迁出地县级审核负责人
	 * 
	 * @generated
	 */
	public void setOutTownAduitIncharge(String outTownAduitIncharge) {
		this.outTownAduitIncharge = outTownAduitIncharge;
	}

	/**
	 * getter for 迁出地县级审核时间
	 * 
	 * @generated
	 */
	public String getOutTownAduitApproveDate() {
		return this.outTownAduitApproveDate;
	}

	/**
	 * setter for 迁出地县级审核时间
	 * 
	 * @generated
	 */
	public void setOutTownAduitApproveDate(String outTownAduitApproveDate) {
		this.outTownAduitApproveDate = outTownAduitApproveDate;
	}

	/**
	 * getter for 迁出地县级审核意见
	 * 
	 * @generated
	 */
	public String getOutTownAduitAdvice() {
		return this.outTownAduitAdvice;
	}

	/**
	 * setter for 迁出地县级审核意见
	 * 
	 * @generated
	 */
	public void setOutTownAduitAdvice(String outTownAduitAdvice) {
		this.outTownAduitAdvice = outTownAduitAdvice;
	}

	/**
	 * getter for 迁出地市级受理人员
	 * 
	 * @generated
	 */
	public String getOutCityCheckPeople() {
		return this.outCityCheckPeople;
	}

	/**
	 * setter for 迁出地市级受理人员
	 * 
	 * @generated
	 */
	public void setOutCityCheckPeople(String outCityCheckPeople) {
		this.outCityCheckPeople = outCityCheckPeople;
	}

	/**
	 * getter for 迁出地市级受理时间
	 * 
	 * @generated
	 */
	public String getOutCityCheckDate() {
		return this.outCityCheckDate;
	}

	/**
	 * setter for 迁出地市级受理时间
	 * 
	 * @generated
	 */
	public void setOutCityCheckDate(String outCityCheckDate) {
		this.outCityCheckDate = outCityCheckDate;
	}

	/**
	 * getter for 迁出地市级受理意见
	 * 
	 * @generated
	 */
	public String getOutCityCheckAdvice() {
		return this.outCityCheckAdvice;
	}

	/**
	 * setter for 迁出地市级受理意见
	 * 
	 * @generated
	 */
	public void setOutCityCheckAdvice(String outCityCheckAdvice) {
		this.outCityCheckAdvice = outCityCheckAdvice;
	}

	/**
	 * getter for 迁出地市级受理联系电话
	 * 
	 * @generated
	 */
	public String getOutCityCheckPhone() {
		return this.outCityCheckPhone;
	}

	/**
	 * setter for 迁出地市级受理联系电话
	 * 
	 * @generated
	 */
	public void setOutCityCheckPhone(String outCityCheckPhone) {
		this.outCityCheckPhone = outCityCheckPhone;
	}

	/**
	 * getter for 迁出地市级审核负责人
	 * 
	 * @generated
	 */
	public String getOutCityAduitIncharge() {
		return this.outCityAduitIncharge;
	}

	/**
	 * setter for 迁出地市级审核负责人
	 * 
	 * @generated
	 */
	public void setOutCityAduitIncharge(String outCityAduitIncharge) {
		this.outCityAduitIncharge = outCityAduitIncharge;
	}

	/**
	 * getter for 迁出地市级审核时间
	 * 
	 * @generated
	 */
	public String getOutCityAduitApproveDate() {
		return this.outCityAduitApproveDate;
	}

	/**
	 * setter for 迁出地市级审核时间
	 * 
	 * @generated
	 */
	public void setOutCityAduitApproveDate(String outCityAduitApproveDate) {
		this.outCityAduitApproveDate = outCityAduitApproveDate;
	}

	/**
	 * getter for 迁出地市级审核意见
	 * 
	 * @generated
	 */
	public String getOutCityAduitAdvice() {
		return this.outCityAduitAdvice;
	}

	/**
	 * setter for 迁出地市级审核意见
	 * 
	 * @generated
	 */
	public void setOutCityAduitAdvice(String outCityAduitAdvice) {
		this.outCityAduitAdvice = outCityAduitAdvice;
	}

	/**
	 * getter for 迁入地县级受理人员
	 * 
	 * @generated
	 */
	public String getInTownCheckPeople() {
		return this.inTownCheckPeople;
	}

	/**
	 * setter for 迁入地县级受理人员
	 * 
	 * @generated
	 */
	public void setInTownCheckPeople(String inTownCheckPeople) {
		this.inTownCheckPeople = inTownCheckPeople;
	}

	/**
	 * getter for 迁入地县级受理时间
	 * 
	 * @generated
	 */
	public String getInTownCheckDate() {
		return this.inTownCheckDate;
	}

	/**
	 * setter for 迁入地县级受理时间
	 * 
	 * @generated
	 */
	public void setInTownCheckDate(String inTownCheckDate) {
		this.inTownCheckDate = inTownCheckDate;
	}

	/**
	 * getter for 迁入地县级受理意见
	 * 
	 * @generated
	 */
	public String getInTownCheckAdvice() {
		return this.inTownCheckAdvice;
	}

	/**
	 * setter for 迁入地县级受理意见
	 * 
	 * @generated
	 */
	public void setInTownCheckAdvice(String inTownCheckAdvice) {
		this.inTownCheckAdvice = inTownCheckAdvice;
	}

	/**
	 * getter for 迁入地县级受理联系电话
	 * 
	 * @generated
	 */
	public String getInTownCheckPhone() {
		return this.inTownCheckPhone;
	}

	/**
	 * setter for 迁入地县级受理联系电话
	 * 
	 * @generated
	 */
	public void setInTownCheckPhone(String inTownCheckPhone) {
		this.inTownCheckPhone = inTownCheckPhone;
	}

	/**
	 * getter for 迁入地县级审核负责人
	 * 
	 * @generated
	 */
	public String getInTownAduitIncharge() {
		return this.inTownAduitIncharge;
	}

	/**
	 * setter for 迁入地县级审核负责人
	 * 
	 * @generated
	 */
	public void setInTownAduitIncharge(String inTownAduitIncharge) {
		this.inTownAduitIncharge = inTownAduitIncharge;
	}

	/**
	 * getter for 迁入地县级审核时间
	 * 
	 * @generated
	 */
	public String getInTownAduitApproveDate() {
		return this.inTownAduitApproveDate;
	}

	/**
	 * setter for 迁入地县级审核时间
	 * 
	 * @generated
	 */
	public void setInTownAduitApproveDate(String inTownAduitApproveDate) {
		this.inTownAduitApproveDate = inTownAduitApproveDate;
	}

	/**
	 * getter for 迁入地县级审核意见
	 * 
	 * @generated
	 */
	public String getInTownAduitAdvice() {
		return this.inTownAduitAdvice;
	}

	/**
	 * setter for 迁入地县级审核意见
	 * 
	 * @generated
	 */
	public void setInTownAduitAdvice(String inTownAduitAdvice) {
		this.inTownAduitAdvice = inTownAduitAdvice;
	}

	/**
	 * getter for 迁入地市级受理人员
	 * 
	 * @generated
	 */
	public String getInCityCheckPeople() {
		return this.inCityCheckPeople;
	}

	/**
	 * setter for 迁入地市级受理人员
	 * 
	 * @generated
	 */
	public void setInCityCheckPeople(String inCityCheckPeople) {
		this.inCityCheckPeople = inCityCheckPeople;
	}

	/**
	 * getter for 迁入地市级受理时间
	 * 
	 * @generated
	 */
	public String getInCityCheckDate() {
		return this.inCityCheckDate;
	}

	/**
	 * setter for 迁入地市级受理时间
	 * 
	 * @generated
	 */
	public void setInCityCheckDate(String inCityCheckDate) {
		this.inCityCheckDate = inCityCheckDate;
	}

	/**
	 * getter for 迁入地市级受理意见
	 * 
	 * @generated
	 */
	public String getInCityCheckAdvice() {
		return this.inCityCheckAdvice;
	}

	/**
	 * setter for 迁入地市级受理意见
	 * 
	 * @generated
	 */
	public void setInCityCheckAdvice(String inCityCheckAdvice) {
		this.inCityCheckAdvice = inCityCheckAdvice;
	}

	/**
	 * getter for 迁入地市级受理联系电话
	 * 
	 * @generated
	 */
	public String getInCityCheckPhone() {
		return this.inCityCheckPhone;
	}

	/**
	 * setter for 迁入地市级受理联系电话
	 * 
	 * @generated
	 */
	public void setInCityCheckPhone(String inCityCheckPhone) {
		this.inCityCheckPhone = inCityCheckPhone;
	}

	/**
	 * getter for 迁入地市级审核负责人
	 * 
	 * @generated
	 */
	public String getInCityAduitIncharge() {
		return this.inCityAduitIncharge;
	}

	/**
	 * setter for 迁入地市级审核负责人
	 * 
	 * @generated
	 */
	public void setInCityAduitIncharge(String inCityAduitIncharge) {
		this.inCityAduitIncharge = inCityAduitIncharge;
	}

	/**
	 * getter for 迁入地市级审核时间
	 * 
	 * @generated
	 */
	public String getInCityAduitApproveDate() {
		return this.inCityAduitApproveDate;
	}

	/**
	 * setter for 迁入地市级审核时间
	 * 
	 * @generated
	 */
	public void setInCityAduitApproveDate(String inCityAduitApproveDate) {
		this.inCityAduitApproveDate = inCityAduitApproveDate;
	}

	/**
	 * getter for 迁入地市级审核意见
	 * 
	 * @generated
	 */
	public String getInCityAduitAdvice() {
		return this.inCityAduitAdvice;
	}

	/**
	 * setter for 迁入地市级审核意见
	 * 
	 * @generated
	 */
	public void setInCityAduitAdvice(String inCityAduitAdvice) {
		this.inCityAduitAdvice = inCityAduitAdvice;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * getter for 发起标志
	 * 
	 * @generated
	 */
	public String getCommitFlag() {
		return this.commitFlag;
	}

	/**
	 * setter for 发起标志
	 * 
	 * @generated
	 */
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
	}

	public String getInDomicileCode() {
		return inDomicileCode;
	}

	public void setInDomicileCode(String inDomicileCode) {
		this.inDomicileCode = inDomicileCode;
	}

	public String getInApanageCode() {
		return inApanageCode;
	}

	public void setInApanageCode(String inApanageCode) {
		this.inApanageCode = inApanageCode;
	}

	public String getInDomicileAddress() {
		return inDomicileAddress;
	}

	public void setInDomicileAddress(String inDomicileAddress) {
		this.inDomicileAddress = inDomicileAddress;
	}

	public String getInApanageAddress() {
		return inApanageAddress;
	}

	public void setInApanageAddress(String inApanageAddress) {
		this.inApanageAddress = inApanageAddress;
	}

	public String getOutDomicileCode() {
		return outDomicileCode;
	}

	public void setOutDomicileCode(String outDomicileCode) {
		this.outDomicileCode = outDomicileCode;
	}

}