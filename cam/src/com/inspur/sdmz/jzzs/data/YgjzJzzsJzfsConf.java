package com.inspur.sdmz.jzzs.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:HelpIndexScore
 * @description:
 * @author:
 * @since:2011-07-07
 * @version:1.0
*/
 @Table(tableName = "HELP_INDEX_SCORE" , keyFields = "id")
public class YgjzJzzsJzfsConf extends StatefulDatabean {
   //HELP_ORGAN_REGION
	@Column(name = "HELP_ORGAN_REGION")
   private String helpOrganRegion;
   //HELP_TYPE
	@Column(name = "HELP_TYPE")
   private String helpType;
   //HELP_CODE
	@Column(name = "HELP_CODE")
   private String helpCode;
   //HELP_SCORE
   	@Rule(value="number")
	@Column(name = "HELP_SCORE")
   private BigDecimal helpScore;
   //备注
	@Column(name = "NOTES")
   private String notes;
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   /**
    * getter for HELP_ORGAN_REGION
    * @generated
    */
   public String getHelpOrganRegion(){
      return this.helpOrganRegion;
   }
   /**
    * setter for HELP_ORGAN_REGION
    * @generated
    */
   public void setHelpOrganRegion(String helpOrganRegion){
      this.helpOrganRegion = helpOrganRegion;
   }

   /**
    * getter for HELP_TYPE
    * @generated
    */
   public String getHelpType(){
      return this.helpType;
   }
   /**
    * setter for HELP_TYPE
    * @generated
    */
   public void setHelpType(String helpType){
      this.helpType = helpType;
   }

   /**
    * getter for HELP_CODE
    * @generated
    */
   public String getHelpCode(){
      return this.helpCode;
   }
   /**
    * setter for HELP_CODE
    * @generated
    */
   public void setHelpCode(String helpCode){
      this.helpCode = helpCode;
   }

   /**
    * getter for HELP_SCORE
    * @generated
    */
   public BigDecimal getHelpScore(){
      return this.helpScore;
   }
   /**
    * setter for HELP_SCORE
    * @generated
    */
   public void setHelpScore(BigDecimal helpScore){
      this.helpScore = helpScore;
   }

   /**
    * getter for 备注
    * @generated
    */
   public String getNotes(){
      return this.notes;
   }
   /**
    * setter for 备注
    * @generated
    */
   public void setNotes(String notes){
      this.notes = notes;
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

}