package com.inspur.cams.drel.sam.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamSpecialAssistanceItem
 * @description:
 * @author douyn
 * @since:2012-05-17
 * @version:1.0
*/
 @Table(tableName = "SAM_SPECIAL_ASSISTANCE_ITEM" , keyFields = "itemId")
public class SamSpecialAssistanceItem extends StatefulDatabean {
   //ITEM_ID
   private String itemId;
   //AREA_CODE
   private String areaCode;
   //RELEASE_TYPE
   private String releaseType;
   //FREQUENCY
   private String frequency;
   //ITEM_CODE
   private String itemCode;
   //ITEM_NAME
   private String itemName;
   //TARGET
   private String target;
   //ASSISTANCE_MONEY
   private BigDecimal assistanceMoney;
   //IN_USE
   private String inUse;
   //REG_PEOPLE
   private String regPeople;
   //REG_ORGAN
   private String regOrgan;
   //REG_TIME
   private String regTime;
   /**
    * getter for ITEM_ID
    * @generated
    */
   public String getItemId(){
      return this.itemId;
   }
   /**
    * setter for ITEM_ID
    * @generated
    */
   public void setItemId(String itemId){
      this.itemId = itemId;
   }

   /**
    * getter for AREA_CODE
    * @generated
    */
   public String getAreaCode(){
      return this.areaCode;
   }
   /**
    * setter for AREA_CODE
    * @generated
    */
   public void setAreaCode(String areaCode){
      this.areaCode = areaCode;
   }

   /**
    * getter for RELEASE_TYPE
    * @generated
    */
   public String getReleaseType(){
      return this.releaseType;
   }
   /**
    * setter for RELEASE_TYPE
    * @generated
    */
   public void setReleaseType(String releaseType){
      this.releaseType = releaseType;
   }

   /**
    * getter for FREQUENCY
    * @generated
    */
   public String getFrequency(){
      return this.frequency;
   }
   /**
    * setter for FREQUENCY
    * @generated
    */
   public void setFrequency(String frequency){
      this.frequency = frequency;
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
    * getter for TARGET
    * @generated
    */
   public String getTarget(){
      return this.target;
   }
   /**
    * setter for TARGET
    * @generated
    */
   public void setTarget(String target){
      this.target = target;
   }

   /**
    * getter for ASSISTANCE_MONEY
    * @generated
    */
   public BigDecimal getAssistanceMoney(){
      return this.assistanceMoney;
   }
   /**
    * setter for ASSISTANCE_MONEY
    * @generated
    */
   public void setAssistanceMoney(BigDecimal assistanceMoney){
      this.assistanceMoney = assistanceMoney;
   }

   /**
    * getter for IN_USE
    * @generated
    */
   public String getInUse(){
      return this.inUse;
   }
   /**
    * setter for IN_USE
    * @generated
    */
   public void setInUse(String inUse){
      this.inUse = inUse;
   }

   /**
    * getter for REG_PEOPLE
    * @generated
    */
   public String getRegPeople(){
      return this.regPeople;
   }
   /**
    * setter for REG_PEOPLE
    * @generated
    */
   public void setRegPeople(String regPeople){
      this.regPeople = regPeople;
   }

   /**
    * getter for REG_ORGAN
    * @generated
    */
   public String getRegOrgan(){
      return this.regOrgan;
   }
   /**
    * setter for REG_ORGAN
    * @generated
    */
   public void setRegOrgan(String regOrgan){
      this.regOrgan = regOrgan;
   }

   /**
    * getter for REG_TIME
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for REG_TIME
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }
public String getItemCode() {
	return itemCode;
}
public void setItemCode(String itemCode) {
	this.itemCode = itemCode;
}

}