package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织发起人（单位）
 * @author shgtch
 * @date 2011-8-9
 */
@Table(tableName = "SOM_HELD_ORGAN", keyFields = "id")
public class SomHeldOrgan extends StatefulDatabean {
	
	// 编号
	private String id;
	
	// 社会组织ID
	private String sorgId;
	
	// 业务编号
	private String taskCode;
	
	// 单位名称
	private String name;
	
	// 情况
	private String situation;
	
	// 发起单位负责人
	private String heldorganPeople;
	
	// 电话
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
	 * getter for SITUATION
	 * 
	 * @generated
	 */
	public String getSituation() {
		return this.situation;
	}

	/**
	 * setter for SITUATION
	 * 
	 * @generated
	 */
	public void setSituation(String situation) {
		this.situation = situation;
	}

	/**
	 * getter for HELDORGAN_PEOPLE
	 * 
	 * @generated
	 */
	public String getHeldorganPeople() {
		return this.heldorganPeople;
	}

	/**
	 * setter for HELDORGAN_PEOPLE
	 * 
	 * @generated
	 */
	public void setHeldorganPeople(String heldorganPeople) {
		this.heldorganPeople = heldorganPeople;
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