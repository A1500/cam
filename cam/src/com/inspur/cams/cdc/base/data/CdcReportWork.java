package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主填报工作信息databean
 * @author shgtch
 * @date 2011-12-19
 */
@Table(tableName = "CDC_REPORT_WORK", keyFields = "workId")
public class CdcReportWork extends StatefulDatabean {
	
	// 工作内码
	private String workId;
	
	// 填报内容
	private String reportDesc;

	// 填报报表
	private String reportId;

	// 填报日期
	private String reportDate;

	// 状态
	private String status;

	// 发起单位行政区划
	private String organCode;
	
	// 发起单位名称
	private String organName;

	// 创建时间
	private String createTime;

	// 农村选举界次
	private String countryElectionSeason;
	/**
	 * 获取 工作内码
	 * @return String
	 */
	public String getWorkId() {
		return workId;
	}

	/**
	 * 设置 工作内码
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}

	/**
	 * 获取 填报内容
	 * @return String
	 */
	public String getReportDesc() {
		return reportDesc;
	}

	/**
	 * 设置 填报内容
	 */
	public void setReportDesc(String reportDesc) {
		this.reportDesc = reportDesc;
	}

	/**
	 * 获取 填报报表
	 * @return String
	 */
	public String getReportId() {
		return reportId;
	}

	/**
	 * 设置 填报报表
	 */
	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

	/**
	 * 获取 填报日期
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
	 * 设置 上报状态
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
	 * 获取 创建时间
	 * @return
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建时间
	 * @param organName
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getCountryElectionSeason() {
		return countryElectionSeason;
	}

	public void setCountryElectionSeason(String countryElectionSeason) {
		this.countryElectionSeason = countryElectionSeason;
	}
	
}