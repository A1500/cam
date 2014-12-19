package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 殡葬服务机构信息表databean
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
@Table(tableName = "FIS_SERVICES_ORGAN_MANAGE", keyFields = "recordId")
public class FisServicesOrganManage extends StatefulDatabean {

	// 记录ID
	private String recordId;

	// 所属业务主管单位ID
	private String parentOrganCode;

	// 所属业务主管单位名称
	private String parentOrganName;

	// 所属行政区划ID
	private String areaCode;

	// 所属行政区划名称
	private String areaName;

	// 单位编号
	private String unitId;

	// 服务机构名称
	private String unitName;

	// 性质
	private String properties;

	// 级别
	private String title;

	// 注册（或登记）单位
	private String organizer;

	// 法人代表
	private String legalPeople;

	// 法人代表联系电话
	private String legalPeoplePhone;

	// 负责人
	private String director;

	// 负责人联系电话
	private String directorPhone;

	// 占地面积
	private BigDecimal builtArea;

	// 建筑面积
	private BigDecimal builtTotalArea;

	// 地址
	private String address;

	// 邮政编码
	private String portCode;

	// 服务电话
	private String servicePhone;

	// 网址
	private String web;

	// 电子邮件地址
	private String email;

	// QQ群
	private String qq;

	// 服务内容
	private String serviceScope;

	// 受表彰情况
	private String honours;

	// 备注
	private String note;

	// 登记人
	private String createPeople;

	// 登记人姓名
	private String createPeopleName;

	// 登记单位
	private String createOrgan;

	// 登记单位名称
	private String createOrganName;

	// 登记时间
	private String createTime;

	/**
	 * 获取 记录ID
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 记录ID
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 所属业务主管单位ID
	 * @return String
	 */
	public String getParentOrganCode() {
		return parentOrganCode;
	}

	/**
	 * 设置 所属业务主管单位ID
	 */
	public void setParentOrganCode(String parentOrganCode) {
		this.parentOrganCode = parentOrganCode;
	}

	/**
	 * 获取 所属业务主管单位名称
	 * @return String
	 */
	public String getParentOrganName() {
		return parentOrganName;
	}

	/**
	 * 设置 所属业务主管单位名称
	 */
	public void setParentOrganName(String parentOrganName) {
		this.parentOrganName = parentOrganName;
	}

	/**
	 * 获取 所属行政区划ID
	 * @return String
	 */
	public String getAreaCode() {
		return areaCode;
	}

	/**
	 * 设置 所属行政区划ID
	 */
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	/**
	 * 获取 所属行政区划名称
	 * @return String
	 */
	public String getAreaName() {
		return areaName;
	}

	/**
	 * 设置 所属行政区划名称
	 */
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	/**
	 * 获取 单位编号
	 * @return String
	 */
	public String getUnitId() {
		return unitId;
	}

	/**
	 * 设置 单位编号
	 */
	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	/**
	 * 获取 服务机构名称
	 * @return String
	 */
	public String getUnitName() {
		return unitName;
	}

	/**
	 * 设置 服务机构名称
	 */
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	/**
	 * 获取 性质
	 * @return String
	 */
	public String getProperties() {
		return properties;
	}

	/**
	 * 设置 性质
	 */
	public void setProperties(String properties) {
		this.properties = properties;
	}

	/**
	 * 获取 级别
	 * @return String
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * 设置 级别
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * 获取 注册（或登记）单位
	 * @return String
	 */
	public String getOrganizer() {
		return organizer;
	}

	/**
	 * 设置 注册（或登记）单位
	 */
	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}

	/**
	 * 获取 法人代表
	 * @return String
	 */
	public String getLegalPeople() {
		return legalPeople;
	}

	/**
	 * 设置 法人代表
	 */
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	/**
	 * 获取 法人代表联系电话
	 * @return String
	 */
	public String getLegalPeoplePhone() {
		return legalPeoplePhone;
	}

	/**
	 * 设置 法人代表联系电话
	 */
	public void setLegalPeoplePhone(String legalPeoplePhone) {
		this.legalPeoplePhone = legalPeoplePhone;
	}

	/**
	 * 获取 负责人
	 * @return String
	 */
	public String getDirector() {
		return director;
	}

	/**
	 * 设置 负责人
	 */
	public void setDirector(String director) {
		this.director = director;
	}

	/**
	 * 获取 负责人联系电话
	 * @return String
	 */
	public String getDirectorPhone() {
		return directorPhone;
	}

	/**
	 * 设置 负责人联系电话
	 */
	public void setDirectorPhone(String directorPhone) {
		this.directorPhone = directorPhone;
	}

	/**
	 * 获取 占地面积
	 * @return BigDecimal
	 */
	public BigDecimal getBuiltArea() {
		return builtArea;
	}

	/**
	 * 设置 占地面积
	 */
	public void setBuiltArea(BigDecimal builtArea) {
		this.builtArea = builtArea;
	}

	/**
	 * 获取 建筑面积
	 * @return BigDecimal
	 */
	public BigDecimal getBuiltTotalArea() {
		return builtTotalArea;
	}

	/**
	 * 设置 建筑面积
	 */
	public void setBuiltTotalArea(BigDecimal builtTotalArea) {
		this.builtTotalArea = builtTotalArea;
	}

	/**
	 * 获取 地址
	 * @return String
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * 设置 地址
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * 获取 邮政编码
	 * @return String
	 */
	public String getPortCode() {
		return portCode;
	}

	/**
	 * 设置 邮政编码
	 */
	public void setPortCode(String portCode) {
		this.portCode = portCode;
	}

	/**
	 * 获取 服务电话
	 * @return String
	 */
	public String getServicePhone() {
		return servicePhone;
	}

	/**
	 * 设置 服务电话
	 */
	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}

	/**
	 * 获取 网址
	 * @return String
	 */
	public String getWeb() {
		return web;
	}

	/**
	 * 设置 网址
	 */
	public void setWeb(String web) {
		this.web = web;
	}

	/**
	 * 获取 电子邮件地址
	 * @return String
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * 设置 电子邮件地址
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 获取 QQ群
	 * @return String
	 */
	public String getQq() {
		return qq;
	}

	/**
	 * 设置 QQ群
	 */
	public void setQq(String qq) {
		this.qq = qq;
	}

	/**
	 * 获取 服务内容
	 * @return String
	 */
	public String getServiceScope() {
		return serviceScope;
	}

	/**
	 * 设置 服务内容
	 */
	public void setServiceScope(String serviceScope) {
		this.serviceScope = serviceScope;
	}

	/**
	 * 获取 受表彰情况
	 * @return String
	 */
	public String getHonours() {
		return honours;
	}

	/**
	 * 设置 受表彰情况
	 */
	public void setHonours(String honours) {
		this.honours = honours;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取 登记人
	 * @return String
	 */
	public String getCreatePeople() {
		return createPeople;
	}

	/**
	 * 设置 登记人
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * 获取 登记人姓名
	 * @return String
	 */
	public String getCreatePeopleName() {
		return createPeopleName;
	}

	/**
	 * 设置 登记人姓名
	 */
	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	/**
	 * 获取 登记单位
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 登记单位
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 登记单位名称
	 * @return String
	 */
	public String getCreateOrganName() {
		return createOrganName;
	}

	/**
	 * 设置 登记单位名称
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	/**
	 * 获取 登记时间
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 登记时间
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}