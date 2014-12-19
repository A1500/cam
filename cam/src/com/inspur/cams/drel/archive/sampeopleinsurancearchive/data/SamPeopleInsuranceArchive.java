package com.inspur.cams.drel.archive.sampeopleinsurancearchive.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleInsuranceArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_INSURANCE_ARCHIVE" , keyFields = "insuranceArchiveId")
public class SamPeopleInsuranceArchive extends StatefulDatabean {
   //INSURANCE_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "INSURANCE_ARCHIVE_ID")
   private String insuranceArchiveId;
   //INSURANCE_ID
   	@Rule(value="require")
	@Column(name = "INSURANCE_ID")
   private String insuranceId;
   //PEOPLE_ARCHIVE_ID
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //PEOPLE_ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //INSURANCE_NUMBER
	@Column(name = "INSURANCE_NUMBER")
   private String insuranceNumber;
   //INSURANCE_TYPE
	@Column(name = "INSURANCE_TYPE")
   private String insuranceType;
   //INSURANCE_FEE
   	@Rule(value="number")
	@Column(name = "INSURANCE_FEE")
   private BigDecimal insuranceFee;
   //INSURANCE_CYCLE
	@Column(name = "INSURANCE_CYCLE")
   private String insuranceCycle;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   /**
    * getter for INSURANCE_ARCHIVE_ID
    * @generated
    */
   public String getInsuranceArchiveId(){
      return this.insuranceArchiveId;
   }
   /**
    * setter for INSURANCE_ARCHIVE_ID
    * @generated
    */
   public void setInsuranceArchiveId(String insuranceArchiveId){
      this.insuranceArchiveId = insuranceArchiveId;
   }

   /**
    * getter for INSURANCE_ID
    * @generated
    */
   public String getInsuranceId(){
      return this.insuranceId;
   }
   /**
    * setter for INSURANCE_ID
    * @generated
    */
   public void setInsuranceId(String insuranceId){
      this.insuranceId = insuranceId;
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
    * getter for INSURANCE_NUMBER
    * @generated
    */
   public String getInsuranceNumber(){
      return this.insuranceNumber;
   }
   /**
    * setter for INSURANCE_NUMBER
    * @generated
    */
   public void setInsuranceNumber(String insuranceNumber){
      this.insuranceNumber = insuranceNumber;
   }

   /**
    * getter for INSURANCE_TYPE
    * @generated
    */
   public String getInsuranceType(){
      return this.insuranceType;
   }
   /**
    * setter for INSURANCE_TYPE
    * @generated
    */
   public void setInsuranceType(String insuranceType){
      this.insuranceType = insuranceType;
   }

   /**
    * getter for INSURANCE_FEE
    * @generated
    */
   public BigDecimal getInsuranceFee(){
      return this.insuranceFee;
   }
   /**
    * setter for INSURANCE_FEE
    * @generated
    */
   public void setInsuranceFee(BigDecimal insuranceFee){
      this.insuranceFee = insuranceFee;
   }

   /**
    * getter for INSURANCE_CYCLE
    * @generated
    */
   public String getInsuranceCycle(){
      return this.insuranceCycle;
   }
   /**
    * setter for INSURANCE_CYCLE
    * @generated
    */
   public void setInsuranceCycle(String insuranceCycle){
      this.insuranceCycle = insuranceCycle;
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

}