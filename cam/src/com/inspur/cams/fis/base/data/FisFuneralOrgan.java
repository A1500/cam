package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisFuneralOrgan
 * @Description: TODO 殡葬业务殡仪馆信息表
 * @author jiangzhaobao
 * @date 2011-11-15
 */
@Table(tableName = "fis_funeral_organ", keyFields = "organId")
public class FisFuneralOrgan extends StatefulDatabean {
	// 单位编号
	@Column(name = "organ_Id")
	private String organId;
	// 组织机构代码
	@Column(name = "organ_Code")
	private String organCode;
	// 殡仪馆名称
	@Column(name = "name")
	private String name;
	// 性质
	@Column(name = "properties")
	private String properties;
	// 法人代表
	@Column(name = "legal_People")
	private String legalPeople;
	// 编制人数
	@Column(name = "number_Of")
	private BigDecimal numberOf;
	// 级别
	@Column(name = "title")
	private String title;
	// 地址
	@Column(name = "address")
	private String address;
	// 邮政编码
	@Column(name = "port_Code")
	private String portCode;
	// 服务电话
	@Column(name = "service_Phone")
	private String servicePhone;
	// 网址
	@Column(name = "web")
	private String web;
	// 电子邮件地址
	@Column(name = "email")
	private String email;
	// QQ群
	@Column(name = "qq")
	private String qq;
	// 殡葬改革示范单位
	@Column(name = "demon_Unit")
	private String demonUnit;
	// 等级
	@Column(name = "grade")
	private String grade;
	// 服务内容
	@Column(name = "service_Scope")
	private String serviceScope;
	// 服务时间
	@Column(name = "service_Time")
	private String serviceTime;
	// 固定资产（万元）
	@Column(name = "fixed_Assets")
	private BigDecimal fixedAssets;
	// 所属行政区划
	@Column(name = "dept_Code")
	private String deptCode;

	// 实有人数
	@Column(name = "NUMBER_REAL")
	private BigDecimal numberReal;
	// 占地面积
	@Column(name = "BUILT_AREA")
	private BigDecimal builtArea;
	// 建筑面积
	@Column(name = "BUILT_TOTAL_AREA")
	private BigDecimal builtTotalArea;
	// 建成时间
	@Column(name = "GESTION_TIME")
	private String gestionTime;
	// 表彰情况
	@Column(name = "HONOURS")
	private String honours;
	// 备注
	@Column(name = "NOTE")
	private String note;

	// 登记人
	@Column(name = "create_People")
	private String createPeople;
	// 登记人姓名
	@Column(name = "create_People_Name")
	private String createPeopleName;
	// 登记单位
	@Column(name = "create_Organ")
	private String createOrgan;
	// 登记单位名称
	@Column(name = "create_Organ_Name")
	private String createOrganName;
	// 登记时间
	@Column(name = "create_Time")
	private String createTime;

	// 区域面积
	@Transient
	private List<FisFuneralOrganBuildarea> buildareaList = new ArrayList<FisFuneralOrganBuildarea>();

	/**
	 * getter for 单位编号
	 * 
	 * @generated
	 */
	public String getOrganId() {
		return this.organId;
	}

	/**
	 * setter for 单位编号
	 * 
	 * @generated
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

	/**
	 * getter for 组织机构代码
	 * 
	 * @generated
	 */
	public String getOrganCode() {
		return this.organCode;
	}

	/**
	 * setter for 组织机构代码
	 * 
	 * @generated
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * getter for 殡仪馆名称
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 殡仪馆名称
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 性质
	 * 
	 * @generated
	 */
	public String getProperties() {
		return this.properties;
	}

	/**
	 * setter for 性质
	 * 
	 * @generated
	 */
	public void setProperties(String properties) {
		this.properties = properties;
	}

	/**
	 * getter for 法人代表
	 * 
	 * @generated
	 */
	public String getLegalPeople() {
		return this.legalPeople;
	}

	/**
	 * setter for 法人代表
	 * 
	 * @generated
	 */
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	/**
	 * getter for 编制人数
	 * 
	 * @generated
	 */
	public BigDecimal getNumberOf() {
		return this.numberOf;
	}

	/**
	 * setter for 编制人数
	 * 
	 * @generated
	 */
	public void setNumberOf(BigDecimal numberOf) {
		this.numberOf = numberOf;
	}

	/**
	 * getter for 级别
	 * 
	 * @generated
	 */
	public String getTitle() {
		return this.title;
	}

	/**
	 * setter for 级别
	 * 
	 * @generated
	 */
	public void setTitle(String title) {
		this.title = title;
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
	public String getPortCode() {
		return this.portCode;
	}

	/**
	 * setter for 邮政编码
	 * 
	 * @generated
	 */
	public void setPortCode(String portCode) {
		this.portCode = portCode;
	}

	/**
	 * getter for 服务电话
	 * 
	 * @generated
	 */
	public String getServicePhone() {
		return this.servicePhone;
	}

	/**
	 * setter for 服务电话
	 * 
	 * @generated
	 */
	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}

