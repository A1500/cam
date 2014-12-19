package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyFamily
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
 */
@Table(tableName = "SAM_ESUREY_FAMILY", keyFields = "familyId")
public class SamEsureyFamily extends StatefulDatabean {
	// 家庭ID
	// @Rule(value="require")
	@Column(name = "FAMILY_ID")
	private String familyId;
	// 户主姓名
	@Column(name = "FAMILY_NAME")
	private String familyName;
	// 家庭类型
	@Column(name = "FAMILY_TYPE")
	private String familyType;
	// 身份证件类型
	@Column(name = "FAMILY_CARD_TYPE")
	private String familyCardType;
	// 身份证号
	@Column(name = "FAMILY_CARD_NO")
	private String familyCardNo;
	// 人口数量
	@Column(name = "PEOPLE_NUM")
	private String peopleNum;
	// 户籍行政区划代码
	@Column(name = "REG_ADDRESS")
	private String regAddress;
	// 属地行政区划代码
	@Column(name = "FAMILY_ADDRESS")
	private String familyAddress;
	// 家庭住址
	@Column(name = "ADDRESS")
	private String address;
	// 邮政编码
	@Column(name = "FAMILY_POSTCODE")
	private String familyPostcode;
	// 联系电话_宅电
	@Column(name = "FAMILY_PHONE")
	private String familyPhone;
	// 户籍类别代码
	@Column(name = "DOMICILE_TYPE")
	private String domicileType;
	// 联系电话_手机
	@Column(name = "FAMILY_MOBILE")
	private String familyMobile;
	// 联系电话_其他
	@Column(name = "FAMILY_OTHER_PHONE")
	private String familyOtherPhone;
	// 家庭年总收入
	@Column(name = "YEAR_INCOME")
	private String yearIncome;
	// 家庭年人均收入
	@Column(name = "YEAR_AVERAGE_INCOME")
	private String yearAverageIncome;
	// 家庭月总收入
	@Column(name = "MONTH_INCOME")
	private String monthIncome;
	// 家庭月人均收入
	@Column(name = "MONTH_AVERAGE_INCOME")
	private String monthAverageIncome;
	// 住房状况类型
	@Column(name = "HOUSE_STATUS")
	private String houseStatus;
	// 建筑面积
	@Column(name = "BUILD_AREA")
	private String buildArea;
	// 人均建筑面积
	@Column(name = "BUILD_AVERAGE_AREA")
	private String buildAverageArea;
	// 房屋结构
	@Column(name = "BUILDING_STRUCTURE")
	private String buildingStructure;
	// 备注
	@Column(name = "NOTE")
	private String note;
	// 赡养费（年）
	@Column(name = "YEAR_SUPPORT_MON")
	private String yearSupportMon;
	// 赡养费（月）
	@Column(name = "MONTH_SUPPORT_MONON")
	private String monthSupportMonon;
	// 家庭状态标志
	@Column(name = "FAMILY_STATUS")
	private String familyStatus;
	// 居委会经办人ID
	@Column(name = "REG_ID")
	private String regId;
	// 居委会经办人
	@Column(name = "REG_PEOPLE")
	private String regPeople;
	// 居委会负责人ID
	@Column(name = "RESP_REG_ID")
	private String respRegId;
	// 居委会负责人姓名
	@Column(name = "RESP_REG_PEOPLE")
	private String respRegPeople;
	// 录入单位ID
	@Column(name = "REG_ORG_ID")
	private String regOrgId;
	// 录入单位名称
	@Column(name = "REG_ORG_NAME")
	private String regOrgName;
	// 录入时间
	@Column(name = "REG_TIME")
	private String regTime;
	// 录入意见
	@Column(name = "REG_NOTE")
	private String regNote;
	// 录入单位行政区划
	@Column(name = "REG_ORG_AREA")
	private String regOrgArea;
	// 修改人ID
	@Column(name = "MOD_ID")
	private String modId;
	// 修改人
	@Column(name = "MOD_PEOPLE")
	private String modPeople;
	// 修改单位ID
	@Column(name = "MOD_ORG_ID")
	private String modOrgId;
	// 修改单位
	@Column(name = "MOD_ORG")
	private String modOrg;
	// 修改时间
	@Column(name = "MOD_TIME")
	private String modTime;
	// 审核人ID
	@Column(name = "CHECK_ID")
	private String checkId;
	// 审核人
	@Column(name = "CHECK_PEOPLE")
	private String checkPeople;
	// 审核单位ID
	@Column(name = "CHECK_ORG_ID")
	private String checkOrgId;
	// 审核单位
	@Column(name = "CHECK_ORG")
	private String checkOrg;
	// 审核单位行政区划
	@Column(name = "CHECK_ORG_AREA")
	private String checkOrgArea;
	// 审核时间
	@Column(name = "CHECK_TIME")
	private String checkTime;
	// 审核意见
	@Column(name = "CHECK_OPINION")
	private String checkOpinion;
	// 补充意见
	@Column(name = "CHECK_NOTE")
	private String checkNote;
	// 审核负责人ID
	@Column(name = "RESP_CHECK_ID")
	private String respCheckId;
	// 审核负责人
	@Column(name = "RESP_CHECK_PEOPLE")
	private String respCheckPeople;
	// 当前环节
	@Column(name = "CUR_ACTIVITY")
	private String curActivity;
	// 当前环节状态
	@Column(name = "CUR_STATE")
	private String curState;
	// 救助类型
	@Column(name = "ASSISTANCE_TYPE")
	private String assistanceType;
	@Transient
	private String familySum;// 非表列，发起核对时外部单位社保
	@Transient
	private String externalSocialOrg;
	// 非表列，发起核对时外部单位房管
	@Transient
	private String externalHouseOrg;
	// 非表列，发起核对时外部单位工商
	@Transient
	private String externalBusinessOrg;
	// 非表列，发起核对时外部单位车管
	@Transient
	private String externalCarOrg;
	// 非表列，发起核对时外部单位国税
	@Transient
	private String externalTaxGOrg;
	// 非表列，发起核对时外部单位地税
	@Transient
	private String externalTaxDOrg;
	// 非表列，发起核对时外部单位公积金
	@Transient
	private String externalFundOrg;
	// 非表列，发起核对时外部单位银行
	@Transient
	private String externalBankOrg;
	// 非表列，发起核对时外部单位证监
	@Transient
	private String externalSecuritiesOrg;
	// 非表列，发起核对时外部单位保监
	@Transient
	private String externalInsuranceOrg;

