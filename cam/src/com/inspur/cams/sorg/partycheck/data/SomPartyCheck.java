package com.inspur.cams.sorg.partycheck.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomPartyCheck
 * @description:
 * @author:
 * @since:2013-04-26
 * @version:1.0
*/
 @Table(tableName = "SOM_PARTY_CHECK" , keyFields = "ycheckId")
public class SomPartyCheck extends StatefulDatabean {
   //YCHECK_ID
   	@Rule(value="require")
	@Column(name = "YCHECK_ID")
   private String ycheckId;
   //TASK_ID
	@Column(name = "TASK_ID")
   private String taskId;
   //YEARLY
   	@Rule(value="require")
	@Column(name = "YEARLY")
   private String yearly;
   //CHECK_RESULT
	@Column(name = "CHECK_RESULT")
   private String checkResult;
   //CHECK_STATUS
	@Column(name = "CHECK_STATUS")
   private String checkStatus;
   //SORG_CODE
   	@Rule(value="require")
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //SORG_NAME
   	@Rule(value="require")
	@Column(name = "SORG_NAME")
   private String sorgName;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //BORG_IF_BUILD_PARTY
	@Column(name = "BORG_IF_BUILD_PARTY")
   private String borgIfBuildParty;
   //PARTY_STATUS
   	@Rule(value="require")
	@Column(name = "PARTY_STATUS")
   private String partyStatus;
   //IF_BUILD_PARTY
   	@Rule(value="require")
	@Column(name = "IF_BUILD_PARTY")
   private String ifBuildParty;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //POLITICS
	@Column(name = "POLITICS")
   private String politics;
   //MEETING_NUM
   	@Rule(value="number")
	@Column(name = "MEETING_NUM")
   private BigDecimal meetingNum;
   //BUILD_DATE
	@Column(name = "BUILD_DATE")
   private String buildDate;
   //AUDIT_ORGAN
	@Column(name = "AUDIT_ORGAN")
   private String auditOrgan;
   //AUDIT_FILE_CODE
	@Column(name = "AUDIT_FILE_CODE")
   private String auditFileCode;
   //PARTY_NAME
	@Column(name = "PARTY_NAME")
   private String partyName;
   //BUILD_TYPE
	@Column(name = "BUILD_TYPE")
   private String buildType;
   //COMBINED
	@Column(name = "COMBINED")
   private String combined;
   //PARTY_TYPE
	@Column(name = "PARTY_TYPE")
   private String partyType;
   //IF_COM_PARTY
	@Column(name = "IF_COM_PARTY")
   private String ifComParty;
   //BELONG_REL
	@Column(name = "BELONG_REL")
   private String belongRel;
   //BELONG_REL_DESC
	@Column(name = "BELONG_REL_DESC")
   private String belongRelDesc;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //PARTY_CHIEF
	@Column(name = "PARTY_CHIEF")
   private String partyChief;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
   //EDUCATION
	@Column(name = "EDUCATION")
   private String education;
   //FOLK
	@Column(name = "FOLK")
   private String folk;
   //SORG_DUTIES
	@Column(name = "SORG_DUTIES")
   private String sorgDuties;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //WORK_DUTIES
	@Column(name = "WORK_DUTIES")
   private String workDuties;
   //FULLTIME_NUM
   	@Rule(value="number")
	@Column(name = "FULLTIME_NUM")
   private BigDecimal fulltimeNum;
   //PARTTIME_NUM
   	@Rule(value="number")
	@Column(name = "PARTTIME_NUM")
   private BigDecimal parttimeNum;
   //ENGAGED_MEMBER_NUM
   	@Rule(value="number")
	@Column(name = "ENGAGED_MEMBER_NUM")
   private BigDecimal engagedMemberNum;
   //PREPARE_NUM
   	@Rule(value="number")
	@Column(name = "PREPARE_NUM")
   private BigDecimal prepareNum;
   //DEVELOP_NUM
   	@Rule(value="number")
	@Column(name = "DEVELOP_NUM")
   private BigDecimal developNum;
   //ENERGETIC_NUM
   	@Rule(value="number")
	@Column(name = "ENERGETIC_NUM")
   private BigDecimal energeticNum;
   //APP_PARTY_NUM
   	@Rule(value="number")
	@Column(name = "APP_PARTY_NUM")
   private BigDecimal appPartyNum;
   //GROUP_TYPE
	@Column(name = "GROUP_TYPE")
   private String groupType;
   //GROUP_DESC
	@Column(name = "GROUP_DESC")
   private String groupDesc;
   //PLAN_BUILD_DATE
	@Column(name = "PLAN_BUILD_DATE")
   private String planBuildDate;
   //NOBUILD_REASON
	@Column(name = "NOBUILD_REASON")
   private String nobuildReason;
   //INSTRUCTOR
	@Column(name = "INSTRUCTOR")
   private String instructor;
   //INSTRUCTOR_WORK_NAME
	@Column(name = "INSTRUCTOR_WORK_NAME")
   private String instructorWorkName;
   //INSTRUCTOR_PHONE
	@Column(name = "INSTRUCTOR_PHONE")
   private String instructorPhone;
   //INSTRUCTOR_REL
	@Column(name = "INSTRUCTOR_REL")
   private String instructorRel;
   //IN_OR_OUT
	@Column(name = "IN_OR_OUT")
   private String inOrOut;
   //IF_FULL_SYSTEM_IN
	@Column(name = "IF_FULL_SYSTEM_IN")
   private String ifFullSystemIn;
   //IN_TIME
	@Column(name = "IN_TIME")
   private String inTime;
   //IN_FROM_ORGAN
	@Column(name = "IN_FROM_ORGAN")
   private String inFromOrgan;
   //IF_FULL_SYSTEM_OUT
	@Column(name = "IF_FULL_SYSTEM_OUT")
   private String ifFullSystemOut;
   //OUT_TIME
	@Column(name = "OUT_TIME")
   private String outTime;
   //OUT_TO_ORGAN
	@Column(name = "OUT_TO_ORGAN")
   private String outToOrgan;
   //CANCEL_REASON
	@Column(name = "CANCEL_REASON")
   private String cancelReason;
   //CANCEL_DATE
	@Column(name = "CANCEL_DATE")
   private String cancelDate;
   //CANCEL_FILE_NO
	@Column(name = "CANCEL_FILE_NO")
   private String cancelFileNo;
   //CANCEL_AUDIT_PARTY
	@Column(name = "CANCEL_AUDIT_PARTY")
   private String cancelAuditParty;
   //MORG_NAME
   	@Rule(value="require")
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
   	@Rule(value="require")
	@Column(name = "MORG_AREA")
   private String morgArea;
   //REG_PEOPLE
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //MOD_PEOPLE
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //MOD_TIME
	@Column(name = "MOD_TIME")
   private String modTime;
   //ENGAGED_LEADER_FULLTIME
   	@Rule(value="number")
	@Column(name = "ENGAGED_LEADER_FULLTIME")
   private BigDecimal engagedLeaderFulltime;
   //ENGAGED_LEADER_PARTTIME
   	@Rule(value="number")
	@Column(name = "ENGAGED_LEADER_PARTTIME")
   private BigDecimal engagedLeaderParttime;
   //ENGAGED_MEM_FULLTIME
   	@Rule(value="number")
	@Column(name = "ENGAGED_MEM_FULLTIME")
   private BigDecimal engagedMemFulltime;
   //ENGAGED_MEM_PARTTIME
   	@Rule(value="number")
	@Column(name = "ENGAGED_MEM_PARTTIME")
   private BigDecimal engagedMemParttime;
   //LEADER_FULLTIME_OUT_NUM
   	@Rule(value="number")
	@Column(name = "LEADER_FULLTIME_OUT_NUM")
   private BigDecimal leaderFulltimeOutNum;
   //LEADER_FULLTIME_NO_NUM
   	@Rule(value="number")
	@Column(name = "LEADER_FULLTIME_NO_NUM")
   private BigDecimal leaderFulltimeNoNum;
   //LEADER_PARTTIME_NUM
   	@Rule(value="number")
	@Column(name = "LEADER_PARTTIME_NUM")
   private BigDecimal leaderParttimeNum;
   //MEM_FULLTIME_OUT_NUM
   	@Rule(value="number")
	@Column(name = "MEM_FULLTIME_OUT_NUM")
   private BigDecimal memFulltimeOutNum;
   //MEM_FULLTIME_NO_NUM
   	@Rule(value="number")
	@Column(name = "MEM_FULLTIME_NO_NUM")
   private BigDecimal memFulltimeNoNum;
   //MEM_PARTTIME_NUM
   	@Rule(value="number")
	@Column(name = "MEM_PARTTIME_NUM")
   private BigDecimal memParttimeNum;
   //ENGAGED_NUM
   	@Rule(value="number")
	@Column(name = "ENGAGED_NUM")
   private BigDecimal engagedNum;
   //MEMBER_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_NUM")
   private BigDecimal memberNum;
   //MEMBER_SOM_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_SOM_NUM")
   private BigDecimal memberSomNum;
   //MEMBER_BUSINESS_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_BUSINESS_NUM")
   private BigDecimal memberBusinessNum;
   //MEMBER_Attached_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_Attached_NUM")
   private BigDecimal memberAttachedNum;
   //MEMBER_POSSSESSION_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_POSSSESSION_NUM")
   private BigDecimal memberPosssessionNum;
   //MEMBER_ORGAN_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_ORGAN_NUM")
   private BigDecimal memberOrganNum;
   //MEMBER_OTHER_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_OTHER_NUM")
   private BigDecimal memberOtherNum;
   //CHECK_PEOPLE_NAME
	@Column(name = "CHECK_PEOPLE_NAME")
   private String checkPeopleName;
   //CHECK_TIME
	@Column(name = "CHECK_TIME")
   private String checkTime;
   //CHECK_ORGAN_NAME
	@Column(name = "CHECK_ORGAN_NAME")
   private String checkOrganName;
	
