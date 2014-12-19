package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptRegularInformationCue
 * @description:
 * @author:
 * @since:2011-06-03
 * @version:1.0
*/
 @Table(tableName = "BPT_REGULAR_INFORMATION_CUE" , keyFields = "informationCueId")
public class BptRegularInformationCue extends StatefulDatabean {
   //信息提示ID
	@Column(name = "INFORMATION_CUE_ID")
   private String informationCueId;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //姓名
	@Column(name = "NAME")
   private String name;
   //性别
	@Column(name = "SEX")
   private String sex;
   //民族
	@Column(name = "NATION")
   private String nation;
   //身份证件号码
	@Column(name = "ID_CARD")
   private String idCard;
   //生日
	private String birthday;
	//年龄
	private String age;
	//属地行政区划
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
	//属地行政区划名称
   private String domicileName;
   //优抚对象状态
	@Column(name = "OBJECT_STATE")
   private String objectState;
   //优抚对象类别
	@Column(name = "OBJECT_TYPE")
   private String objectType;
   //提示时间
	@Column(name = "CUE_DATE")
   private String cueDate;
   //提示信息类别
	@Column(name = "CUE_INFO_TYPE")
   private String cueInfoType;
   //提示信息内容
	@Column(name = "CUE_INFO_CONTENT")
   private String cueInfoContent;
   //确认标志
	@Column(name = "CONFIRM_FLAG")
   private String confirmFlag;
   //确认时间
	@Column(name = "CONFIRM_TIME")
   private String confirmTime;
   //确认人ID
	@Column(name = "CONFIRM_PEOSON_ID")
   private String confirmPeosonId;
   /**
    * getter for 信息提示ID
    * @generated
    */
   public String getInformationCueId(){
      return this.informationCueId;
   }
   /**
    * setter for 信息提示ID
    * @generated
    */
   public void setInformationCueId(String informationCueId){
      this.informationCueId = informationCueId;
   }

   /**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 性别
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for 性别
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for 民族
    * @generated
    */
   public String getNation(){
      return this.nation;
   }
   /**
    * setter for 民族
    * @generated
    */
   public void setNation(String nation){
      this.nation = nation;
   }

   /**
    * getter for 身份证件号码
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for 身份证件号码
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for 优抚对象状态
    * @generated
    */
   public String getObjectState(){
      return this.objectState;
   }
   /**
    * setter for 优抚对象状态
    * @generated
    */
   public void setObjectState(String objectState){
      this.objectState = objectState;
   }

   /**
    * getter for 优抚对象类别
    * @generated
    */
   public String getObjectType(){
      return this.objectType;
   }
   /**
    * setter for 优抚对象类别
    * @generated
    */
   public void setObjectType(String objectType){
      this.objectType = objectType;
   }

   /**
    * getter for 提示时间
    * @generated
    */
   public String getCueDate(){
      return this.cueDate;
   }
   /**
    * setter for 提示时间
    * @generated
    */
   public void setCueDate(String cueDate){
      this.cueDate = cueDate;
   }

   /**
    * getter for 提示信息类别
    * @generated
    */
   public String getCueInfoType(){
      return this.cueInfoType;
   }
   /**
    * setter for 提示信息类别
    * @generated
    */
   public void setCueInfoType(String cueInfoType){
      this.cueInfoType = cueInfoType;
   }

   /**
    * getter for 提示信息内容
    * @generated
    */
   public String getCueInfoContent(){
      return this.cueInfoContent;
   }
   /**
    * setter for 提示信息内容
    * @generated
    */
   public void setCueInfoContent(String cueInfoContent){
      this.cueInfoContent = cueInfoContent;
   }

   /**
    * getter for 确认标志
    * @generated
    */
   public String getConfirmFlag(){
      return this.confirmFlag;
   }
   /**
    * setter for 确认标志
    * @generated
    */
   public void setConfirmFlag(String confirmFlag){
      this.confirmFlag = confirmFlag;
   }

   /**
    * getter for 确认时间
    * @generated
    */
   public String getConfirmTime(){
      return this.confirmTime;
   }
   /**
    * setter for 确认时间
    * @generated
    */
   public void setConfirmTime(String confirmTime){
      this.confirmTime = confirmTime;
   }

   /**
    * getter for 确认人ID
    * @generated
    */
   public String getConfirmPeosonId(){
      return this.confirmPeosonId;
   }
   /**
    * setter for 确认人ID
    * @generated
    */
   public void setConfirmPeosonId(String confirmPeosonId){
      this.confirmPeosonId = confirmPeosonId;
   }
/**
 * @return the domicileCode
 */
public String getDomicileCode() {
	return domicileCode;
}
/**
 * @param domicileCode the domicileCode to set
 */
public void setDomicileCode(String domicileCode) {
	this.domicileCode = domicileCode;
}
/**
 * @return the birthday
 */
public String getBirthday() {
	return birthday;
}
/**
 * @param birthday the birthday to set
 */
public void setBirthday(String birthday) {
	this.birthday = birthday;
}
/**
 * @return the age
 */
public String getAge() {
	return age;
}
/**
 * @param age the age to set
 */
public void setAge(String age) {
	this.age = age;
}
/**
 * @return the domicileName
 */
public String getDomicileName() {
	return domicileName;
}
/**
 * @param domicileName the domicileName to set
 */
public void setDomicileName(String domicileName) {
	this.domicileName = domicileName;
}

}