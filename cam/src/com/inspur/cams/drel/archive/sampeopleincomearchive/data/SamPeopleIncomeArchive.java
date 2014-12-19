package com.inspur.cams.drel.archive.sampeopleincomearchive.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleIncomeArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_INCOME_ARCHIVE" , keyFields = "incomeArchiveId")
public class SamPeopleIncomeArchive extends StatefulDatabean {
   //INCOME_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "INCOME_ARCHIVE_ID")
   private String incomeArchiveId;
   //INCOME_ID
   	@Rule(value="require")
	@Column(name = "INCOME_ID")
   private String incomeId;
   //PEOPLE_ARCHIVE_ID
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //PEOPLE_ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //INCOME_TYPE
	@Column(name = "INCOME_TYPE")
   private String incomeType;
   //INCOME_NAME
	@Column(name = "INCOME_NAME")
   private String incomeName;
   //INCOME_NUM
   	@Rule(value="number")
	@Column(name = "INCOME_NUM")
   private BigDecimal incomeNum;
   //CALCULATE_NUM
   	@Rule(value="number")
	@Column(name = "CALCULATE_NUM")
   private BigDecimal calculateNum;
   //ELIMINATE_NUM
   	@Rule(value="number")
	@Column(name = "ELIMINATE_NUM")
   private BigDecimal eliminateNum;
   //COMPUTE_MODE
	@Column(name = "COMPUTE_MODE")
   private String computeMode;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   /**
    * getter for INCOME_ARCHIVE_ID
    * @generated
    */
   public String getIncomeArchiveId(){
      return this.incomeArchiveId;
   }
   /**
    * setter for INCOME_ARCHIVE_ID
    * @generated
    */
   public void setIncomeArchiveId(String incomeArchiveId){
      this.incomeArchiveId = incomeArchiveId;
   }

   /**
    * getter for INCOME_ID
    * @generated
    */
   public String getIncomeId(){
      return this.incomeId;
   }
   /**
    * setter for INCOME_ID
    * @generated
    */
   public void setIncomeId(String incomeId){
      this.incomeId = incomeId;
   }

   /**
    * getter for PEOPLE_ARCHIVE_ID
    * @generated
    */
   public String getPeopleArchiveId(){
      return this.peopleArchiveId;
   }
   /**
    * setter for PEOPLE_ARCHIVE_ID
    * @generated
    */
   public void setPeopleArchiveId(String peopleArchiveId){
      this.peopleArchiveId = peopleArchiveId;
   }

   /**
    * getter for PEOPLE_ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for PEOPLE_ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for INCOME_TYPE
    * @generated
    */
   public String getIncomeType(){
      return this.incomeType;
   }
   /**
    * setter for INCOME_TYPE
    * @generated
    */
   public void setIncomeType(String incomeType){
      this.incomeType = incomeType;
   }

   /**
    * getter for INCOME_NAME
    * @generated
    */
   public String getIncomeName(){
      return this.incomeName;
   }
   /**
    * setter for INCOME_NAME
    * @generated
    */
   public void setIncomeName(String incomeName){
      this.incomeName = incomeName;
   }

   /**
    * getter for INCOME_NUM
    * @generated
    */
   public BigDecimal getIncomeNum(){
      return this.incomeNum;
   }
   /**
    * setter for INCOME_NUM
    * @generated
    */
   public void setIncomeNum(BigDecimal incomeNum){
      this.incomeNum = incomeNum;
   }

   /**
    * getter for CALCULATE_NUM
    * @generated
    */
   public BigDecimal getCalculateNum(){
      return this.calculateNum;
   }
   /**
    * setter for CALCULATE_NUM
    * @generated
    */
   public void setCalculateNum(BigDecimal calculateNum){
      this.calculateNum = calculateNum;
   }

   /**
    * getter for ELIMINATE_NUM
    * @generated
    */
   public BigDecimal getEliminateNum(){
      return this.eliminateNum;
   }
   /**
    * setter for ELIMINATE_NUM
    * @generated
    */
   public void setEliminateNum(BigDecimal eliminateNum){
      this.eliminateNum = eliminateNum;
   }

   /**
    * getter for COMPUTE_MODE
    * @generated
    */
   public String getComputeMode(){
      return this.computeMode;
   }
   /**
    * setter for COMPUTE_MODE
    * @generated
    */
   public void setComputeMode(String computeMode){
      this.computeMode = computeMode;
   }

   /**
    * getter for REMARKS
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for REMARKS
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }

   /**
    * getter for APPLY_ID
    * @generated
    */
   public String getApplyId(){
      return this.applyId;
   }
   /**
    * setter for APPLY_ID
    * @generated
    */
   public void setApplyId(String applyId){
      this.applyId = applyId;
   }

}