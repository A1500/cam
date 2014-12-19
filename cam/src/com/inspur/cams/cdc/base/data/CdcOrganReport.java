package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息社区单位组织统信息databean
 * @author shgtch
 * @date 2012-1-4
 */
@Table(tableName = "CDC_ORGAN_REPORT", keyFields = "recordId")
public class CdcOrganReport extends StatefulDatabean {

	// 社区民间组织/单位
	@Transient
	private List<CdcOrganInfo> cdcOrganInfoList = new ArrayList<CdcOrganInfo>();
	
	// 统计内码
	private String recordId;

	// 统计单位类型
	private String organType;

	// 社区数量
	@Rule(value = "number" )
	private BigDecimal communityNum;

	// 单位数量
	@Rule(value = "number" )
	private BigDecimal organNum;

	// 当年进驻数量
	@Rule(value = "number" )
	private BigDecimal organYearNum;

	// 主管数量
	@Rule(value = "number" )
	private BigDecimal morgNum;

	// 性质1个数
	@Rule(value = "number" )
	private BigDecimal kindOneNum;

	// 性质2个数
	@Rule(value = "number" )
	private BigDecimal kindTwoNum;

	// 性质3个数
	@Rule(value = "number" )
	private BigDecimal kindThreeNum;

	// 性质4个数
	@Rule(value = "number" )
	private BigDecimal kindFourNum;

	// 成员/职工数量
	@Rule(value = "number" )
	private BigDecimal memberNum;

	// 办公场所处所
	@Rule(value = "number" )
	private BigDecimal officialNum;

	// 办公场所总面积
	private BigDecimal officialArea;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	
	// 填报报表类型
	private String reportType;

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
	
	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	/**
	 * 获取 社区民间组织/单位
	 * @return
	 */
	public List<CdcOrganInfo> getCdcOrganInfoList() {
		return cdcOrganInfoList;
	}

	/**
	 * 设置 社区民间组织/单位
	 * @param cdcOrganInfoList
	 */
	public void setCdcOrganInfoList(List<CdcOrganInfo> cdcOrganInfoList) {
		this.cdcOrganInfoList = cdcOrganInfoList;
	}

	/**
	 * 获取 统计内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 统计内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 统计单位类型
	 * @return String
	 */
	public String getOrganType() {
		return organType;
	}

	/**
	 * 设置 统计单位类型
	 */
	public void setOrganType(String organType) {
		this.organType = organType;
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
	 * 获取 单位数量
	 * @return BigDecimal
	 */
	public BigDecimal getOrganNum() {
		return organNum;
	}

	/**
	 * 设置 单位数量
	 */
	public void setOrganNum(BigDecimal organNum) {
		this.organNum = organNum;
	}

	/**
	 * 获取 当年进驻数量
	 * @return BigDecimal
	 */
	public BigDecimal getOrganYearNum() {
		return organYearNum;
	}

	/**
	 * 设置 当年进驻数量
	 */
	public void setOrganYearNum(BigDecimal organYearNum) {
		this.organYearNum = organYearNum;
	}

	/**
	 * 获取 主管数量
	 * @return BigDecimal
	 */
	public BigDecimal getMorgNum() {
		return morgNum;
	}

	/**
	 * 设置 主管数量
	 */
	public void setMorgNum(BigDecimal morgNum) {
		this.morgNum = morgNum;
	}

	/**
	 * 获取 性质1个数
	 * @return BigDecimal
	 */
	public BigDecimal getKindOneNum() {
		return kindOneNum;
	}

	/**
	 * 设置 性质1个数
	 */
	public void setKindOneNum(BigDecimal kindOneNum) {
		this.kindOneNum = kindOneNum;
	}

	/**
	 * 获取 性质2个数
	 * @return BigDecimal
	 */
	public BigDecimal getKindTwoNum() {
		return kindTwoNum;
	}

	/**
	 * 设置 性质2个数
	 */
	public void setKindTwoNum(BigDecimal kindTwoNum) {
		this.kindTwoNum = kindTwoNum;
	}

	/**
	 * 获取 性质3个数
	 * @return BigDecimal
	 */
	public BigDecimal getKindThreeNum() {
		return kindThreeNum;
	}

	/**
	 * 设置 性质3个数
	 */
	public void setKindThreeNum(BigDecimal kindThreeNum) {
		this.kindThreeNum = kindThreeNum;
	}

	/**
	 * 获取 性质4个数
	 * @return BigDecimal
	 */
	public BigDecimal getKindFourNum() {
		return kindFourNum;
	}

	/**
	 * 设置 性质4个数
	 */
	public void setKindFourNum(BigDecimal kindFourNum) {
		this.kindFourNum = kindFourNum;
	}

	/**
	 * 获取 成员/职工数量
	 * @return BigDecimal
	 */
	public BigDecimal getMemberNum() {
		return memberNum;
	}

	/**
	 * 设置 成员/职工数量
	 */
	public void setMemberNum(BigDecimal memberNum) {
		this.memberNum = memberNum;
	}

	/**
	 * 获取 办公场所处所
	 * @return BigDecimal
	 */
	public BigDecimal getOfficialNum() {
		return officialNum;
	}

	/**
	 * 设置 办公场所处所
	 */
	public void setOfficialNum(BigDecimal officialNum) {
		this.officialNum = officialNum;
	}

	/**
	 * 获取 办公场所总面积
	 * @return BigDecimal
	 */
	public BigDecimal getOfficialArea() {
		return officialArea;
	}

	/**
	 * 设置 办公场所总面积
	 */
	public void setOfficialArea(BigDecimal officialArea) {
		this.officialArea = officialArea;
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

}