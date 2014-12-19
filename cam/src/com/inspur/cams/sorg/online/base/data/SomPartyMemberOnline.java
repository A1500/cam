package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomPartyMemberOnline
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 @Table(tableName = "SOM_PARTY_MEMBER_ONLINE" , keyFields = "memberId")
public class SomPartyMemberOnline extends StatefulDatabean {
   //MEMBER_ID
   	
	@Column(name = "MEMBER_ID")
   private String memberId;
   //SORG_ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //PEOPLE_TYPE
	@Column(name = "PEOPLE_TYPE")
   private String peopleType;
   //NAME
	@Column(name = "NAME")
   private String name;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //FOLK
	@Column(name = "FOLK")
   private String folk;
   //EDUCATION
	@Column(name = "EDUCATION")
   private String education;
   //DEGREE
	@Column(name = "DEGREE")
   private String degree;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
   //SORG_DUTIES
	@Column(name = "SORG_DUTIES")
   private String sorgDuties;
   //PARTY_DUTIES
	@Column(name = "PARTY_DUTIES")
   private String partyDuties;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //WORK_DUTIES
	@Column(name = "WORK_DUTIES")
   private String workDuties;
   //PROFESSION
	@Column(name = "PROFESSION")
   private String profession;
   //IF_FULLTIME
	@Column(name = "IF_FULLTIME")
   private String ifFulltime;
   //IF_INSTRCTOR
	@Column(name = "IF_INSTRCTOR")
   private String ifInstrctor;
   //IF_OTHER_BRANCH
	@Column(name = "IF_OTHER_BRANCH")
   private String ifOtherBranch;
   //IN_OR_OUT
	@Column(name = "IN_OR_OUT")
   private String inOrOut;
   //IN_TIME
	@Column(name = "IN_TIME")
   private String inTime;
   //OUT_TIME
	@Column(name = "OUT_TIME")
   private String outTime;
   //IF_POOR
	@Column(name = "IF_POOR")
   private String ifPoor;
   //BELONG_ORG
	@Column(name = "BELONG_ORG")
   private String belongOrg;
   //RELATION
	@Column(name = "RELATION")
   private String relation;
   //JOIN_DATE
	@Column(name = "JOIN_DATE")
   private String joinDate;
   //NORMAL_DATE
	@Column(name = "NORMAL_DATE")
   private String normalDate;
   //NORMAL_INFO
	@Column(name = "NORMAL_INFO")
   private String normalInfo;
   //APPLICATION_DATE
	@Column(name = "APPLICATION_DATE")
   private String applicationDate;
   //ACTIVISTS_DATE
	@Column(name = "ACTIVISTS_DATE")
   private String activistsDate;
   //DEVELOP_DATE
	@Column(name = "DEVELOP_DATE")
   private String developDate;
   //BELONG_ORG_TYPE
	@Column(name = "BELONG_ORG_TYPE")
   private String belongOrgType;
   //IN_TYPE
	@Column(name = "IN_TYPE")
   private String inType;
   //IN_FROM_ORGAN
	@Column(name = "IN_FROM_ORGAN")
   private String inFromOrgan;
   //OUT_TYPE
	@Column(name = "OUT_TYPE")
   private String outType;
   //OUT_TO_ORGAN
	@Column(name = "OUT_TO_ORGAN")
   private String outToOrgan;
   //MEMBER_STATUS
	@Column(name = "MEMBER_STATUS")
   private String memberStatus;
   //MORG_NAME
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
	@Column(name = "MORG_AREA")
   private String morgArea;
   //REG_PEOPLE_ORGAN_ID
	@Column(name = "REG_PEOPLE_ORGAN_ID")
   private String regPeopleOrganId;
   //REG_PEOPLE
	@Column(name = "REG_PEOPLE")
   private String regPeople;
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
   //STATUS_CHANGE_DATE
	@Column(name = "STATUS_CHANGE_DATE")
   private String statusChangeDate;
   /**
    * getter for MEMBER_ID
    * @generated
    */
   public String getMemberId(){
      return this.memberId;
   }
   /**
    * setter for MEMBER_ID
    * @generated
    */
   public void setMemberId(String memberId){
      this.memberId = memberId;
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
    * getter for PEOPLE_TYPE
    * @generated
    */
   public String getPeopleType(){
      return this.peopleType;
   }
   /**
    * setter for PEOPLE_TYPE
    * @generated
    */
   public void setPeopleType(String peopleType){
      this.peopleType = peopleType;
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
    * getter for DEGREE
    * @generated
    */
   public String getDegree(){
      return this.degree;
   }
   /**
    * setter for DEGREE
    * @generated
    */
   public void setDegree(String degree){
      this.degree = degree;
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
    * getter for PARTY_DUTIES
    * @generated
    */
   public String getPartyDuties(){
      return this.partyDuties;
   }
   /**
    * setter for PARTY_DUTIES
    * @generated
    */
   public void setPartyDuties(String partyDuties){
      this.partyDuties = partyDuties;
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
    * getter for PROFESSION
    * @generated
    */
   public String getProfession(){
      return this.profession;
   }
   /**
    * setter for PROFESSION
    * @generated
    */
   public void setProfession(String profession){
      this.profession = profession;
   }

   /**
    * getter for IF_FULLTIME
    * @generated
    */
   public String getIfFulltime(){
      return this.ifFulltime;
   }
   /**
    * setter for IF_FULLTIME
    * @generated
    */
   public void setIfFulltime(String ifFulltime){
      this.ifFulltime = ifFulltime;
   }

   /**
    * getter for IF_INSTRCTOR
    * @generated
    */
   public String getIfInstrctor(){
      return this.ifInstrctor;
   }
   /**
    * setter for IF_INSTRCTOR
    * @generated
    */
   public void setIfInstrctor(String ifInstrctor){
      this.ifInstrctor = ifInstrctor;
   }

   /**
    * getter for IF_OTHER_BRANCH
    * @generated
    */
   public String getIfOtherBranch(){
      return this.ifOtherBranch;
   }
   /**
    * setter for IF_OTHER_BRANCH
    * @generated
    */
   public void setIfOtherBranch(String ifOtherBranch){
      this.ifOtherBranch = ifOtherBranch;
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
    * getter for IF_POOR
    * @generated
    */
   public String getIfPoor(){
      return this.ifPoor;
   }
   /**
    * setter for IF_POOR
    * @generated
    */
   public void setIfPoor(String ifPoor){
      this.ifPoor = ifPoor;
   }

   /**
    * getter for BELONG_ORG
    * @generated
    */
   public String getBelongOrg(){
      return this.belongOrg;
   }
   /**
    * setter for BELONG_ORG
    * @generated
    */
   public void setBelongOrg(String belongOrg){
      this.belongOrg = belongOrg;
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
    * getter for JOIN_DATE
    * @generated
    */
   public String getJoinDate(){
      return this.joinDate;
   }
   /**
    * setter for JOIN_DATE
    * @generated
    */
   public void setJoinDate(String joinDate){
      this.joinDate = joinDate;
   }

   /**
    * getter for NORMAL_DATE
    * @generated
    */
   public String getNormalDate(){
      return this.normalDate;
   }
   /**
    * setter for NORMAL_DATE
    * @generated
    */
   public void setNormalDate(String normalDate){
      this.normalDate = normalDate;
   }

   /**
    * getter for NORMAL_INFO
    * @generated
    */
   public String getNormalInfo(){
      return this.normalInfo;
   }
   /**
    * setter for NORMAL_INFO
    * @generated
    */
   public void setNormalInfo(String normalInfo){
      this.normalInfo = normalInfo;
   }

   /**
    * getter for APPLICATION_DATE
    * @generated
    */
   public String getApplicationDate(){
      return this.applicationDate;
   }
   /**
    * setter for APPLICATION_DATE
    * @generated
    */
   public void setApplicationDate(String applicationDate){
      this.applicationDate = applicationDate;
   }

   /**
    * getter for ACTIVISTS_DATE
    * @generated
    */
   public String getActivistsDate(){
      return this.activistsDate;
   }
   /**
    * setter for ACTIVISTS_DATE
    * @generated
    */
   public void setActivistsDate(String activistsDate){
      this.activistsDate = activistsDate;
   }

   /**
    * getter for DEVELOP_DATE
    * @generated
    */
   public String getDevelopDate(){
      return this.developDate;
   }
   /**
    * setter for DEVELOP_DATE
    * @generated
    */
   public void setDevelopDate(String developDate){
      this.developDate = developDate;
   }

   /**
    * getter for BELONG_ORG_TYPE
    * @generated
    */
   public String getBelongOrgType(){
      return this.belongOrgType;
   }
   /**
    * setter for BELONG_ORG_TYPE
    * @generated
    */
   public void setBelongOrgType(String belongOrgType){
      this.belongOrgType = belongOrgType;
   }

   /**
    * getter for IN_TYPE
    * @generated
    */
   public String getInType(){
      return this.inType;
   }
   /**
    * setter for IN_TYPE
    * @generated
    */
   public void setInType(String inType){
      this.inType = inType;
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
    * getter for OUT_TYPE
    * @generated
    */
   public String getOutType(){
      return this.outType;
   }
   /**
    * setter for OUT_TYPE
    * @generated
    */
   public void setOutType(String outType){
      this.outType = outType;
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
    * getter for MEMBER_STATUS
    * @generated
    */
   public String getMemberStatus(){
      return this.memberStatus;
   }
   /**
    * setter for MEMBER_STATUS
    * @generated
    */
   public void setMemberStatus(String memberStatus){
      this.memberStatus = memberStatus;
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
    * getter for REG_PEOPLE_ORGAN_ID
    * @generated
    */
   public String getRegPeopleOrganId(){
      return this.regPeopleOrganId;
   }
   /**
    * setter for REG_PEOPLE_ORGAN_ID
    * @generated
    */
   public void setRegPeopleOrganId(String regPeopleOrganId){
      this.regPeopleOrganId = regPeopleOrganId;
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
    * getter for STATUS_CHANGE_DATE
    * @generated
    */
   public String getStatusChangeDate(){
      return this.statusChangeDate;
   }
   /**
    * setter for STATUS_CHANGE_DATE
    * @generated
    */
   public void setStatusChangeDate(String statusChangeDate){
      this.statusChangeDate = statusChangeDate;
   }

}