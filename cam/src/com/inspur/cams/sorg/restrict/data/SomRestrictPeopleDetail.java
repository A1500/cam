package com.inspur.cams.sorg.restrict.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:社会组织受限制人员明细表
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
 */
@Table(tableName = "SOM_RESTRICT_PEOPLE_DETAIL", keyFields = "id")
public class SomRestrictPeopleDetail extends StatefulDatabean {
	// ID
	@Rule(value = "require")
	@Column(name = "ID")
	private String id;
	// PEOPLE_ID
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// IF_LEGAL
	@Column(name = "IF_LEGAL")
	private String ifLegal;
	// SOURCE_TYPE
	@Column(name = "SOURCE_TYPE")
	private String sourceType;
	// SORG_CODE
	@Column(name = "SORG_CODE")
	private String sorgCode;
	// ADD_AREA
	@Column(name = "ADD_AREA")
	private String addArea;
	// ADD_PERSON_ID
	@Column(name = "ADD_PERSON_ID")
	private String addPersonId;
	// ADD_PERSON_NAME
	@Column(name = "ADD_PERSON_NAME")
	private String addPersonName;
	// ADD_TIME
	@Column(name = "ADD_TIME")
	private String addTime;
	// ADD_ORGAN_ID
	@Column(name = "ADD_ORGAN_ID")
	private String addOrganId;
	// ADD_ORGAN_NAME
	@Column(name = "ADD_ORGAN_NAME")
	private String addOrganName;
	// ADD_OPERATION
	@Column(name = "ADD_OPERATION")
	private String addOperation;
	// NOTE
	@Column(name = "NOTE")
	private String note;
	
	//---社会组织受限制人员表
	@Transient
	private String name;
	@Transient
	private String idCard;
	@Transient
	private String ifLimit;
	@Transient
	private String ifValid;
	//---获取：社会组织受限制人员表
	public SomRestrictPeople getSomRestrictPeople() {
		SomRestrictPeople somRestrictPeople = new SomRestrictPeople();
		somRestrictPeople.setPeopleId(getPeopleId());
		somRestrictPeople.setName(getName());
		somRestrictPeople.setIdCard(getIdCard());
		somRestrictPeople.setIfLimit(getIfLimit());
		somRestrictPeople.setIfValid(getIfValid());
		return somRestrictPeople;
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
	 * getter for PEOPLE_ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for PEOPLE_ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
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
	 * getter for IF_LEGAL
	 * 
	 * @generated
	 */
	public String getIfLegal() {
		return this.ifLegal;
	}

	/**
	 * setter for IF_LEGAL
	 * 
	 * @generated
	 */
	public void setIfLegal(String ifLegal) {
		this.ifLegal = ifLegal;
	}

	/**
	 * getter for SOURCE_TYPE
	 * 
	 * @generated
	 */
	public String getSourceType() {
		return this.sourceType;
	}

	/**
	 * setter for SOURCE_TYPE
	 * 
	 * @generated
	 */
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	/**
	 * getter for SORG_CODE
	 * 
	 * @generated
	 */
	public String getSorgCode() {
		return this.sorgCode;
	}

	/**
	 * setter for SORG_CODE
	 * 
	 * @generated
	 */
	public void setSorgCode(String sorgCode) {
		this.sorgCode = sorgCode;
	}

	/**
	 * getter for ADD_AREA
	 * 
	 * @generated
	 */
	public String getAddArea() {
		return this.addArea;
	}

	/**
	 * setter for ADD_AREA
	 * 
	 * @generated
	 */
	public void setAddArea(String addArea) {
		this.addArea = addArea;
	}

	/**
	 * getter for ADD_PERSON_ID
	 * 
	 * @generated
	 */
	public String getAddPersonId() {
		return this.addPersonId;
	}

	/**
	 * setter for ADD_PERSON_ID
	 * 
	 * @generated
	 */
	public void setAddPersonId(String addPersonId) {
		this.addPersonId = addPersonId;
	}

	/**
	 * getter for ADD_PERSON_NAME
	 * 
	 * @generated
	 */
	public String getAddPersonName() {
		return this.addPersonName;
	}

	/**
	 * setter for ADD_PERSON_NAME
	 * 
	 * @generated
	 */
	public void setAddPersonName(String addPersonName) {
		this.addPersonName = addPersonName;
	}

	/**
	 * getter for ADD_TIME
	 * 
	 * @generated
	 */
	public String getAddTime() {
		return this.addTime;
	}

	/**
	 * setter for ADD_TIME
	 * 
	 * @generated
	 */
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}

	/**
	 * getter for ADD_ORGAN_ID
	 * 
	 * @generated
	 */
	public String getAddOrganId() {
		return this.addOrganId;
	}

	/**
	 * setter for ADD_ORGAN_ID
	 * 
	 * @generated
	 */
	public void setAddOrganId(String addOrganId) {
		this.addOrganId = addOrganId;
	}

	/**
	 * getter for ADD_ORGAN_NAME
	 * 
	 * @generated
	 */
	public String getAddOrganName() {
		return this.addOrganName;
	}

	/**
	 * setter for ADD_ORGAN_NAME
	 * 
	 * @generated
	 */
	public void setAddOrganName(String addOrganName) {
		this.addOrganName = addOrganName;
	}

	/**
	 * getter for ADD_OPERATION
	 * 
	 * @generated
	 */
	public String getAddOperation() {
		return this.addOperation;
	}

	/**
	 * setter for ADD_OPERATION
	 * 
	 * @generated
	 */
	public void setAddOperation(String addOperation) {
		this.addOperation = addOperation;
	}

	/**
	 * getter for NOTE
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for NOTE
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getIfLimit() {
		return ifLimit;
	}

	public void setIfLimit(String ifLimit) {
		this.ifLimit = ifLimit;
	}

	public String getIfValid() {
		return ifValid;
	}

	public void setIfValid(String ifValid) {
		this.ifValid = ifValid;
	}

}