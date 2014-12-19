package com.inspur.cams.welfare.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealFitChangerecord
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
 */
@Table(tableName = "WEAL_FIT_CHANGERECORD", keyFields = "changId")
public class WealFitChangerecord extends StatefulDatabean {
	@Transient
	private List<WealFitChangerecordDetail> wealFitChangerecordDetailList = new ArrayList<WealFitChangerecordDetail>();
	// CHANG_ID
	@Rule(value = "require")
	@Column(name = "CHANG_ID")
	private String changId;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// SERIAL_NUM
	@Column(name = "SERIAL_NUM")
	private String serialNum;
	// COMPANY_NAME
	@Column(name = "COMPANY_NAME")
	private String companyName;
	// LINKMAN
	@Column(name = "LINKMAN")
	private String linkman;
	// PHONE
	@Column(name = "PHONE")
	private String phone;
	// CHANGE_REASON
	@Column(name = "CHANGE_REASON")
	private String changeReason;
	// ID_CARD
	@Column(name = "ID_CARD")
	private String idCard;
	// LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
	private String legalPeople;
	// REG_DATE
	@Column(name = "REG_DATE")
	private String regDate;
	// CORPORATION_TYPE
	@Column(name = "CORPORATION_TYPE")
	private String corporationType;
	// IF_CONFIRM
	@Column(name = "IF_CONFIRM")
	private String ifConfirm;
	
	@Column(name = "MORG_AREA")
	private String morgArea;
	
	@Column(name = "MORG_NAME")
	private String morgName;


	public String getIfConfirm() {
		return ifConfirm;
	}

	public void setIfConfirm(String ifConfirm) {
		this.ifConfirm = ifConfirm;
	}

	public String getCorporationType() {
		return corporationType;
	}

	public void setCorporationType(String corporationType) {
		this.corporationType = corporationType;
	}

	/**
	 * getter for CHANG_ID
	 * 
	 * @generated
	 */
	public String getChangId() {
		return this.changId;
	}

	/**
	 * setter for CHANG_ID
	 * 
	 * @generated
	 */
	public void setChangId(String changId) {
		this.changId = changId;
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
	 * getter for SERIAL_NUM
	 * 
	 * @generated
	 */
	public String getSerialNum() {
		return this.serialNum;
	}

	/**
	 * setter for SERIAL_NUM
	 * 
	 * @generated
	 */
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}

	/**
	 * getter for COMPANY_NAME
	 * 
	 * @generated
	 */
	public String getCompanyName() {
		return this.companyName;
	}

	/**
	 * setter for COMPANY_NAME
	 * 
	 * @generated
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	/**
	 * getter for LINKMAN
	 * 
	 * @generated
	 */
	public String getLinkman() {
		return this.linkman;
	}

	/**
	 * setter for LINKMAN
	 * 
	 * @generated
	 */
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	/**
	 * getter for PHONE
	 * 
	 * @generated
	 */
	public String getPhone() {
		return this.phone;
	}

	/**
	 * setter for PHONE
	 * 
	 * @generated
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * getter for CHANGE_REASON
	 * 
	 * @generated
	 */
	public String getChangeReason() {
		return this.changeReason;
	}

	/**
	 * setter for CHANGE_REASON
	 * 
	 * @generated
	 */
	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
	}

	/**
	 * getter for ID_CARD
	 * 
	 * @generated
	 */
	public String getIdCard() {
		return this.idCard;
	}

	/**
	 * setter for ID_CARD
	 * 
	 * @generated
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * getter for LEGAL_PEOPLE
	 * 
	 * @generated
	 */
	public String getLegalPeople() {
		return this.legalPeople;
	}

	/**
	 * setter for LEGAL_PEOPLE
	 * 
	 * @generated
	 */
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	/**
	 * getter for REG_DATE
	 * 
	 * @generated
	 */
	public String getRegDate() {
		return this.regDate;
	}

	/**
	 * setter for REG_DATE
	 * 
	 * @generated
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public List<WealFitChangerecordDetail> getWealFitChangerecordDetailList() {
		return wealFitChangerecordDetailList;
	}

	public void setWealFitChangerecordDetailList(
			List<WealFitChangerecordDetail> wealFitChangerecordDetailList) {
		this.wealFitChangerecordDetailList = wealFitChangerecordDetailList;
	}


	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getMorgArea() {
		return morgArea;
	}

	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

}