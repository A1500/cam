package com.inspur.cams.welfare.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:WealUnitApply
 * @description:福利企业业务表
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
@Table(tableName = "WEAL_UNIT_APPLY", keyFields = "taskCode")
public class WealUnitApply extends StatefulDatabean {
	// TASK_CODE
	@Rule(value = "require")
	@Column(name = "TASK_CODE")
	private String taskCode;
	// UNIT_ID
	@Rule(value = "require")
	@Column(name = "UNIT_ID")
	private String unitId;
	// APPLY_TYPE
	@Rule(value = "require")
	@Column(name = "APPLY_TYPE")
	private String applyType;
	// APPLY_STAUTS
	@Column(name = "APPLY_STAUTS")
	private String applyStauts;
	// ACCEPT_BASE_OPINION
	@Column(name = "ACCEPT_BASE_OPINION")
	private String acceptBaseOpinion;
	// ACCEPT_ADD_OPINION
	@Column(name = "ACCEPT_ADD_OPINION")
	private String acceptAddOpinion;
	// ACCEPT_TIME
	@Column(name = "ACCEPT_TIME")
	private String acceptTime;
	// ACCEPT
	@Column(name = "ACCEPT")
	private String accept;
	// COUNTY_CHARGE_BASE_OPINION
	@Column(name = "COUNTY_CHARGE_BASE_OPINION")
	private String countyChargeBaseOpinion;
	// COUNTY_CHARGE_ADD_OPINION
	@Column(name = "COUNTY_CHARGE_ADD_OPINION")
	private String countyChargeAddOpinion;
	// COUNTY_CHARGE_TIME
	@Column(name = "COUNTY_CHARGE_TIME")
	private String countyChargeTime;
	// COUNTY_CHARGE
	@Column(name = "COUNTY_CHARGE")
	private String countyCharge;
	// COUNTY_CHIEF_BASE_OPINION
	@Column(name = "COUNTY_CHIEF_BASE_OPINION")
	private String countyChiefBaseOpinion;
	// COUNTY_CHIEF_ADD_OPINION
	@Column(name = "COUNTY_CHIEF_ADD_OPINION")
	private String countyChiefAddOpinion;
	// COUNTY_CHIEF_TIME
	@Column(name = "COUNTY_CHIEF_TIME")
	private String countyChiefTime;
	// COUNTY_CHIEF
	@Column(name = "COUNTY_CHIEF")
	private String countyChief;
	// APPROVAL_LEVEL
	@Column(name = "APPROVAL_LEVEL")
	private String approvalLevel;
	// CITY_CHARGE_BASE_OPINION
	@Column(name = "CITY_CHARGE_BASE_OPINION")
	private String cityChargeBaseOpinion;
	// CITY_CHARGE_ADD_OPINION
	@Column(name = "CITY_CHARGE_ADD_OPINION")
	private String cityChargeAddOpinion;
	// CITY_CHARGE_TIME
	@Column(name = "CITY_CHARGE_TIME")
	private String cityChargeTime;
	// CITY_CHARGE
	@Column(name = "CITY_CHARGE")
	private String cityCharge;
	// CITY_CHIEF_BASE_OPINION
	@Column(name = "CITY_CHIEF_BASE_OPINION")
	private String cityChiefBaseOpinion;
	// CITY_CHIEF_ADD_OPINION
	@Column(name = "CITY_CHIEF_ADD_OPINION")
	private String cityChiefAddOpinion;
	// CITY_CHIEF_TIME
	@Column(name = "CITY_CHIEF_TIME")
	private String cityChiefTime;
	// CITY_CHIEF
	@Column(name = "CITY_CHIEF")
	private String cityChief;
	// DATA_SOURCE
	@Rule(value = "require")
	@Column(name = "DATA_SOURCE")
	private String dataSource;
	// REG_DATE
	@Rule(value = "require")
	@Column(name = "REG_DATE")
	private String regDate;
	// CUR_OPINION_ID
	@Column(name = "CUR_OPINION_ID")
	private String curOpinionId;
	// CUR_OPINION
	@Column(name = "CUR_OPINION")
	private String curOpinion;
	// SUBMIT_TIME
	@Column(name = "SUBMIT_TIME")
	private String submitTime;
	// CUR_ACTIVITY
	@Column(name = "CUR_ACTIVITY")
	private String curActivity;
	// CUR_PEOPLE_NAME
	@Column(name = "CUR_PEOPLE_NAME")
	private String curPeopleName;
	// REJECT_REASON
	@Column(name = "REJECT_REASON")
	private String rejectReason;
	// MORG_NAME
	@Rule(value = "require")
	@Column(name = "MORG_NAME")
	private String morgName;
	// MORG_AREA
	@Rule(value = "require")
	@Column(name = "MORG_AREA")
	private String morgArea;

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
	 * getter for APPLY_STAUTS
	 * 
	 * @generated
	 */
	public String getApplyStauts() {
		return this.applyStauts;
	}

