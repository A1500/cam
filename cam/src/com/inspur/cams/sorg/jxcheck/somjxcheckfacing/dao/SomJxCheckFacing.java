package com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:江西会务情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_FACING" , keyFields = "id")
public class SomJxCheckFacing extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SHOULD_TIMES
   	@Rule(value="number")
	@Column(name = "SHOULD_TIMES")
   private BigDecimal shouldTimes;
   //FACT_TIMES
   	@Rule(value="number")
	@Column(name = "FACT_TIMES")
   private BigDecimal factTimes;
   //FACT_DATE
	@Column(name = "FACT_DATE")
   private String factDate;
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
    * getter for SHOULD_TIMES
    * @generated
    */
   public BigDecimal getShouldTimes(){
      return this.shouldTimes;
   }
   /**
    * setter for SHOULD_TIMES
    * @generated
    */
   public void setShouldTimes(BigDecimal shouldTimes){
      this.shouldTimes = shouldTimes;
   }

   /**
    * getter for FACT_TIMES
    * @generated
    */
   public BigDecimal getFactTimes(){
      return this.factTimes;
   }
   /**
    * setter for FACT_TIMES
    * @generated
    */
   public void setFactTimes(BigDecimal factTimes){
      this.factTimes = factTimes;
   }

   /**
    * getter for FACT_DATE
    * @generated
    */
   public String getFactDate(){
      return this.factDate;
   }
   /**
    * setter for FACT_DATE
    * @generated
    */
   public void setFactDate(String factDate){
      this.factDate = factDate;
   }

}