package com.inspur.cams.sorg.check.somcheckcouncilmember.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckCouncilMember
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_COUNCIL_MEMBER" , keyFields = "id")
public class SomCheckCouncilMember extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //MEETING_TIMES
	@Column(name = "MEETING_TIMES")
   private BigDecimal meetingTimes;
   //REMARK_DATE
	@Column(name = "REMARK_DATE")
   private String remarkDate;
   //SORG_DUTY
	@Column(name = "SORG_DUTY")
   private String sorgDuty;
   //WORK_AND_DUTY
	@Column(name = "WORK_AND_DUTY")
   private String workAndDuty;
   //POLITICAL
	@Column(name = "POLITICAL")
   private String political;
   //BIRTHDAY
	@Column(name = "BIRTHDAY")
   private String birthday;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //NAME
	@Column(name = "NAME")
   private String name;
   //SEQ_NUM
	@Column(name = "SEQ_NUM")
   private String seqNum;
   //PEOPLE_TYPE
	@Column(name = "PEOPLE_TYPE")
   private String peopleType;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //MONEY
	@Column(name = "MONEY")
   private BigDecimal money;
   //ALLOWANCE
	@Column(name = "ALLOWANCE")
   private BigDecimal allowance;
   //DUTY_DATE
	@Column(name = "DUTY_DATE")
   private String dutyDate;
   //BETREFFZEILE
	@Column(name = "BETREFFZEILE")
   private String betreffzeile;
   //AVERAGE_YEARLY_SALARY
	@Column(name = "AVERAGE_YEARLY_SALARY")
   private BigDecimal averageYearlySalary;
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
    * getter for MEETING_TIMES
    * @generated
    */
   public BigDecimal getMeetingTimes(){
      return this.meetingTimes;
   }
   /**
    * setter for MEETING_TIMES
    * @generated
    */
   public void setMeetingTimes(BigDecimal meetingTimes){
      this.meetingTimes = meetingTimes;
   }

   /**
    * getter for REMARK_DATE
    * @generated
    */
   public String getRemarkDate(){
      return this.remarkDate;
   }
   /**
    * setter for REMARK_DATE
    * @generated
    */
   public void setRemarkDate(String remarkDate){
      this.remarkDate = remarkDate;
   }

   /**
    * getter for SORG_DUTY
    * @generated
    */
   public String getSorgDuty(){
      return this.sorgDuty;
   }
   /**
    * setter for SORG_DUTY
    * @generated
    */
   public void setSorgDuty(String sorgDuty){
      this.sorgDuty = sorgDuty;
   }

   /**
    * getter for WORK_AND_DUTY
    * @generated
    */
   public String getWorkAndDuty(){
      return this.workAndDuty;
   }
   /**
    * setter for WORK_AND_DUTY
    * @generated
    */
   public void setWorkAndDuty(String workAndDuty){
      this.workAndDuty = workAndDuty;
   }

   /**
    * getter for POLITICAL
    * @generated
    */
   public String getPolitical(){
      return this.political;
   }
   /**
    * setter for POLITICAL
    * @generated
    */
   public void setPolitical(String political){
      this.political = political;
   }

   /**
    * getter for BIRTHDAY
    * @generated
    */
   public String getBirthday(){
      return this.birthday;
   }
   /**
    * setter for BIRTHDAY
    * @generated
    */
   public void setBirthday(String birthday){
      this.birthday = birthday;
   }

   /**
    * getter for SEX
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for SEX
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for NAME
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for NAME
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for SEQ_NUM
    * @generated
    */
   public String getSeqNum(){
      return this.seqNum;
   }
   /**
    * setter for SEQ_NUM
    * @generated
    */
   public void setSeqNum(String seqNum){
      this.seqNum = seqNum;
   }

   /**
    * getter for PEOPLE_TYPE
    * @generated
    */
   public String getPeopleType(){
      return this.peopleType;
   }
   /**
    * setter for PEOPLE_TYPE
    * @generated
    */
   public void setPeopleType(String peopleType){
      this.peopleType = peopleType;
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
    * getter for MONEY
    * @generated
    */
   public BigDecimal getMoney(){
      return this.money;
   }
   /**
    * setter for MONEY
    * @generated
    */
   public void setMoney(BigDecimal money){
      this.money = money;
   }

   /**
    * getter for ALLOWANCE
    * @generated
    */
   public BigDecimal getAllowance(){
      return this.allowance;
   }
   /**
    * setter for ALLOWANCE
    * @generated
    */
   public void setAllowance(BigDecimal allowance){
      this.allowance = allowance;
   }

   /**
    * getter for DUTY_DATE
    * @generated
    */
   public String getDutyDate(){
      return this.dutyDate;
   }
   /**
    * setter for DUTY_DATE
    * @generated
    */
   public void setDutyDate(String dutyDate){
      this.dutyDate = dutyDate;
   }

   /**
    * getter for BETREFFZEILE
    * @generated
    */
   public String getBetreffzeile(){
      return this.betreffzeile;
   }
   /**
    * setter for BETREFFZEILE
    * @generated
    */
   public void setBetreffzeile(String betreffzeile){
      this.betreffzeile = betreffzeile;
   }

   /**
    * getter for AVERAGE_YEARLY_SALARY
    * @generated
    */
   public BigDecimal getAverageYearlySalary(){
      return this.averageYearlySalary;
   }
   /**
    * setter for AVERAGE_YEARLY_SALARY
    * @generated
    */
   public void setAverageYearlySalary(BigDecimal averageYearlySalary){
      this.averageYearlySalary = averageYearlySalary;
   }

}