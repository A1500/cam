package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
* @Package com.inspur.cams.fis.base.data.FisFuneralDeadInfo
* @Description: 数据上报，逝者信息
* @author jiangzhaobao 
* @date 2012-4-5
 */
 @Table(tableName = "FIS_FUNERAL_DEAD_INFO" , keyFields = "deadId")
public class FisFuneralDeadInfo extends StatefulDatabean {
   //DEAD_ID
   	@Rule(value="require")
	@Column(name = "DEAD_ID")
   private String deadId;
   //IF_NAMELESS
	@Column(name = "IF_NAMELESS")
   private String ifNameless;
   //NAME
	@Column(name = "NAME")
   private String name;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //CARD_TYPE
	@Column(name = "CARD_TYPE")
   private String cardType;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //AGE
	@Column(name = "AGE")
   private String age;
   //NATION
	@Column(name = "NATION")
   private String nation;
   //FOLK
	@Column(name = "FOLK")
   private String folk;
   //PROFESSION
	@Column(name = "PROFESSION")
   private String profession;
   //EDUCATION
	@Column(name = "EDUCATION")
   private String education;
   //POLITICAL
	@Column(name = "POLITICAL")
   private String political;
   //RELIGION
	@Column(name = "RELIGION")
   private String religion;
   //POPULACE
	@Column(name = "POPULACE")
   private String populace;
   //FAMILY_ADD
	@Column(name = "FAMILY_ADD")
   private String familyAdd;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //DEATH_DATE
	@Column(name = "DEATH_DATE")
   private String deathDate;
   //DEATH_PLACE
	@Column(name = "DEATH_PLACE")
   private String deathPlace;
   //DEATH_CAUSE
	@Column(name = "DEATH_CAUSE")
   private String deathCause;
   //DEATH_DISEASE
	@Column(name = "DEATH_DISEASE")
   private String deathDisease;
   //CORPSE_STATUS
	@Column(name = "CORPSE_STATUS")
   private String corpseStatus;
   //CORPSE_STATUS_NOTE
	@Column(name = "CORPSE_STATUS_NOTE")
   private String corpseStatusNote;
   //RELICS
	@Column(name = "RELICS")
   private String relics;
   //DEATH_CERT_ORG
	@Column(name = "DEATH_CERT_ORG")
   private String deathCertOrg;
   //DEATH_CERT_ORG_NAME
	@Column(name = "DEATH_CERT_ORG_NAME")
   private String deathCertOrgName;
   //PREFERENTIAL_TYPE
	@Column(name = "PREFERENTIAL_TYPE")
   private String preferentialType;
   //PREFERENTIAL_TYPE_NAME
	@Column(name = "PREFERENTIAL_TYPE_NAME")
   private String preferentialTypeName;
   //PHOTO_ID
	@Column(name = "PHOTO_ID")
   private String photoId;
   //ACCESSORIES
	@Column(name = "ACCESSORIES")
   private String accessories;
   //RECEIVE_TIME
	@Column(name = "RECEIVE_TIME")
   private String receiveTime;
   //START_TIME
	@Column(name = "START_TIME")
   private String startTime;
   //END_TIME
	@Column(name = "END_TIME")
   private String endTime;
   //STOVE_ID
	@Column(name = "STOVE_ID")
   private String stoveId;
   //STOVE_NO
	@Column(name = "STOVE_NO")
   private String stoveNo;
   //STOVE_PEOPLE
	@Column(name = "STOVE_PEOPLE")
   private String stovePeople;
   //IF_TODUST
	@Column(name = "IF_TODUST")
   private String ifTodust;
   //IF_TAKEASHES
	@Column(name = "IF_TAKEASHES")
   private String ifTakeashes;
   //TAKEASHES_TIME
	@Column(name = "TAKEASHES_TIME")
   private String takeashesTime;
   //ASHES_GO
	@Column(name = "ASHES_GO")
   private String ashesGo;
   //ORGAN_ID
	@Column(name = "ORGAN_ID")
   private String organId;
   //NOTE
	@Column(name = "NOTE")
   private String note;
   /**
    * getter for DEAD_ID
    * @generated
    */
   public String getDeadId(){
      return this.deadId;
   }
   /**
    * setter for DEAD_ID
    * @generated
    */
   public void setDeadId(String deadId){
      this.deadId = deadId;
   }

