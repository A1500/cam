package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyPeopleEstate
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_people_estate" , keyFields = "id")
public class SamEsureyPeopleEstate extends StatefulDatabean {
   //流水ID
	@Column(name = "ID")
   private String id;
   //填报ID
	@Column(name = "FEEDBACK_ID")
   private String feedbackId;
   //核对流水ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //信息类别
	@Column(name = "TYPE")
   private String type;
   //年月区分标志
	@Column(name = "PERIOD")
   private String period;
   //财产、收入类别
	@Column(name = "ITEM")
   private String item;
   //金额
	@Column(name = "NUM")
   private String num;
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
    * getter for 年月区分标志
    * @generated
    */
   public String getPeriod(){
      return this.period;
   }
   /**
    * setter for 年月区分标志
    * @generated
    */
   public void setPeriod(String period){
      this.period = period;
   }

   /**
    * getter for 财产、收入类别
    * @generated
    */
   public String getItem(){
      return this.item;
   }
   /**
    * setter for 财产、收入类别
    * @generated
    */
   public void setItem(String item){
      this.item = item;
   }

   /**
    * getter for 金额
    * @generated
    */
   public String getNum(){
      return this.num;
   }
   /**
    * setter for 金额
    * @generated
    */
   public void setNum(String num){
      this.num = num;
   }
public String getSurveyId() {
	return surveyId;
}
public void setSurveyId(String surveyId) {
	this.surveyId = surveyId;
}
public String getFamilyId() {
	return familyId;
}
public void setFamilyId(String familyId) {
	this.familyId = familyId;
}

}