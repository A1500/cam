package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织账户databean
 * 
 * @author shgtch
 * @date 2011-5-11
 */
@Table(tableName = "SOM_ACCOUNT", keyFields = "id")
public class SomAccount extends StatefulDatabean {

	// 账户ID
	private String id;

	// 社会组织ID
	private String sorgId;

	// 社会组织类型
	private String sorgType;
	
	// 业务编号
	private String taskCode;

	// 账户名称
	private String name;

	// 开户银行
	private String bank;

	// 开户银行地址
	private String bankAdds;

	// 开户银行帐号
	private String accountCode;

	// 开户日期
	private String accountDate;

	// 设立银行帐号理由
	private String reason;

	// 备案承办人
	private String regPeople;

	// 备案日期
	private String regDate;
	
	// 备案状态
	private String regStatus;

	// 登记管理机关名称
	private String morgName;

	// 登记管理机关行政区划
	private String morgArea;

	// 录入人
	private String createPeople;

	// 录入时间
	private String createTime;

	/**
	 * getter for 账户ID
	 * 
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for 账户ID
	 * 
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for 社会组织ID
	 * 
	 * @generated
	 */
	public String getSorgId() {
		return this.sorgId;
	}

	/**
	 * setter for 社会组织ID
	 * 
	 * @generated
	 */
	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	/**
	 * 获取 社会组织类型
	 * 
	 * @return
	 */
	public String getSorgType() {
		return sorgType;
	}

	/**
	 * 设置 社会组织类型
	 * 
	 * @param sorgType
	 */
	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	/**
	 * getter for 账户名称
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 账户名称
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 开户银行
	 * 
	 * @generated
	 */
	public String getBank() {
		return this.bank;
	}

	/**
	 * setter for 开户银行
	 * 
	 * @generated
	 */
	public void setBank(String bank) {
		this.bank = bank;
	}

	/**
	 * getter for 开户银行地址
	 * 
	 * @generated
	 */
	public String getBankAdds() {
		return this.bankAdds;
	}

	/**
	 * setter for 开户银行地址
	 * 
	 * @generated
	 */
	public void setBankAdds(String bankAdds) {
		this.bankAdds = bankAdds;
	}

	/**
	 * getter for 开户银行帐号
	 * 
	 * @generated
	 */
	public String getAccountCode() {
		return this.accountCode;
	}

	/**
	 * setter for 开户银行帐号
	 * 
	 * @generated
	 */
	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	/**
	 * getter for 开户日期
	 * 
	 * @generated
	 */
	public String getAccountDate() {
		return this.accountDate;
	}

	/**
	 * setter for 开户日期
	 * 
	 * @generated
	 */
	public void setAccountDate(String accountDate) {
		this.accountDate = accountDate;
	}

	/**
	 * getter for 设立银行帐号理由
	 * 
	 * @generated
	 */
	public String getReason() {
		return this.reason;
	}

	/**
	 * setter for 设立银行帐号理由
	 * 
	 * @generated
	 */
	public void setReason(String reason) {
		this.reason = reason;
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

	public String getRegStatus() {
		return regStatus;
	}

	public void setRegStatus(String regStatus) {
		this.regStatus = regStatus;
	}
	
	/**
	 * getter for 登记管理机关名称
	 * 
	 * @generated
	 */
	public String getMorgName() {
		return this.morgName;
	}

	/**
	 * setter for 登记管理机关名称
	 * 
	 * @generated
	 */
	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	/**
	 * getter for 登记管理机关行政区划
	 * 
	 * @generated
	 */
	public String getMorgArea() {
		return this.morgArea;
	}

	/**
	 * setter for 登记管理机关行政区划
	 * 
	 * @generated
	 */
	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	/**
	 * getter for 录入人
	 * 
	 * @generated
	 */
	public String getCreatePeople() {
		return this.createPeople;
	}

	/**
	 * setter for 录入人
	 * 
	 * @generated
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * getter for 录入时间
	 * 
	 * @generated
	 */
	public String getCreateTime() {
		return this.createTime;
	}

	/**
	 * setter for 录入时间
	 * 
	 * @generated
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}
}