package com.inspur.cams.sorg.check.somcheckaccountingpeople.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckAccountingPeople
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_ACCOUNTING_PEOPLE" , keyFields = "id")
public class SomCheckAccountingPeople extends StatefulDatabean {
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ID
	@Column(name = "ID")
   private String id;
   //PEOPLE_NAME
	@Column(name = "PEOPLE_NAME")
   private String peopleName;
   //WORK_NAME
	@Column(name = "WORK_NAME")
   private String workName;
   //IF_ACCOUNTANT
	@Column(name = "IF_ACCOUNTANT")
   private String ifAccountant;
   //TECHNOLOGY_QUAL
	@Column(name = "TECHNOLOGY_QUAL")
   private String technologyQual;
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
    * getter for PEOPLE_NAME
    * @generated
    */
   public String getPeopleName(){
      return this.peopleName;
   }
   /**
    * setter for PEOPLE_NAME
    * @generated
    */
   public void setPeopleName(String peopleName){
      this.peopleName = peopleName;
   }

   /**
    * getter for WORK_NAME
    * @generated
    */
   public String getWorkName(){
      return this.workName;
   }
   /**
    * setter for WORK_NAME
    * @generated
    */
   public void setWorkName(String workName){
      this.workName = workName;
   }

   /**
    * getter for IF_ACCOUNTANT
    * @generated
    */
   public String getIfAccountant(){
      return this.ifAccountant;
   }
   /**
    * setter for IF_ACCOUNTANT
    * @generated
    */
   public void setIfAccountant(String ifAccountant){
      this.ifAccountant = ifAccountant;
   }

   /**
    * getter for TECHNOLOGY_QUAL
    * @generated
    */
   public String getTechnologyQual(){
      return this.technologyQual;
   }
   /**
    * setter for TECHNOLOGY_QUAL
    * @generated
    */
   public void setTechnologyQual(String technologyQual){
      this.technologyQual = technologyQual;
   }

}