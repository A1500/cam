package com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西分支机构、代表机构情况、专项基金、办事机构、经营性实体情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_ORGAN_FUNDS" , keyFields = "id")
public class SomJxOrganFunds extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //ORGAN_TYPE
	@Column(name = "ORGAN_TYPE")
   private String organType;
   //SEQ_NUM
	@Column(name = "SEQ_NUM")
   private String seqNum;
   //ORGAN_NAME
	@Column(name = "ORGAN_NAME")
   private String organName;
   //PEOPLE_NAME
	@Column(name = "PEOPLE_NAME")
   private String peopleName;
   //ORGAN_DATE
	@Column(name = "ORGAN_DATE")
   private String organDate;
   //SORG_CODE
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //PLACE
	@Column(name = "PLACE")
   private String place;
   //ACCOUNT_TYPE
	@Column(name = "ACCOUNT_TYPE")
   private String accountType;
   //OPEN_ACCOUNT
	@Column(name = "OPEN_ACCOUNT")
   private String openAccount;
   //CHECKIN_TYPE
	@Column(name = "CHECKIN_TYPE")
   private String checkinType;
   //MONEY_SUM
	@Column(name = "MONEY_SUM")
   private String moneySum;
   //MONEY_OUT_SUM
	@Column(name = "MONEY_OUT_SUM")
   private String moneyOutSum;
   //IF_BUILD_ADMINISTRATION
   	@Column(name = "IF_BUILD_ADMINISTRATION")
   private String ifBuildAdministration;	
  //IF_BUILD_ACCOUNT 
   	@Column(name = "IF_BUILD_ACCOUNT")
   private String ifBuildAccount;	
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
    * getter for ORGAN_TYPE
    * @generated
    */
   public String getOrganType(){
      return this.organType;
   }
   /**
    * setter for ORGAN_TYPE
    * @generated
    */
   public void setOrganType(String organType){
      this.organType = organType;
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
    * getter for PEOPLE_NAME
    * @generated
    */
   public String getPeopleName(){
      return this.peopleName;
   }
   /**
    * setter for PEOPLE_NAME
    * @generated
    */
   public void setPeopleName(String peopleName){
      this.peopleName = peopleName;
   }

   /**
    * getter for ORGAN_DATE
    * @generated
    */
   public String getOrganDate(){
      return this.organDate;
   }
   /**
    * setter for ORGAN_DATE
    * @generated
    */
   public void setOrganDate(String organDate){
      this.organDate = organDate;
   }

   /**
    * getter for SORG_CODE
    * @generated
    */
   public String getSorgCode(){
      return this.sorgCode;
   }
   /**
    * setter for SORG_CODE
    * @generated
    */
   public void setSorgCode(String sorgCode){
      this.sorgCode = sorgCode;
   }

   /**
    * getter for PLACE
    * @generated
    */
   public String getPlace(){
      return this.place;
   }
   /**
    * setter for PLACE
    * @generated
    */
   public void setPlace(String place){
      this.place = place;
   }

   /**
    * getter for ACCOUNT_TYPE
    * @generated
    */
   public String getAccountType(){
      return this.accountType;
   }
   /**
    * setter for ACCOUNT_TYPE
    * @generated
    */
   public void setAccountType(String accountType){
      this.accountType = accountType;
   }

   /**
    * getter for OPEN_ACCOUNT
    * @generated
    */
   public String getOpenAccount(){
      return this.openAccount;
   }
   /**
    * setter for OPEN_ACCOUNT
    * @generated
    */
   public void setOpenAccount(String openAccount){
      this.openAccount = openAccount;
   }

   /**
    * getter for CHECKIN_TYPE
    * @generated
    */
   public String getCheckinType(){
      return this.checkinType;
   }
   /**
    * setter for CHECKIN_TYPE
    * @generated
    */
   public void setCheckinType(String checkinType){
      this.checkinType = checkinType;
   }

   /**
    * getter for MONEY_SUM
    * @generated
    */
   public String getMoneySum(){
      return this.moneySum;
   }
   /**
    * setter for MONEY_SUM
    * @generated
    */
   public void setMoneySum(String moneySum){
      this.moneySum = moneySum;
   }

   /**
    * getter for MONEY_OUT_SUM
    * @generated
    */
   public String getMoneyOutSum(){
      return this.moneyOutSum;
   }
   /**
    * setter for MONEY_OUT_SUM
    * @generated
    */
   public void setMoneyOutSum(String moneyOutSum){
      this.moneyOutSum = moneyOutSum;
   }
public String getIfBuildAdministration() {
	return ifBuildAdministration;
}
public void setIfBuildAdministration(String ifBuildAdministration) {
	this.ifBuildAdministration = ifBuildAdministration;
}
public String getIfBuildAccount() {
	return ifBuildAccount;
}
public void setIfBuildAccount(String ifBuildAccount) {
	this.ifBuildAccount = ifBuildAccount;
}
public String getSeqNum() {
	return seqNum;
}
public void setSeqNum(String seqNum) {
	this.seqNum = seqNum;
}

}