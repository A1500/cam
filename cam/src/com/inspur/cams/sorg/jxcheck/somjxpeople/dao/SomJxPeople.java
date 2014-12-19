package com.inspur.cams.sorg.jxcheck.somjxpeople.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:江西人员情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_PEOPLE" , keyFields = "id")
public class SomJxPeople extends StatefulDatabean {
   private String id;
   //TASK_CODE
   private String taskCode;
   //PRACTITIONER_NUM
	@Column(name = "PRACTITIONER_NUM")
   private BigDecimal practitionerNum;
   //FULLTIME_CONTRACT_NUM
	@Column(name = "FULLTIME_CONTRACT_NUM")
   private BigDecimal fulltimeContractNum;
   //RETIRED_NUM
	@Column(name = "RETIRED_NUM")
   private BigDecimal retiredNum;
   //PARTTIME_GOV_NUM
	@Column(name = "PARTTIME_GOV_NUM")
   private BigDecimal parttimeGovNum;
   //ENTERPRISES_NUM
	@Column(name = "ENTERPRISES_NUM")
   private BigDecimal enterprisesNum;
   //OTHER_NUM
	@Column(name = "OTHER_NUM")
   private BigDecimal otherNum;
   //UNDER_THIRTYFIVE_NUM
	@Column(name = "UNDER_THIRTYFIVE_NUM")
   private BigDecimal underThirtyfiveNum;
   //THIRTYSIX_TO_FIFTY_NUM
	@Column(name = "THIRTYSIX_TO_FIFTY_NUM")
   private BigDecimal thirtysixToFiftyNum;
   //FIFTYONE_TO_SIXTY_NUM
	@Column(name = "FIFTYONE_TO_SIXTY_NUM")
   private BigDecimal fiftyoneToSixtyNum;
   //ABOVE_SIXTY_NUM
	@Column(name = "ABOVE_SIXTY_NUM")
   private BigDecimal aboveSixtyNum;
   //UNDER_HIGHSCHOOL_NUM
	@Column(name = "UNDER_HIGHSCHOOL_NUM")
   private BigDecimal underHighschoolNum;
   //UNIVERSITY_NUM
	@Column(name = "UNIVERSITY_NUM")
   private BigDecimal universityNum;
   //ABOVE_MASTER_NUM
	@Column(name = "ABOVE_MASTER_NUM")
   private BigDecimal aboveMasterNum;
   //FROM_ABROAD_NUM
	@Column(name = "FROM_ABROAD_NUM")
   private BigDecimal fromAbroadNum;
   //CASEWORKER_NUM
	@Column(name = "CASEWORKER_NUM")
   private BigDecimal caseworkerNum;
   //VAWIRRMQ_NUM
	@Column(name = "VAWIRRMQ_NUM")
   private BigDecimal vawirrmqNum;
   //ABOVE_COUNTY_NUM
	@Column(name = "ABOVE_COUNTY_NUM")
   private BigDecimal aboveCountyNum;
	
   private BigDecimal partyNumNation;
	
   private BigDecimal partyNumProvince;
   //NPC_NUM
	@Column(name = "NPC_NUM")
   private BigDecimal npcNum;
	
   private BigDecimal npcNumNation;
	   
   private BigDecimal npcNumProvince;
   
   //CPPCC_NUM
	@Column(name = "CPPCC_NUM")
   private BigDecimal cppccNum;
	   
   private BigDecimal cppccNumNation;
	   
   private BigDecimal cppccNumProvince;
   
