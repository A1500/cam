package com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西变更情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_CHANGES" , keyFields = "id")
public class SomJxCheckChanges extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //TYPE
	@Column(name = "TYPE")
   private String type;
   //BEFORE_CHANGE
	@Column(name = "BEFORE_CHANGE")
   private String beforeChange;
   //AFTER_CHANGE
	@Column(name = "AFTER_CHANGE")
   private String afterChange;
   //DEAL_STATUS
	@Column(name = "DEAL_STATUS")
   private String dealStatus;
   //APPROVE_DATE
	@Column(name = "APPROVE_DATE")
   private String approveDate;
	private String appDate;
   public String getAppDate() {
		return appDate;
	}
	public void setAppDate(String appDate) {
		this.appDate = appDate;
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
    * getter for TYPE
    * @generated
    */
   public String getType(){
      return this.type;
   }
   /**
    * setter for TYPE
    * @generated
    */
   public void setType(String type){
      this.type = type;
   }

   /**
    * getter for BEFORE_CHANGE
    * @generated
    */
   public String getBeforeChange(){
      return this.beforeChange;
   }
   /**
    * setter for BEFORE_CHANGE
    * @generated
    */
   public void setBeforeChange(String beforeChange){
      this.beforeChange = beforeChange;
   }

   /**
    * getter for AFTER_CHANGE
    * @generated
    */
   public String getAfterChange(){
      return this.afterChange;
   }
   /**
    * setter for AFTER_CHANGE
    * @generated
    */
   public void setAfterChange(String afterChange){
      this.afterChange = afterChange;
   }

   /**
    * getter for DEAL_STATUS
    * @generated
    */
   public String getDealStatus(){
      return this.dealStatus;
   }
   /**
    * setter for DEAL_STATUS
    * @generated
    */
   public void setDealStatus(String dealStatus){
      this.dealStatus = dealStatus;
   }

   /**
    * getter for APPROVE_DATE
    * @generated
    */
   public String getApproveDate(){
      return this.approveDate;
   }
   /**
    * setter for APPROVE_DATE
    * @generated
    */
   public void setApproveDate(String approveDate){
      this.approveDate = approveDate;
   }

}