	public String getExternalSocialOrg() {
		return externalSocialOrg;
	}

	public void setExternalSocialOrg(String externalSocialOrg) {
		this.externalSocialOrg = externalSocialOrg;
	}

	public String getExternalHouseOrg() {
		return externalHouseOrg;
	}

	public void setExternalHouseOrg(String externalHouseOrg) {
		this.externalHouseOrg = externalHouseOrg;
	}

	public String getExternalBusinessOrg() {
		return externalBusinessOrg;
	}

	public void setExternalBusinessOrg(String externalBusinessOrg) {
		this.externalBusinessOrg = externalBusinessOrg;
	}

	public String getExternalCarOrg() {
		return externalCarOrg;
	}

	public void setExternalCarOrg(String externalCarOrg) {
		this.externalCarOrg = externalCarOrg;
	}

	public String getExternalTaxGOrg() {
		return externalTaxGOrg;
	}

	public void setExternalTaxGOrg(String externalTaxGOrg) {
		this.externalTaxGOrg = externalTaxGOrg;
	}

	public String getExternalTaxDOrg() {
		return externalTaxDOrg;
	}

	public void setExternalTaxDOrg(String externalTaxDOrg) {
		this.externalTaxDOrg = externalTaxDOrg;
	}

	public String getExternalFundOrg() {
		return externalFundOrg;
	}

	public String getRegOrgArea() {
		return regOrgArea;
	}

