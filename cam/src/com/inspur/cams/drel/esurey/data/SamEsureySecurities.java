package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureySecurities
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_securities" , keyFields = "id")
public class SamEsureySecurities extends StatefulDatabean {
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
   //开户人姓名
	@Column(name = "NAME")
   private String name;
   //股票市值总金额
	@Column(name = "STOCK")
   private String stock;
   //基金市值总金额
	@Column(name = "FUND")
   private String fund;
   //资金总余额
	@Column(name = "MONEY")
   private String money;
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
    * getter for 开户人姓名
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for 开户人姓名
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for 股票市值总金额
    * @generated
    */
   public String getStock(){
      return this.stock;
   }
   /**
    * setter for 股票市值总金额
    * @generated
    */
   public void setStock(String stock){
      this.stock = stock;
   }

   /**
    * getter for 基金市值总金额
    * @generated
    */
   public String getFund(){
      return this.fund;
   }
   /**
    * setter for 基金市值总金额
    * @generated
    */
   public void setFund(String fund){
      this.fund = fund;
   }

   /**
    * getter for 资金总余额
    * @generated
    */
   public String getMoney(){
      return this.money;
   }
   /**
    * setter for 资金总余额
    * @generated
    */
   public void setMoney(String money){
      this.money = money;
   }
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}

}