package com.inspur.cams.sorg.online.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomAspchiefOnline
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 @Table(tableName = "SOM_ASPCHIEF_ONLINE" , keyFields = "id")
public class SomAspchiefOnline extends StatefulDatabean {
   //ID

	@Column(name = "ID")
   private String id;
   //SORG_ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //TASK_CODE

	@Column(name = "TASK_CODE")
   private String taskCode;
   //ELECTION_ID
	@Column(name = "ELECTION_ID")
   private String electionId;
   //NAME

	@Column(name = "NAME")
   private String name;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //ID_CARD
	@Column(name = "ID_CARD")
   private String idCard;
   //POLITICS
	@Column(name = "POLITICS")
   private String politics;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //WORK_DUTIES
	@Column(name = "WORK_DUTIES")
   private String workDuties;
   //POPULACE
	@Column(name = "POPULACE")
   private String populace;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
   //SORG_DUTIES
	@Column(name = "SORG_DUTIES")
   private String sorgDuties;
   //PROMISE_ORGAN
	@Column(name = "PROMISE_ORGAN")
   private String promiseOrgan;
   //PROMISE_CODE
	@Column(name = "PROMISE_CODE")
   private String promiseCode;
   //PROMISE_DATE
	@Column(name = "PROMISE_DATE")
   private String promiseDate;
   //MORG_NAME

	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA

	@Column(name = "MORG_AREA")
   private String morgArea;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //OTHER_DUTIES
	@Column(name = "OTHER_DUTIES")
   private String otherDuties;
   //PENAL
	@Column(name = "PENAL")
   private String penal;
   //IF_RETIRE
	@Column(name = "IF_RETIRE")
   private String ifRetire;
   //IF_FULLTIME
	@Column(name = "IF_FULLTIME")
   private String ifFulltime;
   //RELATIVE
	@Column(name = "RELATIVE")
   private String relative;
   //CITIZENSHIP
	@Column(name = "CITIZENSHIP")
   private String citizenship;
   //CARD_TYPE
	@Column(name = "CARD_TYPE")
   private String cardType;
   //POST_CODE
	@Column(name = "POST_CODE")
   private String postCode;
   //FOLK
	@Column(name = "FOLK")
   private String folk;
   //AGE
	@Column(name = "AGE")
   private String age;

   //是否是拟任法定代表人
   private String ifLegal;
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
    * getter for ELECTION_ID
    * @generated
    */
   public String getElectionId(){
      return this.electionId;
   }
   /**
    * setter for ELECTION_ID
    * @generated
    */
   public void setElectionId(String electionId){
      this.electionId = electionId;
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
    * getter for PROMISE_ORGAN
    * @generated
    */
   public String getPromiseOrgan(){
      return this.promiseOrgan;
   }
   /**
    * setter for PROMISE_ORGAN
    * @generated
    */
   public void setPromiseOrgan(String promiseOrgan){
      this.promiseOrgan = promiseOrgan;
   }

   /**
    * getter for PROMISE_CODE
    * @generated
    */
   public String getPromiseCode(){
      return this.promiseCode;
   }
   /**
    * setter for PROMISE_CODE
    * @generated
    */
   public void setPromiseCode(String promiseCode){
      this.promiseCode = promiseCode;
   }

   /**
    * getter for PROMISE_DATE
    * @generated
    */
   public String getPromiseDate(){
      return this.promiseDate;
   }
   /**
    * setter for PROMISE_DATE
    * @generated
    */
   public void setPromiseDate(String promiseDate){
      this.promiseDate = promiseDate;
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
    * getter for OTHER_DUTIES
    * @generated
    */
   public String getOtherDuties(){
      return this.otherDuties;
   }
   /**
    * setter for OTHER_DUTIES
    * @generated
    */
   public void setOtherDuties(String otherDuties){
      this.otherDuties = otherDuties;
   }

   /**
    * getter for PENAL
    * @generated
    */
   public String getPenal(){
      return this.penal;
   }
   /**
    * setter for PENAL
    * @generated
    */
   public void setPenal(String penal){
      this.penal = penal;
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
    * getter for CITIZENSHIP
    * @generated
    */
   public String getCitizenship(){
      return this.citizenship;
   }
   /**
    * setter for CITIZENSHIP
    * @generated
    */
   public void setCitizenship(String citizenship){
      this.citizenship = citizenship;
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
public String getIfLegal() {
	return ifLegal;
}
public void setIfLegal(String ifLegal) {
	this.ifLegal = ifLegal;
}

}