   //PROVINCIAL_NUM
	@Column(name = "PROVINCIAL_NUM")
   private BigDecimal provincialNum;
   //BOARD_NUM
	@Column(name = "BOARD_NUM")
   private BigDecimal boardNum;
   //CHUJI_NUM
	@Column(name = "CHUJI_NUM")
   private BigDecimal chujiNum;
   //PRINCIPAL_NUM
	@Column(name = "PRINCIPAL_NUM")
   private BigDecimal principalNum;
   //WOMEN_PRINCIPAL_NUM
	@Column(name = "WOMEN_PRINCIPAL_NUM")
   private BigDecimal womenPrincipalNum;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //LEGAL_POLITICAL
	@Column(name = "LEGAL_POLITICAL")
   private String legalPolitical;
   //LEGAL_SEX
	@Column(name = "LEGAL_SEX")
   private String legalSex;
   //LEGAL_EDUCATION
	@Column(name = "LEGAL_EDUCATION")
   private String legalEducation;
   //IF_LEGAL_RETIRED
	@Column(name = "IF_LEGAL_RETIRED")
   private String ifLegalRetired;
   //LEGAL_PHONE
	@Column(name = "LEGAL_PHONE")
   private String legalPhone;
   //LEGAL_MOBILE
	@Column(name = "LEGAL_MOBILE")
   private String legalMobile;
   //IF_LEGAL_FULLTIME
	@Column(name = "IF_LEGAL_FULLTIME")
   private String ifLegalFulltime;
   //LEGAL_WORK_NAME
	@Column(name = "LEGAL_WORK_NAME")
   private String legalWorkName;
   //LEGAL_OTHER_DUTY
	@Column(name = "LEGAL_OTHER_DUTY")
   private String legalOtherDuty;
   //PRESIDENT_NAME
	@Column(name = "PRESIDENT_NAME")
   private String presidentName;
   //PRESIDENT_POLITICAL
	@Column(name = "PRESIDENT_POLITICAL")
   private String presidentPolitical;
   //PRESIDENT_SEX
	@Column(name = "PRESIDENT_SEX")
   private String presidentSex;
   //PRESIDENT_EDUCATION
	@Column(name = "PRESIDENT_EDUCATION")
   private String presidentEducation;
   //IF_PRESIDENT_RETIRED
	@Column(name = "IF_PRESIDENT_RETIRED")
   private String ifPresidentRetired;
   //PRESIDENT_PHONE
	@Column(name = "PRESIDENT_PHONE")
   private String presidentPhone;
   //PRESIDENT_MOBILE
	@Column(name = "PRESIDENT_MOBILE")
   private String presidentMobile;
   //IF_PRESIDENT_FULLTIME
	@Column(name = "IF_PRESIDENT_FULLTIME")
   private String ifPresidentFulltime;
   //PRESIDENT_WORK_NAME
	@Column(name = "PRESIDENT_WORK_NAME")
   private String presidentWorkName;
   //PRESIDENT_OTHER_DUTY
	@Column(name = "PRESIDENT_OTHER_DUTY")
   private String presidentOtherDuty;
   //SECRETARY_NAME
	@Column(name = "SECRETARY_NAME")
   private String secretaryName;
   //SECRETARY_POLITICAL
	@Column(name = "SECRETARY_POLITICAL")
   private String secretaryPolitical;
   //SECRETARY_SEX
	@Column(name = "SECRETARY_SEX")
   private String secretarySex;
   //SECRETARY_EDUCATION
	@Column(name = "SECRETARY_EDUCATION")
   private String secretaryEducation;
   //IF_SECRETARY_RETIRED
	@Column(name = "IF_SECRETARY_RETIRED")
   private String ifSecretaryRetired;
   //SECRETARY_PHONE
	@Column(name = "SECRETARY_PHONE")
   private String secretaryPhone;
   //SECRETARY_MOBILE
	@Column(name = "SECRETARY_MOBILE")
   private String secretaryMobile;
   //IF_SECRETARY_FULLTIME
	@Column(name = "IF_SECRETARY_FULLTIME")
   private String ifSecretaryFulltime;
   //SECRETARY_WORK_NAME
	@Column(name = "SECRETARY_WORK_NAME")
   private String secretaryWorkName;
   //SECRETARY_OTHER_DUTY
	@Column(name = "SECRETARY_OTHER_DUTY")
   private String secretaryOtherDuty;
	
   private BigDecimal retiredProvincialNum;

   private BigDecimal retiredBoardNum;
	
   private BigDecimal retiredChujiNum;
   
   private BigDecimal mgRetiredProvincialNum;
   
   private BigDecimal mgRetiredBoardNum;
   
   private BigDecimal mgRetiredChujiNum;
   
   private BigDecimal mgProvincialNum;
   
   private BigDecimal mgBoardNum;
   
   private BigDecimal mgChujiNum;
   
 private String fulltimeNum;
 private String womanPracNum;
 private String secretaryEmail;
 private String parttimeNum;
 
