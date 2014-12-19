package com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西年度登记、备案事项办理
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHANGE_CIRCS" , keyFields = "id")
public class SomJxChangeCircs extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //CHANGE_ITEM
	@Column(name = "CHANGE_ITEM")
   private String changeItem;
   //RESULT
	@Column(name = "RESULT")
   private String result;
   //AGREE_DATE
	@Column(name = "AGREE_DATE")
   private String agreeDate;
	
	private String ifChange;
	
   public String getIfChange() {
		return ifChange;
	}
	public void setIfChange(String ifChange) {
		this.ifChange = ifChange;
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
    * getter for CHANGE_ITEM
    * @generated
    */
   public String getChangeItem(){
      return this.changeItem;
   }
   /**
    * setter for CHANGE_ITEM
    * @generated
    */
   public void setChangeItem(String changeItem){
      this.changeItem = changeItem;
   }

   /**
    * getter for RESULT
    * @generated
    */
   public String getResult(){
      return this.result;
   }
   /**
    * setter for RESULT
    * @generated
    */
   public void setResult(String result){
      this.result = result;
   }

   /**
    * getter for AGREE_DATE
    * @generated
    */
   public String getAgreeDate(){
      return this.agreeDate;
   }
   /**
    * setter for AGREE_DATE
    * @generated
    */
   public void setAgreeDate(String agreeDate){
      this.agreeDate = agreeDate;
   }

}