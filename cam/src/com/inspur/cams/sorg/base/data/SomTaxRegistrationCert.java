package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 税务登记证备案databean
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
@Table(tableName = "SOM_TAX_REGISTRATION_CERT", keyFields = "id")
public class SomTaxRegistrationCert extends StatefulDatabean {

	// 主键
	private String id;

	// 社会组织ID
	private String sorgId;

	// 社会组织类型
	private String sorgType;
	
	// 业务编号
	private String taskCode;

	// 税务登记证号
	private String certNo;

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

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getCertNo() {
		return certNo;
	}

	public void setCertNo(String certNo) {
		this.certNo = certNo;
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
}