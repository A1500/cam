package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举选举程序信息�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_ELECTION_PROGRAM", keyFields = "programId")
public class CdcElectionProgram extends StatefulDatabean {

	// 选举程序内码
	private String programId;

	// 选举内码
	private String recordId;

	// 是否召开选举大会集中投票
	private BigDecimal ifMeeting;

	// 是否设投票中�?
	private BigDecimal ifStation;

	// 是否设秘密划票间
	private BigDecimal ifSecret;

	// 是否设流动投票箱
	private BigDecimal ifFlow;

	// 是否公开唱票
	private BigDecimal ifPublic;

	// 是否当场公布选举结果
	private BigDecimal ifPublicResult;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报日期
	private String reportDate;

	// 上报状�??
	private String status;

	// 上报日期
	private String submitDate;
	
	//填报报表类型
	private String reportType;
	
	//创建时间
	private String createTime;

	/**
	 * 设置 选举程序内码
	 * @return String
	 */
	public String getProgramId() {
		return programId;
	}

	/**
	 * 设置 选举程序内码
	 */
	public void setProgramId(String programId) {
		this.programId = programId;
	}

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
	 * 设置 是否召开选举大会集中投票
	 * @return BigDecimal
	 */
	public BigDecimal getIfMeeting() {
		return ifMeeting;
	}

	/**
	 * 设置 是否召开选举大会集中投票
	 */
	public void setIfMeeting(BigDecimal ifMeeting) {
		this.ifMeeting = ifMeeting;
	}

	/**
	 * 设置 是否设投票中�?
	 * @return BigDecimal
	 */
	public BigDecimal getIfStation() {
		return ifStation;
	}

	/**
	 * 设置 是否设投票中�?
	 */
	public void setIfStation(BigDecimal ifStation) {
		this.ifStation = ifStation;
	}

	/**
	 * 设置 是否设秘密划票间
	 * @return BigDecimal
	 */
	public BigDecimal getIfSecret() {
		return ifSecret;
	}

	/**
	 * 设置 是否设秘密划票间
	 */
	public void setIfSecret(BigDecimal ifSecret) {
		this.ifSecret = ifSecret;
	}

	/**
	 * 设置 是否设流动投票箱
	 * @return BigDecimal
	 */
	public BigDecimal getIfFlow() {
		return ifFlow;
	}

	/**
	 * 设置 是否设流动投票箱
	 */
	public void setIfFlow(BigDecimal ifFlow) {
		this.ifFlow = ifFlow;
	}

	/**
	 * 设置 是否公开唱票
	 * @return BigDecimal
	 */
	public BigDecimal getIfPublic() {
		return ifPublic;
	}

	/**
	 * 设置 是否公开唱票
	 */
	public void setIfPublic(BigDecimal ifPublic) {
		this.ifPublic = ifPublic;
	}

	/**
	 * 设置 是否当场公布选举结果
	 * @return BigDecimal
	 */
	public BigDecimal getIfPublicResult() {
		return ifPublicResult;
	}

	/**
	 * 设置 是否当场公布选举结果
	 */
	public void setIfPublicResult(BigDecimal ifPublicResult) {
		this.ifPublicResult = ifPublicResult;
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

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}