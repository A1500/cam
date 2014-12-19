package com.inspur.cams.comm.baseinfo.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyEstate;
import com.inspur.cams.drel.sam.data.SamFamilySupport;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;

/**
 * @title:BaseinfoFamily
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
 */
@Table(tableName = "BASEINFO_FAMILY" , keyFields = "familyId")
public class BaseinfoFamily extends StatefulDatabean {
	// 家庭待遇信息
	@Transient
	private SamFamilyTreatment samFamilyTreatment; 
	// 救助类型多选
	@Transient
	private List<SamFamilyAssistance> samFamilyAssistanceList = new ArrayList<SamFamilyAssistance>(); 
	@Transient
	private List<SamFamilyHouse> samhouseList = new ArrayList<SamFamilyHouse>();
	@Transient
	private List<SamFamilyEstate> samestateList = new ArrayList<SamFamilyEstate>();
	@Transient
	private List<SamFamilySupport> samsupportList = new ArrayList<SamFamilySupport>();
	@Transient
	private List<BaseinfoPeople> samPeopleList = new ArrayList<BaseinfoPeople>();
	
	//家庭ID
	@Column(name = "FAMILY_ID")
	private String familyId;
	//户主姓名
	@Column(name = "FAMILY_NAME")
	private String familyName;
	//身份证件类型
	@Column(name = "FAMILY_CARD_TYPE")
	private String familyCardType;
	//身份证号
	@Column(name = "FAMILY_CARD_NO")
	private String familyCardNo;
	//人口数量
	@Rule(value="number")
	@Column(name = "PEOPLE_NUM")
	private BigDecimal peopleNum;
	//地址_省
	@Column(name = "PROVINCE")
	private String province;
	//地址_市
	@Column(name = "CITY")
	private String city;
	//地址_县（市、区）
	@Column(name = "COUNTY")
	private String county;
	//地址_镇（乡、街道、办事处）
	@Column(name = "TOWN")
	private String town;
	//地址_村（居）
	@Column(name = "VILLAGE")
	private String village;
	//户籍行政区划代码
	@Column(name = "APANAGE_CODE")
	private String apanageCode;
	//户籍行政区划名称
	private String apanageName;
	//属地行政区划代码
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;
	
	//属地行政区划名称
	@Column(name = "DOMICILE_NAME")
	private String domicileName;
	//家庭住址
	@Column(name = "ADDRESS")
	private String address;
	//邮政编码
	@Column(name = "FAMILY_POSTCODE")
	private String familyPostcode;
	//联系人
	private String familyContact;
	//联系电话_宅电
	@Column(name = "FAMILY_PHONE")
	private String familyPhone;
	//联系电话_手机
	@Column(name = "FAMILY_MOBILE")
	private String familyMobile;
	//联系电话_其他
	@Column(name = "FAMILY_OTHER_PHONE")
	private String familyOtherPhone;
	//家庭年总收入
	@Column(name = "YEAR_INCOME")
	private BigDecimal yearIncome;
	//家庭年人均收入
	@Column(name = "YEAR_AVERAGE_INCOME")
	private BigDecimal yearAverageIncome;
	//家庭月总收入
	@Column(name = "MONTH_INCOME")
	private BigDecimal monthIncome;
	//家庭月人均收入
	@Column(name = "MONTH_AVERAGE_INCOME")
	private BigDecimal monthAverageIncome;
	//住房状况类型
	@Column(name = "HOUSE_STATUS")
	private String houseStatus;
	
	//住房状况类型2
	@Column(name = "HOUSE_STATUS2")
	private String houseStatus2;
	
	//住房性质
	@Column(name = "HOUSE_QUALITY")
	private String houseQuality;
	
	//房屋间数
	@Column(name = "HOUSE_NUMBER")
	private String houseNumber;
	//住房建筑时间
	@Column(name = "BUILDING_DATE")
	private String buildingDate;
	//是否享受购建房补助
	@Column(name = "BUILDING_SUBSIDY_FLAG")
	private String buildingSubsidyFlag;
	//建筑面积
	@Column(name = "BUILD_AREA")
	private BigDecimal buildArea;
	//人均建筑面积
	@Column(name = "BUILD_AVERAGE_AREA")
	private BigDecimal buildAverageArea;
	//房屋结构
	@Column(name = "BUILDING_STRUCTURE")
	private String buildingStructure;
	
