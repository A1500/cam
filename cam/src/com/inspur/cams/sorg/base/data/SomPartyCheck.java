package com.inspur.cams.sorg.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 社会组织党建情况年报表
 * @author yanliangliang
 * @date 2011-9-19
 */
 @Table(tableName = "SOM_PARTY_CHECK" , keyFields = "ycheckId")
public class SomPartyCheck extends StatefulDatabean {
   //年报ID
   private String ycheckId;
   
   //社会组织ID
   private String sorgId;
   
   //年报年份
   private String yearly;
   
   //社会组织名称
   private String sorgName;
   
   //业务主管单位
   private String borgName;
   
   //社会组织种类
   private String sorgType;
   
   //是否建立党组织
   private String ifBuildParty;
   
   //从业人员数
   private BigDecimal engagedNum;
   
   //法定代表人
   private String legalPeople;
   
   //政治面貌
   private String politics;
   
   //党组织建制
   private String buildType;
   
   //联合支部名称
   private String combined;
   
   //党组织类型
   private String partyType;
   
   //成立日期
   private String buildDate;
   
   //审批单位
   private String auditOrgan;
   
   //隶属关系
   private String belongRel;
   
   //隶属关系说明
   private String belongRelDesc;
   
   //党组织负责人
   private String partyChief;
   
   //电话
   private String phone;
   
   //社会组织职务
   private String sorgDuties;
   
   //未建立原因
   private String nobuildReason;
   
   //党建指导员
   private String instructor;
   
   //指导员工作单位
   private String instructorWorkName;
   
   //党员人数
   private BigDecimal memberNum;
   
   //领导专职人员党员数
   private BigDecimal leaderFullNum;
   
   //领导兼职人员党员数
   private BigDecimal leaderPartNum;
   
   //工作兼职人员党员数
   private BigDecimal workerPartNum;
   
   //工作专职人员党员数
   private BigDecimal workerFullNum;
   
   //组织关系
   private String relation;
   
   //组织关系说明
   private String relationDesc;
   
   //申请入党人数
   private BigDecimal appPartyNum;
   
   //积极分子人数
   private BigDecimal energeticNum;
   
   //发展对象人数
   private BigDecimal developNum;
   
   //已建群团组织
   private String groupType;
   
   //已建群团组织说明
   private String groupDesc;
   
   //登记人
   private String regPeople;
   
   //登记日期
   private String regDate;
	
   //录入人
   private String createPeople;
   
   //录入时间
   private String createTime;
   
   //修改人
   private String modPeople;
   
   //修改时间
   private String modTime;
   
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
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
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
    * getter for LEADER_FULL_NUM
    * @generated
    */
   public BigDecimal getLeaderFullNum(){
      return this.leaderFullNum;
   }
   /**
    * setter for LEADER_FULL_NUM
    * @generated
    */
   public void setLeaderFullNum(BigDecimal leaderFullNum){
      this.leaderFullNum = leaderFullNum;
   }

   /**
    * getter for LEADER_PART_NUM
    * @generated
    */
   public BigDecimal getLeaderPartNum(){
      return this.leaderPartNum;
   }
   /**
    * setter for LEADER_PART_NUM
    * @generated
    */
   public void setLeaderPartNum(BigDecimal leaderPartNum){
      this.leaderPartNum = leaderPartNum;
   }

   /**
    * getter for WORKER_PART_NUM
    * @generated
    */
   public BigDecimal getWorkerPartNum(){
      return this.workerPartNum;
   }
   /**
    * setter for WORKER_PART_NUM
    * @generated
    */
   public void setWorkerPartNum(BigDecimal workerPartNum){
      this.workerPartNum = workerPartNum;
   }

   /**
    * getter for WORKER_FULL_NUM
    * @generated
    */
   public BigDecimal getWorkerFullNum(){
      return this.workerFullNum;
   }
   /**
    * setter for WORKER_FULL_NUM
    * @generated
    */
   public void setWorkerFullNum(BigDecimal workerFullNum){
      this.workerFullNum = workerFullNum;
   }

   /**
    * getter for RELATION
    * @generated
    */
   public String getRelation(){
      return this.relation;
   }
   /**
    * setter for RELATION
    * @generated
    */
   public void setRelation(String relation){
      this.relation = relation;
   }

   /**
    * getter for RELATION_DESC
    * @generated
    */
   public String getRelationDesc(){
      return this.relationDesc;
   }
   /**
    * setter for RELATION_DESC
    * @generated
    */
   public void setRelationDesc(String relationDesc){
      this.relationDesc = relationDesc;
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

}