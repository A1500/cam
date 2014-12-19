package com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西评比达标表彰活动情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_IN_MARKET" , keyFields = "id")
public class SomJxCheckInMarket extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ACTIVITY_NAME
	@Column(name = "ACTIVITY_NAME")
   private String activityName;
   //IF_CHARGE
	@Column(name = "IF_CHARGE")
   private String ifCharge;
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
    * getter for ACTIVITY_NAME
    * @generated
    */
   public String getActivityName(){
      return this.activityName;
   }
   /**
    * setter for ACTIVITY_NAME
    * @generated
    */
   public void setActivityName(String activityName){
      this.activityName = activityName;
   }

   /**
    * getter for IF_CHARGE
    * @generated
    */
   public String getIfCharge(){
      return this.ifCharge;
   }
   /**
    * setter for IF_CHARGE
    * @generated
    */
   public void setIfCharge(String ifCharge){
      this.ifCharge = ifCharge;
   }

}