   public String getParttimeNum() {
	return parttimeNum;
}
public void setParttimeNum(String parttimeNum) {
	this.parttimeNum = parttimeNum;
}
/**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
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
    * getter for PRACTITIONER_NUM
    * @generated
    */
   public BigDecimal getPractitionerNum(){
      return this.practitionerNum;
   }
   /**
    * setter for PRACTITIONER_NUM
    * @generated
    */
   public void setPractitionerNum(BigDecimal practitionerNum){
      this.practitionerNum = practitionerNum;
   }

   /**
    * getter for FULLTIME_CONTRACT_NUM
    * @generated
    */
   public BigDecimal getFulltimeContractNum(){
      return this.fulltimeContractNum;
   }
   /**
    * setter for FULLTIME_CONTRACT_NUM
    * @generated
    */
   public void setFulltimeContractNum(BigDecimal fulltimeContractNum){
      this.fulltimeContractNum = fulltimeContractNum;
   }

   /**
    * getter for RETIRED_NUM
    * @generated
    */
   public BigDecimal getRetiredNum(){
      return this.retiredNum;
   }
   /**
    * setter for RETIRED_NUM
    * @generated
    */
   public void setRetiredNum(BigDecimal retiredNum){
      this.retiredNum = retiredNum;
   }

   /**
    * getter for PARTTIME_GOV_NUM
    * @generated
    */
   public BigDecimal getParttimeGovNum(){
      return this.parttimeGovNum;
   }
   /**
    * setter for PARTTIME_GOV_NUM
    * @generated
    */
   public void setParttimeGovNum(BigDecimal parttimeGovNum){
      this.parttimeGovNum = parttimeGovNum;
   }

   /**
    * getter for ENTERPRISES_NUM
    * @generated
    */
   public BigDecimal getEnterprisesNum(){
      return this.enterprisesNum;
   }
   /**
    * setter for ENTERPRISES_NUM
    * @generated
    */
   public void setEnterprisesNum(BigDecimal enterprisesNum){
      this.enterprisesNum = enterprisesNum;
   }

   /**
    * getter for OTHER_NUM
    * @generated
    */
   public BigDecimal getOtherNum(){
      return this.otherNum;
   }
   /**
    * setter for OTHER_NUM
    * @generated
    */
   public void setOtherNum(BigDecimal otherNum){
      this.otherNum = otherNum;
   }

   /**
    * getter for UNDER_THIRTYFIVE_NUM
    * @generated
    */
   public BigDecimal getUnderThirtyfiveNum(){
      return this.underThirtyfiveNum;
   }
   /**
    * setter for UNDER_THIRTYFIVE_NUM
    * @generated
    */
   public void setUnderThirtyfiveNum(BigDecimal underThirtyfiveNum){
      this.underThirtyfiveNum = underThirtyfiveNum;
   }

   /**
    * getter for THIRTYSIX_TO_FIFTY_NUM
    * @generated
    */
   public BigDecimal getThirtysixToFiftyNum(){
      return this.thirtysixToFiftyNum;
   }
   /**
    * setter for THIRTYSIX_TO_FIFTY_NUM
    * @generated
    */
   public void setThirtysixToFiftyNum(BigDecimal thirtysixToFiftyNum){
      this.thirtysixToFiftyNum = thirtysixToFiftyNum;
   }

   /**
    * getter for FIFTYONE_TO_SIXTY_NUM
    * @generated
    */
   public BigDecimal getFiftyoneToSixtyNum(){
      return this.fiftyoneToSixtyNum;
   }
   /**
    * setter for FIFTYONE_TO_SIXTY_NUM
    * @generated
    */
   public void setFiftyoneToSixtyNum(BigDecimal fiftyoneToSixtyNum){
      this.fiftyoneToSixtyNum = fiftyoneToSixtyNum;
   }

   /**
    * getter for ABOVE_SIXTY_NUM
    * @generated
    */
   public BigDecimal getAboveSixtyNum(){
      return this.aboveSixtyNum;
   }
   /**
    * setter for ABOVE_SIXTY_NUM
    * @generated
    */
   public void setAboveSixtyNum(BigDecimal aboveSixtyNum){
      this.aboveSixtyNum = aboveSixtyNum;
   }

