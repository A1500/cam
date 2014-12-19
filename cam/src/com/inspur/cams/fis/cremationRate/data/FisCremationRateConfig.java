package com.inspur.cams.fis.cremationRate.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:FisCremationRateConfig
 * @description:
 * @author:
 * @since:2012-11-16
 * @version:1.0
*/
 @Table(tableName = "FIS_CREMATION_RATE_CONFIG" , keyFields = "recordId")
public class FisCremationRateConfig extends StatefulDatabean {
   //RECORD_ID
   	@Rule(value="require")
	@Column(name = "RECORD_ID")
   private String recordId;
   //ID
	@Column(name = "ID")
   private String id;
   //NAME
	@Column(name = "NAME")
   private String name;
   //LEVE
	@Column(name = "LEVE")
   private String leve;
   //UPS
	@Column(name = "UPS")
   private String ups;
   //FLAG
	@Column(name = "FLAG")
   private String flag;
   //FULL_NAME
	@Column(name = "FULL_NAME")
   private String fullName;
   //IS_SELF
	@Column(name = "IS_SELF")
   private String isSelf;
   //SUM_YEAR
	@Column(name = "SUM_YEAR")
   private String sumYear;
   //TOTAL_NUM
   	@Rule(value="number")
	@Column(name = "TOTAL_NUM")
   private BigDecimal totalNum;
   //DEAD_RATE
   	@Rule(value="number")
	@Column(name = "DEAD_RATE")
   private BigDecimal deadRate;
   //DEAD_NUM
   	@Rule(value="number")
	@Column(name = "DEAD_NUM")
   private BigDecimal deadNum;
   //CREMATION_NUM
   	@Rule(value="number")
	@Column(name = "CREMATION_NUM")
   private BigDecimal cremationNum;
   //CREMATION_RATE
   	@Rule(value="number")
	@Column(name = "CREMATION_RATE")
   private BigDecimal cremationRate;
   //SUM_TIME
	@Column(name = "SUM_TIME")
   private String sumTime;
   //SUM_PEOPLE
	@Column(name = "SUM_PEOPLE")
   private String sumPeople;
   /**
    * getter for RECORD_ID
    * @generated
    */
   public String getRecordId(){
      return this.recordId;
   }
   /**
    * setter for RECORD_ID
    * @generated
    */
   public void setRecordId(String recordId){
      this.recordId = recordId;
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
    * getter for LEVE
    * @generated
    */
   public String getLeve(){
      return this.leve;
   }
   /**
    * setter for LEVE
    * @generated
    */
   public void setLeve(String leve){
      this.leve = leve;
   }

   /**
    * getter for UPS
    * @generated
    */
   public String getUps(){
      return this.ups;
   }
   /**
    * setter for UPS
    * @generated
    */
   public void setUps(String ups){
      this.ups = ups;
   }

   /**
    * getter for FLAG
    * @generated
    */
   public String getFlag(){
      return this.flag;
   }
   /**
    * setter for FLAG
    * @generated
    */
   public void setFlag(String flag){
      this.flag = flag;
   }

   /**
    * getter for FULL_NAME
    * @generated
    */
   public String getFullName(){
      return this.fullName;
   }
   /**
    * setter for FULL_NAME
    * @generated
    */
   public void setFullName(String fullName){
      this.fullName = fullName;
   }

   /**
    * getter for IS_SELF
    * @generated
    */
   public String getIsSelf(){
      return this.isSelf;
   }
   /**
    * setter for IS_SELF
    * @generated
    */
   public void setIsSelf(String isSelf){
      this.isSelf = isSelf;
   }

   /**
    * getter for SUM_YEAR
    * @generated
    */
   public String getSumYear(){
      return this.sumYear;
   }
   /**
    * setter for SUM_YEAR
    * @generated
    */
   public void setSumYear(String sumYear){
      this.sumYear = sumYear;
   }

   /**
    * getter for TOTAL_NUM
    * @generated
    */
   public BigDecimal getTotalNum(){
      return this.totalNum;
   }
   /**
    * setter for TOTAL_NUM
    * @generated
    */
   public void setTotalNum(BigDecimal totalNum){
      this.totalNum = totalNum;
   }

   /**
    * getter for DEAD_RATE
    * @generated
    */
   public BigDecimal getDeadRate(){
      return this.deadRate;
   }
   /**
    * setter for DEAD_RATE
    * @generated
    */
   public void setDeadRate(BigDecimal deadRate){
      this.deadRate = deadRate;
   }

   /**
    * getter for DEAD_NUM
    * @generated
    */
   public BigDecimal getDeadNum(){
      return this.deadNum;
   }
   /**
    * setter for DEAD_NUM
    * @generated
    */
   public void setDeadNum(BigDecimal deadNum){
      this.deadNum = deadNum;
   }

   /**
    * getter for CREMATION_NUM
    * @generated
    */
   public BigDecimal getCremationNum(){
      return this.cremationNum;
   }
   /**
    * setter for CREMATION_NUM
    * @generated
    */
   public void setCremationNum(BigDecimal cremationNum){
      this.cremationNum = cremationNum;
   }

   /**
    * getter for CREMATION_RATE
    * @generated
    */
   public BigDecimal getCremationRate(){
      return this.cremationRate;
   }
   /**
    * setter for CREMATION_RATE
    * @generated
    */
   public void setCremationRate(BigDecimal cremationRate){
      this.cremationRate = cremationRate;
   }

   /**
    * getter for SUM_TIME
    * @generated
    */
   public String getSumTime(){
      return this.sumTime;
   }
   /**
    * setter for SUM_TIME
    * @generated
    */
   public void setSumTime(String sumTime){
      this.sumTime = sumTime;
   }

   /**
    * getter for SUM_PEOPLE
    * @generated
    */
   public String getSumPeople(){
      return this.sumPeople;
   }
   /**
    * setter for SUM_PEOPLE
    * @generated
    */
   public void setSumPeople(String sumPeople){
      this.sumPeople = sumPeople;
   }

}