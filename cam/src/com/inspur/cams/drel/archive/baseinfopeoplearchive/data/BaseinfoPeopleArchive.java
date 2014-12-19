package com.inspur.cams.drel.archive.baseinfopeoplearchive.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BaseinfoPeopleArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "BASEINFO_PEOPLE_ARCHIVE" , keyFields = "peopleArchiveId")
public class BaseinfoPeopleArchive extends StatefulDatabean {
   //PEOPLE_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //APPLY_ID
   @Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   //FAMILY_ARCHIVE_ID
   @Rule(value="require")
	@Column(name = "FAMILY_ARCHIVE_ID")
   private String familyArchiveId;
   //PEOPLE_ID
   @Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //RELATIONSHIP_TYPE
	@Column(name = "RELATIONSHIP_TYPE")
   private String relationshipType;
   //DOMICILE_CODE
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
   //APANAGE_CODE
	@Column(name = "APANAGE_CODE")
   private String apanageCode;
	private String apanageName;
   //NAME
	@Column(name = "NAME")
   private String name;
   //ID_CARD_TYPE
	@Column(name = "ID_CARD_TYPE")
   private String idCardType;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //PHOTO
	@Column(name = "PHOTO")
   private UploadFile photo;
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
   	@Rule(value="number")
	@Column(name = "INCOME_YEAR")
   private BigDecimal incomeYear;
   //INCOME_MONTH
   	@Rule(value="number")
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
	@Column(name = "CITY_RESI_FLAG")
   private String cityResiFlag;
   //RURAL_RESI_FLAG
	@Column(name = "RURAL_RESI_FLAG")
   private String ruralResiFlag;
   //RURAL_FIVEGUA_FLAG
	@Column(name = "RURAL_FIVEGUA_FLAG")
   private String ruralFiveguaFlag;
   //DISABILITY_FLAG
	@Column(name = "DISABILITY_FLAG")
   private String disabilityFlag;
   //DISABILITY_LEVEL_CODE
	@Column(name = "DISABILITY_LEVEL_CODE")
   private String disabilityLevelCode;
   //DISABILITY_CASE_CODE
	@Column(name = "DISABILITY_CASE_CODE")
   private String disabilityCaseCode;
   //REDA_FLAG
	@Column(name = "REDA_FLAG")
   private String redaFlag;
   //DEPENDANT_FLAG
	@Column(name = "DEPENDANT_FLAG")
   private String dependantFlag;
   //DEMOBILIZED_FLAG
	@Column(name = "DEMOBILIZED_FLAG")
   private String demobilizedFlag;
   //WAR_FLAG
	@Column(name = "WAR_FLAG")
   private String warFlag;
   //HANDICAP_FLAG
	@Column(name = "HANDICAP_FLAG")
   private String handicapFlag;
   //DISABILITY_NO
	@Column(name = "DISABILITY_NO")
   private String disabilityNo;
   //REDA_NO
	@Column(name = "REDA_NO")
   private String redaNo;
   //DEPENDANT_NO
	@Column(name = "DEPENDANT_NO")
   private String dependantNo;
   //DEMOBILIZED_NO
	@Column(name = "DEMOBILIZED_NO")
   private String demobilizedNo;
   //WAR_NO
	@Column(name = "WAR_NO")
   private String warNo;
   //DISABILITY_STATE_CODE
	@Column(name = "DISABILITY_STATE_CODE")
   private String disabilityStateCode;
   //REDA_STATE_CODE
	@Column(name = "REDA_STATE_CODE")
   private String redaStateCode;
   //DEPENDANT_STATE_CODE
	@Column(name = "DEPENDANT_STATE_CODE")
   private String dependantStateCode;
   //DEMOBILIZED_STATE_CODE
	@Column(name = "DEMOBILIZED_STATE_CODE")
   private String demobilizedStateCode;
   //WAR_STATE_CODE
	@Column(name = "WAR_STATE_CODE")
   private String warStateCode;
   //PERSONAL_STATS_TAG
	@Column(name = "PERSONAL_STATS_TAG")
   private String personalStatsTag;
   //REG_ID
	@Column(name = "REG_ID")
   private String regId;
   //REG_TIME
	@Column(name = "REG_TIME")
   private String regTime;
   //MOD_ID
	@Column(name = "MOD_ID")
   private String modId;
   //MOD_TIME
	@Column(name = "MOD_TIME")
   private String modTime;
   //PHOTO_ID
	@Column(name = "PHOTO_ID")
   private String photoId;
   //IS_DELETE
	@Column(name = "IS_DELETE")
   private String isDelete;
   //CHECK_ID
	@Column(name = "CHECK_ID")
   private String checkId;
   //CHECK_NAME
	@Column(name = "CHECK_NAME")
   private String checkName;
   //CHECK_ORG
	@Column(name = "CHECK_ORG")
   private String checkOrg;
   //CHECK_ORG_NAME
	@Column(name = "CHECK_ORG_NAME")
   private String checkOrgName;
   //CHECK_ORG_AREA
	@Column(name = "CHECK_ORG_AREA")
   private String checkOrgArea;
   //CHECK_TIME
	@Column(name = "CHECK_TIME")
   private String checkTime;
   //CHECK_FLAG
	@Column(name = "CHECK_FLAG")
   private String checkFlag;
   //MOD_PEOPLE
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //MOD_ORG
	@Column(name = "MOD_ORG")
   private String modOrg;
   //MOD_ORG_NAME
	@Column(name = "MOD_ORG_NAME")
   private String modOrgName;
   //MOD_ORG_AREA
	@Column(name = "MOD_ORG_AREA")
   private String modOrgArea;
   //REG_PEOPLE
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //REG_ORG
	@Column(name = "REG_ORG")
   private String regOrg;
   //REG_ORG_NAME
	@Column(name = "REG_ORG_NAME")
   private String regOrgName;
   //REG_ORG_AREA
	@Column(name = "REG_ORG_AREA")
   private String regOrgArea;
   //BPT_TYPE
	@Column(name = "BPT_TYPE")
   private String bptType;
   //BPT_NUM
   	@Rule(value="number")
	@Column(name = "BPT_NUM")
   private BigDecimal bptNum;
   //PENSION_CODE
	@Column(name = "PENSION_CODE")
   private String pensionCode;
   //DOMICILE_ADDRESS
	@Column(name = "DOMICILE_ADDRESS")
   private String domicileAddress;
   //PHONETIC_CODE
	@Column(name = "PHONETIC_CODE")
   private String phoneticCode;
   //HANDICAP_NUM
	@Column(name = "HANDICAP_NUM")
   private String handicapNum;
   //RETIRED_FLAG
	@Column(name = "RETIRED_FLAG")
   private String retiredFlag;
   //RETIRED_NO
	@Column(name = "RETIRED_NO")
   private String retiredNo;
   //RETIRED_STATE_CODE
	@Column(name = "RETIRED_STATE_CODE")
   private String retiredStateCode;
   //MARTYR_OFFSPRING_FLAG
	@Column(name = "MARTYR_OFFSPRING_FLAG")
   private String martyrOffspringFlag;
   //MARTYR_OFFSPRING_NO
	@Column(name = "MARTYR_OFFSPRING_NO")
   private String martyrOffspringNo;
   //MARTYR_OFFSPRING_STATE_CODE
	@Column(name = "MARTYR_OFFSPRING_STATE_CODE")
   private String martyrOffspringStateCode;
	
