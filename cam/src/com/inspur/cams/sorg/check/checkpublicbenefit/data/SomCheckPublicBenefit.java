package com.inspur.cams.sorg.check.checkpublicbenefit.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:公益活动情况
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_PUBLIC_BENEFIT" , keyFields = "id")
public class SomCheckPublicBenefit extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SEQUENCE
	@Column(name = "SEQUENCE")
   private String sequence;
   //ACTIVITY_NAME
	@Column(name = "ACTIVITY_NAME")
   private String activityName;
   //PERSON_NUM
	@Column(name = "PERSON_NUM")
   private String personNum;
   //ACTIVITY_DATE
	@Column(name = "ACTIVITY_DATE")
   private String activityDate;
   //SOCIAL_BENEFITS
	@Column(name = "SOCIAL_BENEFITS")
   private String socialBenefits;
   //INCOME
	@Column(name = "INCOME")
   private String income;
   //EXPENDITURE
	@Column(name = "EXPENDITURE")
   private String expenditure;
   //START_YEAR
	@Column(name = "START_YEAR")
   private String startYear;
   //END_YEAR
	@Column(name = "END_YEAR")
   private String endYear;
	
	private String activityNum;
	
	private String itemYear;
   public String getActivityNum() {
		return activityNum;
	}
	public void setActivityNum(String activityNum) {
		this.activityNum = activityNum;
	}
	public String getItemYear() {
		return itemYear;
	}
	public void setItemYear(String itemYear) {
		this.itemYear = itemYear;
	}
/**
    * getter for ID
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for ID
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for SEQUENCE
    * @generated
    */
   public String getSequence(){
      return this.sequence;
   }
   /**
    * setter for SEQUENCE
    * @generated
    */
   public void setSequence(String sequence){
      this.sequence = sequence;
   }

   /**
    * getter for ACTIVITY_NAME
    * @generated
    */
   public String getActivityName(){
      return this.activityName;
   }
   /**
    * setter for ACTIVITY_NAME
    * @generated
    */
   public void setActivityName(String activityName){
      this.activityName = activityName;
   }

   /**
    * getter for PERSON_NUM
    * @generated
    */
   public String getPersonNum(){
      return this.personNum;
   }
   /**
    * setter for PERSON_NUM
    * @generated
    */
   public void setPersonNum(String personNum){
      this.personNum = personNum;
   }

   /**
    * getter for ACTIVITY_DATE
    * @generated
    */
   public String getActivityDate(){
      return this.activityDate;
   }
   /**
    * setter for ACTIVITY_DATE
    * @generated
    */
   public void setActivityDate(String activityDate){
      this.activityDate = activityDate;
   }

   /**
    * getter for SOCIAL_BENEFITS
    * @generated
    */
   public String getSocialBenefits(){
      return this.socialBenefits;
   }
   /**
    * setter for SOCIAL_BENEFITS
    * @generated
    */
   public void setSocialBenefits(String socialBenefits){
      this.socialBenefits = socialBenefits;
   }

   /**
    * getter for INCOME
    * @generated
    */
   public String getIncome(){
      return this.income;
   }
   /**
    * setter for INCOME
    * @generated
    */
   public void setIncome(String income){
      this.income = income;
   }

   /**
    * getter for EXPENDITURE
    * @generated
    */
   public String getExpenditure(){
      return this.expenditure;
   }
   /**
    * setter for EXPENDITURE
    * @generated
    */
   public void setExpenditure(String expenditure){
      this.expenditure = expenditure;
   }

   /**
    * getter for START_YEAR
    * @generated
    */
   public String getStartYear(){
      return this.startYear;
   }
   /**
    * setter for START_YEAR
    * @generated
    */
   public void setStartYear(String startYear){
      this.startYear = startYear;
   }

   /**
    * getter for END_YEAR
    * @generated
    */
   public String getEndYear(){
      return this.endYear;
   }
   /**
    * setter for END_YEAR
    * @generated
    */
   public void setEndYear(String endYear){
      this.endYear = endYear;
   }

}