package com.inspur.cams.sorg.check.somcheck.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheck
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK" , keyFields = "taskCode")
public class SomCheck extends StatefulDatabean {
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //TASK_ID
	@Column(name = "TASK_ID")
   private String taskId;
   //CN_NAME
	@Column(name = "CN_NAME")
   private String cnName;
   //BATCH
	@Column(name = "BATCH")
   private String batch;
   //BATCH_YEAR
	@Column(name = "BATCH_YEAR")
   private String batchYear;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //BORG_NAME
	@Column(name = "BORG_NAME")
   private String borgName;
   //BORG_PHOEN
	@Column(name = "BORG_PHOEN")
   private String borgPhoen;
   //BUSINESS_TYPE
	@Column(name = "BUSINESS_TYPE")
   private String businessType;
   //BUSINESS
	@Column(name = "BUSINESS")
   private String business;
   //ORGAN_CODE
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //BUSINESS_CODE
	@Column(name = "BUSINESS_CODE")
   private String businessCode;
   //SORG_CODE
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //PURPOSE
	@Column(name = "PURPOSE")
   private String purpose;
   //SORG_KIND
	@Column(name = "SORG_KIND")
   private String sorgKind;
   //SPECIAL_FUND
	@Column(name = "SPECIAL_FUND")
   private String specialFund;
   //BUILD_DATE
	@Column(name = "BUILD_DATE")
   private String buildDate;
   //PRACTICE_LISENSE
	@Column(name = "PRACTICE_LISENSE")
   private String practiceLisense;
   //TAX_REG_NUM
	@Column(name = "TAX_REG_NUM")
   private String taxRegNum;
   //REG_MON
	@Column(name = "REG_MON")
   private String regMon;
   //REG_BANK
	@Column(name = "REG_BANK")
   private String regBank;
   //REG_ACCOUNT
	@Column(name = "REG_ACCOUNT")
   private String regAccount;
   //RESIDENCE
	@Column(name = "RESIDENCE")
   private String residence;
   //RESIDE_SOURCE
	@Column(name = "RESIDE_SOURCE")
   private String resideSource;
   //LEASE_PERIOD
	@Column(name = "LEASE_PERIOD")
   private String leasePeriod;
   //SORG_POST
	@Column(name = "SORG_POST")
   private String sorgPost;
   //SORG_PHONE
	@Column(name = "SORG_PHONE")
   private String sorgPhone;
   //SORG_FAX
	@Column(name = "SORG_FAX")
   private String sorgFax;
   //SORG_WEB
	@Column(name = "SORG_WEB")
   private String sorgWeb;
   //SORG_WEB_NAME
	@Column(name = "SORG_WEB_NAME")
   private String sorgWebName;
   //SORG_EMAIL
	@Column(name = "SORG_EMAIL")
   private String sorgEmail;
   //UNITS_NUM
	@Column(name = "UNITS_NUM")
   private String unitsNum;
   //PEOPLE_NUM
	@Column(name = "PEOPLE_NUM")
   private String peopleNum;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //LINKMAN_NAME
	@Column(name = "LINKMAN_NAME")
   private String linkmanName;
   //LINKMAN_DUTY
	@Column(name = "LINKMAN_DUTY")
   private String linkmanDuty;
   //LINKMAN_PHONE
	@Column(name = "LINKMAN_PHONE")
   private String linkmanPhone;
   //LINKMAN_MOBILE
	@Column(name = "LINKMAN_MOBILE")
   private String linkmanMobile;
   //LEGAL_PEOPLE_DUTY
	@Column(name = "LEGAL_PEOPLE_DUTY")
   private String legalPeopleDuty;
   //IF_ADMINISTRATIVE_PENALTY
	@Column(name = "IF_ADMINISTRATIVE_PENALTY")
   private String ifAdministrativePenalty;
   //WORK_SUMMARY
	@Column(name = "WORK_SUMMARY")
   private String workSummary;
   //OTHER_DESC
	@Column(name = "OTHER_DESC")
   private String otherDesc;
   //NEXT_YEAR_PLAN
	@Column(name = "NEXT_YEAR_PLAN")
   private String nextYearPlan;
   //IF_PUBLISH
	@Column(name = "IF_PUBLISH")
   private String ifPublish;
   //BORG_OPINION
	@Column(name = "BORG_OPINION")
   private String borgOpinion;
   //BORG_OPINION_DESC
	@Column(name = "BORG_OPINION_DESC")
   private String borgOpinionDesc;
   //REPORT_DATE
	@Column(name = "REPORT_DATE")
   private String reportDate;
   //CHECK_LEVEL
	@Column(name = "CHECK_LEVEL")
   private String checkLevel;
   //CHECK_RESULT
	@Column(name = "CHECK_RESULT")
   private String checkResult;
   //CHECK_RESULT_DESC
	@Column(name = "CHECK_RESULT_DESC")
   private String checkResultDesc;
   //CHECK_TIME
	@Column(name = "CHECK_TIME")
   private String checkTime;
   //CHECK_PEOPLE
	@Column(name = "CHECK_PEOPLE")
   private String checkPeople;
   //CHECK_ORGAN
	@Column(name = "CHECK_ORGAN")
   private String checkOrgan;
   //BORG_CHECK_DATE
	@Column(name = "BORG_CHECK_DATE")
   private String borgCheckDate;
   //STATUS
	@Column(name = "STATUS")
   private String status;
   //FILL_PEOPLE_ID
	@Column(name = "FILL_PEOPLE_ID")
   private String fillPeopleId;
   //FILL_PEOPLE_NAME
	@Column(name = "FILL_PEOPLE_NAME")
   private String fillPeopleName;
   //COMMIT_TIME
	@Column(name = "COMMIT_TIME")
   private String commitTime;
   //FILL_PEOPLE_AREA
	@Column(name = "FILL_PEOPLE_AREA")
   private String fillPeopleArea;
   //CORRECT_NOT_REASON
	@Column(name = "CORRECT_NOT_REASON")
   private String correctNotReason;
   //CHECK_YEAR
	@Column(name = "CHECK_YEAR")
   private String checkYear;
   //LEGAL_SEX
	@Column(name = "LEGAL_SEX")
   private String legalSex;
   //LEGAL_AGE
   	@Rule(value="number")
	@Column(name = "LEGAL_AGE")
   private BigDecimal legalAge;
   //LEGAL_PHONE
	@Column(name = "LEGAL_PHONE")
   private String legalPhone;
   //DOWN_DATE
	@Column(name = "DOWN_DATE")
   private String downDate;
   //CERT_USEFUL_DATE
	@Column(name = "CERT_USEFUL_DATE")
   private String certUsefulDate;
   //INITIAL_FUND
	@Column(name = "INITIAL_FUND")
   private String initialFund;
   //RESIDENCE_NUM
	@Column(name = "RESIDENCE_NUM")
   private String residenceNum;
   //LINKMAN_ADDRESS
	@Column(name = "LINKMAN_ADDRESS")
   private String linkmanAddress;
   //LINKMAN_POST
	@Column(name = "LINKMAN_POST")
   private String linkmanPost;
   //LINKMAN_ADDRESS_NUM
	@Column(name = "LINKMAN_ADDRESS_NUM")
   private String linkmanAddressNum;
   //PRESIDENT_NAME
	@Column(name = "PRESIDENT_NAME")
   private String presidentName;
   //SECRETARY_NAME
	@Column(name = "SECRETARY_NAME")
   private String secretaryName;
   //SECRETARY_PHONE
	@Column(name = "SECRETARY_PHONE")
   private String secretaryPhone;
   //SECRETARY_MOBILE
	@Column(name = "SECRETARY_MOBILE")
   private String secretaryMobile;
   //SYNDIC_NUM
   	@Rule(value="number")
	@Column(name = "SYNDIC_NUM")
   private BigDecimal syndicNum;
   //AUDITOR_NUM
   	@Rule(value="number")
	@Column(name = "AUDITOR_NUM")
   private BigDecimal auditorNum;
   //PRINCIPAL_NUM
   	@Rule(value="number")
	@Column(name = "PRINCIPAL_NUM")
   private BigDecimal principalNum;
   //PRINCIPAL_GOV_NUM
   	@Rule(value="number")
	@Column(name = "PRINCIPAL_GOV_NUM")
   private BigDecimal principalGovNum;
   //PRINCIPAL_PROVINCE_NUM
   	@Rule(value="number")
	@Column(name = "PRINCIPAL_PROVINCE_NUM")
   private BigDecimal principalProvinceNum;
   //RAMUS_NUM
   	@Rule(value="number")
	@Column(name = "RAMUS_NUM")
   private BigDecimal ramusNum;
   //DELEGATE_NUM
   	@Rule(value="number")
	@Column(name = "DELEGATE_NUM")
   private BigDecimal delegateNum;
   //IF_PUBLICATION
	@Column(name = "IF_PUBLICATION")
   private String ifPublication;
   //PUBLICATION
	@Column(name = "PUBLICATION")
   private String publication;
   //FULLTIME_NUM
   	@Rule(value="number")
	@Column(name = "FULLTIME_NUM")
   private BigDecimal fulltimeNum;
   //POSTULAND_NUM
   	@Rule(value="number")
	@Column(name = "POSTULAND_NUM")
   private BigDecimal postulandNum;
   //POSTULAND_WORK_HOUR
   	@Rule(value="number")
	@Column(name = "POSTULAND_WORK_HOUR")
   private BigDecimal postulandWorkHour;
   //IDENTIFY_CODE
	@Column(name = "IDENTIFY_CODE")
   private String identifyCode;
   //NET_ASSET
	@Column(name = "NET_ASSET")
   private String netAsset;
   //ALL_ASSET
	@Column(name = "ALL_ASSET")
   private String allAsset;
   //WORKER_NUM
   	@Rule(value="number")
	@Column(name = "WORKER_NUM")
   private BigDecimal workerNum;
   //WOMEN_WORKER_NUM
   	@Rule(value="number")
	@Column(name = "WOMEN_WORKER_NUM")
   private BigDecimal womenWorkerNum;
   //ACCOUNT_NUM
	@Column(name = "ACCOUNT_NUM")
   private String accountNum;
   //RULE_TIME_ORGAN
	@Column(name = "RULE_TIME_ORGAN")
   private String ruleTimeOrgan;
   //IN_SCHOOL_NUM
   	@Rule(value="number")
	@Column(name = "IN_SCHOOL_NUM")
   private BigDecimal inSchoolNum;
   //TRAIN_NUM
   	@Rule(value="number")
	@Column(name = "TRAIN_NUM")
   private BigDecimal trainNum;
   //MEDICAL_NUM
   	@Rule(value="number")
	@Column(name = "MEDICAL_NUM")
   private BigDecimal medicalNum;
   //CULTURE_ACTIVITY_NUM
   	@Rule(value="number")
	@Column(name = "CULTURE_ACTIVITY_NUM")
   private BigDecimal cultureActivityNum;
   //CURRENT_ACTIVITY
	@Column(name = "CURRENT_ACTIVITY")
   private String currentActivity;
   //BIG_ACTIVITY_CONDITION
	@Column(name = "BIG_ACTIVITY_CONDITION")
   private String bigActivityCondition;
   //IF_PUTOUT_REPORT
	@Column(name = "IF_PUTOUT_REPORT")
   private String ifPutoutReport;
   //RESULT_AND_LACK
	@Column(name = "RESULT_AND_LACK")
   private String resultAndLack;
   //IF_PUTOUT_VIEW
	@Column(name = "IF_PUTOUT_VIEW")
   private String ifPutoutView;
   //IF_PUTOUT_SYS
	@Column(name = "IF_PUTOUT_SYS")
   private String ifPutoutSys;
   //IF_PUTOUT_WEB
	@Column(name = "IF_PUTOUT_WEB")
   private String ifPutoutWeb;
   //IF_PUTOUT_ADVANCE
	@Column(name = "IF_PUTOUT_ADVANCE")
   private String ifPutoutAdvance;
   //IF_PUTOUT_FUNDS
	@Column(name = "IF_PUTOUT_FUNDS")
   private String ifPutoutFunds;
	
