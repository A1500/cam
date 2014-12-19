package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织举办实体databean
 * @author shgtch
 * @date 2011-5-11
 */
@Table(tableName = "SOM_ENTITY", keyFields = "id")
public class SomEntity extends StatefulDatabean {
	
	// 举办实体ID
	private String id;
	
	// 社会组织ID
	private String sorgId;
	
	// 社会组织种类
	private String sorgType;
	
	//业务编号
	private String taskCode;
	
	// 实体名称
	private String name;
	
	// 地址
	private String adds;
	
	// 注册（或批准）日期
	private String registDate;
	
	// 注册（或批准）证种类
	private String registCardType;
	
	// 注册（或批准）证号码
	private String registCardCode;
	
	// 注册（或批准）机关
	private String registOrgan;
	
	// 备案的主要文件
	private String recordFile;
	
	// 备注
	private String note;
	
	// 备案承办人
	private String regPeople;
	
	// 备案日期
	private String regDate;

	// 登记管理机关名称
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	
	// 录入人
	private String createPeople;
	
	// 录入时间
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
	 * getter for ADDS
	 * 
	 * @generated
	 */
	public String getAdds() {
		return this.adds;
	}

	/**
	 * setter for ADDS
	 * 
	 * @generated
	 */
	public void setAdds(String adds) {
		this.adds = adds;
	}

	/**
	 * getter for REGIST_DATE
	 * 
	 * @generated
	 */
	public String getRegistDate() {
		return this.registDate;
	}

	/**
	 * setter for REGIST_DATE
	 * 
	 * @generated
	 */
	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}

	/**
	 * getter for REGIST_CARD_TYPE
	 * 
	 * @generated
	 */
	public String getRegistCardType() {
		return this.registCardType;
	}

	/**
	 * setter for REGIST_CARD_TYPE
	 * 
	 * @generated
	 */
	public void setRegistCardType(String registCardType) {
		this.registCardType = registCardType;
	}

	/**
	 * getter for REGIST_CARD_CODE
	 * 
	 * @generated
	 */
	public String getRegistCardCode() {
		return this.registCardCode;
	}

	/**
	 * setter for REGIST_CARD_CODE
	 * 
	 * @generated
	 */
	public void setRegistCardCode(String registCardCode) {
		this.registCardCode = registCardCode;
	}

	/**
	 * getter for REGIST_ORGAN
	 * 
	 * @generated
	 */
	public String getRegistOrgan() {
		return this.registOrgan;
	}

	/**
	 * setter for REGIST_ORGAN
	 * 
	 * @generated
	 */
	public void setRegistOrgan(String registOrgan) {
		this.registOrgan = registOrgan;
	}

	/**
	 * getter for RECORD_FILE
	 * 
	 * @generated
	 */
	public String getRecordFile() {
		return this.recordFile;
	}

	/**
	 * setter for RECORD_FILE
	 * 
	 * @generated
	 */
	public void setRecordFile(String recordFile) {
		this.recordFile = recordFile;
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

	/**
	 * getter for 备案承办人
	 * 
	 * @generated
	 */
	public String getRegPeople() {
		return regPeople;
	}

	/**
	 * setter for 备案承办人
	 * 
	 * @generated
	 */
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}

	/**
	 * getter for 备案日期
	 * 
	 * @generated
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * setter for 备案日期
	 * 
	 * @generated
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	/**
	 * getter for MORG_NAME
	 * 
	 * @generated
	 */
	public String getMorgName() {
		return this.morgName;
	}

	/**
	 * setter for MORG_NAME
	 * 
	 * @generated
	 */
	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	/**
	 * getter for MORG_AREA
	 * 
	 * @generated
	 */
	public String getMorgArea() {
		return this.morgArea;
	}

	/**
	 * setter for MORG_AREA
	 * 
	 * @generated
	 */
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

	public String getSorgType() {
		return sorgType;
	}

	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

}