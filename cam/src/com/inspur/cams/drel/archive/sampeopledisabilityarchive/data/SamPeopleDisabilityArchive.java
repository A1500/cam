package com.inspur.cams.drel.archive.sampeopledisabilityarchive.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleDisabilityArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_DISABILITY_ARCHIVE" , keyFields = "disabilityArchiveId")
public class SamPeopleDisabilityArchive extends StatefulDatabean {
   //DISABILITY_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "DISABILITY_ARCHIVE_ID")
   private String disabilityArchiveId;
   //PEOPLE_ARCHIVE_ID
   @Rule(value="require")
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //PEOPLE_ID
   @Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //DISABILITY_TYPE
	@Column(name = "DISABILITY_TYPE")
   private String disabilityType;
   //DISABILITY_LEVEL
	@Column(name = "DISABILITY_LEVEL")
   private String disabilityLevel;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   /**
    * getter for DISABILITY_ARCHIVE_ID
    * @generated
    */
   public String getDisabilityArchiveId(){
      return this.disabilityArchiveId;
   }
   /**
    * setter for DISABILITY_ARCHIVE_ID
    * @generated
    */
   public void setDisabilityArchiveId(String disabilityArchiveId){
      this.disabilityArchiveId = disabilityArchiveId;
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
    * getter for DISABILITY_TYPE
    * @generated
    */
   public String getDisabilityType(){
      return this.disabilityType;
   }
   /**
    * setter for DISABILITY_TYPE
    * @generated
    */
   public void setDisabilityType(String disabilityType){
      this.disabilityType = disabilityType;
   }

   /**
    * getter for DISABILITY_LEVEL
    * @generated
    */
   public String getDisabilityLevel(){
      return this.disabilityLevel;
   }
   /**
    * setter for DISABILITY_LEVEL
    * @generated
    */
   public void setDisabilityLevel(String disabilityLevel){
      this.disabilityLevel = disabilityLevel;
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