package com.inspur.cams.drel.esurey.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamEsureySocial
 * @description:
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
 @Table(tableName = "sam_esurey_social" , keyFields = "id")
public class SamEsureySocial extends StatefulDatabean {
   //流水ID
	@Column(name = "ID")
   private String id;
   //信息类别
	@Column(name = "TYPE")
   private String type;
   //填报ID
	@Column(name = "FEEDBACK_ID")
   private String feedbackId;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //年月区分标志
	@Column(name = "YEAR_MONTH")
   private String yearMonth;
   //工资类别
	@Column(name = "SALARY_TYPE")
   private String salaryType;
   //工资、养老金金额
	@Column(name = "SALARY")
   private String salary;
   //养老金缴纳金额
	@Column(name = "PENSION")
   private String pension;
   //养老金余额
	@Column(name = "PENSION_BALANCE")
   private String pensionBalance;
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
    * getter for 年月区分标志
    * @generated
    */
   public String getYearMonth(){
      return this.yearMonth;
   }
   /**
    * setter for 年月区分标志
    * @generated
    */
   public void setYearMonth(String yearMonth){
      this.yearMonth = yearMonth;
   }

   /**
    * getter for 工资类别
    * @generated
    */
   public String getSalaryType(){
      return this.salaryType;
   }
   /**
    * setter for 工资类别
    * @generated
    */
   public void setSalaryType(String salaryType){
      this.salaryType = salaryType;
   }

   /**
    * getter for 工资、养老金金额
    * @generated
    */
   public String getSalary(){
      return this.salary;
   }
   /**
    * setter for 工资、养老金金额
    * @generated
    */
   public void setSalary(String salary){
      this.salary = salary;
   }

   /**
    * getter for 养老金缴纳金额
    * @generated
    */
   public String getPension(){
      return this.pension;
   }
   /**
    * setter for 养老金缴纳金额
    * @generated
    */
   public void setPension(String pension){
      this.pension = pension;
   }

   /**
    * getter for 养老金余额
    * @generated
    */
   public String getPensionBalance(){
      return this.pensionBalance;
   }
   /**
    * setter for 养老金余额
    * @generated
    */
   public void setPensionBalance(String pensionBalance){
      this.pensionBalance = pensionBalance;
   }

}