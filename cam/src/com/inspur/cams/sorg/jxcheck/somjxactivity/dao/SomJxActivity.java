package com.inspur.cams.sorg.jxcheck.somjxactivity.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西活动情况
 * 
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
@Table(tableName = "SOM_JX_ACTIVITY", keyFields = "id")
public class SomJxActivity extends StatefulDatabean {
	// ID
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// GENERAL_TIMES
	@Rule(value = "number")
	@Column(name = "GENERAL_TIMES")
	private BigDecimal generalTimes;
	// COUNCIL_TIMES
	@Rule(value = "number")
	@Column(name = "COUNCIL_TIMES")
	private BigDecimal councilTimes;
	// AUDITING_TIMES
	@Rule(value = "number")
	@Column(name = "AUDITING_TIMES")
	private BigDecimal auditingTimes;
	// LEARN_MEETING_TIMES
	@Rule(value = "number")
	@Column(name = "LEARN_MEETING_TIMES")
	private BigDecimal learnMeetingTimes;
	// TRAIN_TIMES
	@Rule(value = "number")
	@Column(name = "TRAIN_TIMES")
	private BigDecimal trainTimes;
	// TRAIN_NUM
	@Rule(value = "number")
	@Column(name = "TRAIN_NUM")
	private BigDecimal trainNum;
	// COMMONWEAL_NUM
	@Rule(value = "number")
	@Column(name = "COMMONWEAL_NUM")
	private BigDecimal commonwealNum;
	// COMMONWEAL_TIMES
	@Rule(value = "number")
	@Column(name = "COMMONWEAL_TIMES")
	private BigDecimal commonwealTimes;
	// COMMONWEAL_OUT
	@Column(name = "COMMONWEAL_OUT")
	private String commonwealOut;
	// INT_ITEM_NUM
	@Rule(value = "number")
	@Column(name = "INT_ITEM_NUM")
	private BigDecimal intItemNum;
	// INT_ITEM_MONEY
	@Column(name = "INT_ITEM_MONEY")
	private String intItemMoney;
	// MEETING_TIMES
	@Rule(value = "number")
	@Column(name = "MEETING_TIMES")
	private BigDecimal meetingTimes;
	// IF_OFF_FORM
	@Column(name = "IF_OFF_FORM")
	private String ifOffForm;
	// OUT_TO_TIMES
	@Rule(value = "number")
	@Column(name = "OUT_TO_TIMES")
	private BigDecimal outToTimes;
	// OUT_TO_NUM
	@Rule(value = "number")
	@Column(name = "OUT_TO_NUM")
	private BigDecimal outToNum;
	// FROM_OFF_TIMES
	@Rule(value = "number")
	@Column(name = "FROM_OFF_TIMES")
	private BigDecimal fromOffTimes;
	// FROM_OFF_NUM
	@Rule(value = "number")
	@Column(name = "FROM_OFF_NUM")
	private BigDecimal fromOffNum;
	// ACCEPT_OFF_NUM
	@Rule(value = "number")
	@Column(name = "ACCEPT_OFF_NUM")
	private BigDecimal acceptOffNum;
	// ACCEPT_OFF_MONEY
	@Column(name = "ACCEPT_OFF_MONEY")
	private String acceptOffMoney;
	// RETAIN_PEOPLE_NUM
	@Rule(value = "number")
	@Column(name = "RETAIN_PEOPLE_NUM")
	private BigDecimal retainPeopleNum;
	// SEND_INFO_NUM
	@Rule(value = "number")
	@Column(name = "SEND_INFO_NUM")
	private BigDecimal sendInfoNum;
	// INCEPT_INFO_NUM
	@Rule(value = "number")
	@Column(name = "INCEPT_INFO_NUM")
	private BigDecimal inceptInfoNum;
	// IF_PUBLICATION
	@Column(name = "IF_PUBLICATION")
	private String ifPublication;
	
	
	@Rule(value = "number")
	private BigDecimal researchNum;
	@Rule(value = "number")
	private BigDecimal askServeNum;
	@Rule(value = "number")
	private BigDecimal askBorgNum;
	@Rule(value = "number")
	private BigDecimal toAcceptNum;
	
	@Rule(value = "number")
	private BigDecimal beneficiary;
	@Rule(value = "number")
	private BigDecimal cwtFl;
	@Rule(value = "number")
	private BigDecimal cwtZc;
	@Rule(value = "number")
	private BigDecimal cwtJj;
	@Rule(value = "number")
	private BigDecimal cwtJg;
	@Rule(value = "number")
	private BigDecimal cwtZx;
	
	
	public BigDecimal getBeneficiary() {
		return beneficiary;
	}

