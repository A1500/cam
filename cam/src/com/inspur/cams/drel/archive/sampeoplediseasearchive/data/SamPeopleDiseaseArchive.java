package com.inspur.cams.drel.archive.sampeoplediseasearchive.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamPeopleDiseaseArchive
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 @Table(tableName = "SAM_PEOPLE_DISEASE_ARCHIVE" , keyFields = "diseaseArchiveId")
public class SamPeopleDiseaseArchive extends StatefulDatabean {
   //DISEASE_ARCHIVE_ID
   //@Rule(value="require")
	@Column(name = "DISEASE_ARCHIVE_ID")
   private String diseaseArchiveId;
   //PEOPLE_ARCHIVE_ID
   @Rule(value="require")
	@Column(name = "PEOPLE_ARCHIVE_ID")
   private String peopleArchiveId;
   //PEOPLE_ID
   @Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //DISEASE_DATE
	@Column(name = "DISEASE_DATE")
   private String diseaseDate;
   //DISEASE_TYPE
	@Column(name = "DISEASE_TYPE")
   private String diseaseType;
   //COST_MON
	@Column(name = "COST_MON")
   private String costMon;
   //APPLY_ID
   	@Rule(value="require")
	@Column(name = "APPLY_ID")
   private String applyId;
   /**
    * getter for DISEASE_ARCHIVE_ID
    * @generated
    */
   public String getDiseaseArchiveId(){
      return this.diseaseArchiveId;
   }
   /**
    * setter for DISEASE_ARCHIVE_ID
    * @generated
    */
   public void setDiseaseArchiveId(String diseaseArchiveId){
      this.diseaseArchiveId = diseaseArchiveId;
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
    * getter for DISEASE_DATE
    * @generated
    */
   public String getDiseaseDate(){
      return this.diseaseDate;
   }
   /**
    * setter for DISEASE_DATE
    * @generated
    */
   public void setDiseaseDate(String diseaseDate){
      this.diseaseDate = diseaseDate;
   }

   /**
    * getter for DISEASE_TYPE
    * @generated
    */
   public String getDiseaseType(){
      return this.diseaseType;
   }
   /**
    * setter for DISEASE_TYPE
    * @generated
    */
   public void setDiseaseType(String diseaseType){
      this.diseaseType = diseaseType;
   }

   /**
    * getter for COST_MON
    * @generated
    */
   public String getCostMon(){
      return this.costMon;
   }
   /**
    * setter for COST_MON
    * @generated
    */
   public void setCostMon(String costMon){
      this.costMon = costMon;
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