	/**
	 * setter for APPLY_STAUTS
	 * 
	 * @generated
	 */
	public void setApplyStauts(String applyStauts) {
		this.applyStauts = applyStauts;
	}

	/**
	 * getter for ACCEPT_BASE_OPINION
	 * 
	 * @generated
	 */
	public String getAcceptBaseOpinion() {
		return this.acceptBaseOpinion;
	}

	/**
	 * setter for ACCEPT_BASE_OPINION
	 * 
	 * @generated
	 */
	public void setAcceptBaseOpinion(String acceptBaseOpinion) {
		this.acceptBaseOpinion = acceptBaseOpinion;
	}

	/**
	 * getter for ACCEPT_ADD_OPINION
	 * 
	 * @generated
	 */
	public String getAcceptAddOpinion() {
		return this.acceptAddOpinion;
	}

	/**
	 * setter for ACCEPT_ADD_OPINION
	 * 
	 * @generated
	 */
	public void setAcceptAddOpinion(String acceptAddOpinion) {
		this.acceptAddOpinion = acceptAddOpinion;
	}

	/**
	 * getter for ACCEPT_TIME
	 * 
	 * @generated
	 */
	public String getAcceptTime() {
		return this.acceptTime;
	}

	/**
	 * setter for ACCEPT_TIME
	 * 
	 * @generated
	 */
	public void setAcceptTime(String acceptTime) {
		this.acceptTime = acceptTime;
	}

	/**
	 * getter for ACCEPT
	 * 
	 * @generated
	 */
	public String getAccept() {
		return this.accept;
	}

	/**
	 * setter for ACCEPT
	 * 
	 * @generated
	 */
	public void setAccept(String accept) {
		this.accept = accept;
	}

	/**
	 * getter for COUNTY_CHARGE_BASE_OPINION
	 * 
	 * @generated
	 */
	public String getCountyChargeBaseOpinion() {
		return this.countyChargeBaseOpinion;
	}

	/**
	 * setter for COUNTY_CHARGE_BASE_OPINION
	 * 
	 * @generated
	 */
	public void setCountyChargeBaseOpinion(String countyChargeBaseOpinion) {
		this.countyChargeBaseOpinion = countyChargeBaseOpinion;
	}

	/**
	 * getter for COUNTY_CHARGE_ADD_OPINION
	 * 
	 * @generated
	 */
	public String getCountyChargeAddOpinion() {
		return this.countyChargeAddOpinion;
	}

	/**
	 * setter for COUNTY_CHARGE_ADD_OPINION
	 * 
	 * @generated
	 */
	public void setCountyChargeAddOpinion(String countyChargeAddOpinion) {
		this.countyChargeAddOpinion = countyChargeAddOpinion;
	}

	/**
	 * getter for COUNTY_CHARGE_TIME
	 * 
	 * @generated
	 */
	public String getCountyChargeTime() {
		return this.countyChargeTime;
	}

	/**
	 * setter for COUNTY_CHARGE_TIME
	 * 
	 * @generated
	 */
	public void setCountyChargeTime(String countyChargeTime) {
		this.countyChargeTime = countyChargeTime;
	}