	public void setBeneficiary(BigDecimal beneficiary) {
		this.beneficiary = beneficiary;
	}

	public BigDecimal getCwtFl() {
		return cwtFl;
	}

	public void setCwtFl(BigDecimal cwtFl) {
		this.cwtFl = cwtFl;
	}

	public BigDecimal getCwtZc() {
		return cwtZc;
	}

	public void setCwtZc(BigDecimal cwtZc) {
		this.cwtZc = cwtZc;
	}

	public BigDecimal getCwtJj() {
		return cwtJj;
	}

	public void setCwtJj(BigDecimal cwtJj) {
		this.cwtJj = cwtJj;
	}

	public BigDecimal getCwtJg() {
		return cwtJg;
	}

	public void setCwtJg(BigDecimal cwtJg) {
		this.cwtJg = cwtJg;
	}

	public BigDecimal getCwtZx() {
		return cwtZx;
	}

	public void setCwtZx(BigDecimal cwtZx) {
		this.cwtZx = cwtZx;
	}

	public BigDecimal getResearchNum() {
		return researchNum;
	}

	public void setResearchNum(BigDecimal researchNum) {
		this.researchNum = researchNum;
	}

	public BigDecimal getAskServeNum() {
		return askServeNum;
	}

	public void setAskServeNum(BigDecimal askServeNum) {
		this.askServeNum = askServeNum;
	}

	public BigDecimal getAskBorgNum() {
		return askBorgNum;
	}

	public void setAskBorgNum(BigDecimal askBorgNum) {
		this.askBorgNum = askBorgNum;
	}

	public BigDecimal getToAcceptNum() {
		return toAcceptNum;
	}

	public void setToAcceptNum(BigDecimal toAcceptNum) {
		this.toAcceptNum = toAcceptNum;
	}

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
	 * getter for GENERAL_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getGeneralTimes() {
		return this.generalTimes;
	}

	/**
	 * setter for GENERAL_TIMES
	 * 
	 * @generated
	 */
	public void setGeneralTimes(BigDecimal generalTimes) {
		this.generalTimes = generalTimes;
	}

	/**
	 * getter for COUNCIL_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getCouncilTimes() {
		return this.councilTimes;
	}

	/**
	 * setter for COUNCIL_TIMES
	 * 
	 * @generated
	 */
	public void setCouncilTimes(BigDecimal councilTimes) {
		this.councilTimes = councilTimes;
	}

	/**
	 * getter for LEARN_MEETING_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getLearnMeetingTimes() {
		return this.learnMeetingTimes;
	}

	/**
	 * setter for LEARN_MEETING_TIMES
	 * 
	 * @generated
	 */
	public void setLearnMeetingTimes(BigDecimal learnMeetingTimes) {
		this.learnMeetingTimes = learnMeetingTimes;
	}

	/**
	 * getter for TRAIN_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getTrainTimes() {
		return this.trainTimes;
	}

	/**
	 * setter for TRAIN_TIMES
	 * 
	 * @generated
	 */
	public void setTrainTimes(BigDecimal trainTimes) {
		this.trainTimes = trainTimes;
	}

	/**
	 * getter for TRAIN_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getTrainNum() {
		return this.trainNum;
	}

	/**
	 * setter for TRAIN_NUM
	 * 
	 * @generated
	 */
	public void setTrainNum(BigDecimal trainNum) {
		this.trainNum = trainNum;
	}

	/**
	 * getter for COMMONWEAL_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getCommonwealNum() {
		return this.commonwealNum;
	}

	/**
	 * setter for COMMONWEAL_NUM
	 * 
	 * @generated
	 */
	public void setCommonwealNum(BigDecimal commonwealNum) {
		this.commonwealNum = commonwealNum;
	}

	/**
	 * getter for COMMONWEAL_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getCommonwealTimes() {
		return this.commonwealTimes;
	}

	/**
	 * setter for COMMONWEAL_TIMES
	 * 
	 * @generated
	 */
	public void setCommonwealTimes(BigDecimal commonwealTimes) {
		this.commonwealTimes = commonwealTimes;
	}

	 

	/**
	 * getter for INT_ITEM_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getIntItemNum() {
		return this.intItemNum;
	}

	/**
	 * setter for INT_ITEM_NUM
	 * 
	 * @generated
	 */
	public void setIntItemNum(BigDecimal intItemNum) {
		this.intItemNum = intItemNum;
	}

