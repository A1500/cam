package com.inspur.cams.drel.archive.sampeopletypearchive.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleTypeArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_TYPE_ARCHIVE" , keyFields = "peopleTypeArchiveId")
public class SamPeopleTypeArchive extends StatefulDatabean {
   //PEOPLE_TYPE_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "PEOPLE_TYPE_ARCHIVE_ID")
   private String peopleTypeArchiveId;
   //PEOPLE_TYPE_ID
	@Column(name = "PEOPLE_TYPE_ID")
   private String peopleTypeId;
   //PEOPLE_ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //PEOPLE_TYPE
	@Column(name = "PEOPLE_TYPE")
   private String peopleType;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   //PEOPLE_ARCHIVE_ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   /**
    * getter for PEOPLE_TYPE_ARCHIVE_ID
    * @generated
    */
   public String getPeopleTypeArchiveId(){
      return this.peopleTypeArchiveId;
   }
   /**
    * setter for PEOPLE_TYPE_ARCHIVE_ID
    * @generated
    */
   public void setPeopleTypeArchiveId(String peopleTypeArchiveId){
      this.peopleTypeArchiveId = peopleTypeArchiveId;
   }

   /**
    * getter for PEOPLE_TYPE_ID
    * @generated
    */
   public String getPeopleTypeId(){
      return this.peopleTypeId;
   }
   /**
    * setter for PEOPLE_TYPE_ID
    * @generated
    */
   public void setPeopleTypeId(String peopleTypeId){
      this.peopleTypeId = peopleTypeId;
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