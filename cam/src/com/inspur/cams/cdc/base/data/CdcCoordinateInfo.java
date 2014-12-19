package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社区建设领导协调机制信息表databean
 * @author shgtch
 * @date 2012-2-24
 */
@Table(tableName = "CDC_COORDINATE_INFO", keyFields = "coordinateId")
public class CdcCoordinateInfo extends StatefulDatabean {

	// 协调机制内码
	private String coordinateId;

	// 是否成立
	private String ifFound;

	// 名称
	private String name;

	// 职责
	private String duty;

	// 牵头部门
	private String department;

	// 联系人姓名
	private String linkPeople;

	// 电话
	private String phone;

	// 负责人职责
	private String position;

	// 是否纳入财政预算及标准
	private String ifBudget;
	
	//标准
	private BigDecimal criterion;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报日期
	private String reportDate;
	
	//报表填报类型
	private String reportType;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	
	// 上报日期
	private String createTime;

	/**
	 * 获取 协调机制内码
	 * @return String
	 */
	public String getCoordinateId() {
		return coordinateId;
	}

	/**
	 * 设置 协调机制内码
	 */
	public void setCoordinateId(String coordinateId) {
		this.coordinateId = coordinateId;
	}

	/**
	 * 获取 是否成立
	 * @return String
	 */
	public String getIfFound() {
		return ifFound;
	}

	/**
	 * 设置 是否成立
	 */
	public void setIfFound(String ifFound) {
		this.ifFound = ifFound;
	}

	/**
	 * 获取 名称
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取 职责
	 * @return String
	 */
	public String getDuty() {
		return duty;
	}

	/**
	 * 设置 职责
	 */
	public void setDuty(String duty) {
		this.duty = duty;
	}

	/**
	 * 获取 牵头部门
	 * @return String
	 */
	public String getDepartment() {
		return department;
	}

	/**
	 * 设置 牵头部门
	 */
	public void setDepartment(String department) {
		this.department = department;
	}

	/**
	 * 获取 联系人姓名
	 * @return String
	 */
	public String getLinkPeople() {
		return linkPeople;
	}

	/**
	 * 设置 联系人姓名
	 */
	public void setLinkPeople(String linkPeople) {
		this.linkPeople = linkPeople;
	}

	/**
	 * 获取 电话
	 * @return String
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置 电话
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取 负责人职责
	 * @return String
	 */
	public String getPosition() {
		return position;
	}

	/**
	 * 设置 负责人职责
	 */
	public void setPosition(String position) {
		this.position = position;
	}

	/**
	 * 获取 是否纳入财政预算及标准
	 * @return
	 */
	public String getIfBudget() {
		return ifBudget;
	}

	/**
	 * 设置 是否纳入财政预算及标准
	 * @param ifBudget
	 */
	public void setIfBudget(String ifBudget) {
		this.ifBudget = ifBudget;
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

	public BigDecimal getCriterion() {
		return criterion;
	}

	public void setCriterion(BigDecimal criterion) {
		this.criterion = criterion;
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