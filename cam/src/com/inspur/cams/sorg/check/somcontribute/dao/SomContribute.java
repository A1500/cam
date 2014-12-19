package com.inspur.cams.sorg.check.somcontribute.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomContribute
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 @Table(tableName = "SOM_CONTRIBUTE" , keyFields = "id")
public class SomContribute extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ITEM_NUM
   	@Rule(value="number")
	@Column(name = "ITEM_NUM")
   private BigDecimal itemNum;
   //CURRENT_MONEY
   	@Rule(value="number")
	@Column(name = "CURRENT_MONEY")
   private BigDecimal currentMoney;
   //CURRENT_PRACTICALI
   	@Rule(value="number")
	@Column(name = "CURRENT_PRACTICALI")
   private BigDecimal currentPracticali;
   //CURRENT_TOTAL
   	@Rule(value="number")
	@Column(name = "CURRENT_TOTAL")
   private BigDecimal currentTotal;
   //IN_MONEY
   	@Rule(value="number")
	@Column(name = "IN_MONEY")
   private BigDecimal inMoney;
   //IN_PRACTICALI
   	@Rule(value="number")
	@Column(name = "IN_PRACTICALI")
   private BigDecimal inPracticali;
   //IN_TOTAL
   	@Rule(value="number")
	@Column(name = "IN_TOTAL")
   private BigDecimal inTotal;
   //IN_PEOPLE_MONEY
   	@Rule(value="number")
	@Column(name = "IN_PEOPLE_MONEY")
   private BigDecimal inPeopleMoney;
   //IN_PEOPLE_PRACTICALI
   	@Rule(value="number")
	@Column(name = "IN_PEOPLE_PRACTICALI")
   private BigDecimal inPeoplePracticali;
   //IN_PEOPLE_TOTAL
   	@Rule(value="number")
	@Column(name = "IN_PEOPLE_TOTAL")
   private BigDecimal inPeopleTotal;
   //IN_OTHER_MONEY
   	@Rule(value="number")
	@Column(name = "IN_OTHER_MONEY")
   private BigDecimal inOtherMoney;
   //IN_OTHER_PRACTICALI
   	@Rule(value="number")
	@Column(name = "IN_OTHER_PRACTICALI")
   private BigDecimal inOtherPracticali;
   //IN_OTHER_TOTAL
   	@Rule(value="number")
	@Column(name = "IN_OTHER_TOTAL")
   private BigDecimal inOtherTotal;
   //OFF_MONEY
   	@Rule(value="number")
	@Column(name = "OFF_MONEY")
   private BigDecimal offMoney;
   //OFF_PRACTICALI
   	@Rule(value="number")
	@Column(name = "OFF_PRACTICALI")
   private BigDecimal offPracticali;
   //OFF_TOTAL
   	@Rule(value="number")
	@Column(name = "OFF_TOTAL")
   private BigDecimal offTotal;
   //OFF_PEOPLE_MONEY
   	@Rule(value="number")
	@Column(name = "OFF_PEOPLE_MONEY")
   private BigDecimal offPeopleMoney;
   //OFF_PEOPLE_PRACTICALI
   	@Rule(value="number")
	@Column(name = "OFF_PEOPLE_PRACTICALI")
   private BigDecimal offPeoplePracticali;
   //OFF_PEOPLE_TOTAL
   	@Rule(value="number")
	@Column(name = "OFF_PEOPLE_TOTAL")
   private BigDecimal offPeopleTotal;
   //OFF_OTHER_MONEY
   	@Rule(value="number")
	@Column(name = "OFF_OTHER_MONEY")
   private BigDecimal offOtherMoney;
   //OFF_OTHER_PRACTICALI
   	@Rule(value="number")
	@Column(name = "OFF_OTHER_PRACTICALI")
   private BigDecimal offOtherPracticali;
   //OFF_OTHER_TOTAL
   	@Rule(value="number")
	@Column(name = "OFF_OTHER_TOTAL")
   private BigDecimal offOtherTotal;
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
   public BigDecimal getItemNum(){
      return this.itemNum;
   }
   /**
    * setter for ITEM_NUM
    * @generated
    */
   public void setItemNum(BigDecimal itemNum){
      this.itemNum = itemNum;
   }

   /**
    * getter for CURRENT_MONEY
    * @generated
    */
   public BigDecimal getCurrentMoney(){
      return this.currentMoney;
   }
   /**
    * setter for CURRENT_MONEY
    * @generated
    */
   public void setCurrentMoney(BigDecimal currentMoney){
      this.currentMoney = currentMoney;
   }

   /**
    * getter for CURRENT_PRACTICALI
    * @generated
    */
   public BigDecimal getCurrentPracticali(){
      return this.currentPracticali;
   }
   /**
    * setter for CURRENT_PRACTICALI
    * @generated
    */
   public void setCurrentPracticali(BigDecimal currentPracticali){
      this.currentPracticali = currentPracticali;
   }

   /**
    * getter for CURRENT_TOTAL
    * @generated
    */
   public BigDecimal getCurrentTotal(){
      return this.currentTotal;
   }
   /**
    * setter for CURRENT_TOTAL
    * @generated
    */
   public void setCurrentTotal(BigDecimal currentTotal){
      this.currentTotal = currentTotal;
   }

   /**
    * getter for IN_MONEY
    * @generated
    */
   public BigDecimal getInMoney(){
      return this.inMoney;
   }
   /**
    * setter for IN_MONEY
    * @generated
    */
   public void setInMoney(BigDecimal inMoney){
      this.inMoney = inMoney;
   }

   /**
    * getter for IN_PRACTICALI
    * @generated
    */
   public BigDecimal getInPracticali(){
      return this.inPracticali;
   }
   /**
    * setter for IN_PRACTICALI
    * @generated
    */
   public void setInPracticali(BigDecimal inPracticali){
      this.inPracticali = inPracticali;
   }

   /**
    * getter for IN_TOTAL
    * @generated
    */
   public BigDecimal getInTotal(){
      return this.inTotal;
   }
   /**
    * setter for IN_TOTAL
    * @generated
    */
   public void setInTotal(BigDecimal inTotal){
      this.inTotal = inTotal;
   }

   /**
    * getter for IN_PEOPLE_MONEY
    * @generated
    */
   public BigDecimal getInPeopleMoney(){
      return this.inPeopleMoney;
   }
   /**
    * setter for IN_PEOPLE_MONEY
    * @generated
    */
   public void setInPeopleMoney(BigDecimal inPeopleMoney){
      this.inPeopleMoney = inPeopleMoney;
   }

   /**
    * getter for IN_PEOPLE_PRACTICALI
    * @generated
    */
   public BigDecimal getInPeoplePracticali(){
      return this.inPeoplePracticali;
   }
   /**
    * setter for IN_PEOPLE_PRACTICALI
    * @generated
    */
   public void setInPeoplePracticali(BigDecimal inPeoplePracticali){
      this.inPeoplePracticali = inPeoplePracticali;
   }

   /**
    * getter for IN_PEOPLE_TOTAL
    * @generated
    */
   public BigDecimal getInPeopleTotal(){
      return this.inPeopleTotal;
   }
   /**
    * setter for IN_PEOPLE_TOTAL
    * @generated
    */
   public void setInPeopleTotal(BigDecimal inPeopleTotal){
      this.inPeopleTotal = inPeopleTotal;
   }

   /**
    * getter for IN_OTHER_MONEY
    * @generated
    */
   public BigDecimal getInOtherMoney(){
      return this.inOtherMoney;
   }
   /**
    * setter for IN_OTHER_MONEY
    * @generated
    */
   public void setInOtherMoney(BigDecimal inOtherMoney){
      this.inOtherMoney = inOtherMoney;
   }

   /**
    * getter for IN_OTHER_PRACTICALI
    * @generated
    */
   public BigDecimal getInOtherPracticali(){
      return this.inOtherPracticali;
   }
   /**
    * setter for IN_OTHER_PRACTICALI
    * @generated
    */
   public void setInOtherPracticali(BigDecimal inOtherPracticali){
      this.inOtherPracticali = inOtherPracticali;
   }

   /**
    * getter for IN_OTHER_TOTAL
    * @generated
    */
   public BigDecimal getInOtherTotal(){
      return this.inOtherTotal;
   }
   /**
    * setter for IN_OTHER_TOTAL
    * @generated
    */
   public void setInOtherTotal(BigDecimal inOtherTotal){
      this.inOtherTotal = inOtherTotal;
   }

   /**
    * getter for OFF_MONEY
    * @generated
    */
   public BigDecimal getOffMoney(){
      return this.offMoney;
   }
   /**
    * setter for OFF_MONEY
    * @generated
    */
   public void setOffMoney(BigDecimal offMoney){
      this.offMoney = offMoney;
   }

   /**
    * getter for OFF_PRACTICALI
    * @generated
    */
   public BigDecimal getOffPracticali(){
      return this.offPracticali;
   }
   /**
    * setter for OFF_PRACTICALI
    * @generated
    */
   public void setOffPracticali(BigDecimal offPracticali){
      this.offPracticali = offPracticali;
   }

   /**
    * getter for OFF_TOTAL
    * @generated
    */
   public BigDecimal getOffTotal(){
      return this.offTotal;
   }
   /**
    * setter for OFF_TOTAL
    * @generated
    */
   public void setOffTotal(BigDecimal offTotal){
      this.offTotal = offTotal;
   }

   /**
    * getter for OFF_PEOPLE_MONEY
    * @generated
    */
   public BigDecimal getOffPeopleMoney(){
      return this.offPeopleMoney;
   }
   /**
    * setter for OFF_PEOPLE_MONEY
    * @generated
    */
   public void setOffPeopleMoney(BigDecimal offPeopleMoney){
      this.offPeopleMoney = offPeopleMoney;
   }

   /**
    * getter for OFF_PEOPLE_PRACTICALI
    * @generated
    */
   public BigDecimal getOffPeoplePracticali(){
      return this.offPeoplePracticali;
   }
   /**
    * setter for OFF_PEOPLE_PRACTICALI
    * @generated
    */
   public void setOffPeoplePracticali(BigDecimal offPeoplePracticali){
      this.offPeoplePracticali = offPeoplePracticali;
   }

   /**
    * getter for OFF_PEOPLE_TOTAL
    * @generated
    */
   public BigDecimal getOffPeopleTotal(){
      return this.offPeopleTotal;
   }
   /**
    * setter for OFF_PEOPLE_TOTAL
    * @generated
    */
   public void setOffPeopleTotal(BigDecimal offPeopleTotal){
      this.offPeopleTotal = offPeopleTotal;
   }

   /**
    * getter for OFF_OTHER_MONEY
    * @generated
    */
   public BigDecimal getOffOtherMoney(){
      return this.offOtherMoney;
   }
   /**
    * setter for OFF_OTHER_MONEY
    * @generated
    */
   public void setOffOtherMoney(BigDecimal offOtherMoney){
      this.offOtherMoney = offOtherMoney;
   }

   /**
    * getter for OFF_OTHER_PRACTICALI
    * @generated
    */
   public BigDecimal getOffOtherPracticali(){
      return this.offOtherPracticali;
   }
   /**
    * setter for OFF_OTHER_PRACTICALI
    * @generated
    */
   public void setOffOtherPracticali(BigDecimal offOtherPracticali){
      this.offOtherPracticali = offOtherPracticali;
   }

   /**
    * getter for OFF_OTHER_TOTAL
    * @generated
    */
   public BigDecimal getOffOtherTotal(){
      return this.offOtherTotal;
   }
   /**
    * setter for OFF_OTHER_TOTAL
    * @generated
    */
   public void setOffOtherTotal(BigDecimal offOtherTotal){
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