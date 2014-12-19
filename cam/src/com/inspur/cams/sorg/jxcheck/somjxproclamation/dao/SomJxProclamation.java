package com.inspur.cams.sorg.jxcheck.somjxproclamation.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:江西信息公布情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_PROCLAMATION" , keyFields = "id")
public class SomJxProclamation extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ITEM
	@Column(name = "ITEM")
   private String item;
   //INSERTION_NAME
	@Column(name = "INSERTION_NAME")
   private String insertionName;
   //INSERTION_DATE
	@Column(name = "INSERTION_DATE")
   private String insertionDate;
	
	private String seq;
	
   public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
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
    * getter for ITEM
    * @generated
    */
   public String getItem(){
      return this.item;
   }
   /**
    * setter for ITEM
    * @generated
    */
   public void setItem(String item){
      this.item = item;
   }

   /**
    * getter for INSERTION_NAME
    * @generated
    */
   public String getInsertionName(){
      return this.insertionName;
   }
   /**
    * setter for INSERTION_NAME
    * @generated
    */
   public void setInsertionName(String insertionName){
      this.insertionName = insertionName;
   }

   /**
    * getter for INSERTION_DATE
    * @generated
    */
   public String getInsertionDate(){
      return this.insertionDate;
   }
   /**
    * setter for INSERTION_DATE
    * @generated
    */
   public void setInsertionDate(String insertionDate){
      this.insertionDate = insertionDate;
   }

}