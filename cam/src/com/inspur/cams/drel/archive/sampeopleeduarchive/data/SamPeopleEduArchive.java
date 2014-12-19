package com.inspur.cams.drel.archive.sampeopleeduarchive.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleEduArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_EDU_ARCHIVE" , keyFields = "eduArchiveId")
public class SamPeopleEduArchive extends StatefulDatabean {
   //EDU_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "EDU_ARCHIVE_ID")
   private String eduArchiveId;
   //PEOPLE_ARCHIVE_ID
   @Rule(value="require")
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //PEOPLE_ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
   //EDUCATION
	@Column(name = "EDUCATION")
   private String education;
   //GRADE
	@Column(name = "GRADE")
   private String grade;
   //EDU_STATUS
	@Column(name = "EDU_STATUS")
   private String eduStatus;
   //SCHOOL
	@Column(name = "SCHOOL")
   private String school;
   //SCHOOL_TYPE
	@Column(name = "SCHOOL_TYPE")
   private String schoolType;
   //IS_CHOOSE
	@Column(name = "IS_CHOOSE")
   private String isChoose;
   //EDU_YEAR
   	@Rule(value="number")
	@Column(name = "EDU_YEAR")
   private BigDecimal eduYear;
   //ENTRANCE_DATE
	@Column(name = "ENTRANCE_DATE")
   private String entranceDate;
   //GRADUATION_DATE
	@Column(name = "GRADUATION_DATE")
   private String graduationDate;
   //CONECT_PEOPLE
	@Column(name = "CONECT_PEOPLE")
   private String conectPeople;
   //CONECT_PHONE
	@Column(name = "CONECT_PHONE")
   private String conectPhone;
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
    * getter for EDU_ARCHIVE_ID
    * @generated
    */
   public String getEduArchiveId(){
      return this.eduArchiveId;
   }
   /**
    * setter for EDU_ARCHIVE_ID
    * @generated
    */
   public void setEduArchiveId(String eduArchiveId){
      this.eduArchiveId = eduArchiveId;
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
    * getter for REG_DATE
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for REG_DATE
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }

   /**
    * getter for EDUCATION
    * @generated
    */
   public String getEducation(){
      return this.education;
   }
   /**
    * setter for EDUCATION
    * @generated
    */
   public void setEducation(String education){
      this.education = education;
   }

   /**
    * getter for GRADE
    * @generated
    */
   public String getGrade(){
      return this.grade;
   }
   /**
    * setter for GRADE
    * @generated
    */
   public void setGrade(String grade){
      this.grade = grade;
   }

   /**
    * getter for EDU_STATUS
    * @generated
    */
   public String getEduStatus(){
      return this.eduStatus;
   }
   /**
    * setter for EDU_STATUS
    * @generated
    */
   public void setEduStatus(String eduStatus){
      this.eduStatus = eduStatus;
   }

   /**
    * getter for SCHOOL
    * @generated
    */
   public String getSchool(){
      return this.school;
   }
   /**
    * setter for SCHOOL
    * @generated
    */
   public void setSchool(String school){
      this.school = school;
   }

   /**
    * getter for SCHOOL_TYPE
    * @generated
    */
   public String getSchoolType(){
      return this.schoolType;
   }
   /**
    * setter for SCHOOL_TYPE
    * @generated
    */
   public void setSchoolType(String schoolType){
      this.schoolType = schoolType;
   }

   /**
    * getter for IS_CHOOSE
    * @generated
    */
   public String getIsChoose(){
      return this.isChoose;
   }
   /**
    * setter for IS_CHOOSE
    * @generated
    */
   public void setIsChoose(String isChoose){
      this.isChoose = isChoose;
   }

   /**
    * getter for EDU_YEAR
    * @generated
    */
   public BigDecimal getEduYear(){
      return this.eduYear;
   }
   /**
    * setter for EDU_YEAR
    * @generated
    */
   public void setEduYear(BigDecimal eduYear){
      this.eduYear = eduYear;
   }

   /**
    * getter for ENTRANCE_DATE
    * @generated
    */
   public String getEntranceDate(){
      return this.entranceDate;
   }
   /**
    * setter for ENTRANCE_DATE
    * @generated
    */
   public void setEntranceDate(String entranceDate){
      this.entranceDate = entranceDate;
   }

   /**
    * getter for GRADUATION_DATE
    * @generated
    */
   public String getGraduationDate(){
      return this.graduationDate;
   }
   /**
    * setter for GRADUATION_DATE
    * @generated
    */
   public void setGraduationDate(String graduationDate){
      this.graduationDate = graduationDate;
   }

   /**
    * getter for CONECT_PEOPLE
    * @generated
    */
   public String getConectPeople(){
      return this.conectPeople;
   }
   /**
    * setter for CONECT_PEOPLE
    * @generated
    */
   public void setConectPeople(String conectPeople){
      this.conectPeople = conectPeople;
   }

   /**
    * getter for CONECT_PHONE
    * @generated
    */
   public String getConectPhone(){
      return this.conectPhone;
   }
   /**
    * setter for CONECT_PHONE
    * @generated
    */
   public void setConectPhone(String conectPhone){
      this.conectPhone = conectPhone;
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