	/**
	 * getter for INT_ITEM_MONEY
	 * 
	 * @generated
	 */
	public String getIntItemMoney() {
		return this.intItemMoney;
	}

	/**
	 * setter for INT_ITEM_MONEY
	 * 
	 * @generated
	 */
	public void setIntItemMoney(String intItemMoney) {
		this.intItemMoney = intItemMoney;
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
	 * getter for IF_OFF_FORM
	 * 
	 * @generated
	 */
	public String getIfOffForm() {
		return this.ifOffForm;
	}

	/**
	 * setter for IF_OFF_FORM
	 * 
	 * @generated
	 */
	public void setIfOffForm(String ifOffForm) {
		this.ifOffForm = ifOffForm;
	}

	/**
	 * getter for OUT_TO_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getOutToTimes() {
		return this.outToTimes;
	}

	/**
	 * setter for OUT_TO_TIMES
	 * 
	 * @generated
	 */
	public void setOutToTimes(BigDecimal outToTimes) {
		this.outToTimes = outToTimes;
	}

	/**
	 * getter for OUT_TO_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getOutToNum() {
		return this.outToNum;
	}

	/**
	 * setter for OUT_TO_NUM
	 * 
	 * @generated
	 */
	public void setOutToNum(BigDecimal outToNum) {
		this.outToNum = outToNum;
	}

	/**
	 * getter for FROM_OFF_TIMES
	 * 
	 * @generated
	 */
	public BigDecimal getFromOffTimes() {
		return this.fromOffTimes;
	}

	/**
	 * setter for FROM_OFF_TIMES
	 * 
	 * @generated
	 */
	public void setFromOffTimes(BigDecimal fromOffTimes) {
		this.fromOffTimes = fromOffTimes;
	}

	/**
	 * getter for FROM_OFF_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getFromOffNum() {
		return this.fromOffNum;
	}

	/**
	 * setter for FROM_OFF_NUM
	 * 
	 * @generated
	 */
	public void setFromOffNum(BigDecimal fromOffNum) {
		this.fromOffNum = fromOffNum;
	}

	/**
	 * getter for ACCEPT_OFF_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getAcceptOffNum() {
		return this.acceptOffNum;
	}

	/**
	 * setter for ACCEPT_OFF_NUM
	 * 
	 * @generated
	 */
	public void setAcceptOffNum(BigDecimal acceptOffNum) {
		this.acceptOffNum = acceptOffNum;
	}

	/**
	 * getter for ACCEPT_OFF_MONEY
	 * 
	 * @generated
	 */
	 

	/**
	 * getter for RETAIN_PEOPLE_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getRetainPeopleNum() {
		return this.retainPeopleNum;
	}

	/**
	 * setter for RETAIN_PEOPLE_NUM
	 * 
	 * @generated
	 */
	public void setRetainPeopleNum(BigDecimal retainPeopleNum) {
		this.retainPeopleNum = retainPeopleNum;
	}

	/**
	 * getter for SEND_INFO_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getSendInfoNum() {
		return this.sendInfoNum;
	}

	/**
	 * setter for SEND_INFO_NUM
	 * 
	 * @generated
	 */
	public void setSendInfoNum(BigDecimal sendInfoNum) {
		this.sendInfoNum = sendInfoNum;
	}

	/**
	 * getter for INCEPT_INFO_NUM
	 * 
	 * @generated
	 */
	public BigDecimal getInceptInfoNum() {
		return this.inceptInfoNum;
	}

	/**
	 * setter for INCEPT_INFO_NUM
	 * 
	 * @generated
	 */
	public void setInceptInfoNum(BigDecimal inceptInfoNum) {
		this.inceptInfoNum = inceptInfoNum;
	}

	/**
	 * getter for IF_PUBLICATION
	 * 
	 * @generated
	 */
	public String getIfPublication() {
		return this.ifPublication;
	}

	/**
	 * setter for IF_PUBLICATION
	 * 
	 * @generated
	 */
	public void setIfPublication(String ifPublication) {
		this.ifPublication = ifPublication;
	}

	public BigDecimal getAuditingTimes() {
		return auditingTimes;
	}

	public void setAuditingTimes(BigDecimal auditingTimes) {
		this.auditingTimes = auditingTimes;
	}

	public String getCommonwealOut() {
		return commonwealOut;
	}

	public void setCommonwealOut(String commonwealOut) {
		this.commonwealOut = commonwealOut;
	}

	public String getAcceptOffMoney() {
		return acceptOffMoney;
	}

	public void setAcceptOffMoney(String acceptOffMoney) {
		this.acceptOffMoney = acceptOffMoney;
	}

}