   private String ifPenalty;
   
   private String penaltyTime;
   
   private String penaltyPeople;
   
   private String penaltyOrgan;
   
   //ENGAGED_NUM
   @Column(name = "ENGAGED_NUM")
   private BigDecimal engagedNum;
 //PRACTICE_NUM
   @Column(name = "PRACTICE_NUM")
   private BigDecimal practiceNum;
 //PARTY_MEMBER_NUM
   @Column(name = "PARTY_MEMBER_NUM")
   private BigDecimal partyMemberNum;
   //IF_BUILD_PARTY
	@Column(name = "IF_BUILD_PARTY")
  private String ifBuildParty;
	 //PARTY_TYPE
	@Column(name = "PARTY_TYPE")
   private String partyType;
   //REG_ORGAN_NAME
	@Column(name = "REG_ORGAN_NAME")
	   private String regOrganName;
	
	private String receiveTime;
	
	private String receivePerson;
	
	
	
   public String getRegOrganName() {
		return regOrganName;
	}
	public void setRegOrganName(String regOrganName) {
		this.regOrganName = regOrganName;
	}
public BigDecimal getEngagedNum() {
		return engagedNum;
	}
	public void setEngagedNum(BigDecimal engagedNum) {
		this.engagedNum = engagedNum;
	}
	public BigDecimal getPracticeNum() {
		return practiceNum;
	}
	public void setPracticeNum(BigDecimal practiceNum) {
		this.practiceNum = practiceNum;
	}
	public BigDecimal getPartyMemberNum() {
		return partyMemberNum;
	}
	public void setPartyMemberNum(BigDecimal partyMemberNum) {
		this.partyMemberNum = partyMemberNum;
	}
	public String getIfBuildParty() {
		return ifBuildParty;
	}
	public void setIfBuildParty(String ifBuildParty) {
		this.ifBuildParty = ifBuildParty;
	}
	public String getPartyType() {
		return partyType;
	}
	public void setPartyType(String partyType) {
		this.partyType = partyType;
	}
/**
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for TASK_ID
    * @generated
    */
   public String getTaskId(){
      return this.taskId;
   }
   /**
    * setter for TASK_ID
    * @generated
    */
   public void setTaskId(String taskId){
      this.taskId = taskId;
   }