	/**
	 * getter for 网址
	 * 
	 * @generated
	 */
	public String getWeb() {
		return this.web;
	}

	/**
	 * setter for 网址
	 * 
	 * @generated
	 */
	public void setWeb(String web) {
		this.web = web;
	}

	/**
	 * getter for 电子邮件地址
	 * 
	 * @generated
	 */
	public String getEmail() {
		return this.email;
	}

	/**
	 * setter for 电子邮件地址
	 * 
	 * @generated
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * getter for QQ群
	 * 
	 * @generated
	 */
	public String getQq() {
		return this.qq;
	}

	/**
	 * setter for QQ群
	 * 
	 * @generated
	 */
	public void setQq(String qq) {
		this.qq = qq;
	}

	/**
	 * getter for 殡葬改革示范单位
	 * 
	 * @generated
	 */
	public String getDemonUnit() {
		return this.demonUnit;
	}

	/**
	 * setter for 殡葬改革示范单位
	 * 
	 * @generated
	 */
	public void setDemonUnit(String demonUnit) {
		this.demonUnit = demonUnit;
	}

	/**
	 * getter for 等级
	 * 
	 * @generated
	 */
	public String getGrade() {
		return this.grade;
	}

	/**
	 * setter for 等级
	 * 
	 * @generated
	 */
	public void setGrade(String grade) {
		this.grade = grade;
	}

	/**
	 * getter for 服务内容
	 * 
	 * @generated
	 */
	public String getServiceScope() {
		return this.serviceScope;
	}

	/**
	 * setter for 服务内容
	 * 
	 * @generated
	 */
	public void setServiceScope(String serviceScope) {
		this.serviceScope = serviceScope;
	}

	/**
	 * getter for 服务时间
	 * 
	 * @generated
	 */
	public String getServiceTime() {
		return this.serviceTime;
	}

	/**
	 * setter for 服务时间
	 * 
	 * @generated
	 */
	public void setServiceTime(String serviceTime) {
		this.serviceTime = serviceTime;
	}

	/**
	 * getter for 固定资产（万元）
	 * 
	 * @generated
	 */
	public BigDecimal getFixedAssets() {
		return this.fixedAssets;
	}

	/**
	 * setter for 固定资产（万元）
	 * 
	 * @generated
	 */
	public void setFixedAssets(BigDecimal fixedAssets) {
		this.fixedAssets = fixedAssets;
	}

	/**
	 * getter for 所属行政区划
	 * 
	 * @generated
	 */
	public String getDeptCode() {
		return this.deptCode;
	}

	/**
	 * setter for 所属行政区划
	 * 
	 * @generated
	 */
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	/**
	 * getter for 登记人
	 * 
	 * @generated
	 */
	public String getCreatePeople() {
		return this.createPeople;
	}

	/**
	 * setter for 登记人
	 * 
	 * @generated
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * getter for 登记人姓名
	 * 
	 * @generated
	 */
	public String getCreatePeopleName() {
		return this.createPeopleName;
	}

	/**
	 * setter for 登记人姓名
	 * 
	 * @generated
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * getter for 登记单位
	 * 
	 * @generated
	 */
	public String getCreateOrgan() {
		return this.createOrgan;
	}

	/**
	 * setter for 登记单位
	 * 
	 * @generated
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * getter for 登记单位名称
	 * 
	 * @generated
	 */
	public String getCreateOrganName() {
		return this.createOrganName;
	}

	/**
	 * setter for 登记单位名称
	 * 
	 * @generated
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * getter for 登记时间
	 * 
	 * @generated
	 */
	public String getCreateTime() {
		return this.createTime;
	}

	/**
	 * setter for 登记时间
	 * 
	 * @generated
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getNumberReal() {
		return numberReal;
	}

	public void setNumberReal(BigDecimal numberReal) {
		this.numberReal = numberReal;
	}

	public BigDecimal getBuiltArea() {
		return builtArea;
	}

	public void setBuiltArea(BigDecimal builtArea) {
		this.builtArea = builtArea;
	}

	public BigDecimal getBuiltTotalArea() {
		return builtTotalArea;
	}

	public void setBuiltTotalArea(BigDecimal builtTotalArea) {
		this.builtTotalArea = builtTotalArea;
	}

	public String getGestionTime() {
		return gestionTime;
	}

	public void setGestionTime(String gestionTime) {
		this.gestionTime = gestionTime;
	}

	public String getHonours() {
		return honours;
	}

	public void setHonours(String honours) {
		this.honours = honours;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public List<FisFuneralOrganBuildarea> getBuildareaList() {
		return buildareaList;
	}

	public void setBuildareaList(List<FisFuneralOrganBuildarea> buildareaList) {
		this.buildareaList = buildareaList;
	}

}