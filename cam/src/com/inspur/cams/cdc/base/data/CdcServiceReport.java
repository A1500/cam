package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息社区服务统计�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_SERVICE_REPORT", keyFields = "recordId")
public class CdcServiceReport extends StatefulDatabean {

	// 统计内码
	private String recordId;

	// 社区数量
	@Rule( value = "number" )
	private BigDecimal communityNum;

	// �?展服务社区数
	@Rule( value = "number" )
	private BigDecimal serviceNum;

	// �?站式服务大厅�?
	@Rule( value = "number" )
	private BigDecimal onceNum;

	// 公共服务服务项目�?
	@Rule( value = "number" )
	private BigDecimal publicNum;

	// 公共服务现场办理�?
	@Rule( value = "number" )
	private BigDecimal publicLocaleNum;

	// 公共服务全程代理�?
	@Rule( value = "number" )
	private BigDecimal publicSupplyNum;

	// 公共服务其他�?
	@Rule( value = "number" )
	private BigDecimal publicOtherNum;

	// 公共服务主管单位�?
	@Rule( value = "number" )
	private BigDecimal publicMorgNum;

	// 公共服务服务人员�?
	@Rule( value = "number" )
	private BigDecimal publicPeopleNum;

	// 公共服务全天�?
	@Rule( value = "number" )
	private BigDecimal publicDayNum;

	// 公共服务非全天数
	@Rule( value = "number" )
	private BigDecimal publicNotdayNum;

	// 便民利民项目�?
	@Rule( value = "number" )
	private BigDecimal facilitateNum;

	// 便民利民主管单位�?
	@Rule( value = "number" )
	private BigDecimal facilitateMorgNum;

	// 便民利民服务人员�?
	@Rule( value = "number" )
	private BigDecimal facilitatePeopleNum;

	// 便民利民办公场所总面�?
//	@Rule( value = "number" )
	private BigDecimal facilitateArea;

	// 便民利民24小时服务�?
	@Rule( value = "number" )
	private BigDecimal facilitateDayNum;

	// 志愿者服务项目数
	@Rule( value = "number" )
	private BigDecimal voluntNum;

	// 志愿者服务当年成立数
	@Rule( value = "number" )
	private BigDecimal voluntYearNum;

	// 志愿者服务针对儿童数
	@Rule( value = "number" )
	private BigDecimal voluntChildNum;

	// 志愿者服务针对�?�年人数
	@Rule( value = "number" )
	private BigDecimal voluntOldNum;

	// 志愿者服务针对残疾人�?
	@Rule( value = "number" )
	private BigDecimal voluntHandiNum;

	// 志愿者服务针对困难群众数
	@Rule( value = "number" )
	private BigDecimal voluntDiffNum;

	// 志愿者服务针对其他数
	@Rule( value = "number" )
	private BigDecimal voluntOtherNum;

	// 志愿者人�?
	@Rule( value = "number" )
	private BigDecimal volunteerNum;

	// 志愿者注册人�?
	@Rule( value = "number" )
	private BigDecimal regNum;

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
	
	//创建日期
	private String createTime;
	


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
	 * 设置 �?展服务社区数
	 * @return BigDecimal
	 */
	public BigDecimal getServiceNum() {
		return serviceNum;
	}

	/**
	 * 设置 �?展服务社区数
	 */
	public void setServiceNum(BigDecimal serviceNum) {
		this.serviceNum = serviceNum;
	}

	/**
	 * 设置 �?站式服务大厅�?
	 * @return BigDecimal
	 */
	public BigDecimal getOnceNum() {
		return onceNum;
	}

	/**
	 * 设置 �?站式服务大厅�?
	 */
	public void setOnceNum(BigDecimal onceNum) {
		this.onceNum = onceNum;
	}

	/**
	 * 设置 公共服务服务项目�?
	 * @return BigDecimal
	 */
	public BigDecimal getPublicNum() {
		return publicNum;
	}

	/**
	 * 设置 公共服务服务项目�?
	 */
	public void setPublicNum(BigDecimal publicNum) {
		this.publicNum = publicNum;
	}

