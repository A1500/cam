package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

import com.inspur.cams.fis.ep.base.data.FisCemeGovApproval;
import com.inspur.cams.fis.ep.base.data.FisCemeItems;
import com.inspur.cams.fis.ep.base.data.FisCemeLandcard;


/**
 * @title:FisCeme
 * @description:
 * @author:lidongdong
 * @since:2011-11-14
 * @version:1.0
 */
/*
 * 窦玉宁 2011年11月25日修改
 */
@Table(tableName = "FIS_CEME_INFO", keyFields = "cemeId")
public class FisCeme extends StatefulDatabean {

	// 公墓历史审批
	@Transient
	private List<FisCemeItems> itemList = new ArrayList<FisCemeItems>();
	// 土地证信息
	@Transient
	private List<FisCemeLandcard> landcardList = new ArrayList<FisCemeLandcard>();
	// 政府批准文号信息
	@Transient
	private List<FisCemeGovApproval> govAppList = new ArrayList<FisCemeGovApproval>();
	// CEME_ID//主键ID
	@Rule(value = "require")
	@Column(name = "CEME_ID")
	private String cemeId;
	// 公墓名称
	@Column(name = "CEME_NAME")
	private String cemeName;
	// 公墓性质
	@Column(name = "PROP")
	private String prop;
	// MANA_LEVEL 管辖单位管理级别
	@Column(name = "MANA_LEVEL")
	private String manaLevel;
	// MANA_LEVEL_ID
	@Column(name = "MANA_LEVEL_ID")
	private String manaLevelId;
	// AERA_LEVEL 所在区管理级别
	@Column(name = "AREA_LEVEL")
	private String areaLevel;
	// AERA_LEVEL_ID
	@Column(name = "AREA_LEVEL_ID")
	private String areaLevelId;
	// 主办单位
	@Column(name = "ORGANIZER")
	private String organizer;
	// 地址
	@Column(name = "ADDRESS")
	private String address;
	// 邮政编码
	@Column(name = "POSTALCODE")
	private String postalcode;
	// 法人代表
	@Column(name = "LEGAL_PERSON")
	private String legalPerson;
	// 公墓负责人
	@Column(name = "DIRECTOR_MOBILE")
	private String directorMobile;
	// 正式营业时间
	@Column(name = "GESTION_TIME")
	private String gestionTime;
	// 固定资产
	@Rule(value = "number")
	@Column(name = "FIXE_DASSETS")
	private BigDecimal fixeDassets;
	// 总投资额
	@Rule(value = "number")
	@Column(name = "TOTAL_INVESTMENT")
	private BigDecimal totalInvestment;
	// 职工总数
	@Rule(value = "number")
	@Column(name = "TOTAL_STAFF")
	private BigDecimal totalStaff;
	// 单位性质
	@Column(name = "UNIT_PROPERTIES")
	private String unitProperties;
	// 联系电话
	@Column(name = "OFFICE_PHONE")
	private String officePhone;
	// 占地总面积
	@Column(name = "TOTAL_AREA")
	private String totalArea;
	// 公墓占地面积计量单位
	@Column(name = "TOTAL_AREA_UNITS")
	private String totalAreaUnits;
	// 建筑总面积
	@Rule(value = "number")
	@Column(name = "BUILT_TOTAL_AREA")
	private BigDecimal builtTotalArea;
	// 服务范围
	@Column(name = "SERVICE_SCOPE")
	private String serviceScope;
	// 资金来源
	@Column(name = "FUND_SOURCES")
	private String fundSources;
	// 墓区建成面积
	@Rule(value = "number")
	@Column(name = "BUILT_AREA")
	private BigDecimal builtArea;
	// 墓区建成面积计量单位
	@Column(name = "BUILT_AREA_UNITS")
	private String builtAreaUnits;

	// 组织机构代码（工商）
	private String organCode;
	

	// 主办单位性质
	private String organizerProperties;

	// 联办单位
	private String coOrganizer;

	// 联办单位性质
	private String coOrganizerProperties;

	// 管辖级别
	private String domination;


