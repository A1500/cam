package com.inspur.cams.drel.archive.baseinfofamilyarchive.data;

import java.math.*;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BaseinfoFamilyArchive
 * @description:
 * @author:
 * @since:2012-05-30
 * @version:1.0
*/
 @Table(tableName = "BASEINFO_FAMILY_ARCHIVE" , keyFields = "familyArchiveId")
public class BaseinfoFamilyArchive extends StatefulDatabean {
   //FAMILY_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "FAMILY_ARCHIVE_ID")
   private String familyArchiveId;
   //APPLY_ID
   //@Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   //FAMILY_ID
   //@Rule(value="require")
	@Column(name = "FAMILY_ID")
   private String familyId;
   //FAMILY_NAME
	@Column(name = "FAMILY_NAME")
   private String familyName;
   //FAMILY_CARD_TYPE
	@Column(name = "FAMILY_CARD_TYPE")
   private String familyCardType;
   //FAMILY_CARD_NO
	@Column(name = "FAMILY_CARD_NO")
   private String familyCardNo;
   //PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "PEOPLE_NUM")
   private BigDecimal peopleNum;
   //PROVINCE
	@Column(name = "PROVINCE")
   private String province;
   //CITY
	@Column(name = "CITY")
   private String city;
   //COUNTY
	@Column(name = "COUNTY")
   private String county;
   //TOWN
	@Column(name = "TOWN")
   private String town;
   //VILLAGE
	@Column(name = "VILLAGE")
   private String village;
   //APANAGE_CODE
	@Column(name = "APANAGE_CODE")
   private String apanageCode;
   //DOMICILE_CODE
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //ADDRESS
	@Column(name = "ADDRESS")
   private String address;
   //FAMILY_POSTCODE
	@Column(name = "FAMILY_POSTCODE")
   private String familyPostcode;
   //FAMILY_PHONE
	@Column(name = "FAMILY_PHONE")
   private String familyPhone;
   //FAMILY_MOBILE
	@Column(name = "FAMILY_MOBILE")
   private String familyMobile;
   //FAMILY_OTHER_PHONE
	@Column(name = "FAMILY_OTHER_PHONE")
   private String familyOtherPhone;
   //YEAR_INCOME
   	@Rule(value="number")
	@Column(name = "YEAR_INCOME")
   private BigDecimal yearIncome;
   //YEAR_AVERAGE_INCOME
   	@Rule(value="number")
	@Column(name = "YEAR_AVERAGE_INCOME")
   private BigDecimal yearAverageIncome;
   //MONTH_INCOME
   	@Rule(value="number")
	@Column(name = "MONTH_INCOME")
   private BigDecimal monthIncome;
   //MONTH_AVERAGE_INCOME
   	@Rule(value="number")
	@Column(name = "MONTH_AVERAGE_INCOME")
   private BigDecimal monthAverageIncome;
   //HOUSE_STATUS
	@Column(name = "HOUSE_STATUS")
   private String houseStatus;
   //HOUSE_NUMBER
	@Column(name = "HOUSE_NUMBER")
   private String houseNumber;
   //BUILDING_DATE
	@Column(name = "BUILDING_DATE")
   private String buildingDate;
   //BUILDING_SUBSIDY_FLAG
	@Column(name = "BUILDING_SUBSIDY_FLAG")
   private String buildingSubsidyFlag;
   //BUILD_AREA
   	@Rule(value="number")
	@Column(name = "BUILD_AREA")
   private BigDecimal buildArea;
   //BUILD_AVERAGE_AREA
   	@Rule(value="number")
	@Column(name = "BUILD_AVERAGE_AREA")
   private BigDecimal buildAverageArea;
   //BUILDING_STRUCTURE
	@Column(name = "BUILDING_STRUCTURE")
   private String buildingStructure;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   //FAMILY_STATE_FLAG
	@Column(name = "FAMILY_STATE_FLAG")
   private String familyStateFlag;
   //REG_ID
	@Column(name = "REG_ID")
   private String regId;
   //REG_ORG
	@Column(name = "REG_ORG")
   private String regOrg;
   //REG_TIME
	@Column(name = "REG_TIME")
   private String regTime;
   //MOD_ID
	@Column(name = "MOD_ID")
   private String modId;
   //MOD_ORG
	@Column(name = "MOD_ORG")
   private String modOrg;
   //MOD_TIME
	@Column(name = "MOD_TIME")
   private String modTime;
   //CHECK_ID
	@Column(name = "CHECK_ID")
   private String checkId;
   //CHECK_TIME
	@Column(name = "CHECK_TIME")
   private String checkTime;
   //CHECK_NOTE
	@Column(name = "CHECK_NOTE")
   private String checkNote;
   //CHECK_FLAG
   	@Rule(value="number")
	@Column(name = "CHECK_FLAG")
   private BigDecimal checkFlag;
   //REG_PEOPLE
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //REG_ORG_NAME
	@Column(name = "REG_ORG_NAME")
   private String regOrgName;
   //REG_ORG_TYPE
	@Column(name = "REG_ORG_TYPE")
   private String regOrgType;
   //REG_ORG_AREA
	@Column(name = "REG_ORG_AREA")
   private String regOrgArea;
   //MOD_PEOPLE
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //MOD_ORG_NAME
	@Column(name = "MOD_ORG_NAME")
   private String modOrgName;
   //MOD_ORG_AREA
	@Column(name = "MOD_ORG_AREA")
   private String modOrgArea;
   //CHECK_PEOPLE
	@Column(name = "CHECK_PEOPLE")
   private String checkPeople;
   //CHECK_ORG
	@Column(name = "CHECK_ORG")
   private String checkOrg;
   //CHECK_ORG_NAME
	@Column(name = "CHECK_ORG_NAME")
   private String checkOrgName;
   //CHECK_ORG_AREA
	@Column(name = "CHECK_ORG_AREA")
   private String checkOrgArea;
   //ASSISTANCE_TYPE
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;
	@Column(name = "ASSISTANCE_TYPE_NAME")
	private String assistanceTypeName;
   //IS_DEL
	@Column(name = "IS_DEL")
   private String isDel;
   //PHOTO_ID
	@Column(name = "PHOTO_ID")
   private String photoId;
   //CUR_ACTIVITY
	@Column(name = "CUR_ACTIVITY")
   private String curActivity;
   //HOUSE_QUALITY
	@Column(name = "HOUSE_QUALITY")
   private String houseQuality;
   //HOUSE_STRUCTURE_TYPE
	@Column(name = "HOUSE_STRUCTURE_TYPE")
   private String houseStructureType;
   //HOUSE_STATUS2
	@Column(name = "HOUSE_STATUS2")
   private String houseStatus2;
   //AGREEMENT
	@Column(name = "AGREEMENT")
   private UploadFile agreement;
   //AGREEMENT_NAME
	@Column(name = "AGREEMENT_NAME")
   private String agreementName;
   //POVERTY_CAUSE
	@Column(name = "POVERTY_CAUSE")
   private String povertyCause;
   //BELONGING
	@Column(name = "BELONGING")
   private String belonging;
   //ASSISTANCE_CLASS
	@Column(name = "ASSISTANCE_CLASS")
   private String assistanceClass;
   //ASSISTANCE_PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "ASSISTANCE_PEOPLE_NUM")
   private BigDecimal assistancePeopleNum;
   //DOMICILE_NAME
	@Column(name = "DOMICILE_NAME")
   private String domicileName;
	
	
	@Column(name = "RECHECK_TIME")
   private String recheckTime;
   //BELONGING
	@Column(name = "RECHECK_RESULT")
   private String recheckResult;
   //ASSISTANCE_CLASS
	@Column(name = "RECHECK_ORGAN_ID")
   private String recheckOrganId;
   //ASSISTANCE_PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "RECHECK_ORGAN_NAME")
   private BigDecimal recheckOrganName;
   //DOMICILE_NAME
	@Column(name = "RECHECK_PEOPLE_ID")
   private String recheckPeopleId;
	  //DOMICILE_NAME
	@Column(name = "RECHECK_PEOPLE_NAME")
   private String recheckPeopleName;
		
	
	
	
	public String getRecheckTime() {
		return recheckTime;
	}
	public void setRecheckTime(String recheckTime) {
		this.recheckTime = recheckTime;
	}
	public String getRecheckResult() {
		return recheckResult;
	}
	public void setRecheckResult(String recheckResult) {
		this.recheckResult = recheckResult;
	}
	public String getRecheckOrganId() {
		return recheckOrganId;
	}
	public void setRecheckOrganId(String recheckOrganId) {
		this.recheckOrganId = recheckOrganId;
	}
	public BigDecimal getRecheckOrganName() {
		return recheckOrganName;
	}
	public void setRecheckOrganName(BigDecimal recheckOrganName) {
		this.recheckOrganName = recheckOrganName;
	}
	public String getRecheckPeopleId() {
		return recheckPeopleId;
	}
	public void setRecheckPeopleId(String recheckPeopleId) {
		this.recheckPeopleId = recheckPeopleId;
	}
	public String getRecheckPeopleName() {
		return recheckPeopleName;
	}
	public void setRecheckPeopleName(String recheckPeopleName) {
		this.recheckPeopleName = recheckPeopleName;
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
    * getter for FAMILY_ARCHIVE_ID
    * @generated
    */
   public String getFamilyArchiveId(){
      return this.familyArchiveId;
   }
   /**
    * setter for FAMILY_ARCHIVE_ID
    * @generated
    */
   public void setFamilyArchiveId(String familyArchiveId){
      this.familyArchiveId = familyArchiveId;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

   /**
    * getter for FAMILY_ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for FAMILY_ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
   }

   /**
    * getter for FAMILY_NAME
    * @generated
    */
   public String getFamilyName(){
      return this.familyName;
   }
   /**
    * setter for FAMILY_NAME
    * @generated
    */
   public void setFamilyName(String familyName){
      this.familyName = familyName;
   }

   /**
    * getter for FAMILY_CARD_TYPE
    * @generated
    */
   public String getFamilyCardType(){
      return this.familyCardType;
   }
   /**
    * setter for FAMILY_CARD_TYPE
    * @generated
    */
   public void setFamilyCardType(String familyCardType){
      this.familyCardType = familyCardType;
   }

   /**
    * getter for FAMILY_CARD_NO
    * @generated
    */
   public String getFamilyCardNo(){
      return this.familyCardNo;
   }
   /**
    * setter for FAMILY_CARD_NO
    * @generated
    */
   public void setFamilyCardNo(String familyCardNo){
      this.familyCardNo = familyCardNo;
   }

   /**
    * getter for PEOPLE_NUM
    * @generated
    */
   public BigDecimal getPeopleNum(){
      return this.peopleNum;
   }
   /**
    * setter for PEOPLE_NUM
    * @generated
    */
   public void setPeopleNum(BigDecimal peopleNum){
      this.peopleNum = peopleNum;
   }

   /**
    * getter for PROVINCE
    * @generated
    */
   public String getProvince(){
      return this.province;
   }
   /**
    * setter for PROVINCE
    * @generated
    */
   public void setProvince(String province){
      this.province = province;
   }

   /**
    * getter for CITY
    * @generated
    */
   public String getCity(){
      return this.city;
   }
   /**
    * setter for CITY
    * @generated
    */
   public void setCity(String city){
      this.city = city;
   }

   /**
    * getter for COUNTY
    * @generated
    */
   public String getCounty(){
      return this.county;
   }
   /**
    * setter for COUNTY
    * @generated
    */
   public void setCounty(String county){
      this.county = county;
   }

   /**
    * getter for TOWN
    * @generated
    */
   public String getTown(){
      return this.town;
   }
   /**
    * setter for TOWN
    * @generated
    */
   public void setTown(String town){
      this.town = town;
   }

   /**
    * getter for VILLAGE
    * @generated
    */
   public String getVillage(){
      return this.village;
   }
   /**
    * setter for VILLAGE
    * @generated
    */
   public void setVillage(String village){
      this.village = village;
   }

   /**
    * getter for APANAGE_CODE
    * @generated
    */
   public String getApanageCode(){
      return this.apanageCode;
   }
   /**
    * setter for APANAGE_CODE
    * @generated
    */
   public void setApanageCode(String apanageCode){
      this.apanageCode = apanageCode;
   }

   /**
    * getter for DOMICILE_CODE
    * @generated
    */
   public String getDomicileCode(){
      return this.domicileCode;
   }
   /**
    * setter for DOMICILE_CODE
    * @generated
    */
   public void setDomicileCode(String domicileCode){
      this.domicileCode = domicileCode;
   }

   /**
    * getter for ADDRESS
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for ADDRESS
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for FAMILY_POSTCODE
    * @generated
    */
   public String getFamilyPostcode(){
      return this.familyPostcode;
   }
   /**
    * setter for FAMILY_POSTCODE
    * @generated
    */
   public void setFamilyPostcode(String familyPostcode){
      this.familyPostcode = familyPostcode;
   }

   /**
    * getter for FAMILY_PHONE
    * @generated
    */
   public String getFamilyPhone(){
      return this.familyPhone;
   }
   /**
    * setter for FAMILY_PHONE
    * @generated
    */
   public void setFamilyPhone(String familyPhone){
      this.familyPhone = familyPhone;
   }

   /**
    * getter for FAMILY_MOBILE
    * @generated
    */
   public String getFamilyMobile(){
      return this.familyMobile;
   }
   /**
    * setter for FAMILY_MOBILE
    * @generated
    */
   public void setFamilyMobile(String familyMobile){
      this.familyMobile = familyMobile;
   }

   /**
    * getter for FAMILY_OTHER_PHONE
    * @generated
    */
   public String getFamilyOtherPhone(){
      return this.familyOtherPhone;
   }
   /**
    * setter for FAMILY_OTHER_PHONE
    * @generated
    */
   public void setFamilyOtherPhone(String familyOtherPhone){
      this.familyOtherPhone = familyOtherPhone;
   }

   /**
    * getter for YEAR_INCOME
    * @generated
    */
   public BigDecimal getYearIncome(){
      return this.yearIncome;
   }
   /**
    * setter for YEAR_INCOME
    * @generated
    */
   public void setYearIncome(BigDecimal yearIncome){
      this.yearIncome = yearIncome;
   }

   /**
    * getter for YEAR_AVERAGE_INCOME
    * @generated
    */
   public BigDecimal getYearAverageIncome(){
      return this.yearAverageIncome;
   }
   /**
    * setter for YEAR_AVERAGE_INCOME
    * @generated
    */
   public void setYearAverageIncome(BigDecimal yearAverageIncome){
      this.yearAverageIncome = yearAverageIncome;
   }

   /**
    * getter for MONTH_INCOME
    * @generated
    */
   public BigDecimal getMonthIncome(){
      return this.monthIncome;
   }
   /**
    * setter for MONTH_INCOME
    * @generated
    */
   public void setMonthIncome(BigDecimal monthIncome){
      this.monthIncome = monthIncome;
   }

   /**
    * getter for MONTH_AVERAGE_INCOME
    * @generated
    */
   public BigDecimal getMonthAverageIncome(){
      return this.monthAverageIncome;
   }
   /**
    * setter for MONTH_AVERAGE_INCOME
    * @generated
    */
   public void setMonthAverageIncome(BigDecimal monthAverageIncome){
      this.monthAverageIncome = monthAverageIncome;
   }

   /**
    * getter for HOUSE_STATUS
    * @generated
    */
   public String getHouseStatus(){
      return this.houseStatus;
   }
   /**
    * setter for HOUSE_STATUS
    * @generated
    */
   public void setHouseStatus(String houseStatus){
      this.houseStatus = houseStatus;
   }

   /**
    * getter for HOUSE_NUMBER
    * @generated
    */
   public String getHouseNumber(){
      return this.houseNumber;
   }
   /**
    * setter for HOUSE_NUMBER
    * @generated
    */
   public void setHouseNumber(String houseNumber){
      this.houseNumber = houseNumber;
   }

   /**
    * getter for BUILDING_DATE
    * @generated
    */
   public String getBuildingDate(){
      return this.buildingDate;
   }
   /**
    * setter for BUILDING_DATE
    * @generated
    */
   public void setBuildingDate(String buildingDate){
      this.buildingDate = buildingDate;
   }

   /**
    * getter for BUILDING_SUBSIDY_FLAG
    * @generated
    */
   public String getBuildingSubsidyFlag(){
      return this.buildingSubsidyFlag;
   }
   /**
    * setter for BUILDING_SUBSIDY_FLAG
    * @generated
    */
   public void setBuildingSubsidyFlag(String buildingSubsidyFlag){
      this.buildingSubsidyFlag = buildingSubsidyFlag;
   }

   /**
    * getter for BUILD_AREA
    * @generated
    */
   public BigDecimal getBuildArea(){
      return this.buildArea;
   }
   /**
    * setter for BUILD_AREA
    * @generated
    */
   public void setBuildArea(BigDecimal buildArea){
      this.buildArea = buildArea;
   }

   /**
    * getter for BUILD_AVERAGE_AREA
    * @generated
    */
   public BigDecimal getBuildAverageArea(){
      return this.buildAverageArea;
   }
   /**
    * setter for BUILD_AVERAGE_AREA
    * @generated
    */
   public void setBuildAverageArea(BigDecimal buildAverageArea){
      this.buildAverageArea = buildAverageArea;
   }

   /**
    * getter for BUILDING_STRUCTURE
    * @generated
    */
   public String getBuildingStructure(){
      return this.buildingStructure;
   }
   /**
    * setter for BUILDING_STRUCTURE
    * @generated
    */
   public void setBuildingStructure(String buildingStructure){
      this.buildingStructure = buildingStructure;
   }

   /**
    * getter for NOTE
    * @generated
    */
   public String getNote(){
      return this.note;
   }
   /**
    * setter for NOTE
    * @generated
    */
   public void setNote(String note){
      this.note = note;
   }

   /**
    * getter for FAMILY_STATE_FLAG
    * @generated
    */
   public String getFamilyStateFlag(){
      return this.familyStateFlag;
   }
   /**
    * setter for FAMILY_STATE_FLAG
    * @generated
    */
   public void setFamilyStateFlag(String familyStateFlag){
      this.familyStateFlag = familyStateFlag;
   }

   /**
    * getter for REG_ID
    * @generated
    */
   public String getRegId(){
      return this.regId;
   }
   /**
    * setter for REG_ID
    * @generated
    */
   public void setRegId(String regId){
      this.regId = regId;
   }

   /**
    * getter for REG_ORG
    * @generated
    */
   public String getRegOrg(){
      return this.regOrg;
   }
   /**
    * setter for REG_ORG
    * @generated
    */
   public void setRegOrg(String regOrg){
      this.regOrg = regOrg;
   }

   /**
    * getter for REG_TIME
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for REG_TIME
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for MOD_ID
    * @generated
    */
   public String getModId(){
      return this.modId;
   }
   /**
    * setter for MOD_ID
    * @generated
    */
   public void setModId(String modId){
      this.modId = modId;
   }

   /**
    * getter for MOD_ORG
    * @generated
    */
   public String getModOrg(){
      return this.modOrg;
   }
   /**
    * setter for MOD_ORG
    * @generated
    */
   public void setModOrg(String modOrg){
      this.modOrg = modOrg;
   }

   /**
    * getter for MOD_TIME
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for MOD_TIME
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }

   /**
    * getter for CHECK_ID
    * @generated
    */
   public String getCheckId(){
      return this.checkId;
   }
   /**
    * setter for CHECK_ID
    * @generated
    */
   public void setCheckId(String checkId){
      this.checkId = checkId;
   }

   /**
    * getter for CHECK_TIME
    * @generated
    */
   public String getCheckTime(){
      return this.checkTime;
   }
   /**
    * setter for CHECK_TIME
    * @generated
    */
   public void setCheckTime(String checkTime){
      this.checkTime = checkTime;
   }

   /**
    * getter for CHECK_NOTE
    * @generated
    */
   public String getCheckNote(){
      return this.checkNote;
   }
   /**
    * setter for CHECK_NOTE
    * @generated
    */
   public void setCheckNote(String checkNote){
      this.checkNote = checkNote;
   }

   /**
    * getter for CHECK_FLAG
    * @generated
    */
   public BigDecimal getCheckFlag(){
      return this.checkFlag;
   }
   /**
    * setter for CHECK_FLAG
    * @generated
    */
   public void setCheckFlag(BigDecimal checkFlag){
      this.checkFlag = checkFlag;
   }

   /**
    * getter for REG_PEOPLE
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for REG_PEOPLE
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
   }

   /**
    * getter for REG_ORG_NAME
    * @generated
    */
   public String getRegOrgName(){
      return this.regOrgName;
   }
   /**
    * setter for REG_ORG_NAME
    * @generated
    */
   public void setRegOrgName(String regOrgName){
      this.regOrgName = regOrgName;
   }

   /**
    * getter for REG_ORG_TYPE
    * @generated
    */
   public String getRegOrgType(){
      return this.regOrgType;
   }
   /**
    * setter for REG_ORG_TYPE
    * @generated
    */
   public void setRegOrgType(String regOrgType){
      this.regOrgType = regOrgType;
   }

   /**
    * getter for REG_ORG_AREA
    * @generated
    */
   public String getRegOrgArea(){
      return this.regOrgArea;
   }
   /**
    * setter for REG_ORG_AREA
    * @generated
    */
   public void setRegOrgArea(String regOrgArea){
      this.regOrgArea = regOrgArea;
   }

   /**
    * getter for MOD_PEOPLE
    * @generated
    */
   public String getModPeople(){
      return this.modPeople;
   }
   /**
    * setter for MOD_PEOPLE
    * @generated
    */
   public void setModPeople(String modPeople){
      this.modPeople = modPeople;
   }

   /**
    * getter for MOD_ORG_NAME
    * @generated
    */
   public String getModOrgName(){
      return this.modOrgName;
   }
   /**
    * setter for MOD_ORG_NAME
    * @generated
    */
   public void setModOrgName(String modOrgName){
      this.modOrgName = modOrgName;
   }

   /**
    * getter for MOD_ORG_AREA
    * @generated
    */
   public String getModOrgArea(){
      return this.modOrgArea;
   }
   /**
    * setter for MOD_ORG_AREA
    * @generated
    */
   public void setModOrgArea(String modOrgArea){
      this.modOrgArea = modOrgArea;
   }

   /**
    * getter for CHECK_PEOPLE
    * @generated
    */
   public String getCheckPeople(){
      return this.checkPeople;
   }
   /**
    * setter for CHECK_PEOPLE
    * @generated
    */
   public void setCheckPeople(String checkPeople){
      this.checkPeople = checkPeople;
   }

   /**
    * getter for CHECK_ORG
    * @generated
    */
   public String getCheckOrg(){
      return this.checkOrg;
   }
   /**
    * setter for CHECK_ORG
    * @generated
    */
   public void setCheckOrg(String checkOrg){
      this.checkOrg = checkOrg;
   }

   /**
    * getter for CHECK_ORG_NAME
    * @generated
    */
   public String getCheckOrgName(){
      return this.checkOrgName;
   }
   /**
    * setter for CHECK_ORG_NAME
    * @generated
    */
   public void setCheckOrgName(String checkOrgName){
      this.checkOrgName = checkOrgName;
   }

   /**
    * getter for CHECK_ORG_AREA
    * @generated
    */
   public String getCheckOrgArea(){
      return this.checkOrgArea;
   }
   /**
    * setter for CHECK_ORG_AREA
    * @generated
    */
   public void setCheckOrgArea(String checkOrgArea){
      this.checkOrgArea = checkOrgArea;
   }

   /**
    * getter for ASSISTANCE_TYPE
    * @generated
    */
   public String getAssistanceType(){
      return this.assistanceType;
   }
   /**
    * setter for ASSISTANCE_TYPE
    * @generated
    */
   public void setAssistanceType(String assistanceType){
      this.assistanceType = assistanceType;
   }

   /**
    * getter for IS_DEL
    * @generated
    */
   public String getIsDel(){
      return this.isDel;
   }
   /**
    * setter for IS_DEL
    * @generated
    */
   public void setIsDel(String isDel){
      this.isDel = isDel;
   }

   /**
    * getter for PHOTO_ID
    * @generated
    */
   public String getPhotoId(){
      return this.photoId;
   }
   /**
    * setter for PHOTO_ID
    * @generated
    */
   public void setPhotoId(String photoId){
      this.photoId = photoId;
   }

   /**
    * getter for CUR_ACTIVITY
    * @generated
    */
   public String getCurActivity(){
      return this.curActivity;
   }
   /**
    * setter for CUR_ACTIVITY
    * @generated
    */
   public void setCurActivity(String curActivity){
      this.curActivity = curActivity;
   }

   /**
    * getter for HOUSE_QUALITY
    * @generated
    */
   public String getHouseQuality(){
      return this.houseQuality;
   }
   /**
    * setter for HOUSE_QUALITY
    * @generated
    */
   public void setHouseQuality(String houseQuality){
      this.houseQuality = houseQuality;
   }

   /**
    * getter for HOUSE_STRUCTURE_TYPE
    * @generated
    */
   public String getHouseStructureType(){
      return this.houseStructureType;
   }
   /**
    * setter for HOUSE_STRUCTURE_TYPE
    * @generated
    */
   public void setHouseStructureType(String houseStructureType){
      this.houseStructureType = houseStructureType;
   }

   /**
    * getter for HOUSE_STATUS2
    * @generated
    */
   public String getHouseStatus2(){
      return this.houseStatus2;
   }
   /**
    * setter for HOUSE_STATUS2
    * @generated
    */
   public void setHouseStatus2(String houseStatus2){
      this.houseStatus2 = houseStatus2;
   }

   /**
    * getter for AGREEMENT
    * @generated
    */
   public UploadFile getAgreement(){
      return this.agreement;
   }
   /**
    * setter for AGREEMENT
    * @generated
    */
   public void setAgreement(UploadFile agreement){
      this.agreement = agreement;
   }

   /**
    * getter for AGREEMENT_NAME
    * @generated
    */
   public String getAgreementName(){
      return this.agreementName;
   }
   /**
    * setter for AGREEMENT_NAME
    * @generated
    */
   public void setAgreementName(String agreementName){
      this.agreementName = agreementName;
   }

   /**
    * getter for POVERTY_CAUSE
    * @generated
    */
   public String getPovertyCause(){
      return this.povertyCause;
   }
   /**
    * setter for POVERTY_CAUSE
    * @generated
    */
   public void setPovertyCause(String povertyCause){
      this.povertyCause = povertyCause;
   }

   /**
    * getter for BELONGING
    * @generated
    */
   public String getBelonging(){
      return this.belonging;
   }
   /**
    * setter for BELONGING
    * @generated
    */
   public void setBelonging(String belonging){
      this.belonging = belonging;
   }

   /**
    * getter for ASSISTANCE_CLASS
    * @generated
    */
   public String getAssistanceClass(){
      return this.assistanceClass;
   }
   /**
    * setter for ASSISTANCE_CLASS
    * @generated
    */
   public void setAssistanceClass(String assistanceClass){
      this.assistanceClass = assistanceClass;
   }

   /**
    * getter for ASSISTANCE_PEOPLE_NUM
    * @generated
    */
   public BigDecimal getAssistancePeopleNum(){
      return this.assistancePeopleNum;
   }
   /**
    * setter for ASSISTANCE_PEOPLE_NUM
    * @generated
    */
   public void setAssistancePeopleNum(BigDecimal assistancePeopleNum){
      this.assistancePeopleNum = assistancePeopleNum;
   }

   /**
    * getter for DOMICILE_NAME
    * @generated
    */
   public String getDomicileName(){
      return this.domicileName;
   }
   /**
    * setter for DOMICILE_NAME
    * @generated
    */
   public void setDomicileName(String domicileName){
      this.domicileName = domicileName;
   }
public String getAssistanceTypeName() {
	return assistanceTypeName;
}
public void setAssistanceTypeName(String assistanceTypeName) {
	this.assistanceTypeName = assistanceTypeName;
}

}