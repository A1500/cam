package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举党员信息databean
 * @author 
 * @date 2012-12-14
 */
@Table(tableName = "CDC_ELECTION_PARTY", keyFields = "partyId")
public class CdcElectionParty extends StatefulDatabean {

	@Transient
	private List<CdcElectionMember> cdcElectionMemberList = new ArrayList<CdcElectionMember>();
	
	// 成员组成内码
	private String partyId;

	// 选举内码
	private String recordId;

	// 党员人数
	private BigDecimal partyNum;

	// 妇女党员人数
	private BigDecimal femaleNum;

	// 少数民族党员人数
	private BigDecimal folkNum;

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

	public List<CdcElectionMember> getCdcElectionMemberList() {
		return cdcElectionMemberList;
	}

	public void setCdcElectionMemberList(
			List<CdcElectionMember> cdcElectionMemberList) {
		this.cdcElectionMemberList = cdcElectionMemberList;
	}

	/**
	 * 获取 成员组成内码
	 * @return String
	 */
	public String getPartyId() {
		return partyId;
	}

	/**
	 * 设置 成员组成内码
	 */
	public void setPartyId(String partyId) {
		this.partyId = partyId;
	}

	/**
	 * 获取 选举内码
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
	 * 获取 党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getPartyNum() {
		return partyNum;
	}

	/**
	 * 设置 党员人数
	 */
	public void setPartyNum(BigDecimal partyNum) {
		this.partyNum = partyNum;
	}

	/**
	 * 获取 妇女党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getFemaleNum() {
		return femaleNum;
	}

	/**
	 * 设置 妇女党员人数
	 */
	public void setFemaleNum(BigDecimal femaleNum) {
		this.femaleNum = femaleNum;
	}

	/**
	 * 获取 少数民族党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getFolkNum() {
		return folkNum;
	}

	/**
	 * 设置 少数民族党员人数
	 */
	public void setFolkNum(BigDecimal folkNum) {
		this.folkNum = folkNum;
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
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 填报单位名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 所属上级行政区划
	 * @return String
	 */
	public String getParentCode() {
		return parentCode;
	}

	/**
	 * 设置 所属上级行政区划
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * 获取 填报报表类型
	 * @return String
	 */
	public String getReportType() {
		return reportType;
	}

	/**
	 * 设置 填报报表类型
	 */
	public void setReportType(String reportType) {
		this.reportType = reportType;
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

}