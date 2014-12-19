package com.inspur.cams.drel.config.assistance.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:分类施保配置databean
 * @description:
 * @author:
 * @since:2012-05-02
 * @version:1.0
 */
@Table(tableName = "SAM_ASSISTANCE_CLASS", keyFields = "assistanceClassId")
public class SamAssistanceClass extends StatefulDatabean {
	@Column(name = "ASSISTANCE_CLASS_ID")
	private String assistanceClassId;
	// 救助类别
	@Column(name = "ASSISTANCE_TYPE")
	private String assistanceType;
	// 类别名称
	@Column(name = "ASSISTANCE_CLASS_CODE")
	private String assistanceClassCode;
	// 类别名称
	@Column(name = "ASSISTANCE_CLASS_NAME")
	private String assistanceClassName;
	//发放分类
	private String target;
	// 计算方式
	@Column(name = "COMPUTE_MODE")
	private String computeMode;
	// 计算金额或浮动比例
	@Column(name = "COMPUTE_VALUE")
	private BigDecimal computeValue;
	// 启用日期
	@Column(name = "BEGIN_DATE")
	private String beginDate;
	// 停用日期
	@Column(name = "END_DATE")
	private String endDate;
	// 所属区县
	@Column(name = "AREA_CODE")
	private String areaCode;
	// 使用标志
	@Column(name = "IN_USE")
	private String inUse;
	// 备注
	@Column(name = "REMARKS")
	private String remarks;
	// 录入人
	@Column(name = "REG_PEOPLE")
	private String regPeople;
	// 录入单位
	@Column(name = "REG_ORGAN")
	private String regOrgan;
	// 录入时间
	@Column(name = "REG_TIME")
	private String regTime;

	/**
	 * getter for 内码
	 * 
	 * @generated
	 */
	public String getAssistanceClassId() {
		return this.assistanceClassId;
	}

	/**
	 * setter for 内码
	 * 
	 * @generated
	 */
	public void setAssistanceClassId(String assistanceClassId) {
		this.assistanceClassId = assistanceClassId;
	}

	/**
	 * getter for 救助类别
	 * 
	 * @generated
	 */
	public String getAssistanceType() {
		return this.assistanceType;
	}

	/**
	 * setter for 救助类别
	 * 
	 * @generated
	 */
	public void setAssistanceType(String assistanceType) {
		this.assistanceType = assistanceType;
	}

	/**
	 * getter for 类别名称
	 * 
	 * @generated
	 */
	public String getAssistanceClassName() {
		return this.assistanceClassName;
	}

	/**
	 * setter for 类别名称
	 * 
	 * @generated
	 */
	public void setAssistanceClassName(String assistanceClassName) {
		this.assistanceClassName = assistanceClassName;
	}

	/**
	 * getter for 计算方式
	 * 
	 * @generated
	 */
	public String getComputeMode() {
		return this.computeMode;
	}

	/**
	 * setter for 计算方式
	 * 
	 * @generated
	 */
	public void setComputeMode(String computeMode) {
		this.computeMode = computeMode;
	}

	/**
	 * getter for 计算金额或浮动比例
	 * 
	 * @generated
	 */
	public BigDecimal getComputeValue() {
		return this.computeValue;
	}

	/**
	 * setter for 计算金额或浮动比例
	 * 
	 * @generated
	 */
	public void setComputeValue(BigDecimal computeValue) {
		this.computeValue = computeValue;
	}

	/**
	 * getter for 启用日期
	 * 
	 * @generated
	 */
	public String getBeginDate() {
		return this.beginDate;
	}

	/**
	 * setter for 启用日期
	 * 
	 * @generated
	 */
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * getter for 结束日期
	 * 
	 * @generated
	 */
	public String getEndDate() {
		return this.endDate;
	}

	/**
	 * setter for 结束日期
	 * 
	 * @generated
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * getter for 所属区县
	 * 
	 * @generated
	 */
	public String getAreaCode() {
		return this.areaCode;
	}

	/**
	 * setter for 所属区县
	 * 
	 * @generated
	 */
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	/**
	 * getter for 使用标志
	 * 
	 * @generated
	 */
	public String getInUse() {
		return this.inUse;
	}

	/**
	 * setter for 使用标志
	 * 
	 * @generated
	 */
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getRemarks() {
		return this.remarks;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	/**
	 * getter for 录入人
	 * 
	 * @generated
	 */
	public String getRegPeople() {
		return this.regPeople;
	}

	/**
	 * setter for 录入人
	 * 
	 * @generated
	 */
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}

	/**
	 * getter for 录入单位
	 * 
	 * @generated
	 */
	public String getRegOrgan() {
		return this.regOrgan;
	}

	/**
	 * setter for 录入单位
	 * 
	 * @generated
	 */
	public void setRegOrgan(String regOrgan) {
		this.regOrgan = regOrgan;
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
	 * @return the assistanceClassCode
	 */
	public String getAssistanceClassCode() {
		return assistanceClassCode;
	}

	/**
	 * @param assistanceClassCode the assistanceClassCode to set
	 */
	public void setAssistanceClassCode(String assistanceClassCode) {
		this.assistanceClassCode = assistanceClassCode;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

}