   /**
    * getter for UNDER_HIGHSCHOOL_NUM
    * @generated
    */
   public BigDecimal getUnderHighschoolNum(){
      return this.underHighschoolNum;
   }
   /**
    * setter for UNDER_HIGHSCHOOL_NUM
    * @generated
    */
   public void setUnderHighschoolNum(BigDecimal underHighschoolNum){
      this.underHighschoolNum = underHighschoolNum;
   }

   /**
    * getter for UNIVERSITY_NUM
    * @generated
    */
   public BigDecimal getUniversityNum(){
      return this.universityNum;
   }
   /**
    * setter for UNIVERSITY_NUM
    * @generated
    */
   public void setUniversityNum(BigDecimal universityNum){
      this.universityNum = universityNum;
   }

   /**
    * getter for ABOVE_MASTER_NUM
    * @generated
    */
   public BigDecimal getAboveMasterNum(){
      return this.aboveMasterNum;
   }
   /**
    * setter for ABOVE_MASTER_NUM
    * @generated
    */
   public void setAboveMasterNum(BigDecimal aboveMasterNum){
      this.aboveMasterNum = aboveMasterNum;
   }

   /**
    * getter for FROM_ABROAD_NUM
    * @generated
    */
   public BigDecimal getFromAbroadNum(){
      return this.fromAbroadNum;
   }
   /**
    * setter for FROM_ABROAD_NUM
    * @generated
    */
   public void setFromAbroadNum(BigDecimal fromAbroadNum){
      this.fromAbroadNum = fromAbroadNum;
   }

   /**
    * getter for CASEWORKER_NUM
    * @generated
    */
   public BigDecimal getCaseworkerNum(){
      return this.caseworkerNum;
   }
   /**
    * setter for CASEWORKER_NUM
    * @generated
    */
   public void setCaseworkerNum(BigDecimal caseworkerNum){
      this.caseworkerNum = caseworkerNum;
   }

   /**
    * getter for VAWIRRMQ_NUM
    * @generated
    */
   public BigDecimal getVawirrmqNum(){
      return this.vawirrmqNum;
   }
   /**
    * setter for VAWIRRMQ_NUM
    * @generated
    */
   public void setVawirrmqNum(BigDecimal vawirrmqNum){
      this.vawirrmqNum = vawirrmqNum;
   }

   /**
    * getter for ABOVE_COUNTY_NUM
    * @generated
    */
   public BigDecimal getAboveCountyNum(){
      return this.aboveCountyNum;
   }
   /**
    * setter for ABOVE_COUNTY_NUM
    * @generated
    */
   public void setAboveCountyNum(BigDecimal aboveCountyNum){
      this.aboveCountyNum = aboveCountyNum;
   }

   /**
    * getter for NPC_NUM
    * @generated
    */
   public BigDecimal getNpcNum(){
      return this.npcNum;
   }
   /**
    * setter for NPC_NUM
    * @generated
    */
   public void setNpcNum(BigDecimal npcNum){
      this.npcNum = npcNum;
   }

   /**
    * getter for CPPCC_NUM
    * @generated
    */
   public BigDecimal getCppccNum(){
      return this.cppccNum;
   }
   /**
    * setter for CPPCC_NUM
    * @generated
    */
   public void setCppccNum(BigDecimal cppccNum){
      this.cppccNum = cppccNum;
   }

   /**
    * getter for PROVINCIAL_NUM
    * @generated
    */
   public BigDecimal getProvincialNum(){
      return this.provincialNum;
   }
   /**
    * setter for PROVINCIAL_NUM
    * @generated
    */
   public void setProvincialNum(BigDecimal provincialNum){
      this.provincialNum = provincialNum;
   }

   /**
    * getter for BOARD_NUM
    * @generated
    */
   public BigDecimal getBoardNum(){
      return this.boardNum;
   }
   /**
    * setter for BOARD_NUM
    * @generated
    */
   public void setBoardNum(BigDecimal boardNum){
      this.boardNum = boardNum;
   }

