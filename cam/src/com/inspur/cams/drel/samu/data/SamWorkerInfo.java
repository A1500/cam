package com.inspur.cams.drel.samu.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 工作人员信息databean
 * @author 
 * @date 2012-09-26
 */
@Table(tableName = "SAM_WORKER_INFO", keyFields = "workerId")
public class SamWorkerInfo extends StatefulDatabean {

	// 工作人员ID
	private String workerId;

	// 敬老院ID
	private String gerocomiumId;

	// 姓名
	private String workerName;

	// 身份证号
	private String idCard;

	// 性别
	private String sex;

	// 出生日期
	private String birthday;

	// 民族
	private String nation;

	// 政治面貌
	private String politicsStatus;

	// 文化程度
	private String educationLevel;

	// 岗位性质
	private String postProperty;

	// 工种
	private String workType;

	// 职务
	private String positon;

	// 乡镇府在编人员
	private String isEnrolled;

	// 培训简历
	private String resumeTrain;

	// 是否法人代表
	private String isLegelPeople;

	// 工资
	private String salary;

	// 办公电话
	private String officePhone;

	// 手机
	private String telphone;

	// 到岗时间
	private String dutyTime;

	// 是否在岗
	private String isOnduty;

	// 离岗时间
	private String leaveTime;

	/**
	 * 获取 工作人员ID
	 * @return String
	 */
	public String getWorkerId() {
		return workerId;
	}

	/**
	 * 设置 工作人员ID
	 */
	public void setWorkerId(String workerId) {
		this.workerId = workerId;
	}

	/**
	 * 获取 敬老院ID
	 * @return String
	 */
	public String getGerocomiumId() {
		return gerocomiumId;
	}

	/**
	 * 设置 敬老院ID
	 */
	public void setGerocomiumId(String gerocomiumId) {
		this.gerocomiumId = gerocomiumId;
	}

	/**
	 * 获取 姓名
	 * @return String
	 */
	public String getWorkerName() {
		return workerName;
	}

	/**
	 * 设置 姓名
	 */
	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}

	/**
	 * 获取 身份证号
	 * @return String
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * 设置 身份证号
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * 获取 性别
	 * @return String
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * 设置 性别
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * 获取 出生日期
	 * @return String
	 */
	public String getBirthday() {
		return birthday;
	}

	/**
	 * 设置 出生日期
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	/**
	 * 获取 民族
	 * @return String
	 */
	public String getNation() {
		return nation;
	}

	/**
	 * 设置 民族
	 */
	public void setNation(String nation) {
		this.nation = nation;
	}

	/**
	 * 获取 政治面貌
	 * @return String
	 */
	public String getPoliticsStatus() {
		return politicsStatus;
	}

	/**
	 * 设置 政治面貌
	 */
	public void setPoliticsStatus(String politicsStatus) {
		this.politicsStatus = politicsStatus;
	}

	/**
	 * 获取 文化程度
	 * @return String
	 */
	public String getEducationLevel() {
		return educationLevel;
	}

	/**
	 * 设置 文化程度
	 */
	public void setEducationLevel(String educationLevel) {
		this.educationLevel = educationLevel;
	}

	/**
	 * 获取 岗位性质
	 * @return String
	 */
	public String getPostProperty() {
		return postProperty;
	}

	/**
	 * 设置 岗位性质
	 */
	public void setPostProperty(String postProperty) {
		this.postProperty = postProperty;
	}

	/**
	 * 获取 工种
	 * @return String
	 */
	public String getWorkType() {
		return workType;
	}

	/**
	 * 设置 工种
	 */
	public void setWorkType(String workType) {
		this.workType = workType;
	}

	/**
	 * 获取 职务
	 * @return String
	 */
	public String getPositon() {
		return positon;
	}

	/**
	 * 设置 职务
	 */
	public void setPositon(String positon) {
		this.positon = positon;
	}

	/**
	 * 获取 乡镇府在编人员
	 * @return String
	 */
	public String getIsEnrolled() {
		return isEnrolled;
	}

	/**
	 * 设置 乡镇府在编人员
	 */
	public void setIsEnrolled(String isEnrolled) {
		this.isEnrolled = isEnrolled;
	}

	/**
	 * 获取 培训简历
	 * @return String
	 */
	public String getResumeTrain() {
		return resumeTrain;
	}

	/**
	 * 设置 培训简历
	 */
	public void setResumeTrain(String resumeTrain) {
		this.resumeTrain = resumeTrain;
	}

	/**
	 * 获取 是否法人代表
	 * @return String
	 */
	public String getIsLegelPeople() {
		return isLegelPeople;
	}

	/**
	 * 设置 是否法人代表
	 */
	public void setIsLegelPeople(String isLegelPeople) {
		this.isLegelPeople = isLegelPeople;
	}

	/**
	 * 获取 工资
	 * @return BigDecimal
	 */
	public String getSalary() {
		return salary;
	}

	/**
	 * 设置 工资
	 */
	public void setSalary(String salary) {
		this.salary = salary;
	}

	/**
	 * 获取 办公电话
	 * @return String
	 */
	public String getOfficePhone() {
		return officePhone;
	}

	/**
	 * 设置 办公电话
	 */
	public void setOfficePhone(String officePhone) {
		this.officePhone = officePhone;
	}

	/**
	 * 获取 手机
	 * @return String
	 */
	public String getTelphone() {
		return telphone;
	}

	/**
	 * 设置 手机
	 */
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}

	/**
	 * 获取 到岗时间
	 * @return String
	 */
	public String getDutyTime() {
		return dutyTime;
	}

	/**
	 * 设置 到岗时间
	 */
	public void setDutyTime(String dutyTime) {
		this.dutyTime = dutyTime;
	}

	/**
	 * 获取 是否在岗
	 * @return String
	 */
	public String getIsOnduty() {
		return isOnduty;
	}

	/**
	 * 设置 是否在岗
	 */
	public void setIsOnduty(String isOnduty) {
		this.isOnduty = isOnduty;
	}

	/**
	 * 获取 离岗时间
	 * @return String
	 */
	public String getLeaveTime() {
		return leaveTime;
	}

	/**
	 * 设置 离岗时间
	 */
	public void setLeaveTime(String leaveTime) {
		this.leaveTime = leaveTime;
	}

}