	//房屋结构类型
	@Column(name = "HOUSE_STRUCTURE_TYPE")
	private String houseStructureType;
	
	//备注
	@Column(name = "NOTE")
	private String note;
	//家庭状态标志
	@Column(name = "FAMILY_STATE_FLAG")
	private String familyStateFlag;
	//录入人ID
	@Column(name = "REG_ID")
	private String regId;
	//录入单位ID
	@Column(name = "REG_ORG")
	private String regOrg;
	//录入时间
	@Column(name = "REG_TIME")
	private String regTime;
	//修改人ID
	@Column(name = "MOD_ID")
	private String modId;
	//修改单位ID
	@Column(name = "MOD_ORG")
	private String modOrg;
	//修改时间
	@Column(name = "MOD_TIME")
	private String modTime;
	//审核人ID
	@Column(name = "CHECK_ID")
	private String checkId;
	//审核时间
	@Column(name = "CHECK_TIME")
	private String checkTime;
	//审核意见
	@Column(name = "CHECK_NOTE")
	private String checkNote;
	//审核标志
	@Column(name = "CHECK_FLAG")
	private String checkFlag;
	//录入人姓名
	@Column(name = "REG_PEOPLE")
	private String regPeople;
	//录入单位名称
	@Column(name = "REG_ORG_NAME")
	private String regOrgName;
	//录入单位行政区划
	@Column(name = "REG_ORG_AREA")
	private String regOrgArea;
	//修改人姓名
	@Column(name = "MOD_PEOPLE")
	private String modPeople;
	//修改单位名称
	@Column(name = "MOD_ORG_NAME")
	private String modOrgName;
	//修改单位区划
	@Column(name = "MOD_ORG_AREA")
	private String modOrgArea;
	//审核人名称
	@Column(name = "CHECK_PEOPLE")
	private String checkPeople;
	//审核单位ID
	@Column(name = "CHECK_ORG")
	private String checkOrg;
	//审核单位名称
	@Column(name = "CHECK_ORG_NAME")
	private String checkOrgName;
	//审核单位区划
	@Column(name = "CHECK_ORG_AREA")
	private String checkOrgArea;
	//救助类型
	@Column(name = "ASSISTANCE_TYPE")
	private String assistanceType;
	//救助类型名称
	@Column(name = "ASSISTANCE_TYPE_NAME")
	private String assistanceTypeName;
	//删除标志
	@Column(name = "IS_DEL")
	private String isDel;
	//照片ID
	@Column(name = "PHOTO_ID")
	private String photoId;
	//照片内容，非表列
	@Transient
	private String photoTemp;
	//当前环节
	@Column(name = "CUR_ACTIVITY")
	private String curActivity;
	
	
	//TODO 低保用字段
	//致贫原因
	private String povertyCause;
	//属别
	private String belonging;
	//分类施保类别
	private String assistanceClass;
	//保障人口数
	private BigDecimal assistancePeopleNum;
	
	//****   非表列    ****
	//申请日期
	@Transient
	private String applyDate;
	//申请理由
	@Transient
	private String applyReason;
	
	//救助开始日期
	@Transient
	private String beginDate;
	@Transient
	private String endDate;
	//低保证号
	@Transient
	private String cardNo;
	
