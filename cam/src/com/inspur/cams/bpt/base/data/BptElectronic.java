package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptElectronic
 * @description:
 * @author:
 * @since:2011-07-18
 * @version:1.0
*/
 @Table(tableName = "BPT_ELECTRONIC" , keyFields = "electronicId")
public class BptElectronic extends StatefulDatabean {
   //PEOPLE_ID
   	@Rule(value="require")
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //OBJECT_TYPE
	@Column(name = "OBJECT_TYPE")
   private String objectType;
   //SERVICE_TYPE
	@Column(name = "SERVICE_TYPE")
   private String serviceType;
   //FILE_NAME
	@Column(name = "FILE_NAME")
   private String fileName;
   //FILE_TYPE
	@Column(name = "FILE_TYPE")
   private String fileType;
   //FILE_MESS
	@Column(name = "FILE_MESS")
   private String fileMess;
   //FILE_PATH
	@Column(name = "FILE_PATH")
   private String filePath;
   //FILE_ID
	@Column(name = "FILE_ID")
   private String fileId;
   //ELECTRONIC_ID
   	@Rule(value="require")
	@Column(name = "ELECTRONIC_ID")
   private String electronicId;
   //FILE_SAVE
	@Column(name = "FILE_SAVE")
   private String fileSave;
   //FILE_TIME
	@Column(name = "FILE_TIME")
   private String fileTime;
   //FILE_NUMBER
	@Column(name = "FILE_NUMBER")
   private String fileNumber;
   //FILE_OPER
	@Column(name = "FILE_OPER")
   private String fileOper;
	
	//CATALOG_CODE
	@Transient
	@Column(name="CATALOG_CODE")
   private String catalogCode;
   
   //CATALOG_NAME
	@Transient
	@Column(name="CATALOG_NAME")
   private String catalogName;
   
   //CATALOG_ORDER
	@Transient
	@Column(name="CATALOG_ORDER")
   private String catalogOrder;
   
   //ORGAN_ID
	@Transient
	@Column(name="ORGAN_ID")
	private String organId;
   
   /*
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
    * getter for OBJECT_TYPE
    * @generated
    */
   public String getObjectType(){
      return this.objectType;
   }
   /**
    * setter for OBJECT_TYPE
    * @generated
    */
   public void setObjectType(String objectType){
      this.objectType = objectType;
   }

   /**
    * getter for SERVICE_TYPE
    * @generated
    */
   public String getServiceType(){
      return this.serviceType;
   }
   /**
    * setter for SERVICE_TYPE
    * @generated
    */
   public void setServiceType(String serviceType){
      this.serviceType = serviceType;
   }

   /**
    * getter for FILE_NAME
    * @generated
    */
   public String getFileName(){
      return this.fileName;
   }
   /**
    * setter for FILE_NAME
    * @generated
    */
   public void setFileName(String fileName){
      this.fileName = fileName;
   }

   /**
    * getter for FILE_TYPE
    * @generated
    */
   public String getFileType(){
      return this.fileType;
   }
   /**
    * setter for FILE_TYPE
    * @generated
    */
   public void setFileType(String fileType){
      this.fileType = fileType;
   }

   /**
    * getter for FILE_MESS
    * @generated
    */
   public String getFileMess(){
      return this.fileMess;
   }
   /**
    * setter for FILE_MESS
    * @generated
    */
   public void setFileMess(String fileMess){
      this.fileMess = fileMess;
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
    * getter for FILE_ID
    * @generated
    */
   public String getFileId(){
      return this.fileId;
   }
   /**
    * setter for FILE_ID
    * @generated
    */
   public void setFileId(String fileId){
      this.fileId = fileId;
   }

   /**
    * getter for ELECTRONIC_ID
    * @generated
    */
   public String getElectronicId(){
      return this.electronicId;
   }
   /**
    * setter for ELECTRONIC_ID
    * @generated
    */
   public void setElectronicId(String electronicId){
      this.electronicId = electronicId;
   }

   /**
    * getter for FILE_SAVE
    * @generated
    */
   public String getFileSave(){
      return this.fileSave;
   }
   /**
    * setter for FILE_SAVE
    * @generated
    */
   public void setFileSave(String fileSave){
      this.fileSave = fileSave;
   }

   /**
    * getter for FILE_TIME
    * @generated
    */
   public String getFileTime(){
      return this.fileTime;
   }
   /**
    * setter for FILE_TIME
    * @generated
    */
   public void setFileTime(String fileTime){
      this.fileTime = fileTime;
   }

   /**
    * getter for FILE_NUMBER
    * @generated
    */
   public String getFileNumber(){
      return this.fileNumber;
   }
   /**
    * setter for FILE_NUMBER
    * @generated
    */
   public void setFileNumber(String fileNumber){
      this.fileNumber = fileNumber;
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
	 * @return the catalogCode
	 */
	public String getCatalogCode() {
		return catalogCode;
	}
	/**
	 * @param catalogCode the catalogCode to set
	 */
	public void setCatalogCode(String catalogCode) {
		this.catalogCode = catalogCode;
	}
	/**
	 * @return the catalogName
	 */
	public String getCatalogName() {
		return catalogName;
	}
	/**
	 * @param catalogName the catalogName to set
	 */
	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}
	/**
	 * @return the catalogOrder
	 */
	public String getCatalogOrder() {
		return catalogOrder;
	}
	/**
	 * @param catalogOrder the catalogOrder to set
	 */
	public void setCatalogOrder(String catalogOrder) {
		this.catalogOrder = catalogOrder;
	}
	/**
	 * @return the organId
	 */
	public String getOrganId() {
		return organId;
	}
	/**
	 * @param organId the organId to set
	 */
	public void setOrganId(String organId) {
		this.organId = organId;
	}

}