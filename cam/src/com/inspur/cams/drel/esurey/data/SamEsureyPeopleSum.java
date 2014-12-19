package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyPeopleSum
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_people_sum" , keyFields = "surveyId")
public class SamEsureyPeopleSum extends StatefulDatabean {
   //核对流水ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //年收入
	@Column(name = "INCOME_YEAR")
   private String incomeYear;
   //月收入
	@Column(name = "INCOME_MONTH")
   private String incomeMonth;
   /**
    * getter for 核对流水ID
    * @generated
    */
   public String getSurveyId(){
      return this.surveyId;
   }
   /**
    * setter for 核对流水ID
    * @generated
    */
   public void setSurveyId(String surveyId){
      this.surveyId = surveyId;
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
    * getter for 家庭ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for 家庭ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
   }

   /**
    * getter for 年收入
    * @generated
    */
   public String getIncomeYear(){
      return this.incomeYear;
   }
   /**
    * setter for 年收入
    * @generated
    */
   public void setIncomeYear(String incomeYear){
      this.incomeYear = incomeYear;
   }

   /**
    * getter for 月收入
    * @generated
    */
   public String getIncomeMonth(){
      return this.incomeMonth;
   }
   /**
    * setter for 月收入
    * @generated
    */
   public void setIncomeMonth(String incomeMonth){
      this.incomeMonth = incomeMonth;
   }

}