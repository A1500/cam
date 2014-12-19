package com.inspur.cams.sorg.jxcheck.somjxoversee.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西接受监督管理的情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_OVERSEE" , keyFields = "id")
public class SomJxOversee extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //YEAR
	@Column(name = "CHECK_YEAR")
   private String checkYear;
   //RESULT_TYPE
	@Column(name = "RESULT_TYPE")
   private String resultType;
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
    * getter for YEAR
    * @generated
    */
   public String getCheckYear(){
      return this.checkYear;
   }
   /**
    * setter for YEAR
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