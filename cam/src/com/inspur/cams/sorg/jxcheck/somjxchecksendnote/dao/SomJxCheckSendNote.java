package com.inspur.cams.sorg.jxcheck.somjxchecksendnote.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西送达记录
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_SEND_NOTE" , keyFields = "id")
public class SomJxCheckSendNote extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //REPORT_PEOPLE
	@Column(name = "REPORT_PEOPLE")
   private String reportPeople;
   //PHONE
	@Column(name = "PHONE")
   private String phone;
   //INCEPT_PEOPLE
	@Column(name = "INCEPT_PEOPLE")
   private String inceptPeople;
   //SIGN_DATE
	@Column(name = "SIGN_DATE")
   private String signDate;
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
    * getter for REPORT_PEOPLE
    * @generated
    */
   public String getReportPeople(){
      return this.reportPeople;
   }
   /**
    * setter for REPORT_PEOPLE
    * @generated
    */
   public void setReportPeople(String reportPeople){
      this.reportPeople = reportPeople;
   }

   /**
    * getter for PHONE
    * @generated
    */
   public String getPhone(){
      return this.phone;
   }
   /**
    * setter for PHONE
    * @generated
    */
   public void setPhone(String phone){
      this.phone = phone;
   }

   /**
    * getter for INCEPT_PEOPLE
    * @generated
    */
   public String getInceptPeople(){
      return this.inceptPeople;
   }
   /**
    * setter for INCEPT_PEOPLE
    * @generated
    */
   public void setInceptPeople(String inceptPeople){
      this.inceptPeople = inceptPeople;
   }

   /**
    * getter for SIGN_DATE
    * @generated
    */
   public String getSignDate(){
      return this.signDate;
   }
   /**
    * setter for SIGN_DATE
    * @generated
    */
   public void setSignDate(String signDate){
      this.signDate = signDate;
   }

}