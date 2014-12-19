package com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西行政处罚情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_PUNNISH" , keyFields = "id")
public class SomJxCheckPunnish extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //PUNNISH_TYPE
	@Column(name = "PUNNISH_TYPE")
   private String punnishType;
   //PUNNISH_ORGAN
	@Column(name = "PUNNISH_ORGAN")
   private String punnishOrgan;
   //PUNNISH_DATE
	@Column(name = "PUNNISH_DATE")
   private String punnishDate;
   //UNLAWFULACT_DESC
	@Column(name = "UNLAWFULACT_DESC")
   private String unlawfulactDesc;
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
    * getter for PUNNISH_TYPE
    * @generated
    */
   public String getPunnishType(){
      return this.punnishType;
   }
   /**
    * setter for PUNNISH_TYPE
    * @generated
    */
   public void setPunnishType(String punnishType){
      this.punnishType = punnishType;
   }

   /**
    * getter for PUNNISH_ORGAN
    * @generated
    */
   public String getPunnishOrgan(){
      return this.punnishOrgan;
   }
   /**
    * setter for PUNNISH_ORGAN
    * @generated
    */
   public void setPunnishOrgan(String punnishOrgan){
      this.punnishOrgan = punnishOrgan;
   }

   /**
    * getter for PUNNISH_DATE
    * @generated
    */
   public String getPunnishDate(){
      return this.punnishDate;
   }
   /**
    * setter for PUNNISH_DATE
    * @generated
    */
   public void setPunnishDate(String punnishDate){
      this.punnishDate = punnishDate;
   }

   /**
    * getter for UNLAWFULACT_DESC
    * @generated
    */
   public String getUnlawfulactDesc(){
      return this.unlawfulactDesc;
   }
   /**
    * setter for UNLAWFULACT_DESC
    * @generated
    */
   public void setUnlawfulactDesc(String unlawfulactDesc){
      this.unlawfulactDesc = unlawfulactDesc;
   }

}