package com.inspur.cams.bpt.capital.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptCompulsorySummary
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
 */
@Table(tableName = "BPT_COMPULSORY_SUMMARY", keyFields = "registerId")
public class BptCompulsorySummary extends StatefulDatabean {
	// 名册ID
	@Rule(value = "require")
	@Column(name = "REGISTER_ID")
	private String registerId;
	// 名册名字
	@Column(name = "REGISTER_NAME")
	private String registerName;
	//所属年度
	private String respectiveYears;
	//应发时间起
	private String startDate;
	//应发时间止
	private String endDate;
	// 发放单位
	@Column(name = "GRANT_UNIT")
	private String grantUnit;
	// 发放金额
	@Column(name = "GRANT_MON")
	private BigDecimal grantMon;
	// 发放标志
	@Column(name = "GRANT_FLAG")
	private String grantFlag;
	// 发放日期
	@Column(name = "GRANT_DATE")
	private String grantDate;
	// 发放确认日期
	@Column(name = "GRANT_SURE_DATE")
	private String grantSureDate;
	// 反馈编号
	private String feedbackNumber;
	// 备注
	@Column(name = "NOTE")
	private String note;
	// 录入人
	@Column(name = "REG_ID")
	private String regId;
	// 录入时间
	@Column(name = "REG_TIME")
	private String regTime;
	// 修改人
	@Column(name = "MOD_ID")
	private String modId;
	// 修改时间
	@Column(name = "MOD_TIME")
	private String modTime;
	// 类型
	@Column(name = "TYPE")
	private String type;

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
	 * getter for 名册名字
	 * 
	 * @generated
	 */
	public String getRegisterName() {
		return this.registerName;
	}

	/**
	 * setter for 名册名字
	 * 
	 * @generated
	 */
	public void setRegisterName(String registerName) {
		this.registerName = registerName;
	}

	/**
	 * getter for 发放单位
	 * 
	 * @generated
	 */
	public String getGrantUnit() {
		return this.grantUnit;
	}

	/**
	 * setter for 发放单位
	 * 
	 * @generated
	 */
	public void setGrantUnit(String grantUnit) {
		this.grantUnit = grantUnit;
	}

	/**
	 * getter for 发放金额
	 * 
	 * @generated
	 */
	public BigDecimal getGrantMon() {
		return this.grantMon;
	}

	/**
	 * setter for 发放金额
	 * 
	 * @generated
	 */
	public void setGrantMon(BigDecimal grantMon) {
		this.grantMon = grantMon;
	}

	/**
	 * getter for 发放标志
	 * 
	 * @generated
	 */
	public String getGrantFlag() {
		return this.grantFlag;
	}

	/**
	 * setter for 发放标志
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
	 * getter for 录入人
	 * 
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 录入人
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
	 * getter for 修改人
	 * 
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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
	 * @return the respectiveYears
	 */
	public String getRespectiveYears() {
		return respectiveYears;
	}

	/**
	 * @param respectiveYears the respectiveYears to set
	 */
	public void setRespectiveYears(String respectiveYears) {
		this.respectiveYears = respectiveYears;
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