	public void setRegOrgArea(String regOrgArea) {
		this.regOrgArea = regOrgArea;
	}

	public void setExternalFundOrg(String externalFundOrg) {
		this.externalFundOrg = externalFundOrg;
	}

	public String getExternalBankOrg() {
		return externalBankOrg;
	}

	public void setExternalBankOrg(String externalBankOrg) {
		this.externalBankOrg = externalBankOrg;
	}

	public String getExternalSecuritiesOrg() {
		return externalSecuritiesOrg;
	}

	public void setExternalSecuritiesOrg(String externalSecuritiesOrg) {
		this.externalSecuritiesOrg = externalSecuritiesOrg;
	}

	public String getExternalInsuranceOrg() {
		return externalInsuranceOrg;
	}

	public void setExternalInsuranceOrg(String externalInsuranceOrg) {
		this.externalInsuranceOrg = externalInsuranceOrg;
	}

	public String getFamilySum() {
		return familySum;
	}

	public void setFamilySum(String familySum) {
		this.familySum = familySum;
	}

	public String getCheckOrgArea() {
		return checkOrgArea;
	}

	public void setCheckOrgArea(String checkOrgArea) {
		this.checkOrgArea = checkOrgArea;
	}

	/**
	 * getter for 家庭ID
	 * 
	 * @generated
	 */
	public String getFamilyId() {
		return this.familyId;
	}

	/**
	 * setter for 家庭ID
	 * 
	 * @generated
	 */
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	/**
	 * getter for 户主姓名
	 * 
	 * @generated
	 */
	public String getFamilyName() {
		return this.familyName;
	}

	/**
	 * setter for 户主姓名
	 * 
	 * @generated
	 */
	public void setFamilyName(String familyName) {
		this.familyName = familyName;
	}

	/**
	 * getter for 身份证件类型
	 * 
	 * @generated
	 */
	public String getFamilyCardType() {
		return this.familyCardType;
	}

	/**
	 * setter for 身份证件类型
	 * 
	 * @generated
	 */
	public void setFamilyCardType(String familyCardType) {
		this.familyCardType = familyCardType;
	}

	/**
	 * getter for 身份证号
	 * 
	 * @generated
	 */
	public String getFamilyCardNo() {
		return this.familyCardNo;
	}

	/**
	 * setter for 身份证号
	 * 
	 * @generated
	 */
	public void setFamilyCardNo(String familyCardNo) {
		this.familyCardNo = familyCardNo;
	}

	/**
	 * getter for 人口数量
	 * 
	 * @generated
	 */
	public String getPeopleNum() {
		return this.peopleNum;
	}

	/**
	 * setter for 人口数量
	 * 
	 * @generated
	 */
	public void setPeopleNum(String peopleNum) {
		this.peopleNum = peopleNum;
	}

	/**
	 * getter for 户籍行政区划代码
	 * 
	 * @generated
	 */
	public String getRegAddress() {
		return this.regAddress;
	}

	/**
	 * setter for 户籍行政区划代码
	 * 
	 * @generated
	 */
	public void setRegAddress(String regAddress) {
		this.regAddress = regAddress;
	}

	/**
	 * getter for 属地行政区划代码
	 * 
	 * @generated
	 */
	public String getFamilyAddress() {
		return this.familyAddress;
	}

	/**
	 * setter for 属地行政区划代码
	 * 
	 * @generated
	 */
	public void setFamilyAddress(String familyAddress) {
		this.familyAddress = familyAddress;
	}

	/**
	 * getter for 家庭住址
	 * 
	 * @generated
	 */
	public String getAddress() {
		return this.address;
	}

	/**
	 * setter for 家庭住址
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
	public String getFamilyPostcode() {
		return this.familyPostcode;
	}

	/**
	 * setter for 邮政编码
	 * 
	 * @generated
	 */
	public void setFamilyPostcode(String familyPostcode) {
		this.familyPostcode = familyPostcode;
	}

