package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyTax
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_tax" , keyFields = "id")
public class SamEsureyTax extends StatefulDatabean {
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
   //纳税类型
	@Column(name = "TAXES_TYPE")
   private String taxesType;
   //纳税人姓名
	@Column(name = "TAXES_PEOPLE")
   private String taxesPeople;
   //纳税企业名称
	@Column(name = "TAXES_ORG")
   private String taxesOrg;
   //最近一年营业额
	@Column(name = "TURNOVER_LATEST_YEAR")
   private String turnoverLatestYear;
   //最近一年纳税额
	@Column(name = "TAXES_LATEST_YEAR")
   private String taxesLatestYear;
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
    * getter for 信息类别
    * @generated
    */
   public String getType(){
      return this.type;
   }
   /**
    * setter for 信息类别
    * @generated
    */
   public void setType(String type){
      this.type = type;
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
    * getter for 纳税类型
    * @generated
    */
   public String getTaxesType(){
      return this.taxesType;
   }
   /**
    * setter for 纳税类型
    * @generated
    */
   public void setTaxesType(String taxesType){
      this.taxesType = taxesType;
   }

   /**
    * getter for 纳税人姓名
    * @generated
    */
   public String getTaxesPeople(){
      return this.taxesPeople;
   }
   /**
    * setter for 纳税人姓名
    * @generated
    */
   public void setTaxesPeople(String taxesPeople){
      this.taxesPeople = taxesPeople;
   }

   /**
    * getter for 纳税企业名称
    * @generated
    */
   public String getTaxesOrg(){
      return this.taxesOrg;
   }
   /**
    * setter for 纳税企业名称
    * @generated
    */
   public void setTaxesOrg(String taxesOrg){
      this.taxesOrg = taxesOrg;
   }

   /**
    * getter for 最近一年营业额
    * @generated
    */
   public String getTurnoverLatestYear(){
      return this.turnoverLatestYear;
   }
   /**
    * setter for 最近一年营业额
    * @generated
    */
   public void setTurnoverLatestYear(String turnoverLatestYear){
      this.turnoverLatestYear = turnoverLatestYear;
   }

   /**
    * getter for 最近一年纳税额
    * @generated
    */
   public String getTaxesLatestYear(){
      return this.taxesLatestYear;
   }
   /**
    * setter for 最近一年纳税额
    * @generated
    */
   public void setTaxesLatestYear(String taxesLatestYear){
      this.taxesLatestYear = taxesLatestYear;
   }

}