	/**
	 * 设置 公共服务现场办理�?
	 * @return BigDecimal
	 */
	public BigDecimal getPublicLocaleNum() {
		return publicLocaleNum;
	}

	/**
	 * 设置 公共服务现场办理�?
	 */
	public void setPublicLocaleNum(BigDecimal publicLocaleNum) {
		this.publicLocaleNum = publicLocaleNum;
	}

	/**
	 * 设置 公共服务全程代理�?
	 * @return BigDecimal
	 */
	public BigDecimal getPublicSupplyNum() {
		return publicSupplyNum;
	}

	/**
	 * 设置 公共服务全程代理�?
	 */
	public void setPublicSupplyNum(BigDecimal publicSupplyNum) {
		this.publicSupplyNum = publicSupplyNum;
	}

	/**
	 * 设置 公共服务其他�?
	 * @return BigDecimal
	 */
	public BigDecimal getPublicOtherNum() {
		return publicOtherNum;
	}

	/**
	 * 设置 公共服务其他�?
	 */
	public void setPublicOtherNum(BigDecimal publicOtherNum) {
		this.publicOtherNum = publicOtherNum;
	}

	/**
	 * 设置 公共服务主管单位�?
	 * @return BigDecimal
	 */
	public BigDecimal getPublicMorgNum() {
		return publicMorgNum;
	}

	/**
	 * 设置 公共服务主管单位�?
	 */
	public void setPublicMorgNum(BigDecimal publicMorgNum) {
		this.publicMorgNum = publicMorgNum;
	}

	/**
	 * 设置 公共服务服务人员�?
	 * @return BigDecimal
	 */
	public BigDecimal getPublicPeopleNum() {
		return publicPeopleNum;
	}

	/**
	 * 设置 公共服务服务人员�?
	 */
	public void setPublicPeopleNum(BigDecimal publicPeopleNum) {
		this.publicPeopleNum = publicPeopleNum;
	}

	/**
	 * 设置 公共服务全天�?
	 * @return BigDecimal
	 */
	public BigDecimal getPublicDayNum() {
		return publicDayNum;
	}

	/**
	 * 设置 公共服务全天�?
	 */
	public void setPublicDayNum(BigDecimal publicDayNum) {
		this.publicDayNum = publicDayNum;
	}

	/**
	 * 设置 公共服务非全天数
	 * @return BigDecimal
	 */
	public BigDecimal getPublicNotdayNum() {
		return publicNotdayNum;
	}

	/**
	 * 设置 公共服务非全天数
	 */
	public void setPublicNotdayNum(BigDecimal publicNotdayNum) {
		this.publicNotdayNum = publicNotdayNum;
	}

	/**
	 * 设置 便民利民项目�?
	 * @return BigDecimal
	 */
	public BigDecimal getFacilitateNum() {
		return facilitateNum;
	}

	/**
	 * 设置 便民利民项目�?
	 */
	public void setFacilitateNum(BigDecimal facilitateNum) {
		this.facilitateNum = facilitateNum;
	}

	/**
	 * 设置 便民利民主管单位�?
	 * @return BigDecimal
	 */
	public BigDecimal getFacilitateMorgNum() {
		return facilitateMorgNum;
	}

	/**
	 * 设置 便民利民主管单位�?
	 */
	public void setFacilitateMorgNum(BigDecimal facilitateMorgNum) {
		this.facilitateMorgNum = facilitateMorgNum;
	}

	/**
	 * 设置 便民利民服务人员�?
	 * @return BigDecimal
	 */
	public BigDecimal getFacilitatePeopleNum() {
		return facilitatePeopleNum;
	}

	/**
	 * 设置 便民利民服务人员�?
	 */
	public void setFacilitatePeopleNum(BigDecimal facilitatePeopleNum) {
		this.facilitatePeopleNum = facilitatePeopleNum;
	}

	/**
	 * 设置 便民利民办公场所总面�?
	 * @return BigDecimal
	 */
	public BigDecimal getFacilitateArea() {
		return facilitateArea;
	}

