package com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西内部制度建设情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 @Table(tableName = "SOM_JX_CHECK_SYSTEMS" , keyFields = "id")
public class SomJxCheckSystems extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //IF_BRANCH_SYS
	@Column(name = "IF_BRANCH_SYS")
   private String ifBranchSys;
   //IF_CERT_SYS
	@Column(name = "IF_CERT_SYS")
   private String ifCertSys;
   //CERT_SYS_MANAGER
	@Column(name = "CERT_SYS_MANAGER")
   private String certSysManager;
   //IF_STAMP_SYS
	@Column(name = "IF_STAMP_SYS")
   private String ifStampSys;
   //STAMP_SYS_MANAGER
	@Column(name = "STAMP_SYS_MANAGER")
   private String stampSysManager;
   //IF_PERSONNAL_SYS
	@Column(name = "IF_PERSONNAL_SYS")
   private String ifPersonnalSys;
   //CONTRACT_PERSON_NUM
	@Column(name = "CONTRACT_PERSON_NUM")
   private String contractPersonNum;
   //UNEMPLOYMENT_INS_NUM
	@Column(name = "UNEMPLOYMENT_INS_NUM")
   private String unemploymentInsNum;
   //ENDOWMENT_INS_NUM
	@Column(name = "ENDOWMENT_INS_NUM")
   private String endowmentInsNum;
   //MEDICAL_INS_NUM
	@Column(name = "MEDICAL_INS_NUM")
   private String medicalInsNum;
   //INJURY_INS_NUM
	@Column(name = "INJURY_INS_NUM")
   private String injuryInsNum;
   //BIRTH_INS_NUM
	@Column(name = "BIRTH_INS_NUM")
   private String birthInsNum;
   //RMB_DEPOSIT_BANK
	@Column(name = "RMB_DEPOSIT_BANK")
   private String rmbDepositBank;
   //RMB_BANK_ACCOUNTS
	@Column(name = "RMB_BANK_ACCOUNTS")
   private String rmbBankAccounts;
   //WB_DEPOSIT_BANK
	@Column(name = "WB_DEPOSIT_BANK")
   private String wbDepositBank;
   //WB_BANK_ACCOUNTS 
	@Column(name = "WB_BANK_ACCOUNTS")
   private String wbBankAccounts;
   //IF_FINANCIAL_REG
	@Column(name = "IF_FINANCIAL_REG")
   private String ifFinancialReg;
   //TAX_REG_TYPE
	@Column(name = "TAX_REG_TYPE")
   private String taxRegType;
   //BILL_TYPE
	@Column(name = "BILL_TYPE")
   private String billType;
   //OTHERS
	@Column(name = "OTHERS")
   private String others;
   //OHTHER_MANAGEMENT
	@Column(name = "OHTHER_MANAGEMENT")
   private String ohtherManagement;
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
    * getter for IF_BRANCH_SYS
    * @generated
    */
   public String getIfBranchSys(){
      return this.ifBranchSys;
   }
   /**
    * setter for IF_BRANCH_SYS
    * @generated
    */
   public void setIfBranchSys(String ifBranchSys){
      this.ifBranchSys = ifBranchSys;
   }

   /**
    * getter for IF_CERT_SYS
    * @generated
    */
   public String getIfCertSys(){
      return this.ifCertSys;
   }
   /**
    * setter for IF_CERT_SYS
    * @generated
    */
   public void setIfCertSys(String ifCertSys){
      this.ifCertSys = ifCertSys;
   }

   /**
    * getter for CERT_SYS_MANAGER
    * @generated
    */
   public String getCertSysManager(){
      return this.certSysManager;
   }
   /**
    * setter for CERT_SYS_MANAGER
    * @generated
    */
   public void setCertSysManager(String certSysManager){
      this.certSysManager = certSysManager;
   }

   /**
    * getter for IF_STAMP_SYS
    * @generated
    */
   public String getIfStampSys(){
      return this.ifStampSys;
   }
   /**
    * setter for IF_STAMP_SYS
    * @generated
    */
   public void setIfStampSys(String ifStampSys){
      this.ifStampSys = ifStampSys;
   }

   /**
    * getter for STAMP_SYS_MANAGER
    * @generated
    */
   public String getStampSysManager(){
      return this.stampSysManager;
   }
   /**
    * setter for STAMP_SYS_MANAGER
    * @generated
    */
   public void setStampSysManager(String stampSysManager){
      this.stampSysManager = stampSysManager;
   }

   /**
    * getter for IF_PERSONNAL_SYS
    * @generated
    */
   public String getIfPersonnalSys(){
      return this.ifPersonnalSys;
   }
   /**
    * setter for IF_PERSONNAL_SYS
    * @generated
    */
   public void setIfPersonnalSys(String ifPersonnalSys){
      this.ifPersonnalSys = ifPersonnalSys;
   }

   /**
    * getter for CONTRACT_PERSON_NUM
    * @generated
    */
   public String getContractPersonNum(){
      return this.contractPersonNum;
   }
   /**
    * setter for CONTRACT_PERSON_NUM
    * @generated
    */
   public void setContractPersonNum(String contractPersonNum){
      this.contractPersonNum = contractPersonNum;
   }

   /**
    * getter for UNEMPLOYMENT_INS_NUM
    * @generated
    */
   public String getUnemploymentInsNum(){
      return this.unemploymentInsNum;
   }
   /**
    * setter for UNEMPLOYMENT_INS_NUM
    * @generated
    */
   public void setUnemploymentInsNum(String unemploymentInsNum){
      this.unemploymentInsNum = unemploymentInsNum;
   }

   /**
    * getter for ENDOWMENT_INS_NUM
    * @generated
    */
   public String getEndowmentInsNum(){
      return this.endowmentInsNum;
   }
   /**
    * setter for ENDOWMENT_INS_NUM
    * @generated
    */
   public void setEndowmentInsNum(String endowmentInsNum){
      this.endowmentInsNum = endowmentInsNum;
   }

   /**
    * getter for MEDICAL_INS_NUM
    * @generated
    */
   public String getMedicalInsNum(){
      return this.medicalInsNum;
   }
   /**
    * setter for MEDICAL_INS_NUM
    * @generated
    */
   public void setMedicalInsNum(String medicalInsNum){
      this.medicalInsNum = medicalInsNum;
   }

   /**
    * getter for INJURY_INS_NUM
    * @generated
    */
   public String getInjuryInsNum(){
      return this.injuryInsNum;
   }
   /**
    * setter for INJURY_INS_NUM
    * @generated
    */
   public void setInjuryInsNum(String injuryInsNum){
      this.injuryInsNum = injuryInsNum;
   }

   /**
    * getter for BIRTH_INS_NUM
    * @generated
    */
   public String getBirthInsNum(){
      return this.birthInsNum;
   }
   /**
    * setter for BIRTH_INS_NUM
    * @generated
    */
   public void setBirthInsNum(String birthInsNum){
      this.birthInsNum = birthInsNum;
   }

   /**
    * getter for IF_FINANCIAL_REG
    * @generated
    */
   public String getIfFinancialReg(){
      return this.ifFinancialReg;
   }
   /**
    * setter for IF_FINANCIAL_REG
    * @generated
    */
   public void setIfFinancialReg(String ifFinancialReg){
      this.ifFinancialReg = ifFinancialReg;
   }

   /**
    * getter for TAX_REG_TYPE
    * @generated
    */
   public String getTaxRegType(){
      return this.taxRegType;
   }
   /**
    * setter for TAX_REG_TYPE
    * @generated
    */
   public void setTaxRegType(String taxRegType){
      this.taxRegType = taxRegType;
   }

   /**
    * getter for BILL_TYPE
    * @generated
    */
   public String getBillType(){
      return this.billType;
   }
   /**
    * setter for BILL_TYPE
    * @generated
    */
   public void setBillType(String billType){
      this.billType = billType;
   }

   /**
    * getter for OTHERS
    * @generated
    */
   public String getOthers(){
      return this.others;
   }
   /**
    * setter for OTHERS
    * @generated
    */
   public void setOthers(String others){
      this.others = others;
   }
public String getRmbDepositBank() {
	return rmbDepositBank;
}
public void setRmbDepositBank(String rmbDepositBank) {
	this.rmbDepositBank = rmbDepositBank;
}
public String getRmbBankAccounts() {
	return rmbBankAccounts;
}
public void setRmbBankAccounts(String rmbBankAccounts) {
	this.rmbBankAccounts = rmbBankAccounts;
}
public String getWbDepositBank() {
	return wbDepositBank;
}
public void setWbDepositBank(String wbDepositBank) {
	this.wbDepositBank = wbDepositBank;
}
public String getWbBankAccounts() {
	return wbBankAccounts;
}
public void setWbBankAccounts(String wbBankAccounts) {
	this.wbBankAccounts = wbBankAccounts;
}
public String getOhtherManagement() {
	return ohtherManagement;
}
public void setOhtherManagement(String ohtherManagement) {
	this.ohtherManagement = ohtherManagement;
}

}