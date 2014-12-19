package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyBusiness
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_business" , keyFields = "id")
public class SamEsureyBusiness extends StatefulDatabean {
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
   //企业注册方式
	@Column(name = "BUSINESS_TYPE")
   private String businessType;
   //法人名称
	@Column(name = "LEGAL_PERSON")
   private String legalPerson;
   //企业名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //注册地址
	@Column(name = "REG_ADD")
   private String regAdd;
   //经营地址
	@Column(name = "BUSINESS_ADD")
   private String businessAdd;
   //注册资金
	@Column(name = "REG_FUND")
   private String regFund;
   //注册时间
	@Column(name = "REG_DATE")
   private String regDate;
   //经营范围
	@Column(name = "BUSINESS_SCOPE")
   private String businessScope;
   //企业当前状态
	@Column(name = "ORGAN_STATUS")
   private String organStatus;
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

   

   public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBusinessType() {
		return businessType;
	}

	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}

	/**
	 * getter for 法人名称
	 * 
	 * @generated
	 */
	public String getLegalPerson() {
		return this.legalPerson;
	}
   /**
    * setter for 法人名称
    * @generated
    */
   public void setLegalPerson(String legalPerson){
      this.legalPerson = legalPerson;
   }

   /**
    * getter for 企业名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 企业名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for 注册地址
    * @generated
    */
   public String getRegAdd(){
      return this.regAdd;
   }
   /**
    * setter for 注册地址
    * @generated
    */
   public void setRegAdd(String regAdd){
      this.regAdd = regAdd;
   }

   /**
    * getter for 经营地址
    * @generated
    */
   public String getBusinessAdd(){
      return this.businessAdd;
   }
   /**
    * setter for 经营地址
    * @generated
    */
   public void setBusinessAdd(String businessAdd){
      this.businessAdd = businessAdd;
   }

   /**
    * getter for 注册资金
    * @generated
    */
   public String getRegFund(){
      return this.regFund;
   }
   /**
    * setter for 注册资金
    * @generated
    */
   public void setRegFund(String regFund){
      this.regFund = regFund;
   }

   /**
    * getter for 注册时间
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for 注册时间
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }

   /**
    * getter for 经营范围
    * @generated
    */
   public String getBusinessScope(){
      return this.businessScope;
   }
   /**
    * setter for 经营范围
    * @generated
    */
   public void setBusinessScope(String businessScope){
      this.businessScope = businessScope;
   }

   /**
    * getter for 企业当前状态
    * @generated
    */
   public String getOrganStatus(){
      return this.organStatus;
   }
   /**
    * setter for 企业当前状态
    * @generated
    */
   public void setOrganStatus(String organStatus){
      this.organStatus = organStatus;
   }

}