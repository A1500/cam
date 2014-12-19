package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureyFamilySum
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_family_sum" , keyFields = "surveyId")
public class SamEsureyFamilySum extends StatefulDatabean {
   //核对流水ID
	@Column(name = "SURVEY_ID")
   private String surveyId;
   //家庭ID
	@Column(name = "FAMILY_ID")
   private String familyId;
   //家庭年总财产
	@Column(name = "FAMILY_WORTH")
   private String familyWorth;
   //家庭年总收入
	@Column(name = "YEAR_INCOME")
   private String yearIncome;
   //家庭年人均收入
	@Column(name = "YEAR_AVERAGE_INCOME")
   private String yearAverageIncome;
   //家庭月总收入
	@Column(name = "MONTH_INCOME")
   private String monthIncome;
   //家庭月人均收入
	@Column(name = "MONTH_AVERAGE_INCOME")
   private String monthAverageIncome;
   //赡养费（年）
	@Column(name = "YEAR_SUPPORT_MON")
   private String yearSupportMon;
   //赡养费（月）
	@Column(name = "MONTH_SUPPORT_MONON")
   private String monthSupportMonon;
   //家庭诚信等级
	@Column(name = "CREDIT_RATING")
   private String creditRating;
	//低收入类型
	@Column(name = "LOW_INCOME_TYPE")
   private String lowIncomeType;
	//有效期限
	@Column(name = "VALID_PERIOD")
   private String validPeriod;
	//有效期至
	@Column(name = "VALID_DATE")
   private String validDate;
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
    * getter for 家庭年总收入
    * @generated
    */
   public String getYearIncome(){
      return this.yearIncome;
   }
   /**
    * setter for 家庭年总收入
    * @generated
    */
   public void setYearIncome(String yearIncome){
      this.yearIncome = yearIncome;
   }

   /**
    * getter for 家庭年人均收入
    * @generated
    */
   public String getYearAverageIncome(){
      return this.yearAverageIncome;
   }
   /**
    * setter for 家庭年人均收入
    * @generated
    */
   public void setYearAverageIncome(String yearAverageIncome){
      this.yearAverageIncome = yearAverageIncome;
   }

   /**
    * getter for 家庭月总收入
    * @generated
    */
   public String getMonthIncome(){
      return this.monthIncome;
   }
   /**
    * setter for 家庭月总收入
    * @generated
    */
   public void setMonthIncome(String monthIncome){
      this.monthIncome = monthIncome;
   }

   /**
    * getter for 家庭月人均收入
    * @generated
    */
   public String getMonthAverageIncome(){
      return this.monthAverageIncome;
   }
   /**
    * setter for 家庭月人均收入
    * @generated
    */
   public void setMonthAverageIncome(String monthAverageIncome){
      this.monthAverageIncome = monthAverageIncome;
   }

   /**
    * getter for 家庭诚信等级
    * @generated
    */
   public String getCreditRating(){
      return this.creditRating;
   }
   /**
    * setter for 家庭诚信等级
    * @generated
    */
   public void setCreditRating(String creditRating){
      this.creditRating = creditRating;
   }
public String getFamilyWorth() {
	return familyWorth;
}
public void setFamilyWorth(String familyWorth) {
	this.familyWorth = familyWorth;
}
public String getYearSupportMon() {
	return yearSupportMon;
}
public void setYearSupportMon(String yearSupportMon) {
	this.yearSupportMon = yearSupportMon;
}
public String getMonthSupportMonon() {
	return monthSupportMonon;
}
public void setMonthSupportMonon(String monthSupportMonon) {
	this.monthSupportMonon = monthSupportMonon;
}
public String getLowIncomeType() {
	return lowIncomeType;
}
public void setLowIncomeType(String lowIncomeType) {
	this.lowIncomeType = lowIncomeType;
}
public String getValidPeriod() {
	return validPeriod;
}
public void setValidPeriod(String validPeriod) {
	this.validPeriod = validPeriod;
}
public String getValidDate() {
	return validDate;
}
public void setValidDate(String validDate) {
	this.validDate = validDate;
}

}