   /**
    * getter for CN_NAME
    * @generated
    */
   public String getCnName(){
      return this.cnName;
   }
   /**
    * setter for CN_NAME
    * @generated
    */
   public void setCnName(String cnName){
      this.cnName = cnName;
   }

   /**
    * getter for BATCH
    * @generated
    */
   public String getBatch(){
      return this.batch;
   }
   /**
    * setter for BATCH
    * @generated
    */
   public void setBatch(String batch){
      this.batch = batch;
   }

   /**
    * getter for BATCH_YEAR
    * @generated
    */
   public String getBatchYear(){
      return this.batchYear;
   }
   /**
    * setter for BATCH_YEAR
    * @generated
    */
   public void setBatchYear(String batchYear){
      this.batchYear = batchYear;
   }

   /**
    * getter for SORG_TYPE
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for SORG_TYPE
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for BORG_NAME
    * @generated
    */
   public String getBorgName(){
      return this.borgName;
   }
   /**
    * setter for BORG_NAME
    * @generated
    */
   public void setBorgName(String borgName){
      this.borgName = borgName;
   }

   /**
    * getter for BORG_PHOEN
    * @generated
    */
   public String getBorgPhoen(){
      return this.borgPhoen;
   }
   /**
    * setter for BORG_PHOEN
    * @generated
    */
   public void setBorgPhoen(String borgPhoen){
      this.borgPhoen = borgPhoen;
   }

   /**
    * getter for BUSINESS_TYPE
    * @generated
    */
   public String getBusinessType(){
      return this.businessType;
   }
   /**
    * setter for BUSINESS_TYPE
    * @generated
    */
   public void setBusinessType(String businessType){
      this.businessType = businessType;
   }

   /**
    * getter for BUSINESS
    * @generated
    */
   public String getBusiness(){
      return this.business;
   }
   /**
    * setter for BUSINESS
    * @generated
    */
   public void setBusiness(String business){
      this.business = business;
   }

   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for BUSINESS_CODE
    * @generated
    */
   public String getBusinessCode(){
      return this.businessCode;
   }
   /**
    * setter for BUSINESS_CODE
    * @generated
    */
   public void setBusinessCode(String businessCode){
      this.businessCode = businessCode;
   }

   /**
    * getter for SORG_CODE
    * @generated
    */
   public String getSorgCode(){
      return this.sorgCode;
   }
   /**
    * setter for SORG_CODE
    * @generated
    */
   public void setSorgCode(String sorgCode){
      this.sorgCode = sorgCode;
   }

   /**
    * getter for PURPOSE
    * @generated
    */
   public String getPurpose(){
      return this.purpose;
   }
   /**
    * setter for PURPOSE
    * @generated
    */
   public void setPurpose(String purpose){
      this.purpose = purpose;
   }

   /**
    * getter for SORG_KIND
    * @generated
    */
   public String getSorgKind(){
      return this.sorgKind;
   }
   /**
    * setter for SORG_KIND
    * @generated
    */
   public void setSorgKind(String sorgKind){
      this.sorgKind = sorgKind;
   }

   /**
    * getter for SPECIAL_FUND
    * @generated
    */
   public String getSpecialFund(){
      return this.specialFund;
   }
   /**
    * setter for SPECIAL_FUND
    * @generated
    */
   public void setSpecialFund(String specialFund){
      this.specialFund = specialFund;
   }