   /**
    * getter for IF_NAMELESS
    * @generated
    */
   public String getIfNameless(){
      return this.ifNameless;
   }
   /**
    * setter for IF_NAMELESS
    * @generated
    */
   public void setIfNameless(String ifNameless){
      this.ifNameless = ifNameless;
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
    * getter for AGE
    * @generated
    */
   public String getAge(){
      return this.age;
   }
   /**
    * setter for AGE
    * @generated
    */
   public void setAge(String age){
      this.age = age;
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
    * getter for POLITICAL
    * @generated
    */
   public String getPolitical(){
      return this.political;
   }
   /**
    * setter for POLITICAL
    * @generated
    */
   public void setPolitical(String political){
      this.political = political;
   }

   /**
    * getter for RELIGION
    * @generated
    */
   public String getReligion(){
      return this.religion;
   }
   /**
    * setter for RELIGION
    * @generated
    */
   public void setReligion(String religion){
      this.religion = religion;
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
    * getter for FAMILY_ADD
    * @generated
    */
   public String getFamilyAdd(){
      return this.familyAdd;
   }
   /**
    * setter for FAMILY_ADD
    * @generated
    */
   public void setFamilyAdd(String familyAdd){
      this.familyAdd = familyAdd;
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
    * getter for DEATH_DATE
    * @generated
    */
   public String getDeathDate(){
      return this.deathDate;
   }
   /**
    * setter for DEATH_DATE
    * @generated
    */
   public void setDeathDate(String deathDate){
      this.deathDate = deathDate;
   }

   /**
    * getter for DEATH_PLACE
    * @generated
    */
   public String getDeathPlace(){
      return this.deathPlace;
   }
   /**
    * setter for DEATH_PLACE
    * @generated
    */
   public void setDeathPlace(String deathPlace){
      this.deathPlace = deathPlace;
   }

   /**
    * getter for DEATH_CAUSE
    * @generated
    */
   public String getDeathCause(){
      return this.deathCause;
   }
   /**
    * setter for DEATH_CAUSE
    * @generated
    */
   public void setDeathCause(String deathCause){
      this.deathCause = deathCause;
   }

   /**
    * getter for DEATH_DISEASE
    * @generated
    */
   public String getDeathDisease(){
      return this.deathDisease;
   }
   /**
    * setter for DEATH_DISEASE
    * @generated
    */
   public void setDeathDisease(String deathDisease){
      this.deathDisease = deathDisease;
   }

   /**
    * getter for CORPSE_STATUS
    * @generated
    */
   public String getCorpseStatus(){
      return this.corpseStatus;
   }
   /**
    * setter for CORPSE_STATUS
    * @generated
    */
   public void setCorpseStatus(String corpseStatus){
      this.corpseStatus = corpseStatus;
   }

   /**
    * getter for CORPSE_STATUS_NOTE
    * @generated
    */
   public String getCorpseStatusNote(){
      return this.corpseStatusNote;
   }
   /**
    * setter for CORPSE_STATUS_NOTE
    * @generated
    */
   public void setCorpseStatusNote(String corpseStatusNote){
      this.corpseStatusNote = corpseStatusNote;
   }

   /**
    * getter for RELICS
    * @generated
    */
   public String getRelics(){
      return this.relics;
   }
   /**
    * setter for RELICS
    * @generated
    */
   public void setRelics(String relics){
      this.relics = relics;
   }

   /**
    * getter for DEATH_CERT_ORG
    * @generated
    */
   public String getDeathCertOrg(){
      return this.deathCertOrg;
   }
   /**
    * setter for DEATH_CERT_ORG
    * @generated
    */
   public void setDeathCertOrg(String deathCertOrg){
      this.deathCertOrg = deathCertOrg;
   }

   /**
    * getter for DEATH_CERT_ORG_NAME
    * @generated
    */
   public String getDeathCertOrgName(){
      return this.deathCertOrgName;
   }
   /**
    * setter for DEATH_CERT_ORG_NAME
    * @generated
    */
   public void setDeathCertOrgName(String deathCertOrgName){
      this.deathCertOrgName = deathCertOrgName;
   }

   /**
    * getter for PREFERENTIAL_TYPE
    * @generated
    */
   public String getPreferentialType(){
      return this.preferentialType;
   }
   /**
    * setter for PREFERENTIAL_TYPE
    * @generated
    */
   public void setPreferentialType(String preferentialType){
      this.preferentialType = preferentialType;
   }

   /**
    * getter for PREFERENTIAL_TYPE_NAME
    * @generated
    */
   public String getPreferentialTypeName(){
      return this.preferentialTypeName;
   }
   /**
    * setter for PREFERENTIAL_TYPE_NAME
    * @generated
    */
   public void setPreferentialTypeName(String preferentialTypeName){
      this.preferentialTypeName = preferentialTypeName;
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
    * getter for ACCESSORIES
    * @generated
    */
   public String getAccessories(){
      return this.accessories;
   }
   /**
    * setter for ACCESSORIES
    * @generated
    */
   public void setAccessories(String accessories){
      this.accessories = accessories;
   }

   /**
    * getter for RECEIVE_TIME
    * @generated
    */
   public String getReceiveTime(){
      return this.receiveTime;
   }
   /**
    * setter for RECEIVE_TIME
    * @generated
    */
   public void setReceiveTime(String receiveTime){
      this.receiveTime = receiveTime;
   }

   /**
    * getter for START_TIME
    * @generated
    */
   public String getStartTime(){
      return this.startTime;
   }
   /**
    * setter for START_TIME
    * @generated
    */
   public void setStartTime(String startTime){
      this.startTime = startTime;
   }

   /**
    * getter for END_TIME
    * @generated
    */
   public String getEndTime(){
      return this.endTime;
   }
   /**
    * setter for END_TIME
    * @generated
    */
   public void setEndTime(String endTime){
      this.endTime = endTime;
   }

   /**
    * getter for STOVE_ID
    * @generated
    */
   public String getStoveId(){
      return this.stoveId;
   }
   /**
    * setter for STOVE_ID
    * @generated
    */
   public void setStoveId(String stoveId){
      this.stoveId = stoveId;
   }

   /**
    * getter for STOVE_NO
    * @generated
    */
   public String getStoveNo(){
      return this.stoveNo;
   }
   /**
    * setter for STOVE_NO
    * @generated
    */
   public void setStoveNo(String stoveNo){
      this.stoveNo = stoveNo;
   }

   /**
    * getter for STOVE_PEOPLE
    * @generated
    */
   public String getStovePeople(){
      return this.stovePeople;
   }
   /**
    * setter for STOVE_PEOPLE
    * @generated
    */
   public void setStovePeople(String stovePeople){
      this.stovePeople = stovePeople;
   }

   /**
    * getter for IF_TODUST
    * @generated
    */
   public String getIfTodust(){
      return this.ifTodust;
   }
   /**
    * setter for IF_TODUST
    * @generated
    */
   public void setIfTodust(String ifTodust){
      this.ifTodust = ifTodust;
   }

   /**
    * getter for IF_TAKEASHES
    * @generated
    */
   public String getIfTakeashes(){
      return this.ifTakeashes;
   }
   /**
    * setter for IF_TAKEASHES
    * @generated
    */
   public void setIfTakeashes(String ifTakeashes){
      this.ifTakeashes = ifTakeashes;
   }

   /**
    * getter for TAKEASHES_TIME
    * @generated
    */
   public String getTakeashesTime(){
      return this.takeashesTime;
   }
   /**
    * setter for TAKEASHES_TIME
    * @generated
    */
   public void setTakeashesTime(String takeashesTime){
      this.takeashesTime = takeashesTime;
   }

   /**
    * getter for ASHES_GO
    * @generated
    */
   public String getAshesGo(){
      return this.ashesGo;
   }
   /**
    * setter for ASHES_GO
    * @generated
    */
   public void setAshesGo(String ashesGo){
      this.ashesGo = ashesGo;
   }

   /**
    * getter for ORGAN_ID
    * @generated
    */
   public String getOrganId(){
      return this.organId;
   }
   /**
    * setter for ORGAN_ID
    * @generated
    */
   public void setOrganId(String organId){
      this.organId = organId;
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

}