	//家庭待遇ID
	@Transient
	private String treatmentId;
	//救助方式
	@Transient
	private String assistanceMode;
	//户月保障金额
	@Transient
	private BigDecimal assistanceMoney;
	//分类施保金额
	@Transient
	private BigDecimal assistanceClassMoney;
	
	
	
	
	public String getPovertyCause() {
		return povertyCause;
	}
	public void setPovertyCause(String povertyCause) {
		this.povertyCause = povertyCause;
	}
	public String getBelonging() {
		return belonging;
	}
	public void setBelonging(String belonging) {
		this.belonging = belonging;
	}
	public String getAssistanceClass() {
		return assistanceClass;
	}
	public void setAssistanceClass(String assistanceClass) {
		this.assistanceClass = assistanceClass;
	}
	public BigDecimal getAssistancePeopleNum() {
		return assistancePeopleNum;
	}
	public void setAssistancePeopleNum(BigDecimal assistancePeopleNum) {
		this.assistancePeopleNum = assistancePeopleNum;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getApplyReason() {
		return applyReason;
	}
	public void setApplyReason(String applyReason) {
		this.applyReason = applyReason;
	}
	public String getTreatmentId() {
		return treatmentId;
	}
	public void setTreatmentId(String treatmentId) {
		this.treatmentId = treatmentId;
	}
	public String getAssistanceMode() {
		return assistanceMode;
	}
	public void setAssistanceMode(String assistanceMode) {
		this.assistanceMode = assistanceMode;
	}
	public BigDecimal getAssistanceMoney() {
		return assistanceMoney;
	}
	public void setAssistanceMoney(BigDecimal assistanceMoney) {
		this.assistanceMoney = assistanceMoney;
	}
	public BigDecimal getAssistanceClassMoney() {
		return assistanceClassMoney;
	}
	public void setAssistanceClassMoney(BigDecimal assistanceClassMoney) {
		this.assistanceClassMoney = assistanceClassMoney;
	}
	/**
	 * getter for 家庭ID
	 * @generated
	 */
	public String getFamilyId(){
		return this.familyId;
	}
	/**
	 * setter for 家庭ID
	 * @generated
	 */
	public void setFamilyId(String familyId){
		this.familyId = familyId;
	}

	/**
	 * getter for 户主姓名
	 * @generated
	 */
	public String getFamilyName(){
		return this.familyName;
	}
	/**
	 * setter for 户主姓名
	 * @generated
	 */
	public void setFamilyName(String familyName){
		this.familyName = familyName;
	}

	/**
	 * getter for 身份证件类型
	 * @generated
	 */
	public String getFamilyCardType(){
		return this.familyCardType;
	}
	/**
	 * setter for 身份证件类型
	 * @generated
	 */
	public void setFamilyCardType(String familyCardType){
		this.familyCardType = familyCardType;
	}

	/**
	 * getter for 身份证号
	 * @generated
	 */
	public String getFamilyCardNo(){
		return this.familyCardNo;
	}
	/**
	 * setter for 身份证号
	 * @generated
	 */
	public void setFamilyCardNo(String familyCardNo){
		this.familyCardNo = familyCardNo;
	}

	/**
	 * getter for 人口数量
	 * @generated
	 */
	public BigDecimal getPeopleNum(){
		return this.peopleNum;
	}
	/**
	 * setter for 人口数量
	 * @generated
	 */
	public void setPeopleNum(BigDecimal peopleNum){
		this.peopleNum = peopleNum;
	}

	/**
	 * getter for 地址_省
	 * @generated
	 */
	public String getProvince(){
		return this.province;
	}
	/**
	 * setter for 地址_省
	 * @generated
	 */
	public void setProvince(String province){
		this.province = province;
	}

	/**
	 * getter for 地址_市
	 * @generated
	 */
	public String getCity(){
		return this.city;
	}
	/**
	 * setter for 地址_市
	 * @generated
	 */
	public void setCity(String city){
		this.city = city;
	}

	/**
	 * getter for 地址_县（市、区）
	 * @generated
	 */
	public String getCounty(){
		return this.county;
	}
	/**
	 * setter for 地址_县（市、区）
	 * @generated
	 */
	public void setCounty(String county){
		this.county = county;
	}

	/**
	 * getter for 地址_镇（乡、街道、办事处）
	 * @generated
	 */
	public String getTown(){
		return this.town;
	}
	/**
	 * setter for 地址_镇（乡、街道、办事处）
	 * @generated
	 */
	public void setTown(String town){
		this.town = town;
	}

	/**
	 * getter for 地址_村（居）
	 * @generated
	 */
	public String getVillage(){
		return this.village;
	}
	/**
	 * setter for 地址_村（居）
	 * @generated
	 */
	public void setVillage(String village){
		this.village = village;
	}

	/**
	 * getter for 户籍行政区划代码
	 * @generated
	 */
	public String getApanageCode(){
		return this.apanageCode;
	}
	/**
	 * setter for 户籍行政区划代码
	 * @generated
	 */
	public void setApanageCode(String apanageCode){
		this.apanageCode = apanageCode;
	}

	/**
	 * getter for 属地行政区划代码
	 * @generated
	 */
	public String getDomicileCode(){
		return this.domicileCode;
	}
	/**
	 * setter for 属地行政区划代码
	 * @generated
	 */
	public void setDomicileCode(String domicileCode){
		this.domicileCode = domicileCode;
	}

	/**
	 * getter for 属地行政区划名称
	 * @generated
	 */
	public String getDomicileName(){
		return this.domicileName;
	}
	/**
	 * setter for 属地行政区划名称
	 * @generated
	 */
	public void setDomicileName(String domicileName){
		this.domicileName = domicileName;
	}

	/**
	 * getter for 家庭住址
	 * @generated
	 */
	public String getAddress(){
		return this.address;
	}
	/**
	 * setter for 家庭住址
	 * @generated
	 */
	public void setAddress(String address){
		this.address = address;
	}

	/**
	 * getter for 邮政编码
	 * @generated
	 */
	public String getFamilyPostcode(){
		return this.familyPostcode;
	}
	/**
	 * setter for 邮政编码
	 * @generated
	 */
	public void setFamilyPostcode(String familyPostcode){
		this.familyPostcode = familyPostcode;
	}

	/**
	 * getter for 联系电话_宅电
	 * @generated
	 */
	public String getFamilyPhone(){
		return this.familyPhone;
	}
	/**
	 * setter for 联系电话_宅电
	 * @generated
	 */
	public void setFamilyPhone(String familyPhone){
		this.familyPhone = familyPhone;
	}

	/**
	 * getter for 联系电话_手机
	 * @generated
	 */
	public String getFamilyMobile(){
		return this.familyMobile;
	}
	/**
	 * setter for 联系电话_手机
	 * @generated
	 */
	public void setFamilyMobile(String familyMobile){
		this.familyMobile = familyMobile;
	}

	/**
	 * getter for 联系电话_其他
	 * @generated
	 */
	public String getFamilyOtherPhone(){
		return this.familyOtherPhone;
	}
	/**
	 * setter for 联系电话_其他
	 * @generated
	 */
	public void setFamilyOtherPhone(String familyOtherPhone){
		this.familyOtherPhone = familyOtherPhone;
	}

	/**
	 * getter for 家庭年总收入
	 * @generated
	 */
	public BigDecimal getYearIncome(){
		return this.yearIncome;
	}
	/**
	 * setter for 家庭年总收入
	 * @generated
	 */
	public void setYearIncome(BigDecimal yearIncome){
		this.yearIncome = yearIncome;
	}

	/**
	 * getter for 家庭年人均收入
	 * @generated
	 */
	public BigDecimal getYearAverageIncome(){
		return this.yearAverageIncome;
	}
	/**
	 * setter for 家庭年人均收入
	 * @generated
	 */
	public void setYearAverageIncome(BigDecimal yearAverageIncome){
		this.yearAverageIncome = yearAverageIncome;
	}

	/**
	 * getter for 家庭月总收入
	 * @generated
	 */
	public BigDecimal getMonthIncome(){
		return this.monthIncome;
	}
	/**
	 * setter for 家庭月总收入
	 * @generated
	 */
	public void setMonthIncome(BigDecimal monthIncome){
		this.monthIncome = monthIncome;
	}

	/**
	 * getter for 家庭月人均收入
	 * @generated
	 */
	public BigDecimal getMonthAverageIncome(){
		return this.monthAverageIncome;
	}
	/**
	 * setter for 家庭月人均收入
	 * @generated
	 */
	public void setMonthAverageIncome(BigDecimal monthAverageIncome){
		this.monthAverageIncome = monthAverageIncome;
	}

	/**
	 * getter for 住房状况类型
	 * @generated
	 */
	public String getHouseStatus(){
		return this.houseStatus;
	}
	/**
	 * setter for 住房状况类型
	 * @generated
	 */
	public void setHouseStatus(String houseStatus){
		this.houseStatus = houseStatus;
	}

	/**
	 * getter for 房屋间数
	 * @generated
	 */
	public String getHouseNumber(){
		return this.houseNumber;
	}
	/**
	 * setter for 房屋间数
	 * @generated
	 */
	public void setHouseNumber(String houseNumber){
		this.houseNumber = houseNumber;
	}

	/**
	 * getter for 住房建筑时间
	 * @generated
	 */
	public String getBuildingDate(){
		return this.buildingDate;
	}
	/**
	 * setter for 住房建筑时间
	 * @generated
	 */
	public void setBuildingDate(String buildingDate){
		this.buildingDate = buildingDate;
	}

	/**
	 * getter for 是否享受购建房补助
	 * @generated
	 */
	public String getBuildingSubsidyFlag(){
		return this.buildingSubsidyFlag;
	}
	/**
	 * setter for 是否享受购建房补助
	 * @generated
	 */
	public void setBuildingSubsidyFlag(String buildingSubsidyFlag){
		this.buildingSubsidyFlag = buildingSubsidyFlag;
	}

	/**
	 * getter for 建筑面积
	 * @generated
	 */
	public BigDecimal getBuildArea(){
		return this.buildArea;
	}
	/**
	 * setter for 建筑面积
	 * @generated
	 */
	public void setBuildArea(BigDecimal buildArea){
		this.buildArea = buildArea;
	}

	/**
	 * getter for 人均建筑面积
	 * @generated
	 */
	public BigDecimal getBuildAverageArea(){
		return this.buildAverageArea;
	}
	/**
	 * setter for 人均建筑面积
	 * @generated
	 */
	public void setBuildAverageArea(BigDecimal buildAverageArea){
		this.buildAverageArea = buildAverageArea;
	}

	/**
	 * getter for 房屋结构
	 * @generated
	 */
	public String getBuildingStructure(){
		return this.buildingStructure;
	}
	/**
	 * setter for 房屋结构
	 * @generated
	 */
	public void setBuildingStructure(String buildingStructure){
		this.buildingStructure = buildingStructure;
	}

	/**
	 * getter for 备注
	 * @generated
	 */
	public String getNote(){
		return this.note;
	}
	/**
	 * setter for 备注
	 * @generated
	 */
	public void setNote(String note){
		this.note = note;
	}

	/**
	 * getter for 家庭状态标志
	 * @generated
	 */
	public String getFamilyStateFlag(){
		return this.familyStateFlag;
	}
	/**
	 * setter for 家庭状态标志
	 * @generated
	 */
	public void setFamilyStateFlag(String familyStateFlag){
		this.familyStateFlag = familyStateFlag;
	}

	/**
	 * getter for 录入人ID
	 * @generated
	 */
	public String getRegId(){
		return this.regId;
	}
	/**
	 * setter for 录入人ID
	 * @generated
	 */
	public void setRegId(String regId){
		this.regId = regId;
	}

	/**
	 * getter for 录入单位ID
	 * @generated
	 */
	public String getRegOrg(){
		return this.regOrg;
	}
	/**
	 * setter for 录入单位ID
	 * @generated
	 */
	public void setRegOrg(String regOrg){
		this.regOrg = regOrg;
	}

	/**
	 * getter for 录入时间
	 * @generated
	 */
	public String getRegTime(){
		return this.regTime;
	}
	/**
	 * setter for 录入时间
	 * @generated
	 */
	public void setRegTime(String regTime){
		this.regTime = regTime;
	}

	/**
	 * getter for 修改人ID
	 * @generated
	 */
	public String getModId(){
		return this.modId;
	}
	/**
	 * setter for 修改人ID
	 * @generated
	 */
	public void setModId(String modId){
		this.modId = modId;
	}

	/**
	 * getter for 修改单位ID
	 * @generated
	 */
	public String getModOrg(){
		return this.modOrg;
	}
	/**
	 * setter for 修改单位ID
	 * @generated
	 */
	public void setModOrg(String modOrg){
		this.modOrg = modOrg;
	}

	/**
	 * getter for 修改时间
	 * @generated
	 */
	public String getModTime(){
		return this.modTime;
	}
	/**
	 * setter for 修改时间
	 * @generated
	 */
	public void setModTime(String modTime){
		this.modTime = modTime;
	}

	/**
	 * getter for 审核人ID
	 * @generated
	 */
	public String getCheckId(){
		return this.checkId;
	}
	/**
	 * setter for 审核人ID
	 * @generated
	 */
	public void setCheckId(String checkId){
		this.checkId = checkId;
	}

	/**
	 * getter for 审核时间
	 * @generated
	 */
	public String getCheckTime(){
		return this.checkTime;
	}
	/**
	 * setter for 审核时间
	 * @generated
	 */
	public void setCheckTime(String checkTime){
		this.checkTime = checkTime;
	}

	/**
	 * getter for 审核意见
	 * @generated
	 */
	public String getCheckNote(){
		return this.checkNote;
	}
	/**
	 * setter for 审核意见
	 * @generated
	 */
	public void setCheckNote(String checkNote){
		this.checkNote = checkNote;
	}

	/**
	 * getter for 审核标志
	 * @generated
	 */
	public String getCheckFlag(){
		return this.checkFlag;
	}
	/**
	 * setter for 审核标志
	 * @generated
	 */
	public void setCheckFlag(String checkFlag){
		this.checkFlag = checkFlag;
	}

	/**
	 * getter for 录入人姓名
	 * @generated
	 */
	public String getRegPeople(){
		return this.regPeople;
	}
	/**
	 * setter for 录入人姓名
	 * @generated
	 */
	public void setRegPeople(String regPeople){
		this.regPeople = regPeople;
	}

	/**
	 * getter for 录入单位名称
	 * @generated
	 */
	public String getRegOrgName(){
		return this.regOrgName;
	}
	/**
	 * setter for 录入单位名称
	 * @generated
	 */
	public void setRegOrgName(String regOrgName){
		this.regOrgName = regOrgName;
	}

	/**
	 * getter for 录入单位行政区划
	 * @generated
	 */
	public String getRegOrgArea(){
		return this.regOrgArea;
	}
	/**
	 * setter for 录入单位行政区划
	 * @generated
	 */
	public void setRegOrgArea(String regOrgArea){
		this.regOrgArea = regOrgArea;
	}

	/**
	 * getter for 修改人姓名
	 * @generated
	 */
	public String getModPeople(){
		return this.modPeople;
	}
	/**
	 * setter for 修改人姓名
	 * @generated
	 */
	public void setModPeople(String modPeople){
		this.modPeople = modPeople;
	}

	/**
	 * getter for 修改单位名称
	 * @generated
	 */
	public String getModOrgName(){
		return this.modOrgName;
	}
	/**
	 * setter for 修改单位名称
	 * @generated
	 */
	public void setModOrgName(String modOrgName){
		this.modOrgName = modOrgName;
	}

	/**
	 * getter for 修改单位区划
	 * @generated
	 */
	public String getModOrgArea(){
		return this.modOrgArea;
	}
	/**
	 * setter for 修改单位区划
	 * @generated
	 */
	public void setModOrgArea(String modOrgArea){
		this.modOrgArea = modOrgArea;
	}

	/**
	 * getter for 审核人名称
	 * @generated
	 */
	public String getCheckPeople(){
		return this.checkPeople;
	}
	/**
	 * setter for 审核人名称
	 * @generated
	 */
	public void setCheckPeople(String checkPeople){
		this.checkPeople = checkPeople;
	}

	/**
	 * getter for 审核单位ID
	 * @generated
	 */
	public String getCheckOrg(){
		return this.checkOrg;
	}
	/**
	 * setter for 审核单位ID
	 * @generated
	 */
	public void setCheckOrg(String checkOrg){
		this.checkOrg = checkOrg;
	}

	/**
	 * getter for 审核单位名称
	 * @generated
	 */
	public String getCheckOrgName(){
		return this.checkOrgName;
	}
	/**
	 * setter for 审核单位名称
	 * @generated
	 */
	public void setCheckOrgName(String checkOrgName){
		this.checkOrgName = checkOrgName;
	}

	/**
	 * getter for 审核单位区划
	 * @generated
	 */
	public String getCheckOrgArea(){
		return this.checkOrgArea;
	}
	/**
	 * setter for 审核单位区划
	 * @generated
	 */
	public void setCheckOrgArea(String checkOrgArea){
		this.checkOrgArea = checkOrgArea;
	}

	/**
	 * getter for 救助类型
	 * @generated
	 */
	public String getAssistanceType(){
		return this.assistanceType;
	}
	/**
	 * setter for 救助类型
	 * @generated
	 */
	public void setAssistanceType(String assistanceType){
		this.assistanceType = assistanceType;
	}

	/**
	 * getter for 删除标志
	 * @generated
	 */
	public String getIsDel(){
		return this.isDel;
	}
	/**
	 * setter for 删除标志
	 * @generated
	 */
	public void setIsDel(String isDel){
		this.isDel = isDel;
	}

	/**
	 * getter for 照片ID
	 * @generated
	 */
	public String getPhotoId(){
		return this.photoId;
	}
	/**
	 * setter for 照片ID
	 * @generated
	 */
	public void setPhotoId(String photoId){
		this.photoId = photoId;
	}

	/**
	 * getter for 当前环节
	 * @generated
	 */
	public String getCurActivity(){
		return this.curActivity;
	}
	/**
	 * setter for 当前环节
	 * @generated
	 */
	public void setCurActivity(String curActivity){
		this.curActivity = curActivity;
	}
	public void setPhotoTemp(String photoTemp) {
		this.photoTemp = photoTemp;
	}
	public String getPhotoTemp() {
		return photoTemp;
	}
	/**
	 * @return the houseQuality
	 */
	public String getHouseQuality() {
		return houseQuality;
	}
	/**
	 * @param houseQuality the houseQuality to set
	 */
	public void setHouseQuality(String houseQuality) {
		this.houseQuality = houseQuality;
	}
	/**
	 * @return the houseStructureType
	 */
	public String getHouseStructureType() {
		return houseStructureType;
	}
	/**
	 * @param houseStructureType the houseStructureType to set
	 */
	public void setHouseStructureType(String houseStructureType) {
		this.houseStructureType = houseStructureType;
	}
	/**
	 * @return the houseStatus2
	 */
	public String getHouseStatus2() {
		return houseStatus2;
	}
	/**
	 * @param houseStatus2 the houseStatus2 to set
	 */
	public void setHouseStatus2(String houseStatus2) {
		this.houseStatus2 = houseStatus2;
	}
	public SamFamilyTreatment getSamFamilyTreatment() {
		return samFamilyTreatment;
	}
	public void setSamFamilyTreatment(SamFamilyTreatment samFamilyTreatment) {
		this.samFamilyTreatment = samFamilyTreatment;
	}
	public List<SamFamilyAssistance> getSamFamilyAssistanceList() {
		return samFamilyAssistanceList;
	}
	public void setSamFamilyAssistanceList(
			List<SamFamilyAssistance> samFamilyAssistanceList) {
		this.samFamilyAssistanceList = samFamilyAssistanceList;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getAssistanceTypeName() {
		return assistanceTypeName;
	}
	public void setAssistanceTypeName(String assistanceTypeName) {
		this.assistanceTypeName = assistanceTypeName;
	}
	public String getFamilyContact() {
		return familyContact;
	}
	public void setFamilyContact(String familyContact) {
		this.familyContact = familyContact;
	}
	public String getApanageName() {
		return apanageName;
	}
	public void setApanageName(String apanageName) {
		this.apanageName = apanageName;
	}
	public List<SamFamilyHouse> getSamhouseList() {
		return samhouseList;
	}
	public void setSamhouseList(List<SamFamilyHouse> samhouseList) {
		this.samhouseList = samhouseList;
	}
	public List<SamFamilyEstate> getSamestateList() {
		return samestateList;
	}
	public void setSamestateList(List<SamFamilyEstate> samestateList) {
		this.samestateList = samestateList;
	}
	public List<SamFamilySupport> getSamsupportList() {
		return samsupportList;
	}
	public void setSamsupportList(List<SamFamilySupport> samsupportList) {
		this.samsupportList = samsupportList;
	}
	public List<BaseinfoPeople> getSamPeopleList() {
		return samPeopleList;
	}
	public void setSamPeopleList(List<BaseinfoPeople> samPeopleList) {
		this.samPeopleList = samPeopleList;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}