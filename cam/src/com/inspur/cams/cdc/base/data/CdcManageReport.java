package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主民主管理统计
 * 
 * @title:CdcManageReport
 * @description:
 * @author:
 * @since:2012-02-06
 * @version:1.0
 */
@Table(tableName = "CDC_MANAGE_REPORT", keyFields = "recordId")
public class CdcManageReport extends StatefulDatabean {
	
	// 统计内码
	private String recordId;
	
	// 建立村居民自治章程村居数
	private BigDecimal ruleNum;
	
	// 未建立村居民自治章程村居数
	private BigDecimal notRuleNum;
	
	// 建立村居公约村居数
	private BigDecimal pactNum;
	
	// 未建立村居公约村居数
	private BigDecimal notPactNum;

	// 建立建立村务档案村居数
	private BigDecimal archiveNum;
	
	// 未建立建立村务档案村居数
	private BigDecimal notArchiveNum;
	
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
	
	// 创建日期
	private String createTime;
	

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public BigDecimal getRuleNum() {
		return ruleNum;
	}

	public void setRuleNum(BigDecimal ruleNum) {
		this.ruleNum = ruleNum;
	}

	public BigDecimal getNotRuleNum() {
		return notRuleNum;
	}

	public void setNotRuleNum(BigDecimal notRuleNum) {
		this.notRuleNum = notRuleNum;
	}

	public BigDecimal getPactNum() {
		return pactNum;
	}

	public void setPactNum(BigDecimal pactNum) {
		this.pactNum = pactNum;
	}

	public BigDecimal getNotPactNum() {
		return notPactNum;
	}

	public void setNotPactNum(BigDecimal notPactNum) {
		this.notPactNum = notPactNum;
	}

	public BigDecimal getArchiveNum() {
		return archiveNum;
	}

	public void setArchiveNum(BigDecimal archiveNum) {
		this.archiveNum = archiveNum;
	}

	public BigDecimal getNotArchiveNum() {
		return notArchiveNum;
	}

	public void setNotArchiveNum(BigDecimal notArchiveNum) {
		this.notArchiveNum = notArchiveNum;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}


}