	/**
	 * getter for 联系电话_宅电
	 * 
	 * @generated
	 */
	public String getFamilyPhone() {
		return this.familyPhone;
	}

	/**
	 * setter for 联系电话_宅电
	 * 
	 * @generated
	 */
	public void setFamilyPhone(String familyPhone) {
		this.familyPhone = familyPhone;
	}

	/**
	 * getter for 户籍类别代码
	 * 
	 * @generated
	 */
	public String getDomicileType() {
		return this.domicileType;
	}

	/**
	 * setter for 户籍类别代码
	 * 
	 * @generated
	 */
	public void setDomicileType(String domicileType) {
		this.domicileType = domicileType;
	}

	/**
	 * getter for 联系电话_手机
	 * 
	 * @generated
	 */
	public String getFamilyMobile() {
		return this.familyMobile;
	}

	/**
	 * setter for 联系电话_手机
	 * 
	 * @generated
	 */
	public void setFamilyMobile(String familyMobile) {
		this.familyMobile = familyMobile;
	}

	/**
	 * getter for 联系电话_其他
	 * 
	 * @generated
	 */
	public String getFamilyOtherPhone() {
		return this.familyOtherPhone;
	}

	/**
	 * setter for 联系电话_其他
	 * 
	 * @generated
	 */
	public void setFamilyOtherPhone(String familyOtherPhone) {
		this.familyOtherPhone = familyOtherPhone;
	}

	/**
	 * getter for 家庭年总收入
	 * 
	 * @generated
	 */
	public String getYearIncome() {
		return this.yearIncome;
	}

	/**
	 * setter for 家庭年总收入
	 * 
	 * @generated
	 */
	public void setYearIncome(String yearIncome) {
		this.yearIncome = yearIncome;
	}

	/**
	 * getter for 家庭年人均收入
	 * 
	 * @generated
	 */
	public String getYearAverageIncome() {
		return this.yearAverageIncome;
	}

	/**
	 * setter for 家庭年人均收入
	 * 
	 * @generated
	 */
	public void setYearAverageIncome(String yearAverageIncome) {
		this.yearAverageIncome = yearAverageIncome;
	}

	/**
	 * getter for 家庭月总收入
	 * 
	 * @generated
	 */
	public String getMonthIncome() {
		return this.monthIncome;
	}

	/**
	 * setter for 家庭月总收入
	 * 
	 * @generated
	 */
	public void setMonthIncome(String monthIncome) {
		this.monthIncome = monthIncome;
	}

	/**
	 * getter for 家庭月人均收入
	 * 
	 * @generated
	 */
	public String getMonthAverageIncome() {
		return this.monthAverageIncome;
	}

	/**
	 * setter for 家庭月人均收入
	 * 
	 * @generated
	 */
	public void setMonthAverageIncome(String monthAverageIncome) {
		this.monthAverageIncome = monthAverageIncome;
	}

	/**
	 * getter for 住房状况类型
	 * 
	 * @generated
	 */
	public String getHouseStatus() {
		return this.houseStatus;
	}

	/**
	 * setter for 住房状况类型
	 * 
	 * @generated
	 */
	public void setHouseStatus(String houseStatus) {
		this.houseStatus = houseStatus;
	}

	/**
	 * getter for 建筑面积
	 * 
	 * @generated
	 */
	public String getBuildArea() {
		return this.buildArea;
	}

	/**
	 * setter for 建筑面积
	 * 
	 * @generated
	 */
	public void setBuildArea(String buildArea) {
		this.buildArea = buildArea;
	}

	/**
	 * getter for 人均建筑面积
	 * 
	 * @generated
	 */
	public String getBuildAverageArea() {
		return this.buildAverageArea;
	}

	/**
	 * setter for 人均建筑面积
	 * 
	 * @generated
	 */
	public void setBuildAverageArea(String buildAverageArea) {
		this.buildAverageArea = buildAverageArea;
	}

	/**
	 * getter for 房屋结构
	 * 
	 * @generated
	 */
	public String getBuildingStructure() {
		return this.buildingStructure;
	}

