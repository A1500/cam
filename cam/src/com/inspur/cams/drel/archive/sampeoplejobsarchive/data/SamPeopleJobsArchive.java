package com.inspur.cams.drel.archive.sampeoplejobsarchive.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleJobsArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_JOBS_ARCHIVE" , keyFields = "jobArchiveId")
public class SamPeopleJobsArchive extends StatefulDatabean {
   //JOB_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "JOB_ARCHIVE_ID")
   private String jobArchiveId;
   //JOB_ID
   	@Rule(value="require")
	@Column(name = "JOB_ID")
   private String jobId;
   //PEOPLE_ARCHIVE_ID
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //PEOPLE_ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //UNIT_NAME
	@Column(name = "UNIT_NAME")
   private String unitName;
   //UNIT_NATURE
	@Column(name = "UNIT_NATURE")
   private String unitNature;
   //UNIT_INDUSTRY
	@Column(name = "UNIT_INDUSTRY")
   private String unitIndustry;
   //AFFILIATION
	@Column(name = "AFFILIATION")
   private String affiliation;
   //CONTACT_PEOPLE
	@Column(name = "CONTACT_PEOPLE")
   private String contactPeople;
   //CONTACT_PHONE
	@Column(name = "CONTACT_PHONE")
   private String contactPhone;
   //ADDRESS
	@Column(name = "ADDRESS")
   private String address;
   //POST_CODE
	@Column(name = "POST_CODE")
   private String postCode;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   /**
    * getter for JOB_ARCHIVE_ID
    * @generated
    */
   public String getJobArchiveId(){
      return this.jobArchiveId;
   }
   /**
    * setter for JOB_ARCHIVE_ID
    * @generated
    */
   public void setJobArchiveId(String jobArchiveId){
      this.jobArchiveId = jobArchiveId;
   }

   /**
    * getter for JOB_ID
    * @generated
    */
   public String getJobId(){
      return this.jobId;
   }
   /**
    * setter for JOB_ID
    * @generated
    */
   public void setJobId(String jobId){
      this.jobId = jobId;
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
    * getter for UNIT_NAME
    * @generated
    */
   public String getUnitName(){
      return this.unitName;
   }
   /**
    * setter for UNIT_NAME
    * @generated
    */
   public void setUnitName(String unitName){
      this.unitName = unitName;
   }

   /**
    * getter for UNIT_NATURE
    * @generated
    */
   public String getUnitNature(){
      return this.unitNature;
   }
   /**
    * setter for UNIT_NATURE
    * @generated
    */
   public void setUnitNature(String unitNature){
      this.unitNature = unitNature;
   }

   /**
    * getter for UNIT_INDUSTRY
    * @generated
    */
   public String getUnitIndustry(){
      return this.unitIndustry;
   }
   /**
    * setter for UNIT_INDUSTRY
    * @generated
    */
   public void setUnitIndustry(String unitIndustry){
      this.unitIndustry = unitIndustry;
   }

   /**
    * getter for AFFILIATION
    * @generated
    */
   public String getAffiliation(){
      return this.affiliation;
   }
   /**
    * setter for AFFILIATION
    * @generated
    */
   public void setAffiliation(String affiliation){
      this.affiliation = affiliation;
   }

   /**
    * getter for CONTACT_PEOPLE
    * @generated
    */
   public String getContactPeople(){
      return this.contactPeople;
   }
   /**
    * setter for CONTACT_PEOPLE
    * @generated
    */
   public void setContactPeople(String contactPeople){
      this.contactPeople = contactPeople;
   }

   /**
    * getter for CONTACT_PHONE
    * @generated
    */
   public String getContactPhone(){
      return this.contactPhone;
   }
   /**
    * setter for CONTACT_PHONE
    * @generated
    */
   public void setContactPhone(String contactPhone){
      this.contactPhone = contactPhone;
   }

   /**
    * getter for ADDRESS
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for ADDRESS
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for POST_CODE
    * @generated
    */
   public String getPostCode(){
      return this.postCode;
   }
   /**
    * setter for POST_CODE
    * @generated
    */
   public void setPostCode(String postCode){
      this.postCode = postCode;
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