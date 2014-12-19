package com.inspur.cams.drel.sam.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:申请材料
 * @description:
 * @author:yanll
 * @since:2012-05-05
 * @version:1.0
*/
 @Table(tableName = "SAM_APPLY_FILES" , keyFields = "applyFileId")
public class SamApplyFiles extends StatefulDatabean {
   //APPLY_FILE_ID
	@Column(name = "APPLY_FILE_ID")
   private String applyFileId;
   //APPLY_ID
	@Column(name = "APPLY_ID")
   private String applyId;
   //ACTIVITY_ID
	@Column(name = "ACTIVITY_ID")
   private String activityId;
   //FILE_TYPE
	@Column(name = "FILE_TYPE")
   private String fileType;
   //FILE_NAME
	@Column(name = "FILE_NAME")
   private String fileName;
   //FILE_NUM
   	@Rule(value="number")
	@Column(name = "FILE_NUM")
   private BigDecimal fileNum;
   //FILE_CONTENT
	@Column(name = "FILE_CONTENT")
   private UploadFile fileContent;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   /**
    * getter for APPLY_FILE_ID
    * @generated
    */
   public String getApplyFileId(){
      return this.applyFileId;
   }
   /**
    * setter for APPLY_FILE_ID
    * @generated
    */
   public void setApplyFileId(String applyFileId){
      this.applyFileId = applyFileId;
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
    * getter for ACTIVITY_ID
    * @generated
    */
   public String getActivityId(){
      return this.activityId;
   }
   /**
    * setter for ACTIVITY_ID
    * @generated
    */
   public void setActivityId(String activityId){
      this.activityId = activityId;
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
    * getter for FILE_NUM
    * @generated
    */
   public BigDecimal getFileNum(){
      return this.fileNum;
   }
   /**
    * setter for FILE_NUM
    * @generated
    */
   public void setFileNum(BigDecimal fileNum){
      this.fileNum = fileNum;
   }

   /**
    * getter for FILE_CONTENT
    * @generated
    */
   public UploadFile getFileContent(){
      return this.fileContent;
   }
   /**
    * setter for FILE_CONTENT
    * @generated
    */
   public void setFileContent(UploadFile fileContent){
      this.fileContent = fileContent;
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

}