	/**
	 * getter for COUNTY_CHARGE
	 * 
	 * @generated
	 */
	public String getCountyCharge() {
		return this.countyCharge;
	}

	/**
	 * setter for COUNTY_CHARGE
	 * 
	 * @generated
	 */
	public void setCountyCharge(String countyCharge) {
		this.countyCharge = countyCharge;
	}

	/**
	 * getter for COUNTY_CHIEF_BASE_OPINION
	 * 
	 * @generated
	 */
	public String getCountyChiefBaseOpinion() {
		return this.countyChiefBaseOpinion;
	}

	/**
	 * setter for COUNTY_CHIEF_BASE_OPINION
	 * 
	 * @generated
	 */
	public void setCountyChiefBaseOpinion(String countyChiefBaseOpinion) {
		this.countyChiefBaseOpinion = countyChiefBaseOpinion;
	}

	/**
	 * getter for COUNTY_CHIEF_ADD_OPINION
	 * 
	 * @generated
	 */
	public String getCountyChiefAddOpinion() {
		return this.countyChiefAddOpinion;
	}

	/**
	 * setter for COUNTY_CHIEF_ADD_OPINION
	 * 
	 * @generated
	 */
	public void setCountyChiefAddOpinion(String countyChiefAddOpinion) {
		this.countyChiefAddOpinion = countyChiefAddOpinion;
	}

	/**
	 * getter for COUNTY_CHIEF_TIME
	 * 
	 * @generated
	 */
	public String getCountyChiefTime() {
		return this.countyChiefTime;
	}

	/**
	 * setter for COUNTY_CHIEF_TIME
	 * 
	 * @generated
	 */
	public void setCountyChiefTime(String countyChiefTime) {
		this.countyChiefTime = countyChiefTime;
	}

	/**
	 * getter for COUNTY_CHIEF
	 * 
	 * @generated
	 */
	public String getCountyChief() {
		return this.countyChief;
	}

	/**
	 * setter for COUNTY_CHIEF
	 * 
	 * @generated
	 */
	public void setCountyChief(String countyChief) {
		this.countyChief = countyChief;
	}

	/**
	 * getter for APPROVAL_LEVEL
	 * 
	 * @generated
	 */
	public String getApprovalLevel() {
		return this.approvalLevel;
	}

	/**
	 * setter for APPROVAL_LEVEL
	 * 
	 * @generated
	 */
	public void setApprovalLevel(String approvalLevel) {
		this.approvalLevel = approvalLevel;
	}

	/**
	 * getter for CITY_CHARGE_BASE_OPINION
	 * 
	 * @generated
	 */
	public String getCityChargeBaseOpinion() {
		return this.cityChargeBaseOpinion;
	}

	/**
	 * setter for CITY_CHARGE_BASE_OPINION
	 * 
	 * @generated
	 */
	public void setCityChargeBaseOpinion(String cityChargeBaseOpinion) {
		this.cityChargeBaseOpinion = cityChargeBaseOpinion;
	}

	/**
	 * getter for CITY_CHARGE_ADD_OPINION
	 * 
	 * @generated
	 */
	public String getCityChargeAddOpinion() {
		return this.cityChargeAddOpinion;
	}

	/**
	 * setter for CITY_CHARGE_ADD_OPINION
	 * 
	 * @generated
	 */
	public void setCityChargeAddOpinion(String cityChargeAddOpinion) {
		this.cityChargeAddOpinion = cityChargeAddOpinion;
	}

	/**
	 * getter for CITY_CHARGE_TIME
	 * 
	 * @generated
	 */
	public String getCityChargeTime() {
		return this.cityChargeTime;
	}

	/**
	 * setter for CITY_CHARGE_TIME
	 * 
	 * @generated
	 */
	public void setCityChargeTime(String cityChargeTime) {
		this.cityChargeTime = cityChargeTime;
	}