	/**
	 * setter for 房屋结构
	 * 
	 * @generated
	 */
	public void setBuildingStructure(String buildingStructure) {
		this.buildingStructure = buildingStructure;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * getter for 赡养费（年）
	 * 
	 * @generated
	 */
	public String getYearSupportMon() {
		return this.yearSupportMon;
	}

	/**
	 * setter for 赡养费（年）
	 * 
	 * @generated
	 */
	public void setYearSupportMon(String yearSupportMon) {
		this.yearSupportMon = yearSupportMon;
	}

	/**
	 * getter for 赡养费（月）
	 * 
	 * @generated
	 */
	public String getMonthSupportMonon() {
		return this.monthSupportMonon;
	}

	/**
	 * setter for 赡养费（月）
	 * 
	 * @generated
	 */
	public void setMonthSupportMonon(String monthSupportMonon) {
		this.monthSupportMonon = monthSupportMonon;
	}

	/**
	 * getter for 家庭状态标志
	 * 
	 * @generated
	 */
	public String getFamilyStatus() {
		return this.familyStatus;
	}

	/**
	 * setter for 家庭状态标志
	 * 
	 * @generated
	 */
	public void setFamilyStatus(String familyStatus) {
		this.familyStatus = familyStatus;
	}

	/**
	 * getter for 居委会经办人ID
	 * 
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 居委会经办人ID
	 * 
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for 居委会经办人
	 * 
	 * @generated
	 */
	public String getRegPeople() {
		return this.regPeople;
	}

	/**
	 * setter for 居委会经办人
	 * 
	 * @generated
	 */
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}

	/**
	 * getter for 居委会负责人ID
	 * 
	 * @generated
	 */
	public String getRespRegId() {
		return this.respRegId;
	}

	/**
	 * setter for 居委会负责人ID
	 * 
	 * @generated
	 */
	public void setRespRegId(String respRegId) {
		this.respRegId = respRegId;
	}

	/**
	 * getter for 居委会负责人姓名
	 * 
	 * @generated
	 */
	public String getRespRegPeople() {
		return this.respRegPeople;
	}

	/**
	 * setter for 居委会负责人姓名
	 * 
	 * @generated
	 */
	public void setRespRegPeople(String respRegPeople) {
		this.respRegPeople = respRegPeople;
	}

	/**
	 * getter for 录入单位ID
	 * 
	 * @generated
	 */
	public String getRegOrgId() {
		return this.regOrgId;
	}

	/**
	 * setter for 录入单位ID
	 * 
	 * @generated
	 */
	public void setRegOrgId(String regOrgId) {
		this.regOrgId = regOrgId;
	}

	/**
	 * getter for 录入时间
	 * 
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for 录入时间
	 * 
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for 录入意见
	 * 
	 * @generated
	 */
	public String getRegNote() {
		return this.regNote;
	}

	/**
	 * setter for 录入意见
	 * 
	 * @generated
	 */
	public void setRegNote(String regNote) {
		this.regNote = regNote;
	}

	/**
	 * getter for 修改人ID
	 * 
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人ID
	 * 
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for 修改人
	 * 
	 * @generated
	 */
	public String getModPeople() {
		return this.modPeople;
	}

	/**
	 * setter for 修改人
	 * 
	 * @generated
	 */
	public void setModPeople(String modPeople) {
		this.modPeople = modPeople;
	}

	/**
	 * getter for 修改单位ID
	 * 
	 * @generated
	 */
	public String getModOrgId() {
		return this.modOrgId;
	}

	/**
	 * setter for 修改单位ID
	 * 
	 * @generated
	 */
	public void setModOrgId(String modOrgId) {
		this.modOrgId = modOrgId;
	}

	/**
	 * getter for 修改单位
	 * 
	 * @generated
	 */
	public String getModOrg() {
		return this.modOrg;
	}