	// 电子邮件地址
	private String email;

	// 网址
	private String web;
	
	//服务电话 
	private String servicePhone;


	// 公墓负责人
	private String director;


	// 批准建设时间
	private String approveTime;

	// 编制人数
	private BigDecimal numberOf;


	// 占用土地性质
	private String landProperties;



	// 营业室面积（m2）
	private BigDecimal businessArea;

	// 档案室面积（m2）
	private BigDecimal filesroomArea;

	// 办公室面积（m2）
	private BigDecimal officeromArea;

	// 绿地面积（m2）
	private BigDecimal greenArea;

	// 绿化覆盖率(%)
	private BigDecimal greenRatio;


	// 建设资金合计
	private BigDecimal fundTotal;

	// 财政拨款
	private BigDecimal fundFinance;

	// 上级部门拨款
	private BigDecimal fundHigher;

	// 自筹
	private BigDecimal fundSelf;

	// 福彩资助
	private BigDecimal fundLottery;

	// 其他
	private BigDecimal fundOther;

	// 经营管理方式（维护管理办法）
	private String manageStyle;

	// 计划使用年限至
	private String yearPlanto;

	// 参加民政部门业务培训人数
	private BigDecimal trainNum;

	// 计算机数量（台）
	private BigDecimal computerNum;

	// 信息系统安装时间
	private String fixTime;

	// 计算机管理员
	private String computerManager;

	// 计算机管理员联系电话
	private String computerManagerPhone;

	// 备注
	private String note;

	// 建成安葬穴数合计
	private BigDecimal sinceHoleNum;

	// 建成安葬单穴数
	private BigDecimal singleHole;

	// 建成安葬双穴数
	private BigDecimal doubleHole;

	// 建成安葬多穴数
	private BigDecimal moreHole;

	// 建成安放格位数
	private BigDecimal siteNum;

	// 建成生态安葬数
	private BigDecimal ecologyNum;

	// 建成公益安葬数
	private BigDecimal commonwealNum;


	/**
	 * getter for CEME_ID
	 * 
	 * @generated
	 */
	public String getCemeId() {
		return this.cemeId;
	}

	/**
	 * setter for CEME_ID
	 * 
	 * @generated
	 */
	public void setCemeId(String cemeId) {
		this.cemeId = cemeId;
	}

	/**
	 * getter for CEME_NAME
	 * 
	 * @generated
	 */
	public String getCemeName() {
		return this.cemeName;
	}

	/**
	 * setter for CEME_NAME
	 * 
	 * @generated
	 */
	public void setCemeName(String cemeName) {
		this.cemeName = cemeName;
	}

