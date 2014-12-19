package com.inspur.cams.bpt.bptinstitution.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptGloriousInstitute
 * @description:
 * @author:
 * @since:2011-06-14
 * @version:1.0
 */
@Table(tableName = "BPT_GLORIOUS_INSTITUTE", keyFields = "gloriousId")
public class BptGloriousInstitute extends StatefulDatabean {
	//ID

	@Column(name = "GLORIOUS_ID")
	private String gloriousId;
	//行政区划
	@Rule(value = "require")
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;
	//单位全称
	@Rule(value = "require")
	@Column(name = "UNIT_FULLNAME")
	private String unitFullname;
	//主管部门
	@Column(name = "PERSON_SECTION")
	private String personSection;
	//建立日期
	@Column(name = "CREATION_DATE")
	private String creationDate;
	//注册资产(万元)
	@Rule(value = "require")
	@Column(name = "REGISTER_PROPERTY")
	private String registerProperty;
	//固定资产原值(万元)
	@Rule(value = "require")
	@Column(name = "IMMOBILISATIONS")
	private String immobilisations;
	//占地面积(平方米)
	@Rule(value = "require")
	@Column(name = "FLOOR_AREA")
	private String floorArea;
	//业务用房面积(平方米)
	@Column(name = "BUSINESS_AREA")
	private String businessArea;
	//联系电话
	@Column(name = "TEL_CONTACT")
	private String telContact;
	//邮政编码
	@Column(name = "POSTCODE")
	private String postcode;
	//通信地址
	@Column(name = "MAILING_ADDRESS")
	private String mailingAddress;
	//单位介绍
	@Column(name = "UNIT_INTRODUCE")
	private String unitIntroduce;
	//编制人数
	@Transient
	@Column(name = "PREPARE_NUM")
	private String prepareNum;
	//年末职工人数
	@Transient
	@Column(name = "YEAR_WORKER_NUM")
	private String yearWorkerNum;
	
	//录入人员ID
	@Column(name = "REG_ID")
	private String regId;
	//录入时间
	@Column(name = "REG_TIME")
	private String regTime;
	//修改人ID
	@Column(name = "MOD_ID")
	private String modId;
	//修改时间

	@Column(name = "MOD_TIME")
	private String modTime;
	
	 //行政级别
	@Column(name = "ADMINISTRATIVE_LEVEL")
   private String administrativelevel;
	//单位性质
	@Column(name = "UNITS_NATURE")
   private String unitsnature;
	//录入单位行政区划
	@Column(name = "REG_ORGAN_CODE")
   private String regOrganCode;
	
	public String getRegOrganCode() {
		return regOrganCode;
	}

	public void setRegOrganCode(String regOrganCode) {
		this.regOrganCode = regOrganCode;
	}

	/**
	 * getter for ID
	 * @generated
	 */
	public String getGloriousId() {
		return this.gloriousId;
	}

	/**
	 * setter for ID
	 * @generated
	 */
	public void setGloriousId(String gloriousId) {
		this.gloriousId = gloriousId;
	}

	/**
	 * getter for 行政区划
	 * @generated
	 */
	public String getDomicileCode() {
		return this.domicileCode;
	}

	/**
	 * setter for 行政区划
	 * @generated
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}

	/**
	 * getter for 单位全称
	 * @generated
	 */
	public String getUnitFullname() {
		return this.unitFullname;
	}

	/**
	 * setter for 单位全称
	 * @generated
	 */
	public void setUnitFullname(String unitFullname) {
		this.unitFullname = unitFullname;
	}

	/**
	 * getter for 主管部门
	 * @generated
	 */
	public String getPersonSection() {
		return this.personSection;
	}

	/**
	 * setter for 主管部门
	 * @generated
	 */
	public void setPersonSection(String personSection) {
		this.personSection = personSection;
	}

	/**
	 * getter for 建立日期
	 * @generated
	 */
	public String getCreationDate() {
		return this.creationDate;
	}

	/**
	 * setter for 建立日期
	 * @generated
	 */
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	/**
	 * getter for 注册资产(万元)
	 * @generated
	 */
	public String getRegisterProperty() {
		return this.registerProperty;
	}

	/**
	 * setter for 注册资产(万元)
	 * @generated
	 */
	public void setRegisterProperty(String registerProperty) {
		this.registerProperty = registerProperty;
	}

	/**
	 * getter for 固定资产原值(万元)
	 * @generated
	 */
	public String getImmobilisations() {
		return this.immobilisations;
	}

	/**
	 * setter for 固定资产原值(万元)
	 * @generated
	 */
	public void setImmobilisations(String immobilisations) {
		this.immobilisations = immobilisations;
	}

	/**
	 * getter for 占地面积(平方米)
	 * @generated
	 */
	public String getFloorArea() {
		return this.floorArea;
	}

	/**
	 * setter for 占地面积(平方米)
	 * @generated
	 */
	public void setFloorArea(String floorArea) {
		this.floorArea = floorArea;
	}

	/**
	 * getter for 业务用房面积(平方米)
	 * @generated
	 */
	public String getBusinessArea() {
		return this.businessArea;
	}

	/**
	 * setter for 业务用房面积(平方米)
	 * @generated
	 */
	public void setBusinessArea(String businessArea) {
		this.businessArea = businessArea;
	}

	/**
	 * getter for 联系电话
	 * @generated
	 */
	public String getTelContact() {
		return this.telContact;
	}

	/**
	 * setter for 联系电话
	 * @generated
	 */
	public void setTelContact(String telContact) {
		this.telContact = telContact;
	}

	/**
	 * getter for 邮政编码
	 * @generated
	 */
	public String getPostcode() {
		return this.postcode;
	}

	/**
	 * setter for 邮政编码
	 * @generated
	 */
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	/**
	 * getter for 通信地址
	 * @generated
	 */
	public String getMailingAddress() {
		return this.mailingAddress;
	}

	/**
	 * setter for 通信地址
	 * @generated
	 */
	public void setMailingAddress(String mailingAddress) {
		this.mailingAddress = mailingAddress;
	}

	/**
	 * getter for 单位介绍
	 * @generated
	 */
	public String getUnitIntroduce() {
		return this.unitIntroduce;
	}

	/**
	 * setter for 单位介绍
	 * @generated
	 */
	public void setUnitIntroduce(String unitIntroduce) {
		this.unitIntroduce = unitIntroduce;
	}

	/**
	 * getter for 编制人数
	 * @generated
	 */
	public String getPrepareNum() {
		return this.prepareNum;
	}

	/**
	 * setter for 编制人数
	 * @generated
	 */
	public void setPrepareNum(String prepareNum) {
		this.prepareNum = prepareNum;
	}

	/**
	 * getter for 年末职工人数
	 * @generated
	 */
	public String getYearWorkerNum() {
		return this.yearWorkerNum;
	}

	/**
	 * setter for 年末职工人数
	 * @generated
	 */
	public void setYearWorkerNum(String yearWorkerNum) {
		this.yearWorkerNum = yearWorkerNum;
	}

	

	/**
	 * getter for 录入人员ID
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 录入人员ID
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for 录入时间
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for 录入时间
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for 修改人ID
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人ID
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for 修改时间
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for 修改时间
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}



	public String getAdministrativelevel() {
		return administrativelevel;
	}

	public void setAdministrativelevel(String administrativelevel) {
		this.administrativelevel = administrativelevel;
	}

	public String getUnitsnature() {
		return unitsnature;
	}

	public void setUnitsnature(String unitsnature) {
		this.unitsnature = unitsnature;
	}

}