	//SORG_ADDRESS
	@Column(name = "SORG_ADDRESS")
	   private String sorgAddress;
	//BORG_NAME
	@Column(name = "BORG_NAME")
	   private String borgName;
	//LINK_PHONE
	@Column(name = "LINK_PHONE")
	   private String linkPhone;
	//LINK_MAN
	@Column(name = "LINK_MAN")
	   private String linkMan;
	
   public String getLinkMan() {
		return linkMan;
	}
	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
public String getLinkPhone() {
		return linkPhone;
	}
	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}
public String getSorgAddress() {
		return sorgAddress;
	}
	public void setSorgAddress(String sorgAddress) {
		this.sorgAddress = sorgAddress;
	}
	public String getBorgName() {
		return borgName;
	}
	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}
/**
    * getter for YCHECK_ID
    * @generated
    */
   public String getYcheckId(){
      return this.ycheckId;
   }
   /**
    * setter for YCHECK_ID
    * @generated
    */
   public void setYcheckId(String ycheckId){
      this.ycheckId = ycheckId;
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
    * getter for YEARLY
    * @generated
    */
   public String getYearly(){
      return this.yearly;
   }
   /**
    * setter for YEARLY
    * @generated
    */
   public void setYearly(String yearly){
      this.yearly = yearly;
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
    * getter for CHECK_STATUS
    * @generated
    */
   public String getCheckStatus(){
      return this.checkStatus;
   }
   /**
    * setter for CHECK_STATUS
    * @generated
    */
   public void setCheckStatus(String checkStatus){
      this.checkStatus = checkStatus;
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
    * getter for SORG_NAME
    * @generated
    */
   public String getSorgName(){
      return this.sorgName;
   }
   /**
    * setter for SORG_NAME
    * @generated
    */
   public void setSorgName(String sorgName){
      this.sorgName = sorgName;
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
    * getter for BORG_IF_BUILD_PARTY
    * @generated
    */
   public String getBorgIfBuildParty(){
      return this.borgIfBuildParty;
   }
   /**
    * setter for BORG_IF_BUILD_PARTY
    * @generated
    */
   public void setBorgIfBuildParty(String borgIfBuildParty){
      this.borgIfBuildParty = borgIfBuildParty;
   }

   /**
    * getter for PARTY_STATUS
    * @generated
    */
   public String getPartyStatus(){
      return this.partyStatus;
   }
   /**
    * setter for PARTY_STATUS
    * @generated
    */
   public void setPartyStatus(String partyStatus){
      this.partyStatus = partyStatus;
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
    * getter for POLITICS
    * @generated
    */
   public String getPolitics(){
      return this.politics;
   }
   /**
    * setter for POLITICS
    * @generated
    */
   public void setPolitics(String politics){
      this.politics = politics;
   }

   /**
    * getter for MEETING_NUM
    * @generated
    */
   public BigDecimal getMeetingNum(){
      return this.meetingNum;
   }
   /**
    * setter for MEETING_NUM
    * @generated
    */
   public void setMeetingNum(BigDecimal meetingNum){
      this.meetingNum = meetingNum;
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
    * getter for AUDIT_ORGAN
    * @generated
    */
   public String getAuditOrgan(){
      return this.auditOrgan;
   }
   /**
    * setter for AUDIT_ORGAN
    * @generated
    */
   public void setAuditOrgan(String auditOrgan){
      this.auditOrgan = auditOrgan;
   }

   /**
    * getter for AUDIT_FILE_CODE
    * @generated
    */
   public String getAuditFileCode(){
      return this.auditFileCode;
   }
   /**
    * setter for AUDIT_FILE_CODE
    * @generated
    */
   public void setAuditFileCode(String auditFileCode){
      this.auditFileCode = auditFileCode;
   }

   /**
    * getter for PARTY_NAME
    * @generated
    */
   public String getPartyName(){
      return this.partyName;
   }
   /**
    * setter for PARTY_NAME
    * @generated
    */
   public void setPartyName(String partyName){
      this.partyName = partyName;
   }

   /**
    * getter for BUILD_TYPE
    * @generated
    */
   public String getBuildType(){
      return this.buildType;
   }
   /**
    * setter for BUILD_TYPE
    * @generated
    */
   public void setBuildType(String buildType){
      this.buildType = buildType;
   }

   /**
    * getter for COMBINED
    * @generated
    */
   public String getCombined(){
      return this.combined;
   }
   /**
    * setter for COMBINED
    * @generated
    */
   public void setCombined(String combined){
      this.combined = combined;
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
    * getter for IF_COM_PARTY
    * @generated
    */
   public String getIfComParty(){
      return this.ifComParty;
   }
   /**
    * setter for IF_COM_PARTY
    * @generated
    */
   public void setIfComParty(String ifComParty){
      this.ifComParty = ifComParty;
   }

   /**
    * getter for BELONG_REL
    * @generated
    */
   public String getBelongRel(){
      return this.belongRel;
   }
   /**
    * setter for BELONG_REL
    * @generated
    */
   public void setBelongRel(String belongRel){
      this.belongRel = belongRel;
   }

   /**
    * getter for BELONG_REL_DESC
    * @generated
    */
   public String getBelongRelDesc(){
      return this.belongRelDesc;
   }
   /**
    * setter for BELONG_REL_DESC
    * @generated
    */
   public void setBelongRelDesc(String belongRelDesc){
      this.belongRelDesc = belongRelDesc;
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
    * getter for PARTY_CHIEF
    * @generated
    */
   public String getPartyChief(){
      return this.partyChief;
   }
   /**
    * setter for PARTY_CHIEF
    * @generated
    */
   public void setPartyChief(String partyChief){
      this.partyChief = partyChief;
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
    * getter for PHONE
    * @generated
    */
   public String getPhone(){
      return this.phone;
   }
   /**
    * setter for PHONE
    * @generated
    */
   public void setPhone(String phone){
      this.phone = phone;
   }

   /**
    * getter for EDUCATION
    * @generated
    */
   public String getEducation(){
      return this.education;
   }
   /**
    * setter for EDUCATION
    * @generated
    */
   public void setEducation(String education){
      this.education = education;
   }

   /**
    * getter for FOLK
    * @generated
    */
   public String getFolk(){
      return this.folk;
   }
   /**
    * setter for FOLK
    * @generated
    */
   public void setFolk(String folk){
      this.folk = folk;
   }

   /**
    * getter for SORG_DUTIES
    * @generated
    */
   public String getSorgDuties(){
      return this.sorgDuties;
   }
   /**
    * setter for SORG_DUTIES
    * @generated
    */
   public void setSorgDuties(String sorgDuties){
      this.sorgDuties = sorgDuties;
   }

   /**
    * getter for WORK_NAME
    * @generated
    */
   public String getWorkName(){
      return this.workName;
   }
   /**
    * setter for WORK_NAME
    * @generated
    */
   public void setWorkName(String workName){
      this.workName = workName;
   }

   /**
    * getter for WORK_DUTIES
    * @generated
    */
   public String getWorkDuties(){
      return this.workDuties;
   }
   /**
    * setter for WORK_DUTIES
    * @generated
    */
   public void setWorkDuties(String workDuties){
      this.workDuties = workDuties;
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
    * getter for PARTTIME_NUM
    * @generated
    */
   public BigDecimal getParttimeNum(){
      return this.parttimeNum;
   }
   /**
    * setter for PARTTIME_NUM
    * @generated
    */
   public void setParttimeNum(BigDecimal parttimeNum){
      this.parttimeNum = parttimeNum;
   }

   /**
    * getter for ENGAGED_MEMBER_NUM
    * @generated
    */
   public BigDecimal getEngagedMemberNum(){
      return this.engagedMemberNum;
   }
   /**
    * setter for ENGAGED_MEMBER_NUM
    * @generated
    */
   public void setEngagedMemberNum(BigDecimal engagedMemberNum){
      this.engagedMemberNum = engagedMemberNum;
   }

   /**
    * getter for PREPARE_NUM
    * @generated
    */
   public BigDecimal getPrepareNum(){
      return this.prepareNum;
   }
   /**
    * setter for PREPARE_NUM
    * @generated
    */
   public void setPrepareNum(BigDecimal prepareNum){
      this.prepareNum = prepareNum;
   }

   /**
    * getter for DEVELOP_NUM
    * @generated
    */
   public BigDecimal getDevelopNum(){
      return this.developNum;
   }
   /**
    * setter for DEVELOP_NUM
    * @generated
    */
   public void setDevelopNum(BigDecimal developNum){
      this.developNum = developNum;
   }

   /**
    * getter for ENERGETIC_NUM
    * @generated
    */
   public BigDecimal getEnergeticNum(){
      return this.energeticNum;
   }
   /**
    * setter for ENERGETIC_NUM
    * @generated
    */
   public void setEnergeticNum(BigDecimal energeticNum){
      this.energeticNum = energeticNum;
   }

   /**
    * getter for APP_PARTY_NUM
    * @generated
    */
   public BigDecimal getAppPartyNum(){
      return this.appPartyNum;
   }
   /**
    * setter for APP_PARTY_NUM
    * @generated
    */
   public void setAppPartyNum(BigDecimal appPartyNum){
      this.appPartyNum = appPartyNum;
   }

   /**
    * getter for GROUP_TYPE
    * @generated
    */
   public String getGroupType(){
      return this.groupType;
   }
   /**
    * setter for GROUP_TYPE
    * @generated
    */
   public void setGroupType(String groupType){
      this.groupType = groupType;
   }

   /**
    * getter for GROUP_DESC
    * @generated
    */
   public String getGroupDesc(){
      return this.groupDesc;
   }
   /**
    * setter for GROUP_DESC
    * @generated
    */
   public void setGroupDesc(String groupDesc){
      this.groupDesc = groupDesc;
   }

   /**
    * getter for PLAN_BUILD_DATE
    * @generated
    */
   public String getPlanBuildDate(){
      return this.planBuildDate;
   }
   /**
    * setter for PLAN_BUILD_DATE
    * @generated
    */
   public void setPlanBuildDate(String planBuildDate){
      this.planBuildDate = planBuildDate;
   }

   /**
    * getter for NOBUILD_REASON
    * @generated
    */
   public String getNobuildReason(){
      return this.nobuildReason;
   }
   /**
    * setter for NOBUILD_REASON
    * @generated
    */
   public void setNobuildReason(String nobuildReason){
      this.nobuildReason = nobuildReason;
   }

   /**
    * getter for INSTRUCTOR
    * @generated
    */
   public String getInstructor(){
      return this.instructor;
   }
   /**
    * setter for INSTRUCTOR
    * @generated
    */
   public void setInstructor(String instructor){
      this.instructor = instructor;
   }

   /**
    * getter for INSTRUCTOR_WORK_NAME
    * @generated
    */
   public String getInstructorWorkName(){
      return this.instructorWorkName;
   }
   /**
    * setter for INSTRUCTOR_WORK_NAME
    * @generated
    */
   public void setInstructorWorkName(String instructorWorkName){
      this.instructorWorkName = instructorWorkName;
   }

   /**
    * getter for INSTRUCTOR_PHONE
    * @generated
    */
   public String getInstructorPhone(){
      return this.instructorPhone;
   }
   /**
    * setter for INSTRUCTOR_PHONE
    * @generated
    */
   public void setInstructorPhone(String instructorPhone){
      this.instructorPhone = instructorPhone;
   }

   /**
    * getter for INSTRUCTOR_REL
    * @generated
    */
   public String getInstructorRel(){
      return this.instructorRel;
   }
   /**
    * setter for INSTRUCTOR_REL
    * @generated
    */
   public void setInstructorRel(String instructorRel){
      this.instructorRel = instructorRel;
   }

   /**
    * getter for IN_OR_OUT
    * @generated
    */
   public String getInOrOut(){
      return this.inOrOut;
   }
   /**
    * setter for IN_OR_OUT
    * @generated
    */
   public void setInOrOut(String inOrOut){
      this.inOrOut = inOrOut;
   }

   /**
    * getter for IF_FULL_SYSTEM_IN
    * @generated
    */
   public String getIfFullSystemIn(){
      return this.ifFullSystemIn;
   }
   /**
    * setter for IF_FULL_SYSTEM_IN
    * @generated
    */
   public void setIfFullSystemIn(String ifFullSystemIn){
      this.ifFullSystemIn = ifFullSystemIn;
   }

   /**
    * getter for IN_TIME
    * @generated
    */
   public String getInTime(){
      return this.inTime;
   }
   /**
    * setter for IN_TIME
    * @generated
    */
   public void setInTime(String inTime){
      this.inTime = inTime;
   }

   /**
    * getter for IN_FROM_ORGAN
    * @generated
    */
   public String getInFromOrgan(){
      return this.inFromOrgan;
   }
   /**
    * setter for IN_FROM_ORGAN
    * @generated
    */
   public void setInFromOrgan(String inFromOrgan){
      this.inFromOrgan = inFromOrgan;
   }

   /**
    * getter for IF_FULL_SYSTEM_OUT
    * @generated
    */
   public String getIfFullSystemOut(){
      return this.ifFullSystemOut;
   }
   /**
    * setter for IF_FULL_SYSTEM_OUT
    * @generated
    */
   public void setIfFullSystemOut(String ifFullSystemOut){
      this.ifFullSystemOut = ifFullSystemOut;
   }

   /**
    * getter for OUT_TIME
    * @generated
    */
   public String getOutTime(){
      return this.outTime;
   }
   /**
    * setter for OUT_TIME
    * @generated
    */
   public void setOutTime(String outTime){
      this.outTime = outTime;
   }

   /**
    * getter for OUT_TO_ORGAN
    * @generated
    */
   public String getOutToOrgan(){
      return this.outToOrgan;
   }
   /**
    * setter for OUT_TO_ORGAN
    * @generated
    */
   public void setOutToOrgan(String outToOrgan){
      this.outToOrgan = outToOrgan;
   }

   /**
    * getter for CANCEL_REASON
    * @generated
    */
   public String getCancelReason(){
      return this.cancelReason;
   }
   /**
    * setter for CANCEL_REASON
    * @generated
    */
   public void setCancelReason(String cancelReason){
      this.cancelReason = cancelReason;
   }

   /**
    * getter for CANCEL_DATE
    * @generated
    */
   public String getCancelDate(){
      return this.cancelDate;
   }
   /**
    * setter for CANCEL_DATE
    * @generated
    */
   public void setCancelDate(String cancelDate){
      this.cancelDate = cancelDate;
   }

   /**
    * getter for CANCEL_FILE_NO
    * @generated
    */
   public String getCancelFileNo(){
      return this.cancelFileNo;
   }
   /**
    * setter for CANCEL_FILE_NO
    * @generated
    */
   public void setCancelFileNo(String cancelFileNo){
      this.cancelFileNo = cancelFileNo;
   }

   /**
    * getter for CANCEL_AUDIT_PARTY
    * @generated
    */
   public String getCancelAuditParty(){
      return this.cancelAuditParty;
   }
   /**
    * setter for CANCEL_AUDIT_PARTY
    * @generated
    */
   public void setCancelAuditParty(String cancelAuditParty){
      this.cancelAuditParty = cancelAuditParty;
   }

   /**
    * getter for MORG_NAME
    * @generated
    */
   public String getMorgName(){
      return this.morgName;
   }
   /**
    * setter for MORG_NAME
    * @generated
    */
   public void setMorgName(String morgName){
      this.morgName = morgName;
   }

   /**
    * getter for MORG_AREA
    * @generated
    */
   public String getMorgArea(){
      return this.morgArea;
   }
   /**
    * setter for MORG_AREA
    * @generated
    */
   public void setMorgArea(String morgArea){
      this.morgArea = morgArea;
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
    * getter for REG_DATE
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for REG_DATE
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }

   /**
    * getter for CREATE_PEOPLE
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for CREATE_PEOPLE
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
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
    * getter for ENGAGED_LEADER_FULLTIME
    * @generated
    */
   public BigDecimal getEngagedLeaderFulltime(){
      return this.engagedLeaderFulltime;
   }
   /**
    * setter for ENGAGED_LEADER_FULLTIME
    * @generated
    */
   public void setEngagedLeaderFulltime(BigDecimal engagedLeaderFulltime){
      this.engagedLeaderFulltime = engagedLeaderFulltime;
   }

   /**
    * getter for ENGAGED_LEADER_PARTTIME
    * @generated
    */
   public BigDecimal getEngagedLeaderParttime(){
      return this.engagedLeaderParttime;
   }
   /**
    * setter for ENGAGED_LEADER_PARTTIME
    * @generated
    */
   public void setEngagedLeaderParttime(BigDecimal engagedLeaderParttime){
      this.engagedLeaderParttime = engagedLeaderParttime;
   }

   /**
    * getter for ENGAGED_MEM_FULLTIME
    * @generated
    */
   public BigDecimal getEngagedMemFulltime(){
      return this.engagedMemFulltime;
   }
   /**
    * setter for ENGAGED_MEM_FULLTIME
    * @generated
    */
   public void setEngagedMemFulltime(BigDecimal engagedMemFulltime){
      this.engagedMemFulltime = engagedMemFulltime;
   }

   /**
    * getter for ENGAGED_MEM_PARTTIME
    * @generated
    */
   public BigDecimal getEngagedMemParttime(){
      return this.engagedMemParttime;
   }
   /**
    * setter for ENGAGED_MEM_PARTTIME
    * @generated
    */
   public void setEngagedMemParttime(BigDecimal engagedMemParttime){
      this.engagedMemParttime = engagedMemParttime;
   }

   /**
    * getter for LEADER_FULLTIME_OUT_NUM
    * @generated
    */
   public BigDecimal getLeaderFulltimeOutNum(){
      return this.leaderFulltimeOutNum;
   }
   /**
    * setter for LEADER_FULLTIME_OUT_NUM
    * @generated
    */
   public void setLeaderFulltimeOutNum(BigDecimal leaderFulltimeOutNum){
      this.leaderFulltimeOutNum = leaderFulltimeOutNum;
   }

   /**
    * getter for LEADER_FULLTIME_NO_NUM
    * @generated
    */
   public BigDecimal getLeaderFulltimeNoNum(){
      return this.leaderFulltimeNoNum;
   }
   /**
    * setter for LEADER_FULLTIME_NO_NUM
    * @generated
    */
   public void setLeaderFulltimeNoNum(BigDecimal leaderFulltimeNoNum){
      this.leaderFulltimeNoNum = leaderFulltimeNoNum;
   }

   /**
    * getter for LEADER_PARTTIME_NUM
    * @generated
    */
   public BigDecimal getLeaderParttimeNum(){
      return this.leaderParttimeNum;
   }
   /**
    * setter for LEADER_PARTTIME_NUM
    * @generated
    */
   public void setLeaderParttimeNum(BigDecimal leaderParttimeNum){
      this.leaderParttimeNum = leaderParttimeNum;
   }

   /**
    * getter for MEM_FULLTIME_OUT_NUM
    * @generated
    */
   public BigDecimal getMemFulltimeOutNum(){
      return this.memFulltimeOutNum;
   }
   /**
    * setter for MEM_FULLTIME_OUT_NUM
    * @generated
    */
   public void setMemFulltimeOutNum(BigDecimal memFulltimeOutNum){
      this.memFulltimeOutNum = memFulltimeOutNum;
   }

   /**
    * getter for MEM_FULLTIME_NO_NUM
    * @generated
    */
   public BigDecimal getMemFulltimeNoNum(){
      return this.memFulltimeNoNum;
   }
   /**
    * setter for MEM_FULLTIME_NO_NUM
    * @generated
    */
   public void setMemFulltimeNoNum(BigDecimal memFulltimeNoNum){
      this.memFulltimeNoNum = memFulltimeNoNum;
   }

   /**
    * getter for MEM_PARTTIME_NUM
    * @generated
    */
   public BigDecimal getMemParttimeNum(){
      return this.memParttimeNum;
   }
   /**
    * setter for MEM_PARTTIME_NUM
    * @generated
    */
   public void setMemParttimeNum(BigDecimal memParttimeNum){
      this.memParttimeNum = memParttimeNum;
   }

   /**
    * getter for ENGAGED_NUM
    * @generated
    */
   public BigDecimal getEngagedNum(){
      return this.engagedNum;
   }
   /**
    * setter for ENGAGED_NUM
    * @generated
    */
   public void setEngagedNum(BigDecimal engagedNum){
      this.engagedNum = engagedNum;
   }

   /**
    * getter for MEMBER_NUM
    * @generated
    */
   public BigDecimal getMemberNum(){
      return this.memberNum;
   }
   /**
    * setter for MEMBER_NUM
    * @generated
    */
   public void setMemberNum(BigDecimal memberNum){
      this.memberNum = memberNum;
   }

   /**
    * getter for MEMBER_SOM_NUM
    * @generated
    */
   public BigDecimal getMemberSomNum(){
      return this.memberSomNum;
   }
   /**
    * setter for MEMBER_SOM_NUM
    * @generated
    */
   public void setMemberSomNum(BigDecimal memberSomNum){
      this.memberSomNum = memberSomNum;
   }

   /**
    * getter for MEMBER_BUSINESS_NUM
    * @generated
    */
   public BigDecimal getMemberBusinessNum(){
      return this.memberBusinessNum;
   }
   /**
    * setter for MEMBER_BUSINESS_NUM
    * @generated
    */
   public void setMemberBusinessNum(BigDecimal memberBusinessNum){
      this.memberBusinessNum = memberBusinessNum;
   }

   /**
    * getter for MEMBER_Attached_NUM
    * @generated
    */
   public BigDecimal getMemberAttachedNum(){
      return this.memberAttachedNum;
   }
   /**
    * setter for MEMBER_Attached_NUM
    * @generated
    */
   public void setMemberAttachedNum(BigDecimal memberAttachedNum){
      this.memberAttachedNum = memberAttachedNum;
   }

   /**
    * getter for MEMBER_POSSSESSION_NUM
    * @generated
    */
   public BigDecimal getMemberPosssessionNum(){
      return this.memberPosssessionNum;
   }
   /**
    * setter for MEMBER_POSSSESSION_NUM
    * @generated
    */
   public void setMemberPosssessionNum(BigDecimal memberPosssessionNum){
      this.memberPosssessionNum = memberPosssessionNum;
   }

   /**
    * getter for MEMBER_ORGAN_NUM
    * @generated
    */
   public BigDecimal getMemberOrganNum(){
      return this.memberOrganNum;
   }
   /**
    * setter for MEMBER_ORGAN_NUM
    * @generated
    */
   public void setMemberOrganNum(BigDecimal memberOrganNum){
      this.memberOrganNum = memberOrganNum;
   }

   /**
    * getter for MEMBER_OTHER_NUM
    * @generated
    */
   public BigDecimal getMemberOtherNum(){
      return this.memberOtherNum;
   }
   /**
    * setter for MEMBER_OTHER_NUM
    * @generated
    */
   public void setMemberOtherNum(BigDecimal memberOtherNum){
      this.memberOtherNum = memberOtherNum;
   }

   /**
    * getter for CHECK_PEOPLE_NAME
    * @generated
    */
   public String getCheckPeopleName(){
      return this.checkPeopleName;
   }
   /**
    * setter for CHECK_PEOPLE_NAME
    * @generated
    */
   public void setCheckPeopleName(String checkPeopleName){
      this.checkPeopleName = checkPeopleName;
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
    * getter for CHECK_ORGAN_NAME
    * @generated
    */
   public String getCheckOrganName(){
      return this.checkOrganName;
   }
   /**
    * setter for CHECK_ORGAN_NAME
    * @generated
    */
   public void setCheckOrganName(String checkOrganName){
      this.checkOrganName = checkOrganName;
   }

}