	/**
	 * 设置 便民利民办公场所总面�?
	 */
	public void setFacilitateArea(BigDecimal facilitateArea) {
		this.facilitateArea = facilitateArea;
	}


	/**
	 * 设置 便民利民24小时服务�?
	 * @return BigDecimal
	 */
	public BigDecimal getFacilitateDayNum() {
		return facilitateDayNum;
	}

	/**
	 * 设置 便民利民24小时服务�?
	 */
	public void setFacilitateDayNum(BigDecimal facilitateDayNum) {
		this.facilitateDayNum = facilitateDayNum;
	}

	/**
	 * 设置 志愿者服务项目数
	 * @return BigDecimal
	 */
	public BigDecimal getVoluntNum() {
		return voluntNum;
	}

	/**
	 * 设置 志愿者服务项目数
	 */
	public void setVoluntNum(BigDecimal voluntNum) {
		this.voluntNum = voluntNum;
	}


	/**
	 * 设置 志愿者服务当年成立数
	 * @return BigDecimal
	 */
	public BigDecimal getVoluntYearNum() {
		return voluntYearNum;
	}

	/**
	 * 设置 志愿者服务当年成立数
	 */
	public void setVoluntYearNum(BigDecimal voluntYearNum) {
		this.voluntYearNum = voluntYearNum;
	}

	/**
	 * 设置 志愿者服务针对儿童数
	 * @return BigDecimal
	 */
	public BigDecimal getVoluntChildNum() {
		return voluntChildNum;
	}

	/**
	 * 设置 志愿者服务针对儿童数
	 */
	public void setVoluntChildNum(BigDecimal voluntChildNum) {
		this.voluntChildNum = voluntChildNum;
	}

	/**
	 * 设置 志愿者服务针对�?�年人数
	 * @return BigDecimal
	 */
	public BigDecimal getVoluntOldNum() {
		return voluntOldNum;
	}

	/**
	 * 设置 志愿者服务针对�?�年人数
	 */
	public void setVoluntOldNum(BigDecimal voluntOldNum) {
		this.voluntOldNum = voluntOldNum;
	}

	/**
	 * 设置 志愿者服务针对残疾人�?
	 * @return BigDecimal
	 */
	public BigDecimal getVoluntHandiNum() {
		return voluntHandiNum;
	}

	/**
	 * 设置 志愿者服务针对残疾人�?
	 */
	public void setVoluntHandiNum(BigDecimal voluntHandiNum) {
		this.voluntHandiNum = voluntHandiNum;
	}

	/**
	 * 设置 志愿者服务针对困难群众数
	 * @return BigDecimal
	 */
	public BigDecimal getVoluntDiffNum() {
		return voluntDiffNum;
	}

	/**
	 * 设置 志愿者服务针对困难群众数
	 */
	public void setVoluntDiffNum(BigDecimal voluntDiffNum) {
		this.voluntDiffNum = voluntDiffNum;
	}

	/**
	 * 设置 志愿者服务针对其他数
	 * @return BigDecimal
	 */
	public BigDecimal getVoluntOtherNum() {
		return voluntOtherNum;
	}

	/**
	 * 设置 志愿者服务针对其他数
	 */
	public void setVoluntOtherNum(BigDecimal voluntOtherNum) {
		this.voluntOtherNum = voluntOtherNum;
	}

	/**
	 * 设置 志愿者人�?
	 * @return BigDecimal
	 */
	public BigDecimal getVolunteerNum() {
		return volunteerNum;
	}

	/**
	 * 设置 志愿者人�?
	 */
	public void setVolunteerNum(BigDecimal volunteerNum) {
		this.volunteerNum = volunteerNum;
	}

	/**
	 * 设置 志愿者注册人�?
	 * @return BigDecimal
	 */
	public BigDecimal getRegNum() {
		return regNum;
	}

	/**
	 * 设置 志愿者注册人�?
	 */
	public void setRegNum(BigDecimal regNum) {
		this.regNum = regNum;
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
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}


}