	/**
	 * setter for SERVICE_PHONE
	 * 
	 * @generated
	 */
	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}


	/**
	 * getter for SERVICE_PHONE
	 * 
	 * @generated
	 */
	public String getServicePhone() {
		return this.servicePhone;
	}

	/**
	 * getter for PROP
	 * 
	 * @generated
	 */
	public String getProp() {
		return this.prop;
	}

	/**
	 * setter for PROP
	 * 
	 * @generated
	 */
	public void setProp(String prop) {
		this.prop = prop;
	}

	/**
	 * getter for MANA_LEVEL
	 * 
	 * @generated
	 */
	public String getManaLevel() {
		return this.manaLevel;
	}

	/**
	 * setter for MANA_LEVEL
	 * 
	 * @generated
	 */
	public void setManaLevel(String manaLevel) {
		this.manaLevel = manaLevel;
	}

	/**
	 * getter for MANA_LEVEL_ID
	 * 
	 * @generated
	 */
	public String getManaLevelId() {
		return this.manaLevelId;
	}

	/**
	 * setter for MANA_LEVEL_ID
	 * 
	 * @generated
	 */
	public void setManaLevelId(String manaLevelId) {
		this.manaLevelId = manaLevelId;
	}

	/**
	 * getter for ORGANIZER
	 * 
	 * @generated
	 */
	public String getOrganizer() {
		return this.organizer;
	}

	/**
	 * setter for ORGANIZER
	 * 
	 * @generated
	 */
	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}

	/**
	 * getter for ADDRESS
	 * 
	 * @generated
	 */
	public String getAddress() {
		return this.address;
	}

	/**
	 * setter for ADDRESS
	 * 
	 * @generated
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * getter for POSTALCODE
	 * 
	 * @generated
	 */
	public String getPostalcode() {
		return this.postalcode;
	}

	/**
	 * setter for POSTALCODE
	 * 
	 * @generated
	 */
	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}

	/**
	 * getter for TOTAL_AREA
	 * 
	 * @generated
	 */
	public String getTotalArea() {
		return this.totalArea;
	}

	/**
	 * setter for TOTAL_AREA
	 * 
	 * @generated
	 */
	public void setTotalArea(String totalArea) {
		this.totalArea = totalArea;
	}

	/**
	 * getter for LEGAL_PERSON
	 * 
	 * @generated
	 */
	public String getLegalPerson() {
		return this.legalPerson;
	}

	/**
	 * setter for LEGAL_PERSON
	 * 
	 * @generated
	 */
	public void setLegalPerson(String legalPerson) {
		this.legalPerson = legalPerson;
	}


	/**
	 * getter for DIRECTOR_MOBILE
	 * 
	 * @generated
	 */
	public String getDirectorMobile() {
		return this.directorMobile;
	}

	/**
	 * setter for DIRECTOR_MOBILE
	 * 
	 * @generated
	 */
	public void setDirectorMobile(String directorMobile) {
		this.directorMobile = directorMobile;
	}

	/**
	 * getter for GESTION_TIME
	 * 
	 * @generated
	 */
	public String getGestionTime() {
		return this.gestionTime;
	}

	/**
	 * setter for GESTION_TIME
	 * 
	 * @generated
	 */
	public void setGestionTime(String gestionTime) {
		this.gestionTime = gestionTime;
	}

	/**
	 * getter for FIXE_DASSETS
	 * 
	 * @generated
	 */
	public BigDecimal getFixeDassets() {
		return this.fixeDassets;
	}

	/**
	 * setter for FIXE_DASSETS
	 * 
	 * @generated
	 */
	public void setFixeDassets(BigDecimal fixeDassets) {
		this.fixeDassets = fixeDassets;
	}

	/**
	 * getter for TOTAL_INVESTMENT
	 * 
	 * @generated
	 */
	public BigDecimal getTotalInvestment() {
		return this.totalInvestment;
	}

	/**
	 * setter for TOTAL_INVESTMENT
	 * 
	 * @generated
	 */
	public void setTotalInvestment(BigDecimal totalInvestment) {
		this.totalInvestment = totalInvestment;
	}

	/**
	 * getter for TOTAL_STAFF
	 * 
	 * @generated
	 */
	public BigDecimal getTotalStaff() {
		return this.totalStaff;
	}

	/**
	 * setter for TOTAL_STAFF
	 * 
	 * @generated
	 */
	public void setTotalStaff(BigDecimal totalStaff) {
		this.totalStaff = totalStaff;
	}

	/**
	 * getter for UNIT_PROPERTIES
	 * 
	 * @generated
	 */
	public String getUnitProperties() {
		return this.unitProperties;
	}

	/**
	 * setter for UNIT_PROPERTIES
	 * 
	 * @generated
	 */
	public void setUnitProperties(String unitProperties) {
		this.unitProperties = unitProperties;
	}

	/**
	 * getter for OFFICE_PHONE
	 * 
	 * @generated
	 */
	public String getOfficePhone() {
		return this.officePhone;
	}

	/**
	 * setter for OFFICE_PHONE
	 * 
	 * @generated
	 */
	public void setOfficePhone(String officePhone) {
		this.officePhone = officePhone;
	}

	/**
	 * getter for TOTAL_AREA_UNITS
	 * 
	 * @generated
	 */
	public String getTotalAreaUnits() {
		return this.totalAreaUnits;
	}

	/**
	 * setter for TOTAL_AREA_UNITS
	 * 
	 * @generated
	 */
	public void setTotalAreaUnits(String totalAreaUnits) {
		this.totalAreaUnits = totalAreaUnits;
	}

	/**
	 * getter for BUILT_AREA_UNITS
	 * 
	 * @generated
	 */
	public String getBuiltAreaUnits() {
		return this.builtAreaUnits;
	}

	/**
	 * setter for BUILT_AREA_UNITS
	 * 
	 * @generated
	 */
	public void setBuiltAreaUnits(String builtAreaUnits) {
		this.builtAreaUnits = builtAreaUnits;
	}

	/**
	 * getter for BUILT_AREA
	 * 
	 * @generated
	 */
	public BigDecimal getBuiltArea() {
		return this.builtArea;
	}

	/**
	 * setter for BUILT_AREA
	 * 
	 * @generated
	 */
	public void setBuiltArea(BigDecimal builtArea) {
		this.builtArea = builtArea;
	}

	public BigDecimal getBuiltTotalArea() {
		return builtTotalArea;
	}

	public void setBuiltTotalArea(BigDecimal builtTotalArea) {
		this.builtTotalArea = builtTotalArea;
	}

	public String getServiceScope() {
		return serviceScope;
	}

	public void setServiceScope(String serviceScope) {
		this.serviceScope = serviceScope;
	}

	public String getFundSources() {
		return fundSources;
	}

	public void setFundSources(String fundSources) {
		this.fundSources = fundSources;
	}

	public List<FisCemeLandcard> getLandcardList() {
		return landcardList;
	}

	public void setLandcardList(List<FisCemeLandcard> landcardList) {
		this.landcardList = landcardList;
	}

	public List<FisCemeGovApproval> getGovAppList() {
		return govAppList;
	}

	public void setGovAppList(List<FisCemeGovApproval> govAppList) {
		this.govAppList = govAppList;
	}

	public List<FisCemeItems> getItemList() {
		return itemList;
	}

	public void setItemList(List<FisCemeItems> itemList) {
		this.itemList = itemList;
	}

	public String getAreaLevel() {
		return areaLevel;
	}

	public void setAreaLevel(String areaLevel) {
		this.areaLevel = areaLevel;
	}

	public String getAreaLevelId() {
		return areaLevelId;
	}

	public void setAreaLevelId(String areaLevelId) {
		this.areaLevelId = areaLevelId;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getOrganizerProperties() {
		return organizerProperties;
	}

	public void setOrganizerProperties(String organizerProperties) {
		this.organizerProperties = organizerProperties;
	}

	public String getCoOrganizer() {
		return coOrganizer;
	}

	public void setCoOrganizer(String coOrganizer) {
		this.coOrganizer = coOrganizer;
	}

	public String getCoOrganizerProperties() {
		return coOrganizerProperties;
	}

	public void setCoOrganizerProperties(String coOrganizerProperties) {
		this.coOrganizerProperties = coOrganizerProperties;
	}

	public String getDomination() {
		return domination;
	}

	public void setDomination(String domination) {
		this.domination = domination;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWeb() {
		return web;
	}

	public void setWeb(String web) {
		this.web = web;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getApproveTime() {
		return approveTime;
	}

	public void setApproveTime(String approveTime) {
		this.approveTime = approveTime;
	}

	public BigDecimal getNumberOf() {
		return numberOf;
	}

	public void setNumberOf(BigDecimal numberOf) {
		this.numberOf = numberOf;
	}

	public String getLandProperties() {
		return landProperties;
	}

	public void setLandProperties(String landProperties) {
		this.landProperties = landProperties;
	}

	public BigDecimal getBusinessArea() {
		return businessArea;
	}

	public void setBusinessArea(BigDecimal businessArea) {
		this.businessArea = businessArea;
	}

	public BigDecimal getFilesroomArea() {
		return filesroomArea;
	}

	public void setFilesroomArea(BigDecimal filesroomArea) {
		this.filesroomArea = filesroomArea;
	}

	public BigDecimal getOfficeromArea() {
		return officeromArea;
	}

	public void setOfficeromArea(BigDecimal officeromArea) {
		this.officeromArea = officeromArea;
	}

	public BigDecimal getGreenArea() {
		return greenArea;
	}

	public void setGreenArea(BigDecimal greenArea) {
		this.greenArea = greenArea;
	}

	public BigDecimal getGreenRatio() {
		return greenRatio;
	}

	public void setGreenRatio(BigDecimal greenRatio) {
		this.greenRatio = greenRatio;
	}

	public BigDecimal getFundTotal() {
		return fundTotal;
	}

	public void setFundTotal(BigDecimal fundTotal) {
		this.fundTotal = fundTotal;
	}

	public BigDecimal getFundFinance() {
		return fundFinance;
	}

	public void setFundFinance(BigDecimal fundFinance) {
		this.fundFinance = fundFinance;
	}

	public BigDecimal getFundHigher() {
		return fundHigher;
	}

	public void setFundHigher(BigDecimal fundHigher) {
		this.fundHigher = fundHigher;
	}

	public BigDecimal getFundSelf() {
		return fundSelf;
	}

	public void setFundSelf(BigDecimal fundSelf) {
		this.fundSelf = fundSelf;
	}

	public BigDecimal getFundLottery() {
		return fundLottery;
	}

	public void setFundLottery(BigDecimal fundLottery) {
		this.fundLottery = fundLottery;
	}

	public BigDecimal getFundOther() {
		return fundOther;
	}

	public void setFundOther(BigDecimal fundOther) {
		this.fundOther = fundOther;
	}

	public String getManageStyle() {
		return manageStyle;
	}

	public void setManageStyle(String manageStyle) {
		this.manageStyle = manageStyle;
	}

	public String getYearPlanto() {
		return yearPlanto;
	}

	public void setYearPlanto(String yearPlanto) {
		this.yearPlanto = yearPlanto;
	}

	public BigDecimal getTrainNum() {
		return trainNum;
	}

	public void setTrainNum(BigDecimal trainNum) {
		this.trainNum = trainNum;
	}

	public BigDecimal getComputerNum() {
		return computerNum;
	}

	public void setComputerNum(BigDecimal computerNum) {
		this.computerNum = computerNum;
	}

	public String getFixTime() {
		return fixTime;
	}

	public void setFixTime(String fixTime) {
		this.fixTime = fixTime;
	}

	public String getComputerManager() {
		return computerManager;
	}

	public void setComputerManager(String computerManager) {
		this.computerManager = computerManager;
	}

	public String getComputerManagerPhone() {
		return computerManagerPhone;
	}

	public void setComputerManagerPhone(String computerManagerPhone) {
		this.computerManagerPhone = computerManagerPhone;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public BigDecimal getSinceHoleNum() {
		return sinceHoleNum;
	}

	public void setSinceHoleNum(BigDecimal sinceHoleNum) {
		this.sinceHoleNum = sinceHoleNum;
	}

	public BigDecimal getSingleHole() {
		return singleHole;
	}

	public void setSingleHole(BigDecimal singleHole) {
		this.singleHole = singleHole;
	}

	public BigDecimal getDoubleHole() {
		return doubleHole;
	}

	public void setDoubleHole(BigDecimal doubleHole) {
		this.doubleHole = doubleHole;
	}

	public BigDecimal getMoreHole() {
		return moreHole;
	}

	public void setMoreHole(BigDecimal moreHole) {
		this.moreHole = moreHole;
	}

	public BigDecimal getSiteNum() {
		return siteNum;
	}

	public void setSiteNum(BigDecimal siteNum) {
		this.siteNum = siteNum;
	}

	public BigDecimal getEcologyNum() {
		return ecologyNum;
	}

	public void setEcologyNum(BigDecimal ecologyNum) {
		this.ecologyNum = ecologyNum;
	}

	public BigDecimal getCommonwealNum() {
		return commonwealNum;
	}

	public void setCommonwealNum(BigDecimal commonwealNum) {
		this.commonwealNum = commonwealNum;
	}


}