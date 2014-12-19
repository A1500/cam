package com.inspur.cams.sorg.check.checkdues.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckDues
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_DUES" , keyFields = "id")
public class SomCheckDues extends StatefulDatabean {
   //ID
   	
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //MAKE_FEE_DATE
	@Column(name = "MAKE_FEE_DATE")
   private String makeFeeDate;
   //REG_FEE_TYPE
	@Column(name = "REG_FEE_TYPE")
   private String regFeeType;
   //MEETING_NAME
	@Column(name = "MEETING_NAME")
   private String meetingName;
   //FEE_RULE
	@Column(name = "FEE_RULE")
   private String feeRule;
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
    * getter for MAKE_FEE_DATE
    * @generated
    */
   public String getMakeFeeDate(){
      return this.makeFeeDate;
   }
   /**
    * setter for MAKE_FEE_DATE
    * @generated
    */
   public void setMakeFeeDate(String makeFeeDate){
      this.makeFeeDate = makeFeeDate;
   }

   /**
    * getter for REG_FEE_TYPE
    * @generated
    */
   public String getRegFeeType(){
      return this.regFeeType;
   }
   /**
    * setter for REG_FEE_TYPE
    * @generated
    */
   public void setRegFeeType(String regFeeType){
      this.regFeeType = regFeeType;
   }

   /**
    * getter for MEETING_NAME
    * @generated
    */
   public String getMeetingName(){
      return this.meetingName;
   }
   /**
    * setter for MEETING_NAME
    * @generated
    */
   public void setMeetingName(String meetingName){
      this.meetingName = meetingName;
   }

   /**
    * getter for FEE_RULE
    * @generated
    */
   public String getFeeRule(){
      return this.feeRule;
   }
   /**
    * setter for FEE_RULE
    * @generated
    */
   public void setFeeRule(String feeRule){
      this.feeRule = feeRule;
   }

}