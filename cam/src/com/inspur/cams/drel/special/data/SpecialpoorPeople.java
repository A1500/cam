package com.inspur.cams.drel.special.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:特困人员
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 @Table(tableName = "SPECIALPOOR_PEOPLE" , keyFields = "peopleId")
public class SpecialpoorPeople extends StatefulDatabean {
   //PEOPLE_ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //FAMILY_ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //RELATIONSHIP_TYPE
	@Column(name = "RELATIONSHIP_TYPE")
   private String relationshipType;
   //DOMICILE_CODE
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //NAME
	@Column(name = "NAME")
   private String name;
   //ID_CARD_TYPE
	@Column(name = "ID_CARD_TYPE")
   private String idCardType;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //NATION
	@Column(name = "NATION")
   private String nation;
   //EDU_CODE
	@Column(name = "EDU_CODE")
   private String eduCode;
   //HEALTH_CODE
	@Column(name = "HEALTH_CODE")
   private String healthCode;
   //MARRIAGE_CODE
	@Column(name = "MARRIAGE_CODE")
   private String marriageCode;
   //CAREER_CODE
	@Column(name = "CAREER_CODE")
   private String careerCode;
   //POLITICAL_CODE
	@Column(name = "POLITICAL_CODE")
   private String politicalCode;
   //DOMICILE_TYPE
	@Column(name = "DOMICILE_TYPE")
   private String domicileType;
   //TEL_MOBILE
	@Column(name = "TEL_MOBILE")
   private String telMobile;
   //TEL_OTHER
	@Column(name = "TEL_OTHER")
   private String telOther;
   //ADDRESS
	@Column(name = "ADDRESS")
   private String address;
   //POST_CODE
	@Column(name = "POST_CODE")
   private String postCode;
   //INCOME_YEAR
	@Column(name = "INCOME_YEAR")
   private BigDecimal incomeYear;
   //INCOME_MONTH
	@Column(name = "INCOME_MONTH")
   private BigDecimal incomeMonth;
   //EMPLOYMENT_CODE
	@Column(name = "EMPLOYMENT_CODE")
   private String employmentCode;
   //WORK_UNIT_NAME
	@Column(name = "WORK_UNIT_NAME")
   private String workUnitName;
   //WORK_UNIT_CHARACTER
	@Column(name = "WORK_UNIT_CHARACTER")
   private String workUnitCharacter;
   //WORK_UNIT_TEL
	@Column(name = "WORK_UNIT_TEL")
   private String workUnitTel;
   //WORK_UNIT_ADD
	@Column(name = "WORK_UNIT_ADD")
   private String workUnitAdd;
   //SAFEGUARD_TYPE
	@Column(name = "SAFEGUARD_TYPE")
   private String safeguardType;
   //MEDICAL_CODE
	@Column(name = "MEDICAL_CODE")
   private String medicalCode;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   //CITY_RESI_FLAG
   //DISABILITY_FLAG
	@Column(name = "DISABILITY_FLAG")
   private String disabilityFlag;
   //DISABILITY_LEVEL_CODE
	@Column(name = "DISABILITY_LEVEL_CODE")
   private String disabilityLevelCode;
   //DISABILITY_CASE_CODE
	@Column(name = "DISABILITY_CASE_CODE")
   private String disabilityCaseCode;
   //DOMICILE_NAME
	@Column(name = "DOMICILE_NAME")
   private String domicileName;
   	@Column(name = "ASSISTANCE_TYPE")
    private String assistanceType;
   	
   	
   public String getAssistanceType() {
		return assistanceType;
	}
	public void setAssistanceType(String assistanceType) {
		this.assistanceType = assistanceType;
	}
/**
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
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
    * getter for RELATIONSHIP_TYPE
    * @generated
    */
   public String getRelationshipType(){
      return this.relationshipType;
   }
   /**
    * setter for RELATIONSHIP_TYPE
    * @generated
    */
   public void setRelationshipType(String relationshipType){
      this.relationshipType = relationshipType;
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
    * getter for NAME
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for NAME
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for ID_CARD_TYPE
    * @generated
    */
   public String getIdCardType(){
      return this.idCardType;
   }
   /**
    * setter for ID_CARD_TYPE
    * @generated
    */
   public void setIdCardType(String idCardType){
      this.idCardType = idCardType;
   }

   /**
    * getter for ID_CARD
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for ID_CARD
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for SEX
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for SEX
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for BIRTHDAY
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }
   /**
    * setter for BIRTHDAY
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;
   }

   /**
    * getter for NATION
    * @generated
    */
   public String getNation(){
      return this.nation;
   }
   /**
    * setter for NATION
    * @generated
    */
   public void setNation(String nation){
      this.nation = nation;
   }

   /**
    * getter for EDU_CODE
    * @generated
    */
   public String getEduCode(){
      return this.eduCode;
   }
   /**
    * setter for EDU_CODE
    * @generated
    */
   public void setEduCode(String eduCode){
      this.eduCode = eduCode;
   }

   /**
    * getter for HEALTH_CODE
    * @generated
    */
   public String getHealthCode(){
      return this.healthCode;
   }
   /**
    * setter for HEALTH_CODE
    * @generated
    */
   public void setHealthCode(String healthCode){
      this.healthCode = healthCode;
   }

   /**
    * getter for MARRIAGE_CODE
    * @generated
    */
   public String getMarriageCode(){
      return this.marriageCode;
   }
   /**
    * setter for MARRIAGE_CODE
    * @generated
    */
   public void setMarriageCode(String marriageCode){
      this.marriageCode = marriageCode;
   }

   /**
    * getter for CAREER_CODE
    * @generated
    */
   public String getCareerCode(){
      return this.careerCode;
   }
   /**
    * setter for CAREER_CODE
    * @generated
    */
   public void setCareerCode(String careerCode){
      this.careerCode = careerCode;
   }

   /**
    * getter for POLITICAL_CODE
    * @generated
    */
   public String getPoliticalCode(){
      return this.politicalCode;
   }
   /**
    * setter for POLITICAL_CODE
    * @generated
    */
   public void setPoliticalCode(String politicalCode){
      this.politicalCode = politicalCode;
   }

   /**
    * getter for DOMICILE_TYPE
    * @generated
    */
   public String getDomicileType(){
      return this.domicileType;
   }
   /**
    * setter for DOMICILE_TYPE
    * @generated
    */
   public void setDomicileType(String domicileType){
      this.domicileType = domicileType;
   }

   /**
    * getter for TEL_MOBILE
    * @generated
    */
   public String getTelMobile(){
      return this.telMobile;
   }
   /**
    * setter for TEL_MOBILE
    * @generated
    */
   public void setTelMobile(String telMobile){
      this.telMobile = telMobile;
   }

   /**
    * getter for TEL_OTHER
    * @generated
    */
   public String getTelOther(){
      return this.telOther;
   }
   /**
    * setter for TEL_OTHER
    * @generated
    */
   public void setTelOther(String telOther){
      this.telOther = telOther;
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
    * getter for POST_CODE
    * @generated
    */
   public String getPostCode(){
      return this.postCode;
   }
   /**
    * setter for POST_CODE
    * @generated
    */
   public void setPostCode(String postCode){
      this.postCode = postCode;
   }

   /**
    * getter for INCOME_YEAR
    * @generated
    */
   public BigDecimal getIncomeYear(){
      return this.incomeYear;
   }
   /**
    * setter for INCOME_YEAR
    * @generated
    */
   public void setIncomeYear(BigDecimal incomeYear){
      this.incomeYear = incomeYear;
   }

   /**
    * getter for INCOME_MONTH
    * @generated
    */
   public BigDecimal getIncomeMonth(){
      return this.incomeMonth;
   }
   /**
    * setter for INCOME_MONTH
    * @generated
    */
   public void setIncomeMonth(BigDecimal incomeMonth){
      this.incomeMonth = incomeMonth;
   }

   /**
    * getter for EMPLOYMENT_CODE
    * @generated
    */
   public String getEmploymentCode(){
      return this.employmentCode;
   }
   /**
    * setter for EMPLOYMENT_CODE
    * @generated
    */
   public void setEmploymentCode(String employmentCode){
      this.employmentCode = employmentCode;
   }

   /**
    * getter for WORK_UNIT_NAME
    * @generated
    */
   public String getWorkUnitName(){
      return this.workUnitName;
   }
   /**
    * setter for WORK_UNIT_NAME
    * @generated
    */
   public void setWorkUnitName(String workUnitName){
      this.workUnitName = workUnitName;
   }

   /**
    * getter for WORK_UNIT_CHARACTER
    * @generated
    */
   public String getWorkUnitCharacter(){
      return this.workUnitCharacter;
   }
   /**
    * setter for WORK_UNIT_CHARACTER
    * @generated
    */
   public void setWorkUnitCharacter(String workUnitCharacter){
      this.workUnitCharacter = workUnitCharacter;
   }

   /**
    * getter for WORK_UNIT_TEL
    * @generated
    */
   public String getWorkUnitTel(){
      return this.workUnitTel;
   }
   /**
    * setter for WORK_UNIT_TEL
    * @generated
    */
   public void setWorkUnitTel(String workUnitTel){
      this.workUnitTel = workUnitTel;
   }

   /**
    * getter for WORK_UNIT_ADD
    * @generated
    */
   public String getWorkUnitAdd(){
      return this.workUnitAdd;
   }
   /**
    * setter for WORK_UNIT_ADD
    * @generated
    */
   public void setWorkUnitAdd(String workUnitAdd){
      this.workUnitAdd = workUnitAdd;
   }

   /**
    * getter for SAFEGUARD_TYPE
    * @generated
    */
   public String getSafeguardType(){
      return this.safeguardType;
   }
   /**
    * setter for SAFEGUARD_TYPE
    * @generated
    */
   public void setSafeguardType(String safeguardType){
      this.safeguardType = safeguardType;
   }

   /**
    * getter for MEDICAL_CODE
    * @generated
    */
   public String getMedicalCode(){
      return this.medicalCode;
   }
   /**
    * setter for MEDICAL_CODE
    * @generated
    */
   public void setMedicalCode(String medicalCode){
      this.medicalCode = medicalCode;
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
    * getter for DISABILITY_FLAG
    * @generated
    */
   public String getDisabilityFlag(){
      return this.disabilityFlag;
   }
   /**
    * setter for DISABILITY_FLAG
    * @generated
    */
   public void setDisabilityFlag(String disabilityFlag){
      this.disabilityFlag = disabilityFlag;
   }

   /**
    * getter for DISABILITY_LEVEL_CODE
    * @generated
    */
   public String getDisabilityLevelCode(){
      return this.disabilityLevelCode;
   }
   /**
    * setter for DISABILITY_LEVEL_CODE
    * @generated
    */
   public void setDisabilityLevelCode(String disabilityLevelCode){
      this.disabilityLevelCode = disabilityLevelCode;
   }

   /**
    * getter for DISABILITY_CASE_CODE
    * @generated
    */
   public String getDisabilityCaseCode(){
      return this.disabilityCaseCode;
   }
   /**
    * setter for DISABILITY_CASE_CODE
    * @generated
    */
   public void setDisabilityCaseCode(String disabilityCaseCode){
      this.disabilityCaseCode = disabilityCaseCode;
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

}