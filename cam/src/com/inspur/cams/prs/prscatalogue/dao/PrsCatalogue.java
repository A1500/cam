package com.inspur.cams.prs.prscatalogue.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PrsCatalogue
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 @Table(tableName = "PRS_CATALOGUE" , keyFields = "catalogId")
public class PrsCatalogue extends StatefulDatabean {
   //CATALOG_ID
   	@Rule(value="require")
	@Column(name = "CATALOG_ID")
   private String catalogId;
   //CATALOG_CODE
   	@Rule(value="require")
	@Column(name = "CATALOG_CODE")
   private String catalogCode;
   //CATALOG_NAME
   	@Rule(value="require")
	@Column(name = "CATALOG_NAME")
   private String catalogName;
   //CATALOG_INFO
	@Column(name = "CATALOG_INFO")
   private String catalogInfo;
   //FILE_PATH
	@Column(name = "FILE_PATH")
   private String filePath;
   //MILITARY_REGION
	@Column(name = "MILITARY_REGION")
   private String militaryRegion;
   //FILE_OPER
	@Column(name = "FILE_OPER")
   private String fileOper;
   //TIME
   	@Rule(value="require")
	@Column(name = "UPLOADTIME")
   private String uploadtime;
   /**
    * getter for CATALOG_ID
    * @generated
    */
   public String getCatalogId(){
      return this.catalogId;
   }
   /**
    * setter for CATALOG_ID
    * @generated
    */
   public void setCatalogId(String catalogId){
      this.catalogId = catalogId;
   }

   /**
    * getter for CATALOG_CODE
    * @generated
    */
   public String getCatalogCode(){
      return this.catalogCode;
   }
   /**
    * setter for CATALOG_CODE
    * @generated
    */
   public void setCatalogCode(String catalogCode){
      this.catalogCode = catalogCode;
   }

   /**
    * getter for CATALOG_NAME
    * @generated
    */
   public String getCatalogName(){
      return this.catalogName;
   }
   /**
    * setter for CATALOG_NAME
    * @generated
    */
   public void setCatalogName(String catalogName){
      this.catalogName = catalogName;
   }

   /**
    * getter for CATALOG_INFO
    * @generated
    */
   public String getCatalogInfo(){
      return this.catalogInfo;
   }
   /**
    * setter for CATALOG_INFO
    * @generated
    */
   public void setCatalogInfo(String catalogInfo){
      this.catalogInfo = catalogInfo;
   }

   /**
    * getter for FILE_PATH
    * @generated
    */
   public String getFilePath(){
      return this.filePath;
   }
   /**
    * setter for FILE_PATH
    * @generated
    */
   public void setFilePath(String filePath){
      this.filePath = filePath;
   }

   /**
    * getter for MILITARY_REGION
    * @generated
    */
   public String getMilitaryRegion(){
      return this.militaryRegion;
   }
   /**
    * setter for MILITARY_REGION
    * @generated
    */
   public void setMilitaryRegion(String militaryRegion){
      this.militaryRegion = militaryRegion;
   }

   /**
    * getter for FILE_OPER
    * @generated
    */
   public String getFileOper(){
      return this.fileOper;
   }
   /**
    * setter for FILE_OPER
    * @generated
    */
   public void setFileOper(String fileOper){
      this.fileOper = fileOper;
   }

   /**
    * getter for TIME
    * @generated
    */
   public String getUploadtime(){
      return this.uploadtime;
   }
   /**
    * setter for TIME
    * @generated
    */
   public void setUploadtime(String uploadtime){
      this.uploadtime = uploadtime;
   }

}