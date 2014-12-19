package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomElectronic
 * @description:
 * @author:
 * @since:2011-07-19
 * @version:1.0
*/
 @Table(tableName = "SOM_ELECTRONIC" , keyFields = "electronicId")
public class SomElectronic extends StatefulDatabean {
   //ELECTRONIC_ID
   	@Rule(value="require")
	@Column(name = "ELECTRONIC_ID")
   private String electronicId;
   //TASK_CODE
   	@Rule(value="require")
	@Column(name = "TASK_CODE")
   private String taskCode;
  //FILE_CODE
   	@Rule(value="require")
   	@Column(name = "FILE_CODE")
   private String fileCode;
   //SORG_ID
   	@Rule(value="require")
	@Column(name = "SORG_ID")
   private String sorgId;
   //SORG_KIND
	@Column(name = "SORG_KIND")
   private String sorgKind;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //CN_NAME
	@Column(name = "CN_NAME")
   private String cnName;
   //APPLY_TYPE
	@Column(name = "APPLY_TYPE")
   private String applyType;
   //IF_VALID
   	@Rule(value="require")
	@Column(name = "IF_VALID")
   private String ifValid;
   //CATALOG_CODE
   	@Rule(value="require")
	@Column(name = "CATALOG_CODE")
   private String catalogCode;
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
   //FILES
	@Column(name = "FILES")
   private UploadFile files;
   //CREATE_PEOPLE
	@Column(name = "CREATE_PEOPLE")
   private String createPeople;
   //CREATE_TIME
	@Column(name = "CREATE_TIME")
   private String createTime;
   //MOD_PEOPLE
	@Column(name = "MOD_PEOPLE")
   private String modPeople;
   //MOD_TIME
	@Column(name = "MOD_TIME")
   private String modTime;
   // 件号
   private String pieceNumber;
   //UP_CATALOG_CODE
	@Transient
   private String upCatalogCode;
	@Transient
   private String dutyId;
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
    * getter for TASK_CODE
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for TASK_CODE
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for SORG_KIND
    * @generated
    */
   public String getSorgKind(){
      return this.sorgKind;
   }
   /**
    * setter for SORG_KIND
    * @generated
    */
   public void setSorgKind(String sorgKind){
      this.sorgKind = sorgKind;
   }

   /**
    * getter for SORG_TYPE
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for SORG_TYPE
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for CN_NAME
    * @generated
    */
   public String getCnName(){
      return this.cnName;
   }
   /**
    * setter for CN_NAME
    * @generated
    */
   public void setCnName(String cnName){
      this.cnName = cnName;
   }

   /**
    * getter for APPLY_TYPE
    * @generated
    */
   public String getApplyType(){
      return this.applyType;
   }
   /**
    * setter for APPLY_TYPE
    * @generated
    */
   public void setApplyType(String applyType){
      this.applyType = applyType;
   }

   /**
    * getter for IF_VALID
    * @generated
    */
   public String getIfValid(){
      return this.ifValid;
   }
   /**
    * setter for IF_VALID
    * @generated
    */
   public void setIfValid(String ifValid){
      this.ifValid = ifValid;
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
    * getter for FILES
    * @generated
    */
   public UploadFile getFiles(){
      return this.files;
   }
   /**
    * setter for FILES
    * @generated
    */
   public void setFiles(UploadFile files){
      this.files = files;
   }

   /**
    * getter for CREATE_PEOPLE
    * @generated
    */
   public String getCreatePeople(){
      return this.createPeople;
   }
   /**
    * setter for CREATE_PEOPLE
    * @generated
    */
   public void setCreatePeople(String createPeople){
      this.createPeople = createPeople;
   }

   /**
    * getter for CREATE_TIME
    * @generated
    */
   public String getCreateTime(){
      return this.createTime;
   }
   /**
    * setter for CREATE_TIME
    * @generated
    */
   public void setCreateTime(String createTime){
      this.createTime = createTime;
   }

   /**
    * getter for MOD_PEOPLE
    * @generated
    */
   public String getModPeople(){
      return this.modPeople;
   }
   /**
    * setter for MOD_PEOPLE
    * @generated
    */
   public void setModPeople(String modPeople){
      this.modPeople = modPeople;
   }

   /**
    * getter for MOD_TIME
    * @generated
    */
   public String getModTime(){
      return this.modTime;
   }
   /**
    * setter for MOD_TIME
    * @generated
    */
   public void setModTime(String modTime){
      this.modTime = modTime;
   }
public String getCatalogCode() {
	return catalogCode;
}
public void setCatalogCode(String catalogCode) {
	this.catalogCode = catalogCode;
}
public String getUpCatalogCode() {
	return upCatalogCode;
}
public void setUpCatalogCode(String upCatalogCode) {
	this.upCatalogCode = upCatalogCode;
}
public String getFileCode() {
	return fileCode;
}
public void setFileCode(String fileCode) {
	this.fileCode = fileCode;
}
public String getDutyId() {
	return dutyId;
}
public void setDutyId(String dutyId) {
	this.dutyId = dutyId;
}
public String getPieceNumber() {
	return pieceNumber;
}
public void setPieceNumber(String pieceNumber) {
	this.pieceNumber = pieceNumber;
}

}