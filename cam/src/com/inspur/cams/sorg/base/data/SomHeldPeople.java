package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会组织发起人（自然人）
 * @author shgtch
 * @date 2011-8-9
 */
@Table(tableName = "SOM_HELD_PEOPLE", keyFields = "id")
public class SomHeldPeople extends StatefulDatabean {
	
	// 编号
	private String id;
	
	// 社会组织ID
	private String sorgId;

	// 业务编号
	private String taskCode;
	
	// 是否筹备负责人
	private String ifChief;
	
	// 名称
	private String name;
	
	// 性别
	private String sex;
	
	// 出生日期
	private String birthday;
	
	// 身份证号码
	private String idCard;
	
	// 政治面貌
	private String politics;
	
	// 人事关系所在单位
	private String personUnit;
	
	// 工作单位
	private String workName;
	
	// 工作单位职务
	private String workDuties;
	
	// 户籍
	private String populace;
	
	// 联系电话
	private String phone;

	// 登记管理机关
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	
	// 创建人
	private String createPeople;
	
	// 创建时间
	private String createTime;
	
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
	 * getter for SORG_ID
	 * 
	 * @generated
	 */
	public String getSorgId() {
		return this.sorgId;
	}

	/**
	 * setter for SORG_ID
	 * 
	 * @generated
	 */
	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	/**
	 * getter for IF_CHIEF
	 * 
	 * @generated
	 */
	public String getIfChief() {
		return this.ifChief;
	}

	/**
	 * setter for IF_CHIEF
	 * 
	 * @generated
	 */
	public void setIfChief(String ifChief) {
		this.ifChief = ifChief;
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
	 * getter for POLITICS
	 * 
	 * @generated
	 */
	public String getPolitics() {
		return this.politics;
	}

	/**
	 * setter for POLITICS
	 * 
	 * @generated
	 */
	public void setPolitics(String politics) {
		this.politics = politics;
	}


	public String getPersonUnit() {
		return personUnit;
	}

	public void setPersonUnit(String personUnit) {
		this.personUnit = personUnit;
	}
	
	/**
	 * getter for WORK_NAME
	 * 
	 * @generated
	 */
	public String getWorkName() {
		return this.workName;
	}

	/**
	 * setter for WORK_NAME
	 * 
	 * @generated
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}

	/**
	 * getter for WORK_DUTIES
	 * 
	 * @generated
	 */
	public String getWorkDuties() {
		return this.workDuties;
	}

	/**
	 * setter for WORK_DUTIES
	 * 
	 * @generated
	 */
	public void setWorkDuties(String workDuties) {
		this.workDuties = workDuties;
	}

	/**
	 * getter for POPULACE
	 * 
	 * @generated
	 */
	public String getPopulace() {
		return this.populace;
	}

	/**
	 * setter for POPULACE
	 * 
	 * @generated
	 */
	public void setPopulace(String populace) {
		this.populace = populace;
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

	/**
	 * getter for CREATE_PEOPLE
	 * 
	 * @generated
	 */
	public String getCreatePeople() {
		return this.createPeople;
	}

	/**
	 * setter for CREATE_PEOPLE
	 * 
	 * @generated
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * getter for CREATE_TIME
	 * 
	 * @generated
	 */
	public String getCreateTime() {
		return this.createTime;
	}

	/**
	 * setter for CREATE_TIME
	 * 
	 * @generated
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}