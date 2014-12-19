package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyHouse
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_house" , keyFields = "id")
public class SamEsureyHouse extends StatefulDatabean {
   //流水ID
	@Column(name = "ID")
   private String id;
   //填报ID
	@Column(name = "FEEDBACK_ID")
   private String feedbackId;
   //信息类别
	@Column(name = "TYPE")
   private String type;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //房产证号
	@Column(name = "HOUSE_CARD_NO")
   private String houseCardNo;
   //房屋性质
	@Column(name = "HOUSE_PROP")
   private String houseProp;
   //房屋类别
	@Column(name = "HOUSE_TYPE")
   private String houseType;
   //产权人姓名
	@Column(name = "HOUSE_OWER")
   private String houseOwer;
   //身份证号
	@Column(name = "OWER_ID_CARD")
   private String owerIdCard;
   //房屋用途
	@Column(name = "HOUSE_USEAGE")
   private String houseUseage;
   //登记价值
	@Column(name = "REG_VALUE")
   private String regValue;
   //登记或交易时间
	@Column(name = "REG_DATE")
   private String regDate;
   //交易性质
	@Column(name = "BUSINESS_TYPE")
   private String businessType;
   //备案时间
	@Column(name = "RECORD_DATE")
   private String recordDate;
   //房屋坐落
	@Column(name = "LOCATION")
   private String location;
   //使用面积
	@Column(name = "HOUSE_AREA")
   private String houseArea;
   /**
    * getter for 流水ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 流水ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 填报ID
    * @generated
    */
   public String getFeedbackId(){
      return this.feedbackId;
   }
   /**
    * setter for 填报ID
    * @generated
    */
   public void setFeedbackId(String feedbackId){
      this.feedbackId = feedbackId;
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
    * getter for 房产证号
    * @generated
    */
   public String getHouseCardNo(){
      return this.houseCardNo;
   }
   /**
    * setter for 房产证号
    * @generated
    */
   public void setHouseCardNo(String houseCardNo){
      this.houseCardNo = houseCardNo;
   }

   /**
    * getter for 房屋性质
    * @generated
    */
   public String getHouseProp(){
      return this.houseProp;
   }
   /**
    * setter for 房屋性质
    * @generated
    */
   public void setHouseProp(String houseProp){
      this.houseProp = houseProp;
   }

   /**
    * getter for 房屋类别
    * @generated
    */
   public String getHouseType(){
      return this.houseType;
   }
   /**
    * setter for 房屋类别
    * @generated
    */
   public void setHouseType(String houseType){
      this.houseType = houseType;
   }

   /**
    * getter for 产权人姓名
    * @generated
    */
   public String getHouseOwer(){
      return this.houseOwer;
   }
   /**
    * setter for 产权人姓名
    * @generated
    */
   public void setHouseOwer(String houseOwer){
      this.houseOwer = houseOwer;
   }

   /**
    * getter for 身份证号
    * @generated
    */
   public String getOwerIdCard(){
      return this.owerIdCard;
   }
   /**
    * setter for 身份证号
    * @generated
    */
   public void setOwerIdCard(String owerIdCard){
      this.owerIdCard = owerIdCard;
   }

   /**
    * getter for 房屋用途
    * @generated
    */
   public String getHouseUseage(){
      return this.houseUseage;
   }
   /**
    * setter for 房屋用途
    * @generated
    */
   public void setHouseUseage(String houseUseage){
      this.houseUseage = houseUseage;
   }

   /**
    * getter for 登记价值
    * @generated
    */
   public String getRegValue(){
      return this.regValue;
   }
   /**
    * setter for 登记价值
    * @generated
    */
   public void setRegValue(String regValue){
      this.regValue = regValue;
   }

   /**
    * getter for 登记或交易时间
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for 登记或交易时间
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }

   /**
    * getter for 交易性质
    * @generated
    */
   public String getBusinessType(){
      return this.businessType;
   }
   /**
    * setter for 交易性质
    * @generated
    */
   public void setBusinessType(String businessType){
      this.businessType = businessType;
   }

   /**
    * getter for 备案时间
    * @generated
    */
   public String getRecordDate(){
      return this.recordDate;
   }
   /**
    * setter for 备案时间
    * @generated
    */
   public void setRecordDate(String recordDate){
      this.recordDate = recordDate;
   }

   /**
    * getter for 房屋坐落
    * @generated
    */
   public String getLocation(){
      return this.location;
   }
   /**
    * setter for 房屋坐落
    * @generated
    */
   public void setLocation(String location){
      this.location = location;
   }

   /**
    * getter for 使用面积
    * @generated
    */
   public String getHouseArea(){
      return this.houseArea;
   }
   /**
    * setter for 使用面积
    * @generated
    */
   public void setHouseArea(String houseArea){
      this.houseArea = houseArea;
   }
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}

}