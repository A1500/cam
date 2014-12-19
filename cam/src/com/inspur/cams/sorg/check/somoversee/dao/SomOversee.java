package com.inspur.cams.sorg.check.somoversee.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomOversee
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_OVERSEE" , keyFields = "id")
public class SomOversee extends StatefulDatabean {
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ID
	@Column(name = "ID")
   private String id;
   //CHECK_YEAR
	@Column(name = "CHECK_YEAR")
   private String checkYear;
   //RESULT_TYPE
	@Column(name = "RESULT_TYPE")
   private String resultType;
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
    * getter for CHECK_YEAR
    * @generated
    */
   public String getCheckYear(){
      return this.checkYear;
   }
   /**
    * setter for CHECK_YEAR
    * @generated
    */
   public void setCheckYear(String checkYear){
      this.checkYear = checkYear;
   }

   /**
    * getter for RESULT_TYPE
    * @generated
    */
   public String getResultType(){
      return this.resultType;
   }
   /**
    * setter for RESULT_TYPE
    * @generated
    */
   public void setResultType(String resultType){
      this.resultType = resultType;
   }

}