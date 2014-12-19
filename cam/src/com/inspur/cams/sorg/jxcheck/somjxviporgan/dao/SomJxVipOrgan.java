package com.inspur.cams.sorg.jxcheck.somjxviporgan.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:江西会员和机构设置情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_VIP_ORGAN" , keyFields = "id")
public class SomJxVipOrgan extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //UNITS_NUM
   	@Rule(value="number")
	@Column(name = "UNITS_NUM")
   private BigDecimal unitsNum;
   //PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "PEOPLE_NUM")
   private BigDecimal peopleNum;
   //START_DATE
	@Column(name = "START_DATE")
   private String startDate;
   //DUTY_LIMIT
	@Column(name = "DUTY_LIMIT")
   private String dutyLimit;
   //COUNCIL_NUM
   	@Rule(value="number")
	@Column(name = "COUNCIL_NUM")
   private BigDecimal councilNum;
   //STAND_COUNCIL_NUM
   	@Rule(value="number")
	@Column(name = "STAND_COUNCIL_NUM")
   private BigDecimal standCouncilNum;
   //AUDITOR_NUM
   	@Rule(value="number")
	@Column(name = "AUDITOR_NUM")
   private BigDecimal auditorNum;
   //SECRETARY_NUM
   	@Rule(value="number")
	@Column(name = "SECRETARY_NUM")
   private BigDecimal secretaryNum;
   //DAILY_NUM
   	@Rule(value="number")
	@Column(name = "DAILY_NUM")
   private BigDecimal dailyNum;
   //ORGAN_NUM
   	@Rule(value="number")
	@Column(name = "ORGAN_NUM")
   private BigDecimal organNum;
   //SPECIAL_NUM
   	@Rule(value="number")
	@Column(name = "SPECIAL_NUM")
   private BigDecimal specialNum;
   //ENTITY_NUM
   	@Rule(value="number")
	@Column(name = "ENTITY_NUM")
   private BigDecimal entityNum;
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
    * getter for UNITS_NUM
    * @generated
    */
   public BigDecimal getUnitsNum(){
      return this.unitsNum;
   }
   /**
    * setter for UNITS_NUM
    * @generated
    */
   public void setUnitsNum(BigDecimal unitsNum){
      this.unitsNum = unitsNum;
   }

   /**
    * getter for PEOPLE_NUM
    * @generated
    */
   public BigDecimal getPeopleNum(){
      return this.peopleNum;
   }
   /**
    * setter for PEOPLE_NUM
    * @generated
    */
   public void setPeopleNum(BigDecimal peopleNum){
      this.peopleNum = peopleNum;
   }

   /**
    * getter for START_DATE
    * @generated
    */
   public String getStartDate(){
      return this.startDate;
   }
   /**
    * setter for START_DATE
    * @generated
    */
   public void setStartDate(String startDate){
      this.startDate = startDate;
   }

   /**
    * getter for DUTY_LIMIT
    * @generated
    */
   public String getDutyLimit(){
      return this.dutyLimit;
   }
   /**
    * setter for DUTY_LIMIT
    * @generated
    */
   public void setDutyLimit(String dutyLimit){
      this.dutyLimit = dutyLimit;
   }

   /**
    * getter for COUNCIL_NUM
    * @generated
    */
   public BigDecimal getCouncilNum(){
      return this.councilNum;
   }
   /**
    * setter for COUNCIL_NUM
    * @generated
    */
   public void setCouncilNum(BigDecimal councilNum){
      this.councilNum = councilNum;
   }

   /**
    * getter for STAND_COUNCIL_NUM
    * @generated
    */
   public BigDecimal getStandCouncilNum(){
      return this.standCouncilNum;
   }
   /**
    * setter for STAND_COUNCIL_NUM
    * @generated
    */
   public void setStandCouncilNum(BigDecimal standCouncilNum){
      this.standCouncilNum = standCouncilNum;
   }

   /**
    * getter for AUDITOR_NUM
    * @generated
    */
   public BigDecimal getAuditorNum(){
      return this.auditorNum;
   }
   /**
    * setter for AUDITOR_NUM
    * @generated
    */
   public void setAuditorNum(BigDecimal auditorNum){
      this.auditorNum = auditorNum;
   }

   /**
    * getter for SECRETARY_NUM
    * @generated
    */
   public BigDecimal getSecretaryNum(){
      return this.secretaryNum;
   }
   /**
    * setter for SECRETARY_NUM
    * @generated
    */
   public void setSecretaryNum(BigDecimal secretaryNum){
      this.secretaryNum = secretaryNum;
   }

   /**
    * getter for DAILY_NUM
    * @generated
    */
   public BigDecimal getDailyNum(){
      return this.dailyNum;
   }
   /**
    * setter for DAILY_NUM
    * @generated
    */
   public void setDailyNum(BigDecimal dailyNum){
      this.dailyNum = dailyNum;
   }

   /**
    * getter for ORGAN_NUM
    * @generated
    */
   public BigDecimal getOrganNum(){
      return this.organNum;
   }
   /**
    * setter for ORGAN_NUM
    * @generated
    */
   public void setOrganNum(BigDecimal organNum){
      this.organNum = organNum;
   }

   /**
    * getter for SPECIAL_NUM
    * @generated
    */
   public BigDecimal getSpecialNum(){
      return this.specialNum;
   }
   /**
    * setter for SPECIAL_NUM
    * @generated
    */
   public void setSpecialNum(BigDecimal specialNum){
      this.specialNum = specialNum;
   }

   /**
    * getter for ENTITY_NUM
    * @generated
    */
   public BigDecimal getEntityNum(){
      return this.entityNum;
   }
   /**
    * setter for ENTITY_NUM
    * @generated
    */
   public void setEntityNum(BigDecimal entityNum){
      this.entityNum = entityNum;
   }

}