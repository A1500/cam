package com.inspur.cams.sorg.jxcheck.somjxcontribute.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西接受捐赠、公开募捐情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CONTRIBUTE" , keyFields = "id")
public class SomJxContribute extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ITEM_NUM
   	
	@Column(name = "ITEM_NUM")
   private String itemNum;
   //CURRENT_MONEY
   	
	@Column(name = "CURRENT_MONEY")
   private String currentMoney;
   //CURRENT_PRACTICALI
   	
	@Column(name = "CURRENT_PRACTICALI")
   private String currentPracticali;
   //CURRENT_TOTAL
   	
	@Column(name = "CURRENT_TOTAL")
   private String currentTotal;
   //IN_MONEY
   	
	@Column(name = "IN_MONEY")
   private String inMoney;
   //IN_PRACTICALI
   	
	@Column(name = "IN_PRACTICALI")
   private String inPracticali;
   //IN_TOTAL
   	
	@Column(name = "IN_TOTAL")
   private String inTotal;
   //IN_PEOPLE_MONEY
   	
	@Column(name = "IN_PEOPLE_MONEY")
   private String inPeopleMoney;
   //IN_PEOPLE_PRACTICALI
   	
	@Column(name = "IN_PEOPLE_PRACTICALI")
   private String inPeoplePracticali;
   //IN_PEOPLE_TOTAL
   	
	@Column(name = "IN_PEOPLE_TOTAL")
   private String inPeopleTotal;
   //IN_OTHER_MONEY
   	
	@Column(name = "IN_OTHER_MONEY")
   private String inOtherMoney;
   //IN_OTHER_PRACTICALI
   	
	@Column(name = "IN_OTHER_PRACTICALI")
   private String inOtherPracticali;
   //IN_OTHER_TOTAL
   	
	@Column(name = "IN_OTHER_TOTAL")
   private String inOtherTotal;
   //OFF_MONEY
   	
	@Column(name = "OFF_MONEY")
   private String offMoney;
   //OFF_PRACTICALI
   	
	@Column(name = "OFF_PRACTICALI")
   private String offPracticali;
   //OFF_TOTAL
   	
	@Column(name = "OFF_TOTAL")
   private String offTotal;
   //OFF_PEOPLE_MONEY
   	
	@Column(name = "OFF_PEOPLE_MONEY")
   private String offPeopleMoney;
   //OFF_PEOPLE_PRACTICALI
   	
	@Column(name = "OFF_PEOPLE_PRACTICALI")
   private String offPeoplePracticali;
   //OFF_PEOPLE_TOTAL
   	
	@Column(name = "OFF_PEOPLE_TOTAL")
   private String offPeopleTotal;
   //OFF_OTHER_MONEY
   	
	@Column(name = "OFF_OTHER_MONEY")
   private String offOtherMoney;
   //OFF_OTHER_PRACTICALI
   	
	@Column(name = "OFF_OTHER_PRACTICALI")
   private String offOtherPracticali;
   //OFF_OTHER_TOTAL
   	
	@Column(name = "OFF_OTHER_TOTAL")
   private String offOtherTotal;
   //IF_OPEN
	@Column(name = "IF_OPEN")
   private String ifOpen;
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
    * getter for ITEM_NUM
    * @generated
    */
   public String getItemNum(){
      return this.itemNum;
   }
   /**
    * setter for ITEM_NUM
    * @generated
    */
   public void setItemNum(String itemNum){
      this.itemNum = itemNum;
   }

   /**
    * getter for CURRENT_MONEY
    * @generated
    */
   public String getCurrentMoney(){
      return this.currentMoney;
   }
   /**
    * setter for CURRENT_MONEY
    * @generated
    */
   public void setCurrentMoney(String currentMoney){
      this.currentMoney = currentMoney;
   }

   /**
    * getter for CURRENT_PRACTICALI
    * @generated
    */
   public String getCurrentPracticali(){
      return this.currentPracticali;
   }
   /**
    * setter for CURRENT_PRACTICALI
    * @generated
    */
   public void setCurrentPracticali(String currentPracticali){
      this.currentPracticali = currentPracticali;
   }

   /**
    * getter for CURRENT_TOTAL
    * @generated
    */
   public String getCurrentTotal(){
      return this.currentTotal;
   }
   /**
    * setter for CURRENT_TOTAL
    * @generated
    */
   public void setCurrentTotal(String currentTotal){
      this.currentTotal = currentTotal;
   }

   /**
    * getter for IN_MONEY
    * @generated
    */
   public String getInMoney(){
      return this.inMoney;
   }
   /**
    * setter for IN_MONEY
    * @generated
    */
   public void setInMoney(String inMoney){
      this.inMoney = inMoney;
   }

   /**
    * getter for IN_PRACTICALI
    * @generated
    */
   public String getInPracticali(){
      return this.inPracticali;
   }
   /**
    * setter for IN_PRACTICALI
    * @generated
    */
   public void setInPracticali(String inPracticali){
      this.inPracticali = inPracticali;
   }

   /**
    * getter for IN_TOTAL
    * @generated
    */
   public String getInTotal(){
      return this.inTotal;
   }
   /**
    * setter for IN_TOTAL
    * @generated
    */
   public void setInTotal(String inTotal){
      this.inTotal = inTotal;
   }

   /**
    * getter for IN_PEOPLE_MONEY
    * @generated
    */
   public String getInPeopleMoney(){
      return this.inPeopleMoney;
   }
   /**
    * setter for IN_PEOPLE_MONEY
    * @generated
    */
   public void setInPeopleMoney(String inPeopleMoney){
      this.inPeopleMoney = inPeopleMoney;
   }

   /**
    * getter for IN_PEOPLE_PRACTICALI
    * @generated
    */
   public String getInPeoplePracticali(){
      return this.inPeoplePracticali;
   }
   /**
    * setter for IN_PEOPLE_PRACTICALI
    * @generated
    */
   public void setInPeoplePracticali(String inPeoplePracticali){
      this.inPeoplePracticali = inPeoplePracticali;
   }

   /**
    * getter for IN_PEOPLE_TOTAL
    * @generated
    */
   public String getInPeopleTotal(){
      return this.inPeopleTotal;
   }
   /**
    * setter for IN_PEOPLE_TOTAL
    * @generated
    */
   public void setInPeopleTotal(String inPeopleTotal){
      this.inPeopleTotal = inPeopleTotal;
   }

   /**
    * getter for IN_OTHER_MONEY
    * @generated
    */
   public String getInOtherMoney(){
      return this.inOtherMoney;
   }
   /**
    * setter for IN_OTHER_MONEY
    * @generated
    */
   public void setInOtherMoney(String inOtherMoney){
      this.inOtherMoney = inOtherMoney;
   }

   /**
    * getter for IN_OTHER_PRACTICALI
    * @generated
    */
   public String getInOtherPracticali(){
      return this.inOtherPracticali;
   }
   /**
    * setter for IN_OTHER_PRACTICALI
    * @generated
    */
   public void setInOtherPracticali(String inOtherPracticali){
      this.inOtherPracticali = inOtherPracticali;
   }

   /**
    * getter for IN_OTHER_TOTAL
    * @generated
    */
   public String getInOtherTotal(){
      return this.inOtherTotal;
   }
   /**
    * setter for IN_OTHER_TOTAL
    * @generated
    */
   public void setInOtherTotal(String inOtherTotal){
      this.inOtherTotal = inOtherTotal;
   }

   /**
    * getter for OFF_MONEY
    * @generated
    */
   public String getOffMoney(){
      return this.offMoney;
   }
   /**
    * setter for OFF_MONEY
    * @generated
    */
   public void setOffMoney(String offMoney){
      this.offMoney = offMoney;
   }

   /**
    * getter for OFF_PRACTICALI
    * @generated
    */
   public String getOffPracticali(){
      return this.offPracticali;
   }
   /**
    * setter for OFF_PRACTICALI
    * @generated
    */
   public void setOffPracticali(String offPracticali){
      this.offPracticali = offPracticali;
   }

   /**
    * getter for OFF_TOTAL
    * @generated
    */
   public String getOffTotal(){
      return this.offTotal;
   }
   /**
    * setter for OFF_TOTAL
    * @generated
    */
   public void setOffTotal(String offTotal){
      this.offTotal = offTotal;
   }

   /**
    * getter for OFF_PEOPLE_MONEY
    * @generated
    */
   public String getOffPeopleMoney(){
      return this.offPeopleMoney;
   }
   /**
    * setter for OFF_PEOPLE_MONEY
    * @generated
    */
   public void setOffPeopleMoney(String offPeopleMoney){
      this.offPeopleMoney = offPeopleMoney;
   }

   /**
    * getter for OFF_PEOPLE_PRACTICALI
    * @generated
    */
   public String getOffPeoplePracticali(){
      return this.offPeoplePracticali;
   }
   /**
    * setter for OFF_PEOPLE_PRACTICALI
    * @generated
    */
   public void setOffPeoplePracticali(String offPeoplePracticali){
      this.offPeoplePracticali = offPeoplePracticali;
   }

   /**
    * getter for OFF_PEOPLE_TOTAL
    * @generated
    */
   public String getOffPeopleTotal(){
      return this.offPeopleTotal;
   }
   /**
    * setter for OFF_PEOPLE_TOTAL
    * @generated
    */
   public void setOffPeopleTotal(String offPeopleTotal){
      this.offPeopleTotal = offPeopleTotal;
   }

   /**
    * getter for OFF_OTHER_MONEY
    * @generated
    */
   public String getOffOtherMoney(){
      return this.offOtherMoney;
   }
   /**
    * setter for OFF_OTHER_MONEY
    * @generated
    */
   public void setOffOtherMoney(String offOtherMoney){
      this.offOtherMoney = offOtherMoney;
   }

   /**
    * getter for OFF_OTHER_PRACTICALI
    * @generated
    */
   public String getOffOtherPracticali(){
      return this.offOtherPracticali;
   }
   /**
    * setter for OFF_OTHER_PRACTICALI
    * @generated
    */
   public void setOffOtherPracticali(String offOtherPracticali){
      this.offOtherPracticali = offOtherPracticali;
   }

   /**
    * getter for OFF_OTHER_TOTAL
    * @generated
    */
   public String getOffOtherTotal(){
      return this.offOtherTotal;
   }
   /**
    * setter for OFF_OTHER_TOTAL
    * @generated
    */
   public void setOffOtherTotal(String offOtherTotal){
      this.offOtherTotal = offOtherTotal;
   }

   /**
    * getter for IF_OPEN
    * @generated
    */
   public String getIfOpen(){
      return this.ifOpen;
   }
   /**
    * setter for IF_OPEN
    * @generated
    */
   public void setIfOpen(String ifOpen){
      this.ifOpen = ifOpen;
   }

}