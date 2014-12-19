package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyInsurance
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_insurance" , keyFields = "id")
public class SamEsureyInsurance extends StatefulDatabean {
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
   //保险受益人
	@Column(name = "BENEFIT_PEOPLE")
   private String benefitPeople;
   //受益时间
	@Column(name = "BENEFIT_DATE")
   private String benefitDate;
   //保险受益种类
	@Column(name = "BENEFIT_TYPE")
   private String benefitType;
   //保险受益金额
	@Column(name = "BENEFIT_NUM")
   private String benefitNum;
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
    * getter for 保险受益人
    * @generated
    */
   public String getBenefitPeople(){
      return this.benefitPeople;
   }
   /**
    * setter for 保险受益人
    * @generated
    */
   public void setBenefitPeople(String benefitPeople){
      this.benefitPeople = benefitPeople;
   }

   /**
    * getter for 受益时间
    * @generated
    */
   public String getBenefitDate(){
      return this.benefitDate;
   }
   /**
    * setter for 受益时间
    * @generated
    */
   public void setBenefitDate(String benefitDate){
      this.benefitDate = benefitDate;
   }

   /**
    * getter for 保险受益种类
    * @generated
    */
   public String getBenefitType(){
      return this.benefitType;
   }
   /**
    * setter for 保险受益种类
    * @generated
    */
   public void setBenefitType(String benefitType){
      this.benefitType = benefitType;
   }

   /**
    * getter for 保险受益金额
    * @generated
    */
   public String getBenefitNum(){
      return this.benefitNum;
   }
   /**
    * setter for 保险受益金额
    * @generated
    */
   public void setBenefitNum(String benefitNum){
      this.benefitNum = benefitNum;
   }
public String getType() {
	return type;
}
public void setType(String type) {
	this.type = type;
}

}