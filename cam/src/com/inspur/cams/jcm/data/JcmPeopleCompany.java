package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 人员工作单位信息（多条记录过程）databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_PEOPLE_COMPANY", keyFields = "peopleCompanyId")
public class JcmPeopleCompany extends StatefulDatabean {

	// 人员工作单位主键
	private String peopleCompanyId;

	// 人员主键
	private String peopleId;

	// 单位主键
	private String companyId;

	// 部门
	private String peopleDepartment;

	// 职务
	private String companyDuty;

	// 职称
	private String jobTitle;

	// 房间号
	private String roomsNum;

	// 人员编制性质
	private String establishment;

	// 任职时间
	private String dutyTime;

	// 岗位状态
	private String jobStatus;

	// 手机
	private String molible;

	// 联系电话
	private String phone;

	// 专业资格
	private String qualification;

	// 奖惩记录
	private String rpRecord;

	// 变更时间
	private String changeTime;

	// 任职文号
	private String dutyNum;

	// 任职状态
	private String dutyStatus;

	// 人员所属部门
	private String dutySection;

	/**
	 * 获取 人员工作单位主键
	 * @return String
	 */
	public String getPeopleCompanyId() {
		return peopleCompanyId;
	}

	/**
	 * 设置 人员工作单位主键
	 */
	public void setPeopleCompanyId(String peopleCompanyId) {
		this.peopleCompanyId = peopleCompanyId;
	}

	/**
	 * 获取 人员主键
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员主键
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 单位主键
	 * @return String
	 */
	public String getCompanyId() {
		return companyId;
	}

	/**
	 * 设置 单位主键
	 */
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	/**
	 * 获取 部门
	 * @return String
	 */
	public String getPeopleDepartment() {
		return peopleDepartment;
	}

	/**
	 * 设置 部门
	 */
	public void setPeopleDepartment(String peopleDepartment) {
		this.peopleDepartment = peopleDepartment;
	}

	/**
	 * 获取 职务
	 * @return String
	 */
	public String getCompanyDuty() {
		return companyDuty;
	}

	/**
	 * 设置 职务
	 */
	public void setCompanyDuty(String companyDuty) {
		this.companyDuty = companyDuty;
	}

	/**
	 * 获取 职称
	 * @return String
	 */
	public String getJobTitle() {
		return jobTitle;
	}

	/**
	 * 设置 职称
	 */
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	/**
	 * 获取 房间号
	 * @return String
	 */
	public String getRoomsNum() {
		return roomsNum;
	}

	/**
	 * 设置 房间号
	 */
	public void setRoomsNum(String roomsNum) {
		this.roomsNum = roomsNum;
	}

	/**
	 * 获取 人员编制性质
	 * @return String
	 */
	public String getEstablishment() {
		return establishment;
	}

	/**
	 * 设置 人员编制性质
	 */
	public void setEstablishment(String establishment) {
		this.establishment = establishment;
	}

	/**
	 * 获取 任职时间
	 * @return String
	 */
	public String getDutyTime() {
		return dutyTime;
	}

	/**
	 * 设置 任职时间
	 */
	public void setDutyTime(String dutyTime) {
		this.dutyTime = dutyTime;
	}

	/**
	 * 获取 岗位状态
	 * @return String
	 */
	public String getJobStatus() {
		return jobStatus;
	}

	/**
	 * 设置 岗位状态
	 */
	public void setJobStatus(String jobStatus) {
		this.jobStatus = jobStatus;
	}

	/**
	 * 获取 手机
	 * @return String
	 */
	public String getMolible() {
		return molible;
	}

	/**
	 * 设置 手机
	 */
	public void setMolible(String molible) {
		this.molible = molible;
	}

	/**
	 * 获取 联系电话
	 * @return String
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置 联系电话
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取 专业资格
	 * @return String
	 */
	public String getQualification() {
		return qualification;
	}

	/**
	 * 设置 专业资格
	 */
	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	/**
	 * 获取 奖惩记录
	 * @return String
	 */
	public String getRpRecord() {
		return rpRecord;
	}

	/**
	 * 设置 奖惩记录
	 */
	public void setRpRecord(String rpRecord) {
		this.rpRecord = rpRecord;
	}

	/**
	 * 获取 变更时间
	 * @return String
	 */
	public String getChangeTime() {
		return changeTime;
	}

	/**
	 * 设置 变更时间
	 */
	public void setChangeTime(String changeTime) {
		this.changeTime = changeTime;
	}

	/**
	 * 获取 任职文号
	 * @return String
	 */
	public String getDutyNum() {
		return dutyNum;
	}

	/**
	 * 设置 任职文号
	 */
	public void setDutyNum(String dutyNum) {
		this.dutyNum = dutyNum;
	}

	/**
	 * 获取 任职状态
	 * @return String
	 */
	public String getDutyStatus() {
		return dutyStatus;
	}

	/**
	 * 设置 任职状态
	 */
	public void setDutyStatus(String dutyStatus) {
		this.dutyStatus = dutyStatus;
	}

	/**
	 * 获取 人员所属部门
	 * @return String
	 */
	public String getDutySection() {
		return dutySection;
	}

	/**
	 * 设置 人员所属部门
	 */
	public void setDutySection(String dutySection) {
		this.dutySection = dutySection;
	}

}