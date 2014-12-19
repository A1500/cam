package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:就业信息databean
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
@Table(tableName = "SAM_PEOPLE_JOBS", keyFields = "jobId")
public class SamPeopleJobs extends StatefulDatabean {
	// 就业信息ID
	@Column(name = "JOB_ID")
	private String jobId;
	// 人员ID
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// 单位名称
	@Column(name = "UNIT_NAME")
	private String unitName;
	// 单位性质
	@Column(name = "UNIT_NATURE")
	private String unitNature;
	// 单位所属行业
	@Column(name = "UNIT_INDUSTRY")
	private String unitIndustry;
	// 隶属关系
	@Column(name = "AFFILIATION")
	private String affiliation;
	// 联系人
	@Column(name = "CONTACT_PEOPLE")
	private String contactPeople;
	// 联系电话
	@Column(name = "CONTACT_PHONE")
	private String contactPhone;
	// 地址
	@Column(name = "ADDRESS")
	private String address;
	// 邮政编码
	@Column(name = "POST_CODE")
	private String postCode;
	// 备注
	@Column(name = "REMARKS")
	private String remarks;

	/**
	 * getter for 就业信息ID
	 * 
	 * @generated
	 */
	public String getJobId() {
		return this.jobId;
	}

	/**
	 * setter for 就业信息ID
	 * 
	 * @generated
	 */
	public void setJobId(String jobId) {
		this.jobId = jobId;
	}

	/**
	 * getter for 人员ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for 人员ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * getter for 单位名称
	 * 
	 * @generated
	 */
	public String getUnitName() {
		return this.unitName;
	}

	/**
	 * setter for 单位名称
	 * 
	 * @generated
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/**
	 * getter for 单位性质
	 * 
	 * @generated
	 */
	public String getUnitNature() {
		return this.unitNature;
	}

	/**
	 * setter for 单位性质
	 * 
	 * @generated
	 */
	public void setUnitNature(String unitNature) {
		this.unitNature = unitNature;
	}

	/**
	 * getter for 单位所属行业
	 * 
	 * @generated
	 */
	public String getUnitIndustry() {
		return this.unitIndustry;
	}

	/**
	 * setter for 单位所属行业
	 * 
	 * @generated
	 */
	public void setUnitIndustry(String unitIndustry) {
		this.unitIndustry = unitIndustry;
	}

	/**
	 * getter for 隶属关系
	 * 
	 * @generated
	 */
	public String getAffiliation() {
		return this.affiliation;
	}

	/**
	 * setter for 隶属关系
	 * 
	 * @generated
	 */
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}

	/**
	 * getter for 联系人
	 * 
	 * @generated
	 */
	public String getContactPeople() {
		return this.contactPeople;
	}

	/**
	 * setter for 联系人
	 * 
	 * @generated
	 */
	public void setContactPeople(String contactPeople) {
		this.contactPeople = contactPeople;
	}

	/**
	 * getter for 联系电话
	 * 
	 * @generated
	 */
	public String getContactPhone() {
		return this.contactPhone;
	}

	/**
	 * setter for 联系电话
	 * 
	 * @generated
	 */
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	/**
	 * getter for 地址
	 * 
	 * @generated
	 */
	public String getAddress() {
		return this.address;
	}

	/**
	 * setter for 地址
	 * 
	 * @generated
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * getter for 邮政编码
	 * 
	 * @generated
	 */
	public String getPostCode() {
		return this.postCode;
	}

	/**
	 * setter for 邮政编码
	 * 
	 * @generated
	 */
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getRemarks() {
		return this.remarks;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}