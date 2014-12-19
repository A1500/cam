package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyHousingFund
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_housing_fund" , keyFields = "id")
public class SamEsureyHousingFund extends StatefulDatabean {
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
   //公积金姓名
	@Column(name = "NAME")
   private String name;
   //月缴纳公积金金额
	@Column(name = "MONTH_PAY")
   private String monthPay;
   //公积金余额
	@Column(name = "BALANCE")
   private String balance;
   //历史提取金额合计
	@Column(name = "COLLECT_NUM")
   private String collectNum;
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
    * getter for 公积金姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 公积金姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 月缴纳公积金金额
    * @generated
    */
   public String getNonthPay(){
      return this.monthPay;
   }
   /**
    * setter for 月缴纳公积金金额
    * @generated
    */
   public void setNonthPay(String monthPay){
      this.monthPay = monthPay;
   }

   /**
    * getter for 公积金余额
    * @generated
    */
   public String getBalance(){
      return this.balance;
   }
   /**
    * setter for 公积金余额
    * @generated
    */
   public void setBalance(String balance){
      this.balance = balance;
   }

   /**
    * getter for 历史提取金额合计
    * @generated
    */
   public String getCollectNum(){
      return this.collectNum;
   }
   /**
    * setter for 历史提取金额合计
    * @generated
    */
   public void setCollectNun(String collectNum){
      this.collectNum = collectNum;
   }
public String getType() {
	return type;
}
public String getMonthPay() {
	return monthPay;
}
public void setMonthPay(String monthPay) {
	this.monthPay = monthPay;
}
public void setCollectNum(String collectNum) {
	this.collectNum = collectNum;
}
public void setType(String type) {
	this.type = type;
}

}