	//敬老院用字段（是否住院）
    private String inHospital;
    
    public String getInHospital() {
    	return inHospital;
    }
    public void setInHospital(String inHospital) {
    	this.inHospital = inHospital;
    }
	
   /**
    * getter for PEOPLE_ARCHIVE_ID
    * @generated
    */
   public String getPeopleArchiveId(){
      return this.peopleArchiveId;
   }
   /**
    * setter for PEOPLE_ARCHIVE_ID
    * @generated
    */
   public void setPeopleArchiveId(String peopleArchiveId){
      this.peopleArchiveId = peopleArchiveId;
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
    * getter for PHOTO
    * @generated
    */
   public UploadFile getPhoto(){
      return this.photo;
   }
   /**
    * setter for PHOTO
    * @generated
    */
   public void setPhoto(UploadFile photo){
      this.photo = photo;
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
    * getter for CITY_RESI_FLAG
    * @generated
    */
   public String getCityResiFlag(){
      return this.cityResiFlag;
   }
   /**
    * setter for CITY_RESI_FLAG
    * @generated
    */
   public void setCityResiFlag(String cityResiFlag){
      this.cityResiFlag = cityResiFlag;
   }

   /**
    * getter for RURAL_RESI_FLAG
    * @generated
    */
   public String getRuralResiFlag(){
      return this.ruralResiFlag;
   }
   /**
    * setter for RURAL_RESI_FLAG
    * @generated
    */
   public void setRuralResiFlag(String ruralResiFlag){
      this.ruralResiFlag = ruralResiFlag;
   }

   /**
    * getter for RURAL_FIVEGUA_FLAG
    * @generated
    */
   public String getRuralFiveguaFlag(){
      return this.ruralFiveguaFlag;
   }
   /**
    * setter for RURAL_FIVEGUA_FLAG
    * @generated
    */
   public void setRuralFiveguaFlag(String ruralFiveguaFlag){
      this.ruralFiveguaFlag = ruralFiveguaFlag;
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
    * getter for REDA_FLAG
    * @generated
    */
   public String getRedaFlag(){
      return this.redaFlag;
   }
   /**
    * setter for REDA_FLAG
    * @generated
    */
   public void setRedaFlag(String redaFlag){
      this.redaFlag = redaFlag;
   }

   /**
    * getter for DEPENDANT_FLAG
    * @generated
    */
   public String getDependantFlag(){
      return this.dependantFlag;
   }
   /**
    * setter for DEPENDANT_FLAG
    * @generated
    */
   public void setDependantFlag(String dependantFlag){
      this.dependantFlag = dependantFlag;
   }

   /**
    * getter for DEMOBILIZED_FLAG
    * @generated
    */
   public String getDemobilizedFlag(){
      return this.demobilizedFlag;
   }
   /**
    * setter for DEMOBILIZED_FLAG
    * @generated
    */
   public void setDemobilizedFlag(String demobilizedFlag){
      this.demobilizedFlag = demobilizedFlag;
   }

   /**
    * getter for WAR_FLAG
    * @generated
    */
   public String getWarFlag(){
      return this.warFlag;
   }
   /**
    * setter for WAR_FLAG
    * @generated
    */
   public void setWarFlag(String warFlag){
      this.warFlag = warFlag;
   }

   /**
    * getter for HANDICAP_FLAG
    * @generated
    */
   public String getHandicapFlag(){
      return this.handicapFlag;
   }
   /**
    * setter for HANDICAP_FLAG
    * @generated
    */
   public void setHandicapFlag(String handicapFlag){
      this.handicapFlag = handicapFlag;
   }

   /**
    * getter for DISABILITY_NO
    * @generated
    */
   public String getDisabilityNo(){
      return this.disabilityNo;
   }
   /**
    * setter for DISABILITY_NO
    * @generated
    */
   public void setDisabilityNo(String disabilityNo){
      this.disabilityNo = disabilityNo;
   }

   /**
    * getter for REDA_NO
    * @generated
    */
   public String getRedaNo(){
      return this.redaNo;
   }
   /**
    * setter for REDA_NO
    * @generated
    */
   public void setRedaNo(String redaNo){
      this.redaNo = redaNo;
   }

   /**
    * getter for DEPENDANT_NO
    * @generated
    */
   public String getDependantNo(){
      return this.dependantNo;
   }
   /**
    * setter for DEPENDANT_NO
    * @generated
    */
   public void setDependantNo(String dependantNo){
      this.dependantNo = dependantNo;
   }

   /**
    * getter for DEMOBILIZED_NO
    * @generated
    */
   public String getDemobilizedNo(){
      return this.demobilizedNo;
   }
   /**
    * setter for DEMOBILIZED_NO
    * @generated
    */
   public void setDemobilizedNo(String demobilizedNo){
      this.demobilizedNo = demobilizedNo;
   }

   /**
    * getter for WAR_NO
    * @generated
    */
   public String getWarNo(){
      return this.warNo;
   }
   /**
    * setter for WAR_NO
    * @generated
    */
   public void setWarNo(String warNo){
      this.warNo = warNo;
   }

   /**
    * getter for DISABILITY_STATE_CODE
    * @generated
    */
   public String getDisabilityStateCode(){
      return this.disabilityStateCode;
   }
   /**
    * setter for DISABILITY_STATE_CODE
    * @generated
    */
   public void setDisabilityStateCode(String disabilityStateCode){
      this.disabilityStateCode = disabilityStateCode;
   }

   /**
    * getter for REDA_STATE_CODE
    * @generated
    */
   public String getRedaStateCode(){
      return this.redaStateCode;
   }
   /**
    * setter for REDA_STATE_CODE
    * @generated
    */
   public void setRedaStateCode(String redaStateCode){
      this.redaStateCode = redaStateCode;
   }

   /**
    * getter for DEPENDANT_STATE_CODE
    * @generated
    */
   public String getDependantStateCode(){
      return this.dependantStateCode;
   }
   /**
    * setter for DEPENDANT_STATE_CODE
    * @generated
    */
   public void setDependantStateCode(String dependantStateCode){
      this.dependantStateCode = dependantStateCode;
   }

   /**
    * getter for DEMOBILIZED_STATE_CODE
    * @generated
    */
   public String getDemobilizedStateCode(){
      return this.demobilizedStateCode;
   }
   /**
    * setter for DEMOBILIZED_STATE_CODE
    * @generated
    */
   public void setDemobilizedStateCode(String demobilizedStateCode){
      this.demobilizedStateCode = demobilizedStateCode;
   }

   /**
    * getter for WAR_STATE_CODE
    * @generated
    */
   public String getWarStateCode(){
      return this.warStateCode;
   }
   /**
    * setter for WAR_STATE_CODE
    * @generated
    */
   public void setWarStateCode(String warStateCode){
      this.warStateCode = warStateCode;
   }

   /**
    * getter for PERSONAL_STATS_TAG
    * @generated
    */
   public String getPersonalStatsTag(){
      return this.personalStatsTag;
   }
   /**
    * setter for PERSONAL_STATS_TAG
    * @generated
    */
   public void setPersonalStatsTag(String personalStatsTag){
      this.personalStatsTag = personalStatsTag;
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
    * getter for IS_DELETE
    * @generated
    */
   public String getIsDelete(){
      return this.isDelete;
   }
   /**
    * setter for IS_DELETE
    * @generated
    */
   public void setIsDelete(String isDelete){
      this.isDelete = isDelete;
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
    * getter for CHECK_NAME
    * @generated
    */
   public String getCheckName(){
      return this.checkName;
   }
   /**
    * setter for CHECK_NAME
    * @generated
    */
   public void setCheckName(String checkName){
      this.checkName = checkName;
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
    * getter for CHECK_FLAG
    * @generated
    */
   public String getCheckFlag(){
      return this.checkFlag;
   }
   /**
    * setter for CHECK_FLAG
    * @generated
    */
   public void setCheckFlag(String checkFlag){
      this.checkFlag = checkFlag;
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
    * getter for BPT_TYPE
    * @generated
    */
   public String getBptType(){
      return this.bptType;
   }
   /**
    * setter for BPT_TYPE
    * @generated
    */
   public void setBptType(String bptType){
      this.bptType = bptType;
   }

   /**
    * getter for BPT_NUM
    * @generated
    */
   public BigDecimal getBptNum(){
      return this.bptNum;
   }
   /**
    * setter for BPT_NUM
    * @generated
    */
   public void setBptNum(BigDecimal bptNum){
      this.bptNum = bptNum;
   }

   /**
    * getter for PENSION_CODE
    * @generated
    */
   public String getPensionCode(){
      return this.pensionCode;
   }
   /**
    * setter for PENSION_CODE
    * @generated
    */
   public void setPensionCode(String pensionCode){
      this.pensionCode = pensionCode;
   }

   /**
    * getter for DOMICILE_ADDRESS
    * @generated
    */
   public String getDomicileAddress(){
      return this.domicileAddress;
   }
   /**
    * setter for DOMICILE_ADDRESS
    * @generated
    */
   public void setDomicileAddress(String domicileAddress){
      this.domicileAddress = domicileAddress;
   }

   /**
    * getter for PHONETIC_CODE
    * @generated
    */
   public String getPhoneticCode(){
      return this.phoneticCode;
   }
   /**
    * setter for PHONETIC_CODE
    * @generated
    */
   public void setPhoneticCode(String phoneticCode){
      this.phoneticCode = phoneticCode;
   }

   /**
    * getter for HANDICAP_NUM
    * @generated
    */
   public String getHandicapNum(){
      return this.handicapNum;
   }
   /**
    * setter for HANDICAP_NUM
    * @generated
    */
   public void setHandicapNum(String handicapNum){
      this.handicapNum = handicapNum;
   }

   /**
    * getter for RETIRED_FLAG
    * @generated
    */
   public String getRetiredFlag(){
      return this.retiredFlag;
   }
   /**
    * setter for RETIRED_FLAG
    * @generated
    */
   public void setRetiredFlag(String retiredFlag){
      this.retiredFlag = retiredFlag;
   }

   /**
    * getter for RETIRED_NO
    * @generated
    */
   public String getRetiredNo(){
      return this.retiredNo;
   }
   /**
    * setter for RETIRED_NO
    * @generated
    */
   public void setRetiredNo(String retiredNo){
      this.retiredNo = retiredNo;
   }

   /**
    * getter for RETIRED_STATE_CODE
    * @generated
    */
   public String getRetiredStateCode(){
      return this.retiredStateCode;
   }
   /**
    * setter for RETIRED_STATE_CODE
    * @generated
    */
   public void setRetiredStateCode(String retiredStateCode){
      this.retiredStateCode = retiredStateCode;
   }

   /**
    * getter for MARTYR_OFFSPRING_FLAG
    * @generated
    */
   public String getMartyrOffspringFlag(){
      return this.martyrOffspringFlag;
   }
   /**
    * setter for MARTYR_OFFSPRING_FLAG
    * @generated
    */
   public void setMartyrOffspringFlag(String martyrOffspringFlag){
      this.martyrOffspringFlag = martyrOffspringFlag;
   }

   /**
    * getter for MARTYR_OFFSPRING_NO
    * @generated
    */
   public String getMartyrOffspringNo(){
      return this.martyrOffspringNo;
   }
   /**
    * setter for MARTYR_OFFSPRING_NO
    * @generated
    */
   public void setMartyrOffspringNo(String martyrOffspringNo){
      this.martyrOffspringNo = martyrOffspringNo;
   }

   /**
    * getter for MARTYR_OFFSPRING_STATE_CODE
    * @generated
    */
   public String getMartyrOffspringStateCode(){
      return this.martyrOffspringStateCode;
   }
   /**
    * setter for MARTYR_OFFSPRING_STATE_CODE
    * @generated
    */
   public void setMartyrOffspringStateCode(String martyrOffspringStateCode){
      this.martyrOffspringStateCode = martyrOffspringStateCode;
   }
public String getApanageName() {
	return apanageName;
}
public void setApanageName(String apanageName) {
	this.apanageName = apanageName;
}

}