   /**
    * getter for BUILD_DATE
    * @generated
    */
   public String getBuildDate(){
      return this.buildDate;
   }
   /**
    * setter for BUILD_DATE
    * @generated
    */
   public void setBuildDate(String buildDate){
      this.buildDate = buildDate;
   }

   /**
    * getter for PRACTICE_LISENSE
    * @generated
    */
   public String getPracticeLisense(){
      return this.practiceLisense;
   }
   /**
    * setter for PRACTICE_LISENSE
    * @generated
    */
   public void setPracticeLisense(String practiceLisense){
      this.practiceLisense = practiceLisense;
   }

   /**
    * getter for TAX_REG_NUM
    * @generated
    */
   public String getTaxRegNum(){
      return this.taxRegNum;
   }
   /**
    * setter for TAX_REG_NUM
    * @generated
    */
   public void setTaxRegNum(String taxRegNum){
      this.taxRegNum = taxRegNum;
   }

   /**
    * getter for REG_MON
    * @generated
    */
   public String getRegMon(){
      return this.regMon;
   }
   /**
    * setter for REG_MON
    * @generated
    */
   public void setRegMon(String regMon){
      this.regMon = regMon;
   }

   /**
    * getter for REG_BANK
    * @generated
    */
   public String getRegBank(){
      return this.regBank;
   }
   /**
    * setter for REG_BANK
    * @generated
    */
   public void setRegBank(String regBank){
      this.regBank = regBank;
   }

   /**
    * getter for REG_ACCOUNT
    * @generated
    */
   public String getRegAccount(){
      return this.regAccount;
   }
   /**
    * setter for REG_ACCOUNT
    * @generated
    */
   public void setRegAccount(String regAccount){
      this.regAccount = regAccount;
   }

   /**
    * getter for RESIDENCE
    * @generated
    */
   public String getResidence(){
      return this.residence;
   }
   /**
    * setter for RESIDENCE
    * @generated
    */
   public void setResidence(String residence){
      this.residence = residence;
   }

   /**
    * getter for RESIDE_SOURCE
    * @generated
    */
   public String getResideSource(){
      return this.resideSource;
   }
   /**
    * setter for RESIDE_SOURCE
    * @generated
    */
   public void setResideSource(String resideSource){
      this.resideSource = resideSource;
   }

   /**
    * getter for LEASE_PERIOD
    * @generated
    */
   public String getLeasePeriod(){
      return this.leasePeriod;
   }
   /**
    * setter for LEASE_PERIOD
    * @generated
    */
   public void setLeasePeriod(String leasePeriod){
      this.leasePeriod = leasePeriod;
   }

   /**
    * getter for SORG_POST
    * @generated
    */
   public String getSorgPost(){
      return this.sorgPost;
   }
   /**
    * setter for SORG_POST
    * @generated
    */
   public void setSorgPost(String sorgPost){
      this.sorgPost = sorgPost;
   }

   /**
    * getter for SORG_PHONE
    * @generated
    */
   public String getSorgPhone(){
      return this.sorgPhone;
   }
   /**
    * setter for SORG_PHONE
    * @generated
    */
   public void setSorgPhone(String sorgPhone){
      this.sorgPhone = sorgPhone;
   }

   /**
    * getter for SORG_FAX
    * @generated
    */
   public String getSorgFax(){
      return this.sorgFax;
   }
   /**
    * setter for SORG_FAX
    * @generated
    */
   public void setSorgFax(String sorgFax){
      this.sorgFax = sorgFax;
   }

   /**
    * getter for SORG_WEB
    * @generated
    */
   public String getSorgWeb(){
      return this.sorgWeb;
   }
   /**
    * setter for SORG_WEB
    * @generated
    */
   public void setSorgWeb(String sorgWeb){
      this.sorgWeb = sorgWeb;
   }

   /**
    * getter for SORG_WEB_NAME
    * @generated
    */
   public String getSorgWebName(){
      return this.sorgWebName;
   }
   /**
    * setter for SORG_WEB_NAME
    * @generated
    */
   public void setSorgWebName(String sorgWebName){
      this.sorgWebName = sorgWebName;
   }

   /**
    * getter for SORG_EMAIL
    * @generated
    */
   public String getSorgEmail(){
      return this.sorgEmail;
   }
   /**
    * setter for SORG_EMAIL
    * @generated
    */
   public void setSorgEmail(String sorgEmail){
      this.sorgEmail = sorgEmail;
   }

   /**
    * getter for UNITS_NUM
    * @generated
    */
   public String getUnitsNum(){
      return this.unitsNum;
   }
   /**
    * setter for UNITS_NUM
    * @generated
    */
   public void setUnitsNum(String unitsNum){
      this.unitsNum = unitsNum;
   }

   /**
    * getter for PEOPLE_NUM
    * @generated
    */
   public String getPeopleNum(){
      return this.peopleNum;
   }
   /**
    * setter for PEOPLE_NUM
    * @generated
    */
   public void setPeopleNum(String peopleNum){
      this.peopleNum = peopleNum;
   }

   /**
    * getter for LEGAL_PEOPLE
    * @generated
    */
   public String getLegalPeople(){
      return this.legalPeople;
   }
   /**
    * setter for LEGAL_PEOPLE
    * @generated
    */
   public void setLegalPeople(String legalPeople){
      this.legalPeople = legalPeople;
   }

   /**
    * getter for LINKMAN_NAME
    * @generated
    */
   public String getLinkmanName(){
      return this.linkmanName;
   }
   /**
    * setter for LINKMAN_NAME
    * @generated
    */
   public void setLinkmanName(String linkmanName){
      this.linkmanName = linkmanName;
   }

   /**
    * getter for LINKMAN_DUTY
    * @generated
    */
   public String getLinkmanDuty(){
      return this.linkmanDuty;
   }
   /**
    * setter for LINKMAN_DUTY
    * @generated
    */
   public void setLinkmanDuty(String linkmanDuty){
      this.linkmanDuty = linkmanDuty;
   }

