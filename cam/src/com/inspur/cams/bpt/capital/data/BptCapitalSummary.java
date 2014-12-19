package com.inspur.cams.bpt.capital.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptCapitalSummary
 * @description:优抚_资金发放_汇总
 * @author:
 * @since:2011-05-28
 * @version:1.0
 */
@Table(tableName = "BPT_CAPITAL_SUMMARY", keyFields = "registerId")
public class BptCapitalSummary extends StatefulDatabean {
	// 名册ID
	//@Rule(value = "require")
	@Column(name = "REGISTER_ID")
	private String registerId;
	// 名册名称
	//@Rule(value = "require")
	@Column(name = "REGISTER_NAME")
	private String registerName;
	// 名册类别
	//// @Rule(value="require")
	@Column(name = "REGISTER_TYPE")
	private String registerType;
	// 发放单位
	// @Rule(value="require")
	@Column(name = "ORGAN_CODE")
	private String organCode;
	// 所属年月
	// @Rule(value="require")
	@Column(name = "RESPECTIVE_YEARS")
	private String respectiveYears;
	// 发放资金金额
	@Column(name = "GRANT_MON_SUM")
	private BigDecimal grantMonSum;
	// 发放状态标志
	// @Rule(value="require")
	@Column(name = "GRANT_FLAG")
	private String grantFlag;
	// 发放日期
	// @Rule(value="require")
	@Column(name = "GRANT_DATE")
	private String grantDate;
	// 发放确认日期
	@Column(name = "GRANT_SURE_DATE")
	private String grantSureDate;
	//反馈编号
	private String feedbackNumber;
 	// 备注
	@Column(name = "NOTE")
	private String note;
	// 录入人ID
	@Rule(value = "require")
	@Column(name = "REG_ID")
	private String regId;
	// 录入时间
	@Rule(value = "require")
	@Column(name = "REG_TIME")
	private String regTime;
	// 修改人ID
	@Rule(value = "require")
	@Column(name = "MOD_ID")
	private String modId;
	// 修改时间
	@Rule(value = "require")
	@Column(name = "MOD_TIME")
	private String modTime;
	
	// 生成日期
	private String buildDate;
	
	// 发放起
	private String startDate;
	
	// 发放止
	private String endDate;
	
	/**
	 * @return the buildDate
	 */
	public String getBuildDate() {
		return buildDate;
	}

	/**
	 * @param buildDate the buildDate to set
	 */
	public void setBuildDate(String buildDate) {
		this.buildDate = buildDate;
	}

	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * getter for 名册ID
	 * 
	 * @generated
	 */
	public String getRegisterId() {
		return this.registerId;
	}

	/**
	 * setter for 名册ID
	 * 
	 * @generated
	 */
	public void setRegisterId(String registerId) {
		this.registerId = registerId;
	}

	/**
	 * getter for 名册名称
	 * 
	 * @generated
	 */
	public String getRegisterName() {
		return this.registerName;
	}

	/**
	 * setter for 名册名称
	 * 
	 * @generated
	 */
	public void setRegisterName(String registerName) {
		this.registerName = registerName;
	}

	/**
	 * getter for 名册类别
	 * 
	 * @generated
	 */
	public String getRegisterType() {
		return this.registerType;
	}

	/**
	 * setter for 名册类别
	 * 
	 * @generated
	 */
	public void setRegisterType(String registerType) {
		this.registerType = registerType;
	}


	/**
	 * getter for 所属年月
	 * 
	 * @generated
	 */
	public String getRespectiveYears() {
		return this.respectiveYears;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * setter for 所属年月
	 * 
	 * @generated
	 */
	public void setRespectiveYears(String respectiveYears) {
		this.respectiveYears = respectiveYears;
	}

	/**
	 * getter for 发放状态标志
	 * 
	 * @generated
	 */
	public String getGrantFlag() {
		return this.grantFlag;
	}

	/**
	 * setter for 发放状态标志
	 * 
	 * @generated
	 */
	public void setGrantFlag(String grantFlag) {
		this.grantFlag = grantFlag;
	}

	/**
	 * getter for 发放日期
	 * 
	 * @generated
	 */
	public String getGrantDate() {
		return this.grantDate;
	}

	/**
	 * setter for 发放日期
	 * 
	 * @generated
	 */
	public void setGrantDate(String grantDate) {
		this.grantDate = grantDate;
	}

	/**
	 * getter for 发放确认日期
	 * 
	 * @generated
	 */
	public String getGrantSureDate() {
		return this.grantSureDate;
	}

	/**
	 * setter for 发放确认日期
	 * 
	 * @generated
	 */
	public void setGrantSureDate(String grantSureDate) {
		this.grantSureDate = grantSureDate;
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
	 * getter for 录入人ID
	 * 
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 录入人ID
	 * 
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for 录入时间
	 * 
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for 录入时间
	 * 
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for 修改人ID
	 * 
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人ID
	 * 
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for 修改时间
	 * 
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for 修改时间
	 * 
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	/**
	 * @return the grantMonSum
	 */
	public BigDecimal getGrantMonSum() {
		return grantMonSum;
	}

	/**
	 * @param grantMonSum the grantMonSum to set
	 */
	public void setGrantMonSum(BigDecimal grantMonSum) {
		this.grantMonSum = grantMonSum;
	}

	/**
	 * @return the feedbackNumber
	 */
	public String getFeedbackNumber() {
		return feedbackNumber;
	}

	/**
	 * @param feedbackNumber the feedbackNumber to set
	 */
	public void setFeedbackNumber(String feedbackNumber) {
		this.feedbackNumber = feedbackNumber;
	}
}