package com.inspur.cams.drel.special.data;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:特困家庭
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 @Table(tableName = "SPECIALPOOR_FAMILY" , keyFields = "familyId")
public class SpecialpoorFamily extends StatefulDatabean {
	 
	 @Transient
	 List<SpecialpoorPeople> SpecialpoorPeopleList = new ArrayList<SpecialpoorPeople>(); 
   //FAMILY_ID
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
   //POVERTY_CAUSE
	@Column(name = "POVERTY_CAUSE")
   private String povertyCause;
   //ASSISTANCE_FLAG
	@Column(name = "ASSISTANCE_FLAG")
   private String assistanceFlag;
   //ASSISTANCE_TYPE
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;
   //FLOW_FLAG
	@Column(name = "FLOW_FLAG")
   private String flowFlag;
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
   //SPECIALPOOR_CAUSE
	@Column(name = "SPECIALPOOR_CAUSE")
   private String specialpoorCause;
   //ASSISTANCE_TYPE_NAME
	@Column(name = "ASSISTANCE_TYPE_NAME")
   private String assistanceTypeName;
   //DOMICILE_NAME
	@Column(name = "DOMICILE_NAME")
   private String domicileName;
	
	@Column(name = "DOMICILE_FULL_NAME")
	 private String domicileFullName;
	
	@Column(name = "SPECIALPOOR_CAUSE_NAME")
	   private String specialpoorCauseName;
	
	@Column(name = "HELP_VILLAGE_CODE")
	   private String helpVillageCode;
	
	@Column(name = "HELP_VILLAGE_NAME")
	   private String helpVillageName;
	//是否省直单位联系困难家庭（必填）
	 private String ifSupport;
	//省直单位名称
	 private String supportName;
	
   public String getIfSupport() {
		return ifSupport;
	}
	public void setIfSupport(String ifSupport) {
		this.ifSupport = ifSupport;
	}
	public String getSupportName() {
		return supportName;
	}
	public void setSupportName(String supportName) {
		this.supportName = supportName;
	}
public String getHelpVillageCode() {
		return helpVillageCode;
	}
	public void setHelpVillageCode(String helpVillageCode) {
		this.helpVillageCode = helpVillageCode;
	}
	public String getHelpVillageName() {
		return helpVillageName;
	}
	public void setHelpVillageName(String helpVillageName) {
		this.helpVillageName = helpVillageName;
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
    * getter for ASSISTANCE_FLAG
    * @generated
    */
   public String getAssistanceFlag(){
      return this.assistanceFlag;
   }
   /**
    * setter for ASSISTANCE_FLAG
    * @generated
    */
   public void setAssistanceFlag(String assistanceFlag){
      this.assistanceFlag = assistanceFlag;
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
    * getter for FLOW_FLAG
    * @generated
    */
   public String getFlowFlag(){
      return this.flowFlag;
   }
   /**
    * setter for FLOW_FLAG
    * @generated
    */
   public void setFlowFlag(String flowFlag){
      this.flowFlag = flowFlag;
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
    * getter for SPECIALPOOR_CAUSE
    * @generated
    */
   public String getSpecialpoorCause(){
      return this.specialpoorCause;
   }
   /**
    * setter for SPECIALPOOR_CAUSE
    * @generated
    */
   public void setSpecialpoorCause(String specialpoorCause){
      this.specialpoorCause = specialpoorCause;
   }

   /**
    * getter for ASSISTANCE_TYPE_NAME
    * @generated
    */
   public String getAssistanceTypeName(){
      return this.assistanceTypeName;
   }
   /**
    * setter for ASSISTANCE_TYPE_NAME
    * @generated
    */
   public void setAssistanceTypeName(String assistanceTypeName){
      this.assistanceTypeName = assistanceTypeName;
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
public String getDomicileFullName() {
	return domicileFullName;
}
public void setDomicileFullName(String domicileFullName) {
	this.domicileFullName = domicileFullName;
}
public String getSpecialpoorCauseName() {
	return specialpoorCauseName;
}
public void setSpecialpoorCauseName(String specialpoorCauseName) {
	this.specialpoorCauseName = specialpoorCauseName;
}
public List<SpecialpoorPeople> getSpecialpoorPeopleList() {
	return SpecialpoorPeopleList;
}
public void setSpecialpoorPeopleList(
		List<SpecialpoorPeople> specialpoorPeopleList) {
	SpecialpoorPeopleList = specialpoorPeopleList;
}

}