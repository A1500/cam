package com.inspur.sdmz.jzzs.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:HelpIndexConf
 * @description:
 * @author:
 * @since:2011-07-07
 * @version:1.0
*/
 @Table(tableName = "HELP_INDEX_CONF" , keyFields = "helpOrganRegion")
public class YgjzJzzsConf extends StatefulDatabean {
   //HELP_ORGAN_REGION
   	@Rule(value="require")
	@Column(name = "HELP_ORGAN_REGION")
   private String helpOrganRegion;
   //HELP_TYPE
	@Column(name = "HELP_TYPE")
   private String helpType;
   //HELP_PER
	@Column(name = "HELP_PER")
   private String helpPer;
   //HELP_ORGAN_NAME
	@Column(name = "HELP_ORGAN_NAME")
   private String helpOrganName;
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
    * getter for HELP_PER
    * @generated
    */
   public String getHelpPer(){
      return this.helpPer;
   }
   /**
    * setter for HELP_PER
    * @generated
    */
   public void setHelpPer(String helpPer){
      this.helpPer = helpPer;
   }

   /**
    * getter for HELP_ORGAN_NAME
    * @generated
    */
   public String getHelpOrganName(){
      return this.helpOrganName;
   }
   /**
    * setter for HELP_ORGAN_NAME
    * @generated
    */
   public void setHelpOrganName(String helpOrganName){
      this.helpOrganName = helpOrganName;
   }

}