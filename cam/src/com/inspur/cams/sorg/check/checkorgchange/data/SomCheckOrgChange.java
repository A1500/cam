package com.inspur.cams.sorg.check.checkorgchange.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomCheckOrgChange
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_ORG_CHANGE" , keyFields = "id")
public class SomCheckOrgChange extends StatefulDatabean {
   //ID
  
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
	private String sequence;
   //CHANGE_TYPE
	@Column(name = "CHANGE_TYPE")
   private String changeType;
   //ORG_NAME
	@Column(name = "ORG_NAME")
   private String orgName;
   //ORG_CHARGER
	@Column(name = "ORG_CHARGER")
   private String orgCharger;
   //RECORD_DATE
	@Column(name = "RECORD_DATE")
   private String recordDate;
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
    * getter for CHANGE_TYPE
    * @generated
    */
   public String getChangeType(){
      return this.changeType;
   }
   /**
    * setter for CHANGE_TYPE
    * @generated
    */
   public void setChangeType(String changeType){
      this.changeType = changeType;
   }

   /**
    * getter for ORG_NAME
    * @generated
    */
   public String getOrgName(){
      return this.orgName;
   }
   /**
    * setter for ORG_NAME
    * @generated
    */
   public void setOrgName(String orgName){
      this.orgName = orgName;
   }

   /**
    * getter for ORG_CHARGER
    * @generated
    */
   public String getOrgCharger(){
      return this.orgCharger;
   }
   /**
    * setter for ORG_CHARGER
    * @generated
    */
   public void setOrgCharger(String orgCharger){
      this.orgCharger = orgCharger;
   }

   /**
    * getter for RECORD_DATE
    * @generated
    */
   public String getRecordDate(){
      return this.recordDate;
   }
   /**
    * setter for RECORD_DATE
    * @generated
    */
   public void setRecordDate(String recordDate){
      this.recordDate = recordDate;
   }
public String getSequence() {
	return sequence;
}
public void setSequence(String sequence) {
	this.sequence = sequence;
}

}