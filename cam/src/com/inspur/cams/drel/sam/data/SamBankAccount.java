package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:SamBankAccount
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
 @Table(tableName = "SAM_BANK_ACCOUNT" , keyFields = "familyId")
public class SamBankAccount extends StatefulDatabean {
   //ACCOUNT_ID
   //@Rule(value="require")
	@Column(name = "ACCOUNT_ID")
   private String accountId;
   //FAMILY_ID
   //@Rule(value="require")
	@Column(name = "FAMILY_ID")
   private String familyId;
   //ASSISTANCE_TYPE
	@Column(name = "ASSISTANCE_TYPE")
   private String assistanceType;
   //RELEASE_WAY
	@Column(name = "RELEASE_WAY")
   private String releaseWay;
   //BANK
	@Column(name = "BANK")
   private String bank;
   //ACCOUNT_NAME
	@Column(name = "ACCOUNT_NAME")
   private String accountName;
   //ACCOUNT_NUMBER
	@Column(name = "ACCOUNT_NUMBER")
   private String accountNumber;
   //ACCOUNT_STATUS
	@Column(name = "ACCOUNT_STATUS")
   private String accountStatus;
   //REMARKS
	@Column(name = "REMARKS")
   private String remarks;
   /**
    * getter for ACCOUNT_ID
    * @generated
    */
   public String getAccountId(){
      return this.accountId;
   }
   /**
    * setter for ACCOUNT_ID
    * @generated
    */
   public void setAccountId(String accountId){
      this.accountId = accountId;
   }

   /**
    * getter for FAMILY_ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for FAMILY_ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
   }

   /**
    * getter for ASSISTANCE_TYPE
    * @generated
    */
   public String getAssistanceType(){
      return this.assistanceType;
   }
   /**
    * setter for ASSISTANCE_TYPE
    * @generated
    */
   public void setAssistanceType(String assistanceType){
      this.assistanceType = assistanceType;
   }

   /**
    * getter for RELEASE_WAY
    * @generated
    */
   public String getReleaseWay(){
      return this.releaseWay;
   }
   /**
    * setter for RELEASE_WAY
    * @generated
    */
   public void setReleaseWay(String releaseWay){
      this.releaseWay = releaseWay;
   }

   /**
    * getter for BANK
    * @generated
    */
   public String getBank(){
      return this.bank;
   }
   /**
    * setter for BANK
    * @generated
    */
   public void setBank(String bank){
      this.bank = bank;
   }

   /**
    * getter for ACCOUNT_NAME
    * @generated
    */
   public String getAccountName(){
      return this.accountName;
   }
   /**
    * setter for ACCOUNT_NAME
    * @generated
    */
   public void setAccountName(String accountName){
      this.accountName = accountName;
   }

   /**
    * getter for ACCOUNT_NUMBER
    * @generated
    */
   public String getAccountNumber(){
      return this.accountNumber;
   }
   /**
    * setter for ACCOUNT_NUMBER
    * @generated
    */
   public void setAccountNumber(String accountNumber){
      this.accountNumber = accountNumber;
   }

   /**
    * getter for ACCOUNT_STATUS
    * @generated
    */
   public String getAccountStatus(){
      return this.accountStatus;
   }
   /**
    * setter for ACCOUNT_STATUS
    * @generated
    */
   public void setAccountStatus(String accountStatus){
      this.accountStatus = accountStatus;
   }

   /**
    * getter for REMARKS
    * @generated
    */
   public String getRemarks(){
      return this.remarks;
   }
   /**
    * setter for REMARKS
    * @generated
    */
   public void setRemarks(String remarks){
      this.remarks = remarks;
   }

}