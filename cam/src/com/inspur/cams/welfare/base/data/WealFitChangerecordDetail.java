package com.inspur.cams.welfare.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealFitChangerecordDetail
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 @Table(tableName = "WEAL_FIT_CHANGERECORD_DETAIL" , keyFields = "detailId")
public class WealFitChangerecordDetail extends StatefulDatabean {
   //DETAIL_ID
   	@Rule(value="require")
	@Column(name = "DETAIL_ID")
   private String detailId;
   //CHANG_ID
	@Column(name = "CHANG_ID")
   private String changId;
   //ITEM_CODE
   	@Rule(value="require")
	@Column(name = "ITEM_CODE")
   private String itemCode;
   //ITEM_NAME
	@Column(name = "ITEM_NAME")
   private String itemName;
   //ITEM_BEFORE
	@Column(name = "ITEM_BEFORE")
   private String itemBefore;
   //ITEM_AFTER
	@Column(name = "ITEM_AFTER")
   private String itemAfter;
   /**
    * getter for DETAIL_ID
    * @generated
    */
   public String getDetailId(){
      return this.detailId;
   }
   /**
    * setter for DETAIL_ID
    * @generated
    */
   public void setDetailId(String detailId){
      this.detailId = detailId;
   }

   /**
    * getter for CHANG_ID
    * @generated
    */
   public String getChangId(){
      return this.changId;
   }
   /**
    * setter for CHANG_ID
    * @generated
    */
   public void setChangId(String changId){
      this.changId = changId;
   }

   /**
    * getter for ITEM_CODE
    * @generated
    */
   public String getItemCode(){
      return this.itemCode;
   }
   /**
    * setter for ITEM_CODE
    * @generated
    */
   public void setItemCode(String itemCode){
      this.itemCode = itemCode;
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
    * getter for ITEM_BEFORE
    * @generated
    */
   public String getItemBefore(){
      return this.itemBefore;
   }
   /**
    * setter for ITEM_BEFORE
    * @generated
    */
   public void setItemBefore(String itemBefore){
      this.itemBefore = itemBefore;
   }

   /**
    * getter for ITEM_AFTER
    * @generated
    */
   public String getItemAfter(){
      return this.itemAfter;
   }
   /**
    * setter for ITEM_AFTER
    * @generated
    */
   public void setItemAfter(String itemAfter){
      this.itemAfter = itemAfter;
   }

}