   /**
    * getter for CHUJI_NUM
    * @generated
    */
   public BigDecimal getChujiNum(){
      return this.chujiNum;
   }
   /**
    * setter for CHUJI_NUM
    * @generated
    */
   public void setChujiNum(BigDecimal chujiNum){
      this.chujiNum = chujiNum;
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
    * getter for WOMEN_PRINCIPAL_NUM
    * @generated
    */
   public BigDecimal getWomenPrincipalNum(){
      return this.womenPrincipalNum;
   }
   /**
    * setter for WOMEN_PRINCIPAL_NUM
    * @generated
    */
   public void setWomenPrincipalNum(BigDecimal womenPrincipalNum){
      this.womenPrincipalNum = womenPrincipalNum;
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
    * getter for LEGAL_POLITICAL
    * @generated
    */
   public String getLegalPolitical(){
      return this.legalPolitical;
   }
   /**
    * setter for LEGAL_POLITICAL
    * @generated
    */
   public void setLegalPolitical(String legalPolitical){
      this.legalPolitical = legalPolitical;
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
    * getter for LEGAL_EDUCATION
    * @generated
    */
   public String getLegalEducation(){
      return this.legalEducation;
   }
   /**
    * setter for LEGAL_EDUCATION
    * @generated
    */
   public void setLegalEducation(String legalEducation){
      this.legalEducation = legalEducation;
   }

   /**
    * getter for IF_LEGAL_RETIRED
    * @generated
    */
   public String getIfLegalRetired(){
      return this.ifLegalRetired;
   }
   /**
    * setter for IF_LEGAL_RETIRED
    * @generated
    */
   public void setIfLegalRetired(String ifLegalRetired){
      this.ifLegalRetired = ifLegalRetired;
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
    * getter for LEGAL_MOBILE
    * @generated
    */
   public String getLegalMobile(){
      return this.legalMobile;
   }
   /**
    * setter for LEGAL_MOBILE
    * @generated
    */
   public void setLegalMobile(String legalMobile){
      this.legalMobile = legalMobile;
   }

   /**
    * getter for IF_LEGAL_FULLTIME
    * @generated
    */
   public String getIfLegalFulltime(){
      return this.ifLegalFulltime;
   }
   /**
    * setter for IF_LEGAL_FULLTIME
    * @generated
    */
   public void setIfLegalFulltime(String ifLegalFulltime){
      this.ifLegalFulltime = ifLegalFulltime;
   }

   /**
    * getter for LEGAL_WORK_NAME
    * @generated
    */
   public String getLegalWorkName(){
      return this.legalWorkName;
   }
   /**
    * setter for LEGAL_WORK_NAME
    * @generated
    */
   public void setLegalWorkName(String legalWorkName){
      this.legalWorkName = legalWorkName;
   }

   /**
    * getter for LEGAL_OTHER_DUTY
    * @generated
    */
   public String getLegalOtherDuty(){
      return this.legalOtherDuty;
   }
   /**
    * setter for LEGAL_OTHER_DUTY
    * @generated
    */
   public void setLegalOtherDuty(String legalOtherDuty){
      this.legalOtherDuty = legalOtherDuty;
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
    * getter for PRESIDENT_POLITICAL
    * @generated
    */
   public String getPresidentPolitical(){
      return this.presidentPolitical;
   }
   /**
    * setter for PRESIDENT_POLITICAL
    * @generated
    */
   public void setPresidentPolitical(String presidentPolitical){
      this.presidentPolitical = presidentPolitical;
   }

   /**
    * getter for PRESIDENT_SEX
    * @generated
    */
   public String getPresidentSex(){
      return this.presidentSex;
   }
   /**
    * setter for PRESIDENT_SEX
    * @generated
    */
   public void setPresidentSex(String presidentSex){
      this.presidentSex = presidentSex;
   }

   /**
    * getter for PRESIDENT_EDUCATION
    * @generated
    */
   public String getPresidentEducation(){
      return this.presidentEducation;
   }
   /**
    * setter for PRESIDENT_EDUCATION
    * @generated
    */
   public void setPresidentEducation(String presidentEducation){
      this.presidentEducation = presidentEducation;
   }

   /**
    * getter for IF_PRESIDENT_RETIRED
    * @generated
    */
   public String getIfPresidentRetired(){
      return this.ifPresidentRetired;
   }
   /**
    * setter for IF_PRESIDENT_RETIRED
    * @generated
    */
   public void setIfPresidentRetired(String ifPresidentRetired){
      this.ifPresidentRetired = ifPresidentRetired;
   }

   /**
    * getter for PRESIDENT_PHONE
    * @generated
    */
   public String getPresidentPhone(){
      return this.presidentPhone;
   }
   /**
    * setter for PRESIDENT_PHONE
    * @generated
    */
   public void setPresidentPhone(String presidentPhone){
      this.presidentPhone = presidentPhone;
   }

   /**
    * getter for PRESIDENT_MOBILE
    * @generated
    */
   public String getPresidentMobile(){
      return this.presidentMobile;
   }
   /**
    * setter for PRESIDENT_MOBILE
    * @generated
    */
   public void setPresidentMobile(String presidentMobile){
      this.presidentMobile = presidentMobile;
   }

   /**
    * getter for IF_PRESIDENT_FULLTIME
    * @generated
    */
   public String getIfPresidentFulltime(){
      return this.ifPresidentFulltime;
   }
   /**
    * setter for IF_PRESIDENT_FULLTIME
    * @generated
    */
   public void setIfPresidentFulltime(String ifPresidentFulltime){
      this.ifPresidentFulltime = ifPresidentFulltime;
   }

   /**
    * getter for PRESIDENT_WORK_NAME
    * @generated
    */
   public String getPresidentWorkName(){
      return this.presidentWorkName;
   }
   /**
    * setter for PRESIDENT_WORK_NAME
    * @generated
    */
   public void setPresidentWorkName(String presidentWorkName){
      this.presidentWorkName = presidentWorkName;
   }

   /**
    * getter for PRESIDENT_OTHER_DUTY
    * @generated
    */
   public String getPresidentOtherDuty(){
      return this.presidentOtherDuty;
   }
   /**
    * setter for PRESIDENT_OTHER_DUTY
    * @generated
    */
   public void setPresidentOtherDuty(String presidentOtherDuty){
      this.presidentOtherDuty = presidentOtherDuty;
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
    * getter for SECRETARY_POLITICAL
    * @generated
    */
   public String getSecretaryPolitical(){
      return this.secretaryPolitical;
   }
   /**
    * setter for SECRETARY_POLITICAL
    * @generated
    */
   public void setSecretaryPolitical(String secretaryPolitical){
      this.secretaryPolitical = secretaryPolitical;
   }

   /**
    * getter for SECRETARY_SEX
    * @generated
    */
   public String getSecretarySex(){
      return this.secretarySex;
   }
   /**
    * setter for SECRETARY_SEX
    * @generated
    */
   public void setSecretarySex(String secretarySex){
      this.secretarySex = secretarySex;
   }

   /**
    * getter for SECRETARY_EDUCATION
    * @generated
    */
   public String getSecretaryEducation(){
      return this.secretaryEducation;
   }
   /**
    * setter for SECRETARY_EDUCATION
    * @generated
    */
   public void setSecretaryEducation(String secretaryEducation){
      this.secretaryEducation = secretaryEducation;
   }

   /**
    * getter for IF_SECRETARY_RETIRED
    * @generated
    */
   public String getIfSecretaryRetired(){
      return this.ifSecretaryRetired;
   }
   /**
    * setter for IF_SECRETARY_RETIRED
    * @generated
    */
   public void setIfSecretaryRetired(String ifSecretaryRetired){
      this.ifSecretaryRetired = ifSecretaryRetired;
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
    * getter for IF_SECRETARY_FULLTIME
    * @generated
    */
   public String getIfSecretaryFulltime(){
      return this.ifSecretaryFulltime;
   }
   /**
    * setter for IF_SECRETARY_FULLTIME
    * @generated
    */
   public void setIfSecretaryFulltime(String ifSecretaryFulltime){
      this.ifSecretaryFulltime = ifSecretaryFulltime;
   }

   /**
    * getter for SECRETARY_WORK_NAME
    * @generated
    */
   public String getSecretaryWorkName(){
      return this.secretaryWorkName;
   }
   /**
    * setter for SECRETARY_WORK_NAME
    * @generated
    */
   public void setSecretaryWorkName(String secretaryWorkName){
      this.secretaryWorkName = secretaryWorkName;
   }

   /**
    * getter for SECRETARY_OTHER_DUTY
    * @generated
    */
   public String getSecretaryOtherDuty(){
      return this.secretaryOtherDuty;
   }
   /**
    * setter for SECRETARY_OTHER_DUTY
    * @generated
    */
   public void setSecretaryOtherDuty(String secretaryOtherDuty){
      this.secretaryOtherDuty = secretaryOtherDuty;
   }
public String getSecretaryEmail() {
	return secretaryEmail;
}
public void setSecretaryEmail(String secretaryEmail) {
	this.secretaryEmail = secretaryEmail;
}
public String getFulltimeNum() {
	return fulltimeNum;
}
public void setFulltimeNum(String fulltimeNum) {
	this.fulltimeNum = fulltimeNum;
}
public String getWomanPracNum() {
	return womanPracNum;
}
public void setWomanPracNum(String womanPracNum) {
	this.womanPracNum = womanPracNum;
}
public BigDecimal getPartyNumNation() {
	return partyNumNation;
}
public void setPartyNumNation(BigDecimal partyNumNation) {
	this.partyNumNation = partyNumNation;
}
public BigDecimal getPartyNumProvince() {
	return partyNumProvince;
}
public void setPartyNumProvince(BigDecimal partyNumProvince) {
	this.partyNumProvince = partyNumProvince;
}
public BigDecimal getNpcNumNation() {
	return npcNumNation;
}
public void setNpcNumNation(BigDecimal npcNumNation) {
	this.npcNumNation = npcNumNation;
}
public BigDecimal getNpcNumProvince() {
	return npcNumProvince;
}
public void setNpcNumProvince(BigDecimal npcNumProvince) {
	this.npcNumProvince = npcNumProvince;
}
public BigDecimal getCppccNumNation() {
	return cppccNumNation;
}
public void setCppccNumNation(BigDecimal cppccNumNation) {
	this.cppccNumNation = cppccNumNation;
}
public BigDecimal getCppccNumProvince() {
	return cppccNumProvince;
}
public void setCppccNumProvince(BigDecimal cppccNumProvince) {
	this.cppccNumProvince = cppccNumProvince;
}
public BigDecimal getRetiredProvincialNum() {
	return retiredProvincialNum;
}
public void setRetiredProvincialNum(BigDecimal retiredProvincialNum) {
	this.retiredProvincialNum = retiredProvincialNum;
}
public BigDecimal getRetiredChujiNum() {
	return retiredChujiNum;
}
public void setRetiredChujiNum(BigDecimal retiredChujiNum) {
	this.retiredChujiNum = retiredChujiNum;
}
public BigDecimal getRetiredBoardNum() {
	return retiredBoardNum;
}
public void setRetiredBoardNum(BigDecimal retiredBoardNum) {
	this.retiredBoardNum = retiredBoardNum;
}
public BigDecimal getMgRetiredProvincialNum() {
	return mgRetiredProvincialNum;
}
public void setMgRetiredProvincialNum(BigDecimal mgRetiredProvincialNum) {
	this.mgRetiredProvincialNum = mgRetiredProvincialNum;
}
public BigDecimal getMgRetiredBoardNum() {
	return mgRetiredBoardNum;
}
public void setMgRetiredBoardNum(BigDecimal mgRetiredBoardNum) {
	this.mgRetiredBoardNum = mgRetiredBoardNum;
}
public BigDecimal getMgRetiredChujiNum() {
	return mgRetiredChujiNum;
}
public void setMgRetiredChujiNum(BigDecimal mgRetiredChujiNum) {
	this.mgRetiredChujiNum = mgRetiredChujiNum;
}
public BigDecimal getMgProvincialNum() {
	return mgProvincialNum;
}
public void setMgProvincialNum(BigDecimal mgProvincialNum) {
	this.mgProvincialNum = mgProvincialNum;
}
public BigDecimal getMgBoardNum() {
	return mgBoardNum;
}
public void setMgBoardNum(BigDecimal mgBoardNum) {
	this.mgBoardNum = mgBoardNum;
}
public BigDecimal getMgChujiNum() {
	return mgChujiNum;
}
public void setMgChujiNum(BigDecimal mgChujiNum) {
	this.mgChujiNum = mgChujiNum;
}

}