	/**
	 * setter for 修改单位
	 * 
	 * @generated
	 */
	public void setModOrg(String modOrg) {
		this.modOrg = modOrg;
	}

	/**
	 * getter for 修改时间
	 * 
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for 修改时间
	 * 
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	/**
	 * getter for 审核人ID
	 * 
	 * @generated
	 */
	public String getCheckId() {
		return this.checkId;
	}

	/**
	 * setter for 审核人ID
	 * 
	 * @generated
	 */
	public void setCheckId(String checkId) {
		this.checkId = checkId;
	}

	/**
	 * getter for 审核人
	 * 
	 * @generated
	 */
	public String getCheckPeople() {
		return this.checkPeople;
	}

	/**
	 * setter for 审核人
	 * 
	 * @generated
	 */
	public void setCheckPeople(String checkPeople) {
		this.checkPeople = checkPeople;
	}

	/**
	 * getter for 审核单位ID
	 * 
	 * @generated
	 */
	public String getCheckOrgId() {
		return this.checkOrgId;
	}

	/**
	 * setter for 审核单位ID
	 * 
	 * @generated
	 */
	public void setCheckOrgId(String checkOrgId) {
		this.checkOrgId = checkOrgId;
	}

	/**
	 * getter for 审核单位
	 * 
	 * @generated
	 */
	public String getCheckOrg() {
		return this.checkOrg;
	}

	/**
	 * setter for 审核单位
	 * 
	 * @generated
	 */
	public void setCheckOrg(String checkOrg) {
		this.checkOrg = checkOrg;
	}

	/**
	 * getter for 审核时间
	 * 
	 * @generated
	 */
	public String getCheckTime() {
		return this.checkTime;
	}

	/**
	 * setter for 审核时间
	 * 
	 * @generated
	 */
	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	/**
	 * getter for 审核意见
	 * 
	 * @generated
	 */
	public String getCheckNote() {
		return this.checkNote;
	}

	/**
	 * setter for 审核意见
	 * 
	 * @generated
	 */
	public void setCheckNote(String checkNote) {
		this.checkNote = checkNote;
	}

	/**
	 * getter for 审核负责人ID
	 * 
	 * @generated
	 */
	public String getRespCheckId() {
		return this.respCheckId;
	}

	/**
	 * setter for 审核负责人ID
	 * 
	 * @generated
	 */
	public void setRespCheckId(String respCheckId) {
		this.respCheckId = respCheckId;
	}

	/**
	 * getter for 审核负责人
	 * 
	 * @generated
	 */
	public String getRespCheckPeople() {
		return this.respCheckPeople;
	}

	/**
	 * setter for 审核负责人
	 * 
	 * @generated
	 */
	public void setRespCheckPeople(String respCheckPeople) {
		this.respCheckPeople = respCheckPeople;
	}

	/**
	 * getter for 当前环节
	 * 
	 * @generated
	 */
	public String getCurActivity() {
		return this.curActivity;
	}

	/**
	 * setter for 当前环节
	 * 
	 * @generated
	 */
	public void setCurActivity(String curActivity) {
		this.curActivity = curActivity;
	}

	/**
	 * getter for 当前环节状态
	 * 
	 * @generated
	 */
	public String getCurState() {
		return this.curState;
	}

	/**
	 * setter for 当前环节状态
	 * 
	 * @generated
	 */
	public void setCurState(String curState) {
		this.curState = curState;
	}

	public String getRegOrgName() {
		return regOrgName;
	}

	public void setRegOrgName(String regOrgName) {
		this.regOrgName = regOrgName;
	}

	public String getFamilyType() {
		return familyType;
	}

	public void setFamilyType(String familyType) {
		this.familyType = familyType;
	}

	public String getAssistanceType() {
		return assistanceType;
	}

	public void setAssistanceType(String assistanceType) {
		this.assistanceType = assistanceType;
	}

	public String getCheckOpinion() {
		return checkOpinion;
	}

	public void setCheckOpinion(String checkOpinion) {
		this.checkOpinion = checkOpinion;
	}

}