   /**
    * getter for LINKMAN_PHONE
    * @generated
    */
   public String getLinkmanPhone(){
      return this.linkmanPhone;
   }
   /**
    * setter for LINKMAN_PHONE
    * @generated
    */
   public void setLinkmanPhone(String linkmanPhone){
      this.linkmanPhone = linkmanPhone;
   }

   /**
    * getter for LINKMAN_MOBILE
    * @generated
    */
   public String getLinkmanMobile(){
      return this.linkmanMobile;
   }
   /**
    * setter for LINKMAN_MOBILE
    * @generated
    */
   public void setLinkmanMobile(String linkmanMobile){
      this.linkmanMobile = linkmanMobile;
   }

   /**
    * getter for LEGAL_PEOPLE_DUTY
    * @generated
    */
   public String getLegalPeopleDuty(){
      return this.legalPeopleDuty;
   }
   /**
    * setter for LEGAL_PEOPLE_DUTY
    * @generated
    */
   public void setLegalPeopleDuty(String legalPeopleDuty){
      this.legalPeopleDuty = legalPeopleDuty;
   }

   /**
    * getter for IF_ADMINISTRATIVE_PENALTY
    * @generated
    */
   public String getIfAdministrativePenalty(){
      return this.ifAdministrativePenalty;
   }
   /**
    * setter for IF_ADMINISTRATIVE_PENALTY
    * @generated
    */
   public void setIfAdministrativePenalty(String ifAdministrativePenalty){
      this.ifAdministrativePenalty = ifAdministrativePenalty;
   }

   /**
    * getter for WORK_SUMMARY
    * @generated
    */
   public String getWorkSummary(){
      return this.workSummary;
   }
   /**
    * setter for WORK_SUMMARY
    * @generated
    */
   public void setWorkSummary(String workSummary){
      this.workSummary = workSummary;
   }

   /**
    * getter for OTHER_DESC
    * @generated
    */
   public String getOtherDesc(){
      return this.otherDesc;
   }
   /**
    * setter for OTHER_DESC
    * @generated
    */
   public void setOtherDesc(String otherDesc){
      this.otherDesc = otherDesc;
   }

   /**
    * getter for NEXT_YEAR_PLAN
    * @generated
    */
   public String getNextYearPlan(){
      return this.nextYearPlan;
   }
   /**
    * setter for NEXT_YEAR_PLAN
    * @generated
    */
   public void setNextYearPlan(String nextYearPlan){
      this.nextYearPlan = nextYearPlan;
   }

   /**
    * getter for IF_PUBLISH
    * @generated
    */
   public String getIfPublish(){
      return this.ifPublish;
   }
   /**
    * setter for IF_PUBLISH
    * @generated
    */
   public void setIfPublish(String ifPublish){
      this.ifPublish = ifPublish;
   }

   /**
    * getter for BORG_OPINION
    * @generated
    */
   public String getBorgOpinion(){
      return this.borgOpinion;
   }
   /**
    * setter for BORG_OPINION
    * @generated
    */
   public void setBorgOpinion(String borgOpinion){
      this.borgOpinion = borgOpinion;
   }

   /**
    * getter for BORG_OPINION_DESC
    * @generated
    */
   public String getBorgOpinionDesc(){
      return this.borgOpinionDesc;
   }
   /**
    * setter for BORG_OPINION_DESC
    * @generated
    */
   public void setBorgOpinionDesc(String borgOpinionDesc){
      this.borgOpinionDesc = borgOpinionDesc;
   }

   /**
    * getter for REPORT_DATE
    * @generated
    */
   public String getReportDate(){
      return this.reportDate;
   }
   /**
    * setter for REPORT_DATE
    * @generated
    */
   public void setReportDate(String reportDate){
      this.reportDate = reportDate;
   }

   /**
    * getter for CHECK_LEVEL
    * @generated
    */
   public String getCheckLevel(){
      return this.checkLevel;
   }
   /**
    * setter for CHECK_LEVEL
    * @generated
    */
   public void setCheckLevel(String checkLevel){
      this.checkLevel = checkLevel;
   }

   /**
    * getter for CHECK_RESULT
    * @generated
    */
   public String getCheckResult(){
      return this.checkResult;
   }
   /**
    * setter for CHECK_RESULT
    * @generated
    */
   public void setCheckResult(String checkResult){
      this.checkResult = checkResult;
   }

