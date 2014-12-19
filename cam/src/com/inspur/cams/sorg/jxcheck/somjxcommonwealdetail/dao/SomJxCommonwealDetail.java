package com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西本年度公益活动明细
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_COMMONWEAL_DETAIL" , keyFields = "id")
public class SomJxCommonwealDetail extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ACTIVITY_NUM
   	
	@Column(name = "ACTIVITY_NUM")
   private String activityNum;
   //ITEM_NAME
	@Column(name = "ITEM_NAME")
   private String itemName;
   //ITEM_IN
   	
	@Column(name = "ITEM_IN")
   private String itemIn;
   //ITEM_OUT
   	
	@Column(name = "ITEM_OUT")
   private String itemOut;
   //ITEM_YEAR
	@Column(name = "ITEM_YEAR")
   private String itemYear;
	private String itemYearEnd;
   //ITEM_CONTENT
	@Column(name = "ITEM_CONTENT")
   private String itemContent;
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
    * getter for ACTIVITY_NUM
    * @generated
    */
   public String getActivityNum(){
      return this.activityNum;
   }
   /**
    * setter for ACTIVITY_NUM
    * @generated
    */
   public void setActivityNum(String activityNum){
      this.activityNum = activityNum;
   }

   /**
    * getter for ITEM_NAME
    * @generated
    */
   public String getItemName(){
      return this.itemName;
   }
   /**
    * setter for ITEM_NAME
    * @generated
    */
   public void setItemName(String itemName){
      this.itemName = itemName;
   }

   /**
    * getter for ITEM_IN
    * @generated
    */
   public String getItemIn(){
      return this.itemIn;
   }
   /**
    * setter for ITEM_IN
    * @generated
    */
   public void setItemIn(String itemIn){
      this.itemIn = itemIn;
   }

   /**
    * getter for ITEM_OUT
    * @generated
    */
   public String getItemOut(){
      return this.itemOut;
   }
   /**
    * setter for ITEM_OUT
    * @generated
    */
   public void setItemOut(String itemOut){
      this.itemOut = itemOut;
   }

   /**
    * getter for ITEM_YEAR
    * @generated
    */
   public String getItemYear(){
      return this.itemYear;
   }
   /**
    * setter for ITEM_YEAR
    * @generated
    */
   public void setItemYear(String itemYear){
      this.itemYear = itemYear;
   }

   /**
    * getter for ITEM_CONTENT
    * @generated
    */
   public String getItemContent(){
      return this.itemContent;
   }
   /**
    * setter for ITEM_CONTENT
    * @generated
    */
   public void setItemContent(String itemContent){
      this.itemContent = itemContent;
   }
public String getItemYearEnd() {
	return itemYearEnd;
}
public void setItemYearEnd(String itemYearEnd) {
	this.itemYearEnd = itemYearEnd;
}


}