	/**
	 * getter for CITY_CHARGE
	 * 
	 * @generated
	 */
	public String getCityCharge() {
		return this.cityCharge;
	}

	/**
	 * setter for CITY_CHARGE
	 * 
	 * @generated
	 */
	public void setCityCharge(String cityCharge) {
		this.cityCharge = cityCharge;
	}

	/**
	 * getter for CITY_CHIEF_BASE_OPINION
	 * 
	 * @generated
	 */
	public String getCityChiefBaseOpinion() {
		return this.cityChiefBaseOpinion;
	}

	/**
	 * setter for CITY_CHIEF_BASE_OPINION
	 * 
	 * @generated
	 */
	public void setCityChiefBaseOpinion(String cityChiefBaseOpinion) {
		this.cityChiefBaseOpinion = cityChiefBaseOpinion;
	}

	/**
	 * getter for CITY_CHIEF_ADD_OPINION
	 * 
	 * @generated
	 */
	public String getCityChiefAddOpinion() {
		return this.cityChiefAddOpinion;
	}

	/**
	 * setter for CITY_CHIEF_ADD_OPINION
	 * 
	 * @generated
	 */
	public void setCityChiefAddOpinion(String cityChiefAddOpinion) {
		this.cityChiefAddOpinion = cityChiefAddOpinion;
	}

	/**
	 * getter for CITY_CHIEF_TIME
	 * 
	 * @generated
	 */
	public String getCityChiefTime() {
		return this.cityChiefTime;
	}

	/**
	 * setter for CITY_CHIEF_TIME
	 * 
	 * @generated
	 */
	public void setCityChiefTime(String cityChiefTime) {
		this.cityChiefTime = cityChiefTime;
	}

	/**
	 * getter for CITY_CHIEF
	 * 
	 * @generated
	 */
	public String getCityChief() {
		return this.cityChief;
	}

	/**
	 * setter for CITY_CHIEF
	 * 
	 * @generated
	 */
	public void setCityChief(String cityChief) {
		this.cityChief = cityChief;
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
	 * getter for CUR_OPINION_ID
	 * 
	 * @generated
	 */
	public String getCurOpinionId() {
		return this.curOpinionId;
	}

	/**
	 * setter for CUR_OPINION_ID
	 * 
	 * @generated
	 */
	public void setCurOpinionId(String curOpinionId) {
		this.curOpinionId = curOpinionId;
	}

	/**
	 * getter for CUR_OPINION
	 * 
	 * @generated
	 */
	public String getCurOpinion() {
		return this.curOpinion;
	}

	/**
	 * setter for CUR_OPINION
	 * 
	 * @generated
	 */
	public void setCurOpinion(String curOpinion) {
		this.curOpinion = curOpinion;
	}

	/**
	 * getter for SUBMIT_TIME
	 * 
	 * @generated
	 */
	public String getSubmitTime() {
		return this.submitTime;
	}

	/**
	 * setter for SUBMIT_TIME
	 * 
	 * @generated
	 */
	public void setSubmitTime(String submitTime) {
		this.submitTime = submitTime;
	}

	/**
	 * getter for CUR_ACTIVITY
	 * 
	 * @generated
	 */
	public String getCurActivity() {
		return this.curActivity;
	}

	/**
	 * setter for CUR_ACTIVITY
	 * 
	 * @generated
	 */
	public void setCurActivity(String curActivity) {
		this.curActivity = curActivity;
	}

	/**
	 * getter for CUR_PEOPLE_NAME
	 * 
	 * @generated
	 */
	public String getCurPeopleName() {
		return this.curPeopleName;
	}

	/**
	 * setter for CUR_PEOPLE_NAME
	 * 
	 * @generated
	 */
	public void setCurPeopleName(String curPeopleName) {
		this.curPeopleName = curPeopleName;
	}

	/**
	 * getter for REJECT_REASON
	 * 
	 * @generated
	 */
	public String getRejectReason() {
		return this.rejectReason;
	}

	/**
	 * setter for REJECT_REASON
	 * 
	 * @generated
	 */
	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
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