package com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西理事会成员、监事和工作人员情况
 * 
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
@Table(tableName = "SOM_JX_FUND_PEOPLE", keyFields = "id")
public class SomJxFundPeople extends StatefulDatabean {
	// ID
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// PEOPLE_TYPE
	@Column(name = "PEOPLE_TYPE")
	private String peopleType;
	// SEQ_NUM
	@Column(name = "SEQ_NUM")
	private String seqNum;
	// NAME
	@Column(name = "NAME")
	private String name;
	// SEX
	@Column(name = "SEX")
	private String sex;
	// BIRTHDAY
	@Column(name = "BIRTHDAY")
	private String birthday;
	// POLITICAL
	@Column(name = "POLITICAL")
	private String political;
	// WORK_AND_DUTY
	@Column(name = "WORK_AND_DUTY")
	private String workAndDuty;
	// SORG_DUTY
	@Column(name = "SORG_DUTY")
	private String sorgDuty;
	// REMARK_DATE
	@Column(name = "REMARK_DATE")
	private String remarkDate;
	// MEETING_TIMES
	@Column(name = "MEETING_TIMES")
	private BigDecimal meetingTimes;
	// MONEY
	@Column(name = "MONEY")
	private BigDecimal money;
	// ALLOWANCE
	@Column(name = "ALLOWANCE")
	private BigDecimal allowance;
	// DATE
	@Column(name = "DUTY_DATE")
	private String dutyDate;
	// BETREFFZEILE
	@Column(name = "BETREFFZEILE")
	private String betreffzeile;
	// AVERAGE_YEARLY_SALARY
	@Column(name = "AVERAGE_YEARLY_SALARY")
	private BigDecimal averageYearlySalary;
	/**
	 * getter for ID
	 * 
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for ID
	 * 
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for TASK_CODE
	 * 
	 * @generated
	 */
	public String getTaskCode() {
		return this.taskCode;
	}

	/**
	 * setter for TASK_CODE
	 * 
	 * @generated
	 */
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	/**
	 * getter for PEOPLE_TYPE
	 * 
	 * @generated
	 */
	public String getPeopleType() {
		return this.peopleType;
	}

	/**
	 * setter for PEOPLE_TYPE
	 * 
	 * @generated
	 */
	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
	}

	/**
	 * getter for NAME
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for NAME
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for SEX
	 * 
	 * @generated
	 */
	public String getSex() {
		return this.sex;
	}

	/**
	 * setter for SEX
	 * 
	 * @generated
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * getter for BIRTHDAY
	 * 
	 * @generated
	 */
	public String getBirthday() {
		return this.birthday;
	}

	/**
	 * setter for BIRTHDAY
	 * 
	 * @generated
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	/**
	 * getter for POLITICAL
	 * 
	 * @generated
	 */
	public String getPolitical() {
		return this.political;
	}

	/**
	 * setter for POLITICAL
	 * 
	 * @generated
	 */
	public void setPolitical(String political) {
		this.political = political;
	}

	/**
	 * getter for WORK_AND_DUTY
	 * 
	 * @generated
	 */
	public String getWorkAndDuty() {
		return this.workAndDuty;
	}

	/**
	 * setter for WORK_AND_DUTY
	 * 
	 * @generated
	 */
	public void setWorkAndDuty(String workAndDuty) {
		this.workAndDuty = workAndDuty;
	}

	/**
	 * getter for SORG_DUTY
	 * 
	 * @generated
	 */
	public String getSorgDuty() {
		return this.sorgDuty;
	}

	/**
	 * setter for SORG_DUTY
	 * 
	 * @generated
	 */
	public void setSorgDuty(String sorgDuty) {
		this.sorgDuty = sorgDuty;
	}

	/**
	 * getter for REMARK_DATE
	 * 
	 * @generated
	 */
	public String getRemarkDate() {
		return this.remarkDate;
	}

	/**
	 * setter for REMARK_DATE
	 * 
	 * @generated
	 */
	public void setRemarkDate(String remarkDate) {
		this.remarkDate = remarkDate;
	}

	/**
	 * getter for MEETING_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getMeetingTimes() {
		return this.meetingTimes;
	}

	/**
	 * setter for MEETING_TIMES
	 * 
	 * @generated
	 */
	public void setMeetingTimes(BigDecimal meetingTimes) {
		this.meetingTimes = meetingTimes;
	}

	/**
	 * getter for MONEY
	 * 
	 * @generated
	 */
	public BigDecimal getMoney() {
		return this.money;
	}

	/**
	 * setter for MONEY
	 * 
	 * @generated
	 */
	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	/**
	 * getter for ALLOWANCE
	 * 
	 * @generated
	 */
	public BigDecimal getAllowance() {
		return this.allowance;
	}

	/**
	 * setter for ALLOWANCE
	 * 
	 * @generated
	 */
	public void setAllowance(BigDecimal allowance) {
		this.allowance = allowance;
	}

	/**
	 * getter for DUTY_DATE
	 * 
	 * @generated
	 */
	public String getDutyDate() {
		return dutyDate;
	}

	/**
	 * setter for DUTY_DATE
	 * 
	 * @generated
	 */
	public void setDutyDate(String dutyDate) {
		this.dutyDate = dutyDate;
	}

	public String getBetreffzeile() {
		return betreffzeile;
	}

	public void setBetreffzeile(String betreffzeile) {
		this.betreffzeile = betreffzeile;
	}

	public BigDecimal getAverageYearlySalary() {
		return averageYearlySalary;
	}

	public void setAverageYearlySalary(BigDecimal averageYearlySalary) {
		this.averageYearlySalary = averageYearlySalary;
	}

	public String getSeqNum() {
		return seqNum;
	}

	public void setSeqNum(String seqNum) {
		this.seqNum = seqNum;
	}

}