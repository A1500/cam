package com.inspur.cams.comm.menuconfig.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:PubMenuConfig
 * @description:
 * @author:
 * @since:2011-08-09
 * @version:1.0
*/
 @Table(tableName = "PUB_MENU_CONFIG" , keyFields = "organCode")
public class PubMenuConfig extends StatefulDatabean {
   //ORGAN_CODE
   	@Rule(value="require")
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //ORGAN_NAME
	@Column(name = "ORGAN_NAME")
   private String organName;
   //MENU_TYPE_ID
	@Column(name = "MENU_TYPE_ID")
   private String menuTypeId;
   //DEAL_PERSON_ID
	@Column(name = "DEAL_PERSON_ID")
   private String dealPersonId;
   //DEAL_PERSON_NAME
	@Column(name = "DEAL_PERSON_NAME")
   private String dealPersonName;
   //DEAL_TIME
	@Column(name = "DEAL_TIME")
   private String dealTime;
   //MENU_TYPE_NAME
	@Column(name = "MENU_TYPE_NAME")
   private String menuTypeName;
   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for ORGAN_NAME
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for ORGAN_NAME
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for MENU_TYPE_ID
    * @generated
    */
   public String getMenuTypeId(){
      return this.menuTypeId;
   }
   /**
    * setter for MENU_TYPE_ID
    * @generated
    */
   public void setMenuTypeId(String menuTypeId){
      this.menuTypeId = menuTypeId;
   }

   /**
    * getter for DEAL_PERSON_ID
    * @generated
    */
   public String getDealPersonId(){
      return this.dealPersonId;
   }
   /**
    * setter for DEAL_PERSON_ID
    * @generated
    */
   public void setDealPersonId(String dealPersonId){
      this.dealPersonId = dealPersonId;
   }

   /**
    * getter for DEAL_PERSON_NAME
    * @generated
    */
   public String getDealPersonName(){
      return this.dealPersonName;
   }
   /**
    * setter for DEAL_PERSON_NAME
    * @generated
    */
   public void setDealPersonName(String dealPersonName){
      this.dealPersonName = dealPersonName;
   }

   /**
    * getter for DEAL_TIME
    * @generated
    */
   public String getDealTime(){
      return this.dealTime;
   }
   /**
    * setter for DEAL_TIME
    * @generated
    */
   public void setDealTime(String dealTime){
      this.dealTime = dealTime;
   }

   /**
    * getter for MENU_TYPE_NAME
    * @generated
    */
   public String getMenuTypeName(){
      return this.menuTypeName;
   }
   /**
    * setter for MENU_TYPE_NAME
    * @generated
    */
   public void setMenuTypeName(String menuTypeName){
      this.menuTypeName = menuTypeName;
   }

}