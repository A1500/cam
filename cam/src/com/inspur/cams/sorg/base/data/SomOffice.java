package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织内设机构databean
 * @author shgtch
 * @date 2011-5-11
 */
@Table(tableName = "SOM_OFFICE", keyFields = "id")
public class SomOffice extends StatefulDatabean {
	
	// 机构ID
//	@Rule(value = "require")
	private String id;
	
	// 社会组织ID
//	@Rule(value = "require")
	private String sorgId;
	
	private String taskCode;
	
	// 社会组织类型
	private String sorgType;
	
	// 机构名称
	private String name;
	
	// 场所
	private String place;
	
	// 机构邮编
	private String postCode;
	
	// 电话
	private String phone;
	
	// 机构负责人
	private String officeChief;
	
	// 工作职责/职能
	private String dutiesDesc;
	
	// 设立理由
	private String reason;
	
	// 履行内部程序
	private String process;
	
	// 登记管理机关名称
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	
	// 备案状态
	private String regPeople;
	
	// 备案状态
	private String regDate;
	
	// 备案状态
	private String regStatus;
	
	// 录入人
	private String createPeople;
	
	// 录入时间
	private String createTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getSorgType() {
		return sorgType;
	}

	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getOfficeChief() {
		return officeChief;
	}

	public void setOfficeChief(String officeChief) {
		this.officeChief = officeChief;
	}

	public String getDutiesDesc() {
		return dutiesDesc;
	}

	public void setDutiesDesc(String dutiesDesc) {
		this.dutiesDesc = dutiesDesc;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
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

	public String getRegPeople() {
		return regPeople;
	}

	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegStatus() {
		return regStatus;
	}

	public void setRegStatus(String regStatus) {
		this.regStatus = regStatus;
	}

	public String getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreateTime() {
		return createTime;
	}

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