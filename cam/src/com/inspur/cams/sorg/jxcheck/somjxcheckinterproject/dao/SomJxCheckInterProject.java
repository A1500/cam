package com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西涉外合作项目
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_INTER_PROJECT" , keyFields = "id")
public class SomJxCheckInterProject extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //PROJECT_NAME
	@Column(name = "PROJECT_NAME")
   private String projectName;
   //COOP_ORGAN_NAME
	@Column(name = "COOP_ORGAN_NAME")
   private String coopOrganName;
   //COOP_ORGAN_NATION
	@Column(name = "COOP_ORGAN_NATION")
   private String coopOrganNation;
   //ON_PROJECT_FUND
	@Column(name = "ON_PROJECT_FUND")
   private String onProjectFund;
   //OFF_PROJECT_FUND
	@Column(name = "OFF_PROJECT_FUND")
   private String offProjectFund;
   //PROJECT_TYPE
	@Column(name = "PROJECT_TYPE")
   private String projectType;
   //PROJECT_DESC
	@Column(name = "PROJECT_DESC")
   private String projectDesc;
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
    * getter for PROJECT_NAME
    * @generated
    */
   public String getProjectName(){
      return this.projectName;
   }
   /**
    * setter for PROJECT_NAME
    * @generated
    */
   public void setProjectName(String projectName){
      this.projectName = projectName;
   }

   /**
    * getter for COOP_ORGAN_NAME
    * @generated
    */
   public String getCoopOrganName(){
      return this.coopOrganName;
   }
   /**
    * setter for COOP_ORGAN_NAME
    * @generated
    */
   public void setCoopOrganName(String coopOrganName){
      this.coopOrganName = coopOrganName;
   }

   /**
    * getter for COOP_ORGAN_NATION
    * @generated
    */
   public String getCoopOrganNation(){
      return this.coopOrganNation;
   }
   /**
    * setter for COOP_ORGAN_NATION
    * @generated
    */
   public void setCoopOrganNation(String coopOrganNation){
      this.coopOrganNation = coopOrganNation;
   }

   /**
    * getter for ON_PROJECT_FUND
    * @generated
    */
   public String getOnProjectFund(){
      return this.onProjectFund;
   }
   /**
    * setter for ON_PROJECT_FUND
    * @generated
    */
   public void setOnProjectFund(String onProjectFund){
      this.onProjectFund = onProjectFund;
   }

   /**
    * getter for OFF_PROJECT_FUND
    * @generated
    */
   public String getOffProjectFund(){
      return this.offProjectFund;
   }
   /**
    * setter for OFF_PROJECT_FUND
    * @generated
    */
   public void setOffProjectFund(String offProjectFund){
      this.offProjectFund = offProjectFund;
   }

   /**
    * getter for PROJECT_TYPE
    * @generated
    */
   public String getProjectType(){
      return this.projectType;
   }
   /**
    * setter for PROJECT_TYPE
    * @generated
    */
   public void setProjectType(String projectType){
      this.projectType = projectType;
   }

   /**
    * getter for PROJECT_DESC
    * @generated
    */
   public String getProjectDesc(){
      return this.projectDesc;
   }
   /**
    * setter for PROJECT_DESC
    * @generated
    */
   public void setProjectDesc(String projectDesc){
      this.projectDesc = projectDesc;
   }

}