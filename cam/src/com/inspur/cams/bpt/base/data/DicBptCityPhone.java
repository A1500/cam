package com.inspur.cams.bpt.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:DicBptCityPhone
 * @description:
 * @author:
 * @since:2011-09-20
 * @version:1.0
 */
@Table(tableName = "DIC_BPT_CITY_PHONE", keyFields = "id")
public class DicBptCityPhone extends StatefulDatabean {
	// 民政局来信来访地址
	@Column(name = "ADDRESS")
	private String address;
	// ID
	@Column(name = "ID")
	private String id;
	// 县市区编码
	@Rule(value = "require")
	@Column(name = "ORGAN_CODE")
	private String organCode;
	// 县市区名称
	@Rule(value = "require")
	@Column(name = "ORGAN_NAME")
	private String organName;
	// 业务类型

	@Column(name = "SERVICE_TYPE")
	private String serviceType;
	// 电话
	@Rule(value = "require")
	@Column(name = "PHONE")
	private String phone;

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
	 * getter for 县市区编码
	 * 
	 * @generated
	 */
	public String getOrganCode() {
		return this.organCode;
	}

	/**
	 * setter for 县市区编码
	 * 
	 * @generated
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * getter for 县市区名称
	 * 
	 * @generated
	 */
	public String getOrganName() {
		return this.organName;
	}

	/**
	 * setter for 县市区名称
	 * 
	 * @generated
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * getter for 业务类型
	 * 
	 * @generated
	 */
	public String getServiceType() {
		return this.serviceType;
	}

	/**
	 * setter for 业务类型
	 * 
	 * @generated
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	/**
	 * getter for 电话
	 * 
	 * @generated
	 */
	public String getPhone() {
		return this.phone;
	}

	/**
	 * setter for 电话
	 * 
	 * @generated
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}