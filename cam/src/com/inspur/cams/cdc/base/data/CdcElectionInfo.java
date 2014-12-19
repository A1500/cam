package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举选举信息�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_ELECTION_INFO", keyFields = "recordId")
public class CdcElectionInfo extends StatefulDatabean {

	// 选举内码
	private String recordId;

	// 是否参加换届选举
	private String ifElection;

	// 是否完成选举
	private String ifComplete;

	// 选举年份
	private String yearly;

	// 选举届次
	private String season;
	
	//完成情况
	private String completeResult;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;
	
	//填报报表类型
	private String reportType;

	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	
	//所属社区
	private String communityCode;

	/**
	 * 设置 选举内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 选举内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 设置 是否参加换届选举
	 * @return String
	 */
	public String getIfElection() {
		return ifElection;
	}

	/**
	 * 设置 是否参加换届选举
	 */
	public void setIfElection(String ifElection) {
		this.ifElection = ifElection;
	}

	/**
	 * 设置 是否完成选举
	 * @return String
	 */
	public String getIfComplete() {
		return ifComplete;
	}

	/**
	 * 设置 是否完成选举
	 */
	public void setIfComplete(String ifComplete) {
		this.ifComplete = ifComplete;
	}

	/**
	 * 设置 选举年份
	 * @return String
	 */
	public String getYearly() {
		return yearly;
	}

	/**
	 * 设置 选举年份
	 */
	public void setYearly(String yearly) {
		this.yearly = yearly;
	}

	/**
	 * 设置 填报单位行政区划
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
	 * 设置 上报状�??
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 上报状�??
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 设置 上报日期
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

	public String getCompleteResult() {
		return completeResult;
	}

	public void setCompleteResult(String completeResult) {
		this.completeResult = completeResult;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	/**
	 * 设置 选举届次
	 */
	public String getSeason() {
		return season;
	}

	/**
	 * 设置 选举届次
	 */
	public void setSeason(String season) {
		this.season = season;
	}

	public String getCommunityCode() {
		return communityCode;
	}

	public void setCommunityCode(String communityCode) {
		this.communityCode = communityCode;
	}

}