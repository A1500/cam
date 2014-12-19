package com.inspur.cams.bpt.bptelectronicfile.dao;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:BptUploadfile
 * @description:
 * @author:
 * @since:2011-07-16
 * @version:1.0
*/
 @Table(tableName = "BPT_UPLOADFILE" , keyFields = "fileId")
public class BptUploadfile extends StatefulDatabean {
   //FILE_ID
   	@Rule(value="require")
	@Column(name = "FILE_ID")
   private String fileId;
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
   //RANGE_FLAG
	@Column(name = "RANGE_FLAG")
   private String rangeFlag;
   //VIEW_ORDER
   	@Rule(value="number")
	@Column(name = "VIEW_ORDER")
   private BigDecimal viewOrder;
   //FILE_OPER
	@Column(name = "FILE_OPER")
   private String fileOper;
   //FILE_NUMBER
   	@Rule(value="number")
	@Column(name = "FILE_NUMBER")
   private BigDecimal fileNumber;
   //FILE_TIME
	@Column(name = "FILE_TIME")
   private String fileTime;
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
    * getter for RANGE_FLAG
    * @generated
    */
   public String getRangeFlag(){
      return this.rangeFlag;
   }
   /**
    * setter for RANGE_FLAG
    * @generated
    */
   public void setRangeFlag(String rangeFlag){
      this.rangeFlag = rangeFlag;
   }

   /**
    * getter for VIEW_ORDER
    * @generated
    */
   public BigDecimal getViewOrder(){
      return this.viewOrder;
   }
   /**
    * setter for VIEW_ORDER
    * @generated
    */
   public void setViewOrder(BigDecimal viewOrder){
      this.viewOrder = viewOrder;
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
    * getter for FILE_NUMBER
    * @generated
    */
   public BigDecimal getFileNumber(){
      return this.fileNumber;
   }
   /**
    * setter for FILE_NUMBER
    * @generated
    */
   public void setFileNumber(BigDecimal fileNumber){
      this.fileNumber = fileNumber;
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

}