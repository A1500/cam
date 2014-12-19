package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息自然状况统计�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_NATURE_REPORT", keyFields = "recordId")
public class CdcNatureReport extends StatefulDatabean {

	// 统计内码
	private String recordId;

	// 社区数量
	private BigDecimal communityNum;

	// 自然村个�?
	private BigDecimal villageNum;

	// 村民小组�?
	private BigDecimal groupNum;

	// 辖区总面�?
	private BigDecimal totalArea;

	// 耕地面积
	private BigDecimal ploughArea;

	// 宅基地�?�面�?
	private BigDecimal houseArea;

	// 集中型个�?
	private BigDecimal collectNum;

	// �?般型个数
	private BigDecimal commonNum;

	// 分散型个�?
	private BigDecimal disperseNum;

	// 山区型个�?
	private BigDecimal mountainNum;

	// 半山区型个数
	private BigDecimal helfMountainNum;

	// 平原型个�?
	private BigDecimal campagnaNum;

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

	// 上报状�??
	private String status;

	// 上报日期
	private String submitDate;
	
	private String createTime;
	

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * 设置 统计内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 统计内码
	 */
	public void setRecordId(String reportId) {
		this.recordId = reportId;
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
	 * 设置 自然村个�?
	 * @return BigDecimal
	 */
	public BigDecimal getVillageNum() {
		return villageNum;
	}

	/**
	 * 设置 自然村个�?
	 */
	public void setVillageNum(BigDecimal villageNum) {
		this.villageNum = villageNum;
	}

	/**
	 * 设置 村民小组�?
	 * @return BigDecimal
	 */
	public BigDecimal getGroupNum() {
		return groupNum;
	}

	/**
	 * 设置 村民小组�?
	 */
	public void setGroupNum(BigDecimal groupNum) {
		this.groupNum = groupNum;
	}

	/**
	 * 设置 辖区总面�?
	 * @return BigDecimal
	 */
	public BigDecimal getTotalArea() {
		return totalArea;
	}

	/**
	 * 设置 辖区总面�?
	 */
	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	/**
	 * 设置 耕地面积
	 * @return BigDecimal
	 */
	public BigDecimal getPloughArea() {
		return ploughArea;
	}

	/**
	 * 设置 耕地面积
	 */
	public void setPloughArea(BigDecimal ploughArea) {
		this.ploughArea = ploughArea;
	}

	/**
	 * 设置 宅基地�?�面�?
	 * @return BigDecimal
	 */
	public BigDecimal getHouseArea() {
		return houseArea;
	}

	/**
	 * 设置 宅基地�?�面�?
	 */
	public void setHouseArea(BigDecimal houseArea) {
		this.houseArea = houseArea;
	}

	/**
	 * 设置 集中型个�?
	 * @return BigDecimal
	 */
	public BigDecimal getCollectNum() {
		return collectNum;
	}

	/**
	 * 设置 集中型个�?
	 */
	public void setCollectNum(BigDecimal collectNum) {
		this.collectNum = collectNum;
	}

	/**
	 * 设置 �?般型个数
	 * @return BigDecimal
	 */
	public BigDecimal getCommonNum() {
		return commonNum;
	}

	/**
	 * 设置 �?般型个数
	 */
	public void setCommonNum(BigDecimal commonNum) {
		this.commonNum = commonNum;
	}

	/**
	 * 设置 分散型个�?
	 * @return BigDecimal
	 */
	public BigDecimal getDisperseNum() {
		return disperseNum;
	}

	/**
	 * 设置 分散型个�?
	 */
	public void setDisperseNum(BigDecimal disperseNum) {
		this.disperseNum = disperseNum;
	}

	/**
	 * 设置 山区型个�?
	 * @return BigDecimal
	 */
	public BigDecimal getMountainNum() {
		return mountainNum;
	}

	/**
	 * 设置 山区型个�?
	 */
	public void setMountainNum(BigDecimal mountainNum) {
		this.mountainNum = mountainNum;
	}

	/**
	 * 设置 半山区型个数
	 * @return BigDecimal
	 */
	public BigDecimal getHelfMountainNum() {
		return helfMountainNum;
	}

	/**
	 * 设置 半山区型个数
	 */
	public void setHelfMountainNum(BigDecimal helfMountainNum) {
		this.helfMountainNum = helfMountainNum;
	}

	/**
	 * 设置 平原型个�?
	 * @return BigDecimal
	 */
	public BigDecimal getCampagnaNum() {
		return campagnaNum;
	}

	/**
	 * 设置 平原型个�?
	 */
	public void setCampagnaNum(BigDecimal campagnaNum) {
		this.campagnaNum = campagnaNum;
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

	/**
	 * 填报报表类型
	 */
	public String getReportType() {
		return reportType;
	}

	/**
	 * 填报报表类型
	 * @param reportType
	 */
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}


}