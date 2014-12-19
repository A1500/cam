package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社区建设规划信息�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_PLAN_INFO", keyFields = "planId")
public class CdcPlanInfo extends StatefulDatabean {

	// 社区建设规划内码
	private String planId;

	// 规划社区数量
	@Rule( value = "number" )
	private BigDecimal planNum;

	// 规划建设完成社区数量
	@Rule( value = "number" )
	private BigDecimal completeNum;

	// 本年度建设完成社区数�?
	@Rule( value = "number" )
	private BigDecimal yearCompleteNum;
	
	private String fileId;
	
	private String fileName;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;
	
	//报表填报类型
	private String reportType;

	// 填报日期
	private String reportDate;

	// 上报状�??
	private String status;

	// 上报日期
	private String submitDate;
	
	//创建时间
	private String createTime;

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * 设置 社区建设规划内码
	 * @return String
	 */
	public String getPlanId() {
		return planId;
	}

	/**
	 * 设置 社区建设规划内码
	 */
	public void setPlanId(String planId) {
		this.planId = planId;
	}

	/**
	 * 设置 规划社区数量
	 * @return BigDecimal
	 */
	public BigDecimal getPlanNum() {
		return planNum;
	}

	/**
	 * 设置 规划社区数量
	 */
	public void setPlanNum(BigDecimal planNum) {
		this.planNum = planNum;
	}

	/**
	 * 设置 规划建设完成社区数量
	 * @return BigDecimal
	 */
	public BigDecimal getCompleteNum() {
		return completeNum;
	}

	/**
	 * 设置 规划建设完成社区数量
	 */
	public void setCompleteNum(BigDecimal completeNum) {
		this.completeNum = completeNum;
	}

	/**
	 * 设置 本年度建设完成社区数�?
	 * @return BigDecimal
	 */
	public BigDecimal getYearCompleteNum() {
		return yearCompleteNum;
	}

	/**
	 * 设置 本年度建设完成社区数�?
	 */
	public void setYearCompleteNum(BigDecimal yearCompleteNum) {
		this.yearCompleteNum = yearCompleteNum;
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

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

}