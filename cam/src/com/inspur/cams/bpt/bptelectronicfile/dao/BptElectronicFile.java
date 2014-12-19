package com.inspur.cams.bpt.bptelectronicfile.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptElectronicFile
 * @description:
 * @author:
 * @since:2011-06-27
 * @version:1.0
*/
 @Table(tableName = "BPT_ELECTRONIC_FILE" , keyFields = "electronicId")
public class BptElectronicFile extends StatefulDatabean {
   //ELECTRONIC_ID
   	@Rule(value="require")
	@Column(name = "ELECTRONIC_ID")
   private String electronicId;
   //FILE_ID
   	@Rule(value="require")
	@Column(name = "FILE_ID")
   private String fileId;
   //FILE_NAME
	@Column(name = "FILE_NAME")
   private String fileName;
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

}