package com.inspur.cams.sorg.check.somcheckparty.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckParty
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_PARTY" , keyFields = "id")
public class SomCheckParty extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //IF_BUILD_PARTY
	@Column(name = "IF_BUILD_PARTY")
   private String ifBuildParty;
   //NO_BUILD_PARTY_RESON
	@Column(name = "NO_BUILD_PARTY_RESON")
   private String noBuildPartyReson;
   //PARTY_MEMBER_TOTAL
   	@Rule(value="number")
	@Column(name = "PARTY_MEMBER_TOTAL")
   private BigDecimal partyMemberTotal;
   //PARTY_PRACTITIONER_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_PRACTITIONER_NUM")
   private BigDecimal partyPractitionerNum;
   //PARTY_FULL_TIME_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_FULL_TIME_NUM")
   private BigDecimal partyFullTimeNum;
   //NEW_PARTY_PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "NEW_PARTY_PEOPLE_NUM")
   private BigDecimal newPartyPeopleNum;
   //LEGAL_PARTY_NUM
   	@Rule(value="number")
	@Column(name = "LEGAL_PARTY_NUM")
   private BigDecimal legalPartyNum;
   //PARTY_UNDER_THIRTY_FIVE_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_UNDER_THIRTY_FIVE_NUM")
   private BigDecimal partyUnderThirtyFiveNum;
   //PARTY_ABOVE_THIRTY_FIVE_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_ABOVE_THIRTY_FIVE_NUM")
   private BigDecimal partyAboveThirtyFiveNum;
   //PARTY_UNDER_SIXTY_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_UNDER_SIXTY_NUM")
   private BigDecimal partyUnderSixtyNum;
   //PARTY_ABOVE_SIXTY_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_ABOVE_SIXTY_NUM")
   private BigDecimal partyAboveSixtyNum;
   //PARTY_SENIOR_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_SENIOR_NUM")
   private BigDecimal partySeniorNum;
   //PARTY_BACHELOR_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_BACHELOR_NUM")
   private BigDecimal partyBachelorNum;
   //PARTY_MASTER_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_MASTER_NUM")
   private BigDecimal partyMasterNum;
   //PARTY_ABROAD_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_ABROAD_NUM")
   private BigDecimal partyAbroadNum;
   //PARTY_WORK_SPACE_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_WORK_SPACE_NUM")
   private BigDecimal partyWorkSpaceNum;
   //PARTY_OTHER_SUBJECTION_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_OTHER_SUBJECTION_NUM")
   private BigDecimal partyOtherSubjectionNum;
   //PARTY_OFFICER_NAME
	@Column(name = "PARTY_OFFICER_NAME")
   private String partyOfficerName;
   //PARTY_OFFICER_CONTACT
	@Column(name = "PARTY_OFFICER_CONTACT")
   private String partyOfficerContact;
   //PARTY_PARTY_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_PARTY_NUM")
   private BigDecimal partyPartyNum;
   //PARTY_BORG_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_BORG_NUM")
   private BigDecimal partyBorgNum;
   //PARTY_LINKED_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_LINKED_NUM")
   private BigDecimal partyLinkedNum;
   //PARTY_COLONY_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_COLONY_NUM")
   private BigDecimal partyColonyNum;
   //PARTY_TYPE
	@Column(name = "PARTY_TYPE")
   private String partyType;
   //PARTY_RELATION_TYPE
	@Column(name = "PARTY_RELATION_TYPE")
   private String partyRelationType;
   //PARTY_ACTIVITY_MON
	@Column(name = "PARTY_ACTIVITY_MON")
   private String partyActivityMon;
   //PARTY_DUES_MON
	@Column(name = "PARTY_DUES_MON")
   private String partyDuesMon;
   //PARTY_SUPPORT_MON
	@Column(name = "PARTY_SUPPORT_MON")
   private String partySupportMon;
   //PARTY_BUSINESS_MON
	@Column(name = "PARTY_BUSINESS_MON")
   private String partyBusinessMon;
   //PARTY_FINANCE_MON
	@Column(name = "PARTY_FINANCE_MON")
   private String partyFinanceMon;
   //PARTY_OTHER_MON
	@Column(name = "PARTY_OTHER_MON")
   private String partyOtherMon;
   //PARTY_TYPE_OTHER
	@Column(name = "PARTY_TYPE_OTHER")
   private String partyTypeOther;
   //PARTY_PEOPLE_TYPE
	@Column(name = "PARTY_PEOPLE_TYPE")
   private String partyPeopleType;
   //PARTY_STUDY_WAY
	@Column(name = "PARTY_STUDY_WAY")
   private String partyStudyWay;
   //PARTY_PEOPLE_AGE
	@Column(name = "PARTY_PEOPLE_AGE")
   private String partyPeopleAge;
   //PARTY_PEOPLE_EDU
	@Column(name = "PARTY_PEOPLE_EDU")
   private String partyPeopleEdu;
   //PARTY_OTHER_STUDY_WAY
	@Column(name = "PARTY_OTHER_STUDY_WAY")
   private String partyOtherStudyWay;
   //PARTY_ACTIVITY_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_ACTIVITY_NUM")
   private BigDecimal partyActivityNum;
   //ACTIVITY_GOOD_NUM
   	@Rule(value="number")
	@Column(name = "ACTIVITY_GOOD_NUM")
   private BigDecimal activityGoodNum;
   //IF_ACCEPTANCE
	@Column(name = "IF_ACCEPTANCE")
   private String ifAcceptance;
   //PARTY_WORKER_NUM
   	@Rule(value="number")
	@Column(name = "PARTY_WORKER_NUM")
   private BigDecimal partyWorkerNum;
   //PARTY_COORDINATOR_NAME
	@Column(name = "PARTY_COORDINATOR_NAME")
   private String partyCoordinatorName;
   //PARTY_COORDINATOR_CONTACT
	@Column(name = "PARTY_COORDINATOR_CONTACT")
   private String partyCoordinatorContact;
   //PARTY_ACTIVITY_DETAIL
	@Column(name = "PARTY_ACTIVITY_DETAIL")
   private String partyActivityDetail;
   //PARTY_SUGGEST
	@Column(name = "PARTY_SUGGEST")
   private String partySuggest;
   //IF_PARTY_OFFICER
	@Column(name = "IF_PARTY_OFFICER")
   private String ifPartyOfficer;
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
    * getter for IF_BUILD_PARTY
    * @generated
    */
   public String getIfBuildParty(){
      return this.ifBuildParty;
   }
   /**
    * setter for IF_BUILD_PARTY
    * @generated
    */
   public void setIfBuildParty(String ifBuildParty){
      this.ifBuildParty = ifBuildParty;
   }

   /**
    * getter for NO_BUILD_PARTY_RESON
    * @generated
    */
   public String getNoBuildPartyReson(){
      return this.noBuildPartyReson;
   }
   /**
    * setter for NO_BUILD_PARTY_RESON
    * @generated
    */
   public void setNoBuildPartyReson(String noBuildPartyReson){
      this.noBuildPartyReson = noBuildPartyReson;
   }

   /**
    * getter for PARTY_MEMBER_TOTAL
    * @generated
    */
   public BigDecimal getPartyMemberTotal(){
      return this.partyMemberTotal;
   }
   /**
    * setter for PARTY_MEMBER_TOTAL
    * @generated
    */
   public void setPartyMemberTotal(BigDecimal partyMemberTotal){
      this.partyMemberTotal = partyMemberTotal;
   }

   /**
    * getter for PARTY_PRACTITIONER_NUM
    * @generated
    */
   public BigDecimal getPartyPractitionerNum(){
      return this.partyPractitionerNum;
   }
   /**
    * setter for PARTY_PRACTITIONER_NUM
    * @generated
    */
   public void setPartyPractitionerNum(BigDecimal partyPractitionerNum){
      this.partyPractitionerNum = partyPractitionerNum;
   }

   /**
    * getter for PARTY_FULL_TIME_NUM
    * @generated
    */
   public BigDecimal getPartyFullTimeNum(){
      return this.partyFullTimeNum;
   }
   /**
    * setter for PARTY_FULL_TIME_NUM
    * @generated
    */
   public void setPartyFullTimeNum(BigDecimal partyFullTimeNum){
      this.partyFullTimeNum = partyFullTimeNum;
   }

   /**
    * getter for NEW_PARTY_PEOPLE_NUM
    * @generated
    */
   public BigDecimal getNewPartyPeopleNum(){
      return this.newPartyPeopleNum;
   }
   /**
    * setter for NEW_PARTY_PEOPLE_NUM
    * @generated
    */
   public void setNewPartyPeopleNum(BigDecimal newPartyPeopleNum){
      this.newPartyPeopleNum = newPartyPeopleNum;
   }

   /**
    * getter for LEGAL_PARTY_NUM
    * @generated
    */
   public BigDecimal getLegalPartyNum(){
      return this.legalPartyNum;
   }
   /**
    * setter for LEGAL_PARTY_NUM
    * @generated
    */
   public void setLegalPartyNum(BigDecimal legalPartyNum){
      this.legalPartyNum = legalPartyNum;
   }

   /**
    * getter for PARTY_UNDER_THIRTY_FIVE_NUM
    * @generated
    */
   public BigDecimal getPartyUnderThirtyFiveNum(){
      return this.partyUnderThirtyFiveNum;
   }
   /**
    * setter for PARTY_UNDER_THIRTY_FIVE_NUM
    * @generated
    */
   public void setPartyUnderThirtyFiveNum(BigDecimal partyUnderThirtyFiveNum){
      this.partyUnderThirtyFiveNum = partyUnderThirtyFiveNum;
   }

   /**
    * getter for PARTY_ABOVE_THIRTY_FIVE_NUM
    * @generated
    */
   public BigDecimal getPartyAboveThirtyFiveNum(){
      return this.partyAboveThirtyFiveNum;
   }
   /**
    * setter for PARTY_ABOVE_THIRTY_FIVE_NUM
    * @generated
    */
   public void setPartyAboveThirtyFiveNum(BigDecimal partyAboveThirtyFiveNum){
      this.partyAboveThirtyFiveNum = partyAboveThirtyFiveNum;
   }

   /**
    * getter for PARTY_UNDER_SIXTY_NUM
    * @generated
    */
   public BigDecimal getPartyUnderSixtyNum(){
      return this.partyUnderSixtyNum;
   }
   /**
    * setter for PARTY_UNDER_SIXTY_NUM
    * @generated
    */
   public void setPartyUnderSixtyNum(BigDecimal partyUnderSixtyNum){
      this.partyUnderSixtyNum = partyUnderSixtyNum;
   }

   /**
    * getter for PARTY_ABOVE_SIXTY_NUM
    * @generated
    */
   public BigDecimal getPartyAboveSixtyNum(){
      return this.partyAboveSixtyNum;
   }
   /**
    * setter for PARTY_ABOVE_SIXTY_NUM
    * @generated
    */
   public void setPartyAboveSixtyNum(BigDecimal partyAboveSixtyNum){
      this.partyAboveSixtyNum = partyAboveSixtyNum;
   }

   /**
    * getter for PARTY_SENIOR_NUM
    * @generated
    */
   public BigDecimal getPartySeniorNum(){
      return this.partySeniorNum;
   }
   /**
    * setter for PARTY_SENIOR_NUM
    * @generated
    */
   public void setPartySeniorNum(BigDecimal partySeniorNum){
      this.partySeniorNum = partySeniorNum;
   }

   /**
    * getter for PARTY_BACHELOR_NUM
    * @generated
    */
   public BigDecimal getPartyBachelorNum(){
      return this.partyBachelorNum;
   }
   /**
    * setter for PARTY_BACHELOR_NUM
    * @generated
    */
   public void setPartyBachelorNum(BigDecimal partyBachelorNum){
      this.partyBachelorNum = partyBachelorNum;
   }

   /**
    * getter for PARTY_MASTER_NUM
    * @generated
    */
   public BigDecimal getPartyMasterNum(){
      return this.partyMasterNum;
   }
   /**
    * setter for PARTY_MASTER_NUM
    * @generated
    */
   public void setPartyMasterNum(BigDecimal partyMasterNum){
      this.partyMasterNum = partyMasterNum;
   }

   /**
    * getter for PARTY_ABROAD_NUM
    * @generated
    */
   public BigDecimal getPartyAbroadNum(){
      return this.partyAbroadNum;
   }
   /**
    * setter for PARTY_ABROAD_NUM
    * @generated
    */
   public void setPartyAbroadNum(BigDecimal partyAbroadNum){
      this.partyAbroadNum = partyAbroadNum;
   }

   /**
    * getter for PARTY_WORK_SPACE_NUM
    * @generated
    */
   public BigDecimal getPartyWorkSpaceNum(){
      return this.partyWorkSpaceNum;
   }
   /**
    * setter for PARTY_WORK_SPACE_NUM
    * @generated
    */
   public void setPartyWorkSpaceNum(BigDecimal partyWorkSpaceNum){
      this.partyWorkSpaceNum = partyWorkSpaceNum;
   }

   /**
    * getter for PARTY_OTHER_SUBJECTION_NUM
    * @generated
    */
   public BigDecimal getPartyOtherSubjectionNum(){
      return this.partyOtherSubjectionNum;
   }
   /**
    * setter for PARTY_OTHER_SUBJECTION_NUM
    * @generated
    */
   public void setPartyOtherSubjectionNum(BigDecimal partyOtherSubjectionNum){
      this.partyOtherSubjectionNum = partyOtherSubjectionNum;
   }

   /**
    * getter for PARTY_OFFICER_NAME
    * @generated
    */
   public String getPartyOfficerName(){
      return this.partyOfficerName;
   }
   /**
    * setter for PARTY_OFFICER_NAME
    * @generated
    */
   public void setPartyOfficerName(String partyOfficerName){
      this.partyOfficerName = partyOfficerName;
   }

   /**
    * getter for PARTY_OFFICER_CONTACT
    * @generated
    */
   public String getPartyOfficerContact(){
      return this.partyOfficerContact;
   }
   /**
    * setter for PARTY_OFFICER_CONTACT
    * @generated
    */
   public void setPartyOfficerContact(String partyOfficerContact){
      this.partyOfficerContact = partyOfficerContact;
   }

   /**
    * getter for PARTY_PARTY_NUM
    * @generated
    */
   public BigDecimal getPartyPartyNum(){
      return this.partyPartyNum;
   }
   /**
    * setter for PARTY_PARTY_NUM
    * @generated
    */
   public void setPartyPartyNum(BigDecimal partyPartyNum){
      this.partyPartyNum = partyPartyNum;
   }

   /**
    * getter for PARTY_BORG_NUM
    * @generated
    */
   public BigDecimal getPartyBorgNum(){
      return this.partyBorgNum;
   }
   /**
    * setter for PARTY_BORG_NUM
    * @generated
    */
   public void setPartyBorgNum(BigDecimal partyBorgNum){
      this.partyBorgNum = partyBorgNum;
   }

   /**
    * getter for PARTY_LINKED_NUM
    * @generated
    */
   public BigDecimal getPartyLinkedNum(){
      return this.partyLinkedNum;
   }
   /**
    * setter for PARTY_LINKED_NUM
    * @generated
    */
   public void setPartyLinkedNum(BigDecimal partyLinkedNum){
      this.partyLinkedNum = partyLinkedNum;
   }

   /**
    * getter for PARTY_COLONY_NUM
    * @generated
    */
   public BigDecimal getPartyColonyNum(){
      return this.partyColonyNum;
   }
   /**
    * setter for PARTY_COLONY_NUM
    * @generated
    */
   public void setPartyColonyNum(BigDecimal partyColonyNum){
      this.partyColonyNum = partyColonyNum;
   }

   /**
    * getter for PARTY_TYPE
    * @generated
    */
   public String getPartyType(){
      return this.partyType;
   }
   /**
    * setter for PARTY_TYPE
    * @generated
    */
   public void setPartyType(String partyType){
      this.partyType = partyType;
   }

   /**
    * getter for PARTY_RELATION_TYPE
    * @generated
    */
   public String getPartyRelationType(){
      return this.partyRelationType;
   }
   /**
    * setter for PARTY_RELATION_TYPE
    * @generated
    */
   public void setPartyRelationType(String partyRelationType){
      this.partyRelationType = partyRelationType;
   }

   /**
    * getter for PARTY_ACTIVITY_MON
    * @generated
    */
   public String getPartyActivityMon(){
      return this.partyActivityMon;
   }
   /**
    * setter for PARTY_ACTIVITY_MON
    * @generated
    */
   public void setPartyActivityMon(String partyActivityMon){
      this.partyActivityMon = partyActivityMon;
   }

   /**
    * getter for PARTY_DUES_MON
    * @generated
    */
   public String getPartyDuesMon(){
      return this.partyDuesMon;
   }
   /**
    * setter for PARTY_DUES_MON
    * @generated
    */
   public void setPartyDuesMon(String partyDuesMon){
      this.partyDuesMon = partyDuesMon;
   }

   /**
    * getter for PARTY_SUPPORT_MON
    * @generated
    */
   public String getPartySupportMon(){
      return this.partySupportMon;
   }
   /**
    * setter for PARTY_SUPPORT_MON
    * @generated
    */
   public void setPartySupportMon(String partySupportMon){
      this.partySupportMon = partySupportMon;
   }

   /**
    * getter for PARTY_BUSINESS_MON
    * @generated
    */
   public String getPartyBusinessMon(){
      return this.partyBusinessMon;
   }
   /**
    * setter for PARTY_BUSINESS_MON
    * @generated
    */
   public void setPartyBusinessMon(String partyBusinessMon){
      this.partyBusinessMon = partyBusinessMon;
   }

   /**
    * getter for PARTY_FINANCE_MON
    * @generated
    */
   public String getPartyFinanceMon(){
      return this.partyFinanceMon;
   }
   /**
    * setter for PARTY_FINANCE_MON
    * @generated
    */
   public void setPartyFinanceMon(String partyFinanceMon){
      this.partyFinanceMon = partyFinanceMon;
   }

   /**
    * getter for PARTY_OTHER_MON
    * @generated
    */
   public String getPartyOtherMon(){
      return this.partyOtherMon;
   }
   /**
    * setter for PARTY_OTHER_MON
    * @generated
    */
   public void setPartyOtherMon(String partyOtherMon){
      this.partyOtherMon = partyOtherMon;
   }

   /**
    * getter for PARTY_TYPE_OTHER
    * @generated
    */
   public String getPartyTypeOther(){
      return this.partyTypeOther;
   }
   /**
    * setter for PARTY_TYPE_OTHER
    * @generated
    */
   public void setPartyTypeOther(String partyTypeOther){
      this.partyTypeOther = partyTypeOther;
   }

   /**
    * getter for PARTY_PEOPLE_TYPE
    * @generated
    */
   public String getPartyPeopleType(){
      return this.partyPeopleType;
   }
   /**
    * setter for PARTY_PEOPLE_TYPE
    * @generated
    */
   public void setPartyPeopleType(String partyPeopleType){
      this.partyPeopleType = partyPeopleType;
   }

   /**
    * getter for PARTY_STUDY_WAY
    * @generated
    */
   public String getPartyStudyWay(){
      return this.partyStudyWay;
   }
   /**
    * setter for PARTY_STUDY_WAY
    * @generated
    */
   public void setPartyStudyWay(String partyStudyWay){
      this.partyStudyWay = partyStudyWay;
   }

   /**
    * getter for PARTY_PEOPLE_AGE
    * @generated
    */
   public String getPartyPeopleAge(){
      return this.partyPeopleAge;
   }
   /**
    * setter for PARTY_PEOPLE_AGE
    * @generated
    */
   public void setPartyPeopleAge(String partyPeopleAge){
      this.partyPeopleAge = partyPeopleAge;
   }

   /**
    * getter for PARTY_PEOPLE_EDU
    * @generated
    */
   public String getPartyPeopleEdu(){
      return this.partyPeopleEdu;
   }
   /**
    * setter for PARTY_PEOPLE_EDU
    * @generated
    */
   public void setPartyPeopleEdu(String partyPeopleEdu){
      this.partyPeopleEdu = partyPeopleEdu;
   }

   /**
    * getter for PARTY_OTHER_STUDY_WAY
    * @generated
    */
   public String getPartyOtherStudyWay(){
      return this.partyOtherStudyWay;
   }
   /**
    * setter for PARTY_OTHER_STUDY_WAY
    * @generated
    */
   public void setPartyOtherStudyWay(String partyOtherStudyWay){
      this.partyOtherStudyWay = partyOtherStudyWay;
   }

   /**
    * getter for PARTY_ACTIVITY_NUM
    * @generated
    */
   public BigDecimal getPartyActivityNum(){
      return this.partyActivityNum;
   }
   /**
    * setter for PARTY_ACTIVITY_NUM
    * @generated
    */
   public void setPartyActivityNum(BigDecimal partyActivityNum){
      this.partyActivityNum = partyActivityNum;
   }

   /**
    * getter for ACTIVITY_GOOD_NUM
    * @generated
    */
   public BigDecimal getActivityGoodNum(){
      return this.activityGoodNum;
   }
   /**
    * setter for ACTIVITY_GOOD_NUM
    * @generated
    */
   public void setActivityGoodNum(BigDecimal activityGoodNum){
      this.activityGoodNum = activityGoodNum;
   }

   /**
    * getter for IF_ACCEPTANCE
    * @generated
    */
   public String getIfAcceptance(){
      return this.ifAcceptance;
   }
   /**
    * setter for IF_ACCEPTANCE
    * @generated
    */
   public void setIfAcceptance(String ifAcceptance){
      this.ifAcceptance = ifAcceptance;
   }

   /**
    * getter for PARTY_WORKER_NUM
    * @generated
    */
   public BigDecimal getPartyWorkerNum(){
      return this.partyWorkerNum;
   }
   /**
    * setter for PARTY_WORKER_NUM
    * @generated
    */
   public void setPartyWorkerNum(BigDecimal partyWorkerNum){
      this.partyWorkerNum = partyWorkerNum;
   }

   /**
    * getter for PARTY_COORDINATOR_NAME
    * @generated
    */
   public String getPartyCoordinatorName(){
      return this.partyCoordinatorName;
   }
   /**
    * setter for PARTY_COORDINATOR_NAME
    * @generated
    */
   public void setPartyCoordinatorName(String partyCoordinatorName){
      this.partyCoordinatorName = partyCoordinatorName;
   }

   /**
    * getter for PARTY_COORDINATOR_CONTACT
    * @generated
    */
   public String getPartyCoordinatorContact(){
      return this.partyCoordinatorContact;
   }
   /**
    * setter for PARTY_COORDINATOR_CONTACT
    * @generated
    */
   public void setPartyCoordinatorContact(String partyCoordinatorContact){
      this.partyCoordinatorContact = partyCoordinatorContact;
   }

   /**
    * getter for PARTY_ACTIVITY_DETAIL
    * @generated
    */
   public String getPartyActivityDetail(){
      return this.partyActivityDetail;
   }
   /**
    * setter for PARTY_ACTIVITY_DETAIL
    * @generated
    */
   public void setPartyActivityDetail(String partyActivityDetail){
      this.partyActivityDetail = partyActivityDetail;
   }

   /**
    * getter for PARTY_SUGGEST
    * @generated
    */
   public String getPartySuggest(){
      return this.partySuggest;
   }
   /**
    * setter for PARTY_SUGGEST
    * @generated
    */
   public void setPartySuggest(String partySuggest){
      this.partySuggest = partySuggest;
   }

   /**
    * getter for IF_PARTY_OFFICER
    * @generated
    */
   public String getIfPartyOfficer(){
      return this.ifPartyOfficer;
   }
   /**
    * setter for IF_PARTY_OFFICER
    * @generated
    */
   public void setIfPartyOfficer(String ifPartyOfficer){
      this.ifPartyOfficer = ifPartyOfficer;
   }

}