   /**
    * getter for CHECK_RESULT_DESC
    * @generated
    */
   public String getCheckResultDesc(){
      return this.checkResultDesc;
   }
   /**
    * setter for CHECK_RESULT_DESC
    * @generated
    */
   public void setCheckResultDesc(String checkResultDesc){
      this.checkResultDesc = checkResultDesc;
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
    * getter for CHECK_ORGAN
    * @generated
    */
   public String getCheckOrgan(){
      return this.checkOrgan;
   }
   /**
    * setter for CHECK_ORGAN
    * @generated
    */
   public void setCheckOrgan(String checkOrgan){
      this.checkOrgan = checkOrgan;
   }

   /**
    * getter for BORG_CHECK_DATE
    * @generated
    */
   public String getBorgCheckDate(){
      return this.borgCheckDate;
   }
   /**
    * setter for BORG_CHECK_DATE
    * @generated
    */
   public void setBorgCheckDate(String borgCheckDate){
      this.borgCheckDate = borgCheckDate;
   }

   /**
    * getter for STATUS
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for STATUS
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for FILL_PEOPLE_ID
    * @generated
    */
   public String getFillPeopleId(){
      return this.fillPeopleId;
   }
   /**
    * setter for FILL_PEOPLE_ID
    * @generated
    */
   public void setFillPeopleId(String fillPeopleId){
      this.fillPeopleId = fillPeopleId;
   }

   /**
    * getter for FILL_PEOPLE_NAME
    * @generated
    */
   public String getFillPeopleName(){
      return this.fillPeopleName;
   }
   /**
    * setter for FILL_PEOPLE_NAME
    * @generated
    */
   public void setFillPeopleName(String fillPeopleName){
      this.fillPeopleName = fillPeopleName;
   }

   /**
    * getter for COMMIT_TIME
    * @generated
    */
   public String getCommitTime(){
      return this.commitTime;
   }
   /**
    * setter for COMMIT_TIME
    * @generated
    */
   public void setCommitTime(String commitTime){
      this.commitTime = commitTime;
   }

   /**
    * getter for FILL_PEOPLE_AREA
    * @generated
    */
   public String getFillPeopleArea(){
      return this.fillPeopleArea;
   }
   /**
    * setter for FILL_PEOPLE_AREA
    * @generated
    */
   public void setFillPeopleArea(String fillPeopleArea){
      this.fillPeopleArea = fillPeopleArea;
   }

   /**
    * getter for CORRECT_NOT_REASON
    * @generated
    */
   public String getCorrectNotReason(){
      return this.correctNotReason;
   }
   /**
    * setter for CORRECT_NOT_REASON
    * @generated
    */
   public void setCorrectNotReason(String correctNotReason){
      this.correctNotReason = correctNotReason;
   }

   /**
    * getter for CHECK_YEAR
    * @generated
    */
   public String getCheckYear(){
      return this.checkYear;
   }
   /**
    * setter for CHECK_YEAR
    * @generated
    */
   public void setCheckYear(String checkYear){
      this.checkYear = checkYear;
   }

   /**
    * getter for LEGAL_SEX
    * @generated
    */
   public String getLegalSex(){
      return this.legalSex;
   }
   /**
    * setter for LEGAL_SEX
    * @generated
    */
   public void setLegalSex(String legalSex){
      this.legalSex = legalSex;
   }

   /**
    * getter for LEGAL_AGE
    * @generated
    */
   public BigDecimal getLegalAge(){
      return this.legalAge;
   }
   /**
    * setter for LEGAL_AGE
    * @generated
    */
   public void setLegalAge(BigDecimal legalAge){
      this.legalAge = legalAge;
   }

   /**
    * getter for LEGAL_PHONE
    * @generated
    */
   public String getLegalPhone(){
      return this.legalPhone;
   }
   /**
    * setter for LEGAL_PHONE
    * @generated
    */
   public void setLegalPhone(String legalPhone){
      this.legalPhone = legalPhone;
   }

   /**
    * getter for DOWN_DATE
    * @generated
    */
   public String getDownDate(){
      return this.downDate;
   }
   /**
    * setter for DOWN_DATE
    * @generated
    */
   public void setDownDate(String downDate){
      this.downDate = downDate;
   }

   /**
    * getter for CERT_USEFUL_DATE
    * @generated
    */
   public String getCertUsefulDate(){
      return this.certUsefulDate;
   }
   /**
    * setter for CERT_USEFUL_DATE
    * @generated
    */
   public void setCertUsefulDate(String certUsefulDate){
      this.certUsefulDate = certUsefulDate;
   }

   /**
    * getter for INITIAL_FUND
    * @generated
    */
   public String getInitialFund(){
      return this.initialFund;
   }
   /**
    * setter for INITIAL_FUND
    * @generated
    */
   public void setInitialFund(String initialFund){
      this.initialFund = initialFund;
   }

   /**
    * getter for RESIDENCE_NUM
    * @generated
    */
   public String getResidenceNum(){
      return this.residenceNum;
   }
   /**
    * setter for RESIDENCE_NUM
    * @generated
    */
   public void setResidenceNum(String residenceNum){
      this.residenceNum = residenceNum;
   }

   /**
    * getter for LINKMAN_ADDRESS
    * @generated
    */
   public String getLinkmanAddress(){
      return this.linkmanAddress;
   }
   /**
    * setter for LINKMAN_ADDRESS
    * @generated
    */
   public void setLinkmanAddress(String linkmanAddress){
      this.linkmanAddress = linkmanAddress;
   }

   /**
    * getter for LINKMAN_POST
    * @generated
    */
   public String getLinkmanPost(){
      return this.linkmanPost;
   }
   /**
    * setter for LINKMAN_POST
    * @generated
    */
   public void setLinkmanPost(String linkmanPost){
      this.linkmanPost = linkmanPost;
   }

   /**
    * getter for LINKMAN_ADDRESS_NUM
    * @generated
    */
   public String getLinkmanAddressNum(){
      return this.linkmanAddressNum;
   }
   /**
    * setter for LINKMAN_ADDRESS_NUM
    * @generated
    */
   public void setLinkmanAddressNum(String linkmanAddressNum){
      this.linkmanAddressNum = linkmanAddressNum;
   }

   /**
    * getter for PRESIDENT_NAME
    * @generated
    */
   public String getPresidentName(){
      return this.presidentName;
   }
   /**
    * setter for PRESIDENT_NAME
    * @generated
    */
   public void setPresidentName(String presidentName){
      this.presidentName = presidentName;
   }

   /**
    * getter for SECRETARY_NAME
    * @generated
    */
   public String getSecretaryName(){
      return this.secretaryName;
   }
   /**
    * setter for SECRETARY_NAME
    * @generated
    */
   public void setSecretaryName(String secretaryName){
      this.secretaryName = secretaryName;
   }

   /**
    * getter for SECRETARY_PHONE
    * @generated
    */
   public String getSecretaryPhone(){
      return this.secretaryPhone;
   }
   /**
    * setter for SECRETARY_PHONE
    * @generated
    */
   public void setSecretaryPhone(String secretaryPhone){
      this.secretaryPhone = secretaryPhone;
   }

   /**
    * getter for SECRETARY_MOBILE
    * @generated
    */
   public String getSecretaryMobile(){
      return this.secretaryMobile;
   }
   /**
    * setter for SECRETARY_MOBILE
    * @generated
    */
   public void setSecretaryMobile(String secretaryMobile){
      this.secretaryMobile = secretaryMobile;
   }

   /**
    * getter for SYNDIC_NUM
    * @generated
    */
   public BigDecimal getSyndicNum(){
      return this.syndicNum;
   }
   /**
    * setter for SYNDIC_NUM
    * @generated
    */
   public void setSyndicNum(BigDecimal syndicNum){
      this.syndicNum = syndicNum;
   }

   /**
    * getter for AUDITOR_NUM
    * @generated
    */
   public BigDecimal getAuditorNum(){
      return this.auditorNum;
   }
   /**
    * setter for AUDITOR_NUM
    * @generated
    */
   public void setAuditorNum(BigDecimal auditorNum){
      this.auditorNum = auditorNum;
   }

   /**
    * getter for PRINCIPAL_NUM
    * @generated
    */
   public BigDecimal getPrincipalNum(){
      return this.principalNum;
   }
   /**
    * setter for PRINCIPAL_NUM
    * @generated
    */
   public void setPrincipalNum(BigDecimal principalNum){
      this.principalNum = principalNum;
   }

   /**
    * getter for PRINCIPAL_GOV_NUM
    * @generated
    */
   public BigDecimal getPrincipalGovNum(){
      return this.principalGovNum;
   }
   /**
    * setter for PRINCIPAL_GOV_NUM
    * @generated
    */
   public void setPrincipalGovNum(BigDecimal principalGovNum){
      this.principalGovNum = principalGovNum;
   }

   /**
    * getter for PRINCIPAL_PROVINCE_NUM
    * @generated
    */
   public BigDecimal getPrincipalProvinceNum(){
      return this.principalProvinceNum;
   }
   /**
    * setter for PRINCIPAL_PROVINCE_NUM
    * @generated
    */
   public void setPrincipalProvinceNum(BigDecimal principalProvinceNum){
      this.principalProvinceNum = principalProvinceNum;
   }

   /**
    * getter for RAMUS_NUM
    * @generated
    */
   public BigDecimal getRamusNum(){
      return this.ramusNum;
   }
   /**
    * setter for RAMUS_NUM
    * @generated
    */
   public void setRamusNum(BigDecimal ramusNum){
      this.ramusNum = ramusNum;
   }

   /**
    * getter for DELEGATE_NUM
    * @generated
    */
   public BigDecimal getDelegateNum(){
      return this.delegateNum;
   }
   /**
    * setter for DELEGATE_NUM
    * @generated
    */
   public void setDelegateNum(BigDecimal delegateNum){
      this.delegateNum = delegateNum;
   }

   /**
    * getter for IF_PUBLICATION
    * @generated
    */
   public String getIfPublication(){
      return this.ifPublication;
   }
   /**
    * setter for IF_PUBLICATION
    * @generated
    */
   public void setIfPublication(String ifPublication){
      this.ifPublication = ifPublication;
   }

   /**
    * getter for PUBLICATION
    * @generated
    */
   public String getPublication(){
      return this.publication;
   }
   /**
    * setter for PUBLICATION
    * @generated
    */
   public void setPublication(String publication){
      this.publication = publication;
   }

   /**
    * getter for FULLTIME_NUM
    * @generated
    */
   public BigDecimal getFulltimeNum(){
      return this.fulltimeNum;
   }
   /**
    * setter for FULLTIME_NUM
    * @generated
    */
   public void setFulltimeNum(BigDecimal fulltimeNum){
      this.fulltimeNum = fulltimeNum;
   }

   /**
    * getter for POSTULAND_NUM
    * @generated
    */
   public BigDecimal getPostulandNum(){
      return this.postulandNum;
   }
   /**
    * setter for POSTULAND_NUM
    * @generated
    */
   public void setPostulandNum(BigDecimal postulandNum){
      this.postulandNum = postulandNum;
   }

   /**
    * getter for POSTULAND_WORK_HOUR
    * @generated
    */
   public BigDecimal getPostulandWorkHour(){
      return this.postulandWorkHour;
   }
   /**
    * setter for POSTULAND_WORK_HOUR
    * @generated
    */
   public void setPostulandWorkHour(BigDecimal postulandWorkHour){
      this.postulandWorkHour = postulandWorkHour;
   }

   /**
    * getter for IDENTIFY_CODE
    * @generated
    */
   public String getIdentifyCode(){
      return this.identifyCode;
   }
   /**
    * setter for IDENTIFY_CODE
    * @generated
    */
   public void setIdentifyCode(String identifyCode){
      this.identifyCode = identifyCode;
   }

   /**
    * getter for NET_ASSET
    * @generated
    */
   public String getNetAsset(){
      return this.netAsset;
   }
   /**
    * setter for NET_ASSET
    * @generated
    */
   public void setNetAsset(String netAsset){
      this.netAsset = netAsset;
   }

   /**
    * getter for ALL_ASSET
    * @generated
    */
   public String getAllAsset(){
      return this.allAsset;
   }
   /**
    * setter for ALL_ASSET
    * @generated
    */
   public void setAllAsset(String allAsset){
      this.allAsset = allAsset;
   }

   /**
    * getter for WORKER_NUM
    * @generated
    */
   public BigDecimal getWorkerNum(){
      return this.workerNum;
   }
   /**
    * setter for WORKER_NUM
    * @generated
    */
   public void setWorkerNum(BigDecimal workerNum){
      this.workerNum = workerNum;
   }

   /**
    * getter for WOMEN_WORKER_NUM
    * @generated
    */
   public BigDecimal getWomenWorkerNum(){
      return this.womenWorkerNum;
   }
   /**
    * setter for WOMEN_WORKER_NUM
    * @generated
    */
   public void setWomenWorkerNum(BigDecimal womenWorkerNum){
      this.womenWorkerNum = womenWorkerNum;
   }

   /**
    * getter for ACCOUNT_NUM
    * @generated
    */
   public String getAccountNum(){
      return this.accountNum;
   }
   /**
    * setter for ACCOUNT_NUM
    * @generated
    */
   public void setAccountNum(String accountNum){
      this.accountNum = accountNum;
   }

   /**
    * getter for RULE_TIME_ORGAN
    * @generated
    */
   public String getRuleTimeOrgan(){
      return this.ruleTimeOrgan;
   }
   /**
    * setter for RULE_TIME_ORGAN
    * @generated
    */
   public void setRuleTimeOrgan(String ruleTimeOrgan){
      this.ruleTimeOrgan = ruleTimeOrgan;
   }

   /**
    * getter for IN_SCHOOL_NUM
    * @generated
    */
   public BigDecimal getInSchoolNum(){
      return this.inSchoolNum;
   }
   /**
    * setter for IN_SCHOOL_NUM
    * @generated
    */
   public void setInSchoolNum(BigDecimal inSchoolNum){
      this.inSchoolNum = inSchoolNum;
   }

   /**
    * getter for TRAIN_NUM
    * @generated
    */
   public BigDecimal getTrainNum(){
      return this.trainNum;
   }
   /**
    * setter for TRAIN_NUM
    * @generated
    */
   public void setTrainNum(BigDecimal trainNum){
      this.trainNum = trainNum;
   }

   /**
    * getter for MEDICAL_NUM
    * @generated
    */
   public BigDecimal getMedicalNum(){
      return this.medicalNum;
   }
   /**
    * setter for MEDICAL_NUM
    * @generated
    */
   public void setMedicalNum(BigDecimal medicalNum){
      this.medicalNum = medicalNum;
   }

   /**
    * getter for CULTURE_ACTIVITY_NUM
    * @generated
    */
   public BigDecimal getCultureActivityNum(){
      return this.cultureActivityNum;
   }
   /**
    * setter for CULTURE_ACTIVITY_NUM
    * @generated
    */
   public void setCultureActivityNum(BigDecimal cultureActivityNum){
      this.cultureActivityNum = cultureActivityNum;
   }

   /**
    * getter for CURRENT_ACTIVITY
    * @generated
    */
   public String getCurrentActivity(){
      return this.currentActivity;
   }
   /**
    * setter for CURRENT_ACTIVITY
    * @generated
    */
   public void setCurrentActivity(String currentActivity){
      this.currentActivity = currentActivity;
   }

   /**
    * getter for BIG_ACTIVITY_CONDITION
    * @generated
    */
   public String getBigActivityCondition(){
      return this.bigActivityCondition;
   }
   /**
    * setter for BIG_ACTIVITY_CONDITION
    * @generated
    */
   public void setBigActivityCondition(String bigActivityCondition){
      this.bigActivityCondition = bigActivityCondition;
   }

   /**
    * getter for IF_PUTOUT_REPORT
    * @generated
    */
   public String getIfPutoutReport(){
      return this.ifPutoutReport;
   }
   /**
    * setter for IF_PUTOUT_REPORT
    * @generated
    */
   public void setIfPutoutReport(String ifPutoutReport){
      this.ifPutoutReport = ifPutoutReport;
   }

   /**
    * getter for RESULT_AND_LACK
    * @generated
    */
   public String getResultAndLack(){
      return this.resultAndLack;
   }
   /**
    * setter for RESULT_AND_LACK
    * @generated
    */
   public void setResultAndLack(String resultAndLack){
      this.resultAndLack = resultAndLack;
   }

   /**
    * getter for IF_PUTOUT_VIEW
    * @generated
    */
   public String getIfPutoutView(){
      return this.ifPutoutView;
   }
   /**
    * setter for IF_PUTOUT_VIEW
    * @generated
    */
   public void setIfPutoutView(String ifPutoutView){
      this.ifPutoutView = ifPutoutView;
   }

   /**
    * getter for IF_PUTOUT_SYS
    * @generated
    */
   public String getIfPutoutSys(){
      return this.ifPutoutSys;
   }
   /**
    * setter for IF_PUTOUT_SYS
    * @generated
    */
   public void setIfPutoutSys(String ifPutoutSys){
      this.ifPutoutSys = ifPutoutSys;
   }

   /**
    * getter for IF_PUTOUT_WEB
    * @generated
    */
   public String getIfPutoutWeb(){
      return this.ifPutoutWeb;
   }
   /**
    * setter for IF_PUTOUT_WEB
    * @generated
    */
   public void setIfPutoutWeb(String ifPutoutWeb){
      this.ifPutoutWeb = ifPutoutWeb;
   }

   /**
    * getter for IF_PUTOUT_ADVANCE
    * @generated
    */
   public String getIfPutoutAdvance(){
      return this.ifPutoutAdvance;
   }
   /**
    * setter for IF_PUTOUT_ADVANCE
    * @generated
    */
   public void setIfPutoutAdvance(String ifPutoutAdvance){
      this.ifPutoutAdvance = ifPutoutAdvance;
   }

   /**
    * getter for IF_PUTOUT_FUNDS
    * @generated
    */
   public String getIfPutoutFunds(){
      return this.ifPutoutFunds;
   }
   /**
    * setter for IF_PUTOUT_FUNDS
    * @generated
    */
   public void setIfPutoutFunds(String ifPutoutFunds){
      this.ifPutoutFunds = ifPutoutFunds;
   }
public String getIfPenalty() {
	return ifPenalty;
}
public void setIfPenalty(String ifPenalty) {
	this.ifPenalty = ifPenalty;
}
public String getPenaltyTime() {
	return penaltyTime;
}
public void setPenaltyTime(String penaltyTime) {
	this.penaltyTime = penaltyTime;
}
public String getPenaltyPeople() {
	return penaltyPeople;
}
public void setPenaltyPeople(String penaltyPeople) {
	this.penaltyPeople = penaltyPeople;
}
public String getPenaltyOrgan() {
	return penaltyOrgan;
}
public void setPenaltyOrgan(String penaltyOrgan) {
	this.penaltyOrgan = penaltyOrgan;
}
public String getReceiveTime() {
	return receiveTime;
}
public void setReceiveTime(String receiveTime) {
	this.receiveTime = receiveTime;
}
public String getReceivePerson() {
	return receivePerson;
}
public void setReceivePerson(String receivePerson) {
	this.receivePerson = receivePerson;
}

}