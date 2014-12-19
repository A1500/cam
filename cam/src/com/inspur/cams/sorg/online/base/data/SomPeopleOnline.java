package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomPeopleOnline
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 @Table(tableName = "SOM_PEOPLE_ONLINE" , keyFields = "peopleId")
public class SomPeopleOnline extends StatefulDatabean {
   //PEOPLE_ID
   	
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //NAME
	@Column(name = "NAME")
   private String name;
   //ALIAS_NAME
	@Column(name = "ALIAS_NAME")
   private String aliasName;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //FOLK
	@Column(name = "FOLK")
   private String folk;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //NATION
	@Column(name = "NATION")
   private String nation;
   //CARD_TYPE
	@Column(name = "CARD_TYPE")
   private String cardType;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //POLITICS
	@Column(name = "POLITICS")
   private String politics;
   //EDUCATION
	@Column(name = "EDUCATION")
   private String education;
   //POPULACE
	@Column(name = "POPULACE")
   private String populace;
   //BIRTHPLACE
	@Column(name = "BIRTHPLACE")
   private String birthplace;
   //ADDS
	@Column(name = "ADDS")
   private String adds;
   //POST_CODE
	@Column(name = "POST_CODE")
   private String postCode;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
   //IF_PARTY_LEADER
	@Column(name = "IF_PARTY_LEADER")
   private String ifPartyLeader;
   //IF_RETIRE
	@Column(name = "IF_RETIRE")
   private String ifRetire;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //WORK_PHONE
	@Column(name = "WORK_PHONE")
   private String workPhone;
   //WORK_DUTIES
	@Column(name = "WORK_DUTIES")
   private String workDuties;
   //PROFESSION
	@Column(name = "PROFESSION")
   private String profession;
   //IF_FULLTIME
	@Column(name = "IF_FULLTIME")
   private String ifFulltime;
   //PEOPLE_PARTY_TYPE
	@Column(name = "PEOPLE_PARTY_TYPE")
   private String peoplePartyType;
   //JOIN_DATE
	@Column(name = "JOIN_DATE")
   private String joinDate;
   //RELATION
	@Column(name = "RELATION")
   private String relation;
   //PARTY_DUTIES
	@Column(name = "PARTY_DUTIES")
   private String partyDuties;
   //IF_MOBLIE
	@Column(name = "IF_MOBLIE")
   private String ifMoblie;
   //DEVELOP_DATE
	@Column(name = "DEVELOP_DATE")
   private String developDate;
   //ACTIVISTS_DATE
	@Column(name = "ACTIVISTS_DATE")
   private String activistsDate;
   //APPLICATION_DATE
	@Column(name = "APPLICATION_DATE")
   private String applicationDate;
   //RESUME
	@Column(name = "RESUME")
   private String resume;
   //RELATIVE
	@Column(name = "RELATIVE")
   private String relative;
   //PHOTO_ID
	@Column(name = "PHOTO_ID")
   private String photoId;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //PERSON_UNIT
	@Column(name = "PERSON_UNIT")
   private String personUnit;
   //PERSON_UNIT_PHONE
	@Column(name = "PERSON_UNIT_PHONE")
   private String personUnitPhone;
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
    * getter for ALIAS_NAME
    * @generated
    */
   public String getAliasName(){
      return this.aliasName;
   }
   /**
    * setter for ALIAS_NAME
    * @generated
    */
   public void setAliasName(String aliasName){
      this.aliasName = aliasName;
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
    * getter for CARD_TYPE
    * @generated
    */
   public String getCardType(){
      return this.cardType;
   }
   /**
    * setter for CARD_TYPE
    * @generated
    */
   public void setCardType(String cardType){
      this.cardType = cardType;
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
    * getter for POPULACE
    * @generated
    */
   public String getPopulace(){
      return this.populace;
   }
   /**
    * setter for POPULACE
    * @generated
    */
   public void setPopulace(String populace){
      this.populace = populace;
   }

   /**
    * getter for BIRTHPLACE
    * @generated
    */
   public String getBirthplace(){
      return this.birthplace;
   }
   /**
    * setter for BIRTHPLACE
    * @generated
    */
   public void setBirthplace(String birthplace){
      this.birthplace = birthplace;
   }

   /**
    * getter for ADDS
    * @generated
    */
   public String getAdds(){
      return this.adds;
   }
   /**
    * setter for ADDS
    * @generated
    */
   public void setAdds(String adds){
      this.adds = adds;
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
    * getter for IF_PARTY_LEADER
    * @generated
    */
   public String getIfPartyLeader(){
      return this.ifPartyLeader;
   }
   /**
    * setter for IF_PARTY_LEADER
    * @generated
    */
   public void setIfPartyLeader(String ifPartyLeader){
      this.ifPartyLeader = ifPartyLeader;
   }

   /**
    * getter for IF_RETIRE
    * @generated
    */
   public String getIfRetire(){
      return this.ifRetire;
   }
   /**
    * setter for IF_RETIRE
    * @generated
    */
   public void setIfRetire(String ifRetire){
      this.ifRetire = ifRetire;
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
    * getter for WORK_PHONE
    * @generated
    */
   public String getWorkPhone(){
      return this.workPhone;
   }
   /**
    * setter for WORK_PHONE
    * @generated
    */
   public void setWorkPhone(String workPhone){
      this.workPhone = workPhone;
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
    * getter for PEOPLE_PARTY_TYPE
    * @generated
    */
   public String getPeoplePartyType(){
      return this.peoplePartyType;
   }
   /**
    * setter for PEOPLE_PARTY_TYPE
    * @generated
    */
   public void setPeoplePartyType(String peoplePartyType){
      this.peoplePartyType = peoplePartyType;
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
    * getter for IF_MOBLIE
    * @generated
    */
   public String getIfMoblie(){
      return this.ifMoblie;
   }
   /**
    * setter for IF_MOBLIE
    * @generated
    */
   public void setIfMoblie(String ifMoblie){
      this.ifMoblie = ifMoblie;
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
    * getter for RESUME
    * @generated
    */
   public String getResume(){
      return this.resume;
   }
   /**
    * setter for RESUME
    * @generated
    */
   public void setResume(String resume){
      this.resume = resume;
   }

   /**
    * getter for RELATIVE
    * @generated
    */
   public String getRelative(){
      return this.relative;
   }
   /**
    * setter for RELATIVE
    * @generated
    */
   public void setRelative(String relative){
      this.relative = relative;
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
    * getter for PERSON_UNIT
    * @generated
    */
   public String getPersonUnit(){
      return this.personUnit;
   }
   /**
    * setter for PERSON_UNIT
    * @generated
    */
   public void setPersonUnit(String personUnit){
      this.personUnit = personUnit;
   }

   /**
    * getter for PERSON_UNIT_PHONE
    * @generated
    */
   public String getPersonUnitPhone(){
      return this.personUnitPhone;
   }
   /**
    * setter for PERSON_UNIT_PHONE
    * @generated
    */
   public void setPersonUnitPhone(String personUnitPhone){
      this.personUnitPhone = personUnitPhone;
   }

}