package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息社区资产状况信息表databean
 * @author shgtch
 * @date 2011-12-31
 */
@Table(tableName = "CDC_ECONOMY_INFO", keyFields = "recordId")
public class CdcEconomyInfo extends StatefulDatabean {

	// 资产状况内码
	private String recordId;

	// 社区数量
	@Rule(value = "number" )
	private BigDecimal communityNum;

	// 生产总值
//	@Rule(value = "number" )
	private BigDecimal gdpMon;

	// 农业产值
//	@Rule(value = "number" )
	private BigDecimal agricultureMon;

	// 收入总额
//	@Rule(value = "number" )
	private BigDecimal incomeMon;

	// 人均收入
//	@Rule(value = "number" )
	private BigDecimal personMon;

	// 财政收入
//	@Rule(value = "number" )
	private BigDecimal financeMon;

	// 债权总额
//	@Rule(value = "number" )
	private BigDecimal claimMon;

	// 债务总额
//	@Rule(value = "number" )
	private BigDecimal debtMon;

	// 固定资产总值
//	@Rule(value = "number" )
	private BigDecimal fixedMon;
	
	// 是否负资产
	private String ifNegative;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报报表类型
	private String reportType;
	
	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	//创建日期
	private String createTime;
	
 
	/**
	 * 获取 创建日期
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建日期
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取 资产状况内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 资产状况内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 社区数量
	 * @return BigDecimal
	 */
	public BigDecimal getCommunityNum() {
		return communityNum;
	}

	/**
	 * 设置 社区数量
	 */
	public void setCommunityNum(BigDecimal communityNum) {
		this.communityNum = communityNum;
	}

	/**
	 * 获取 生产总值
	 * @return BigDecimal
	 */
	public BigDecimal getGdpMon() {
		return gdpMon;
	}

	/**
	 * 设置 生产总值
	 */
	public void setGdpMon(BigDecimal gdpMon) {
		this.gdpMon = gdpMon;
	}

	/**
	 * 获取 农业产值
	 * @return BigDecimal
	 */
	public BigDecimal getAgricultureMon() {
		return agricultureMon;
	}

	/**
	 * 设置 农业产值
	 */
	public void setAgricultureMon(BigDecimal agricultureMon) {
		this.agricultureMon = agricultureMon;
	}

	/**
	 * 获取 收入总额
	 * @return BigDecimal
	 */
	public BigDecimal getIncomeMon() {
		return incomeMon;
	}

	/**
	 * 设置 收入总额
	 */
	public void setIncomeMon(BigDecimal incomeMon) {
		this.incomeMon = incomeMon;
	}

	/**
	 * 获取 人均收入
	 * @return BigDecimal
	 */
	public BigDecimal getPersonMon() {
		return personMon;
	}

	/**
	 * 设置 人均收入
	 */
	public void setPersonMon(BigDecimal personMon) {
		this.personMon = personMon;
	}

	/**
	 * 获取 财政收入
	 * @return BigDecimal
	 */
	public BigDecimal getFinanceMon() {
		return financeMon;
	}

	/**
	 * 设置 财政收入
	 */
	public void setFinanceMon(BigDecimal financeMon) {
		this.financeMon = financeMon;
	}

	/**
	 * 获取 债权总额
	 * @return BigDecimal
	 */
	public BigDecimal getClaimMon() {
		return claimMon;
	}

	/**
	 * 设置 债权总额
	 */
	public void setClaimMon(BigDecimal claimMon) {
		this.claimMon = claimMon;
	}

	/**
	 * 获取 债务总额
	 * @return BigDecimal
	 */
	public BigDecimal getDebtMon() {
		return debtMon;
	}

	/**
	 * 设置 债务总额
	 */
	public void setDebtMon(BigDecimal debtMon) {
		this.debtMon = debtMon;
	}

	/**
	 * 获取 固定资产总值
	 * @return BigDecimal
	 */
	public BigDecimal getFixedMon() {
		return fixedMon;
	}

	/**
	 * 设置 固定资产总值
	 */
	public void setFixedMon(BigDecimal fixedMon) {
		this.fixedMon = fixedMon;
	}

	/**
	 * 获取 填报单位行政区划
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 填报单位行政区划
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 填报单位名称
	 * @return
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 填报单位名称
	 * @param organName
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	
	/**
	 * 获取 所属上级行政区划
	 * @return
	 */
	public String getParentCode() {
		return parentCode;
	}

	/**
	 * 设置 所属上级行政区划
	 * @param parentCode
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * 获取 填报报表类型
	 * @return
	 */
	public String getReportType() {
		return reportType;
	}

	/**
	 * 设置 填报报表类型
	 * @param organName
	 */
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	/**
	 * 设置 填报日期
	 * @return String
	 */
	public String getReportDate() {
		return reportDate;
	}

	/**
	 * 设置 填报日期
	 */
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * 获取 上报状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 上报状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 获取 上报日期
	 * @return String
	 */
	public String getSubmitDate() {
		return submitDate;
	}

	/**
	 * 设置 上报日期
	 */
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getIfNegative() {
		return ifNegative;
	}

	public void setIfNegative(String ifNegative) {
		this.ifNegative = ifNegative;
	}

}