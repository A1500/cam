package com.inspur.cams.sorg.check.checksuborgan.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:分支、代表、办事、专项基金管理机构情况
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 @Table(tableName = "SOM_CHECK_SUBORGAN" , keyFields = "id")
public class SomCheckSuborgan extends StatefulDatabean {
   //管理机构情况主键
   	
	@Column(name = "ID")
   private String id;
   //业务编号
	@Column(name = "TASK_CODE")
   private String taskCode;
   //机构类型
	@Column(name = "ORGAN_TYPE")
   private String organType;
   //序号
	@Column(name = "SEQUENCE")
   private String sequence;
   //名称
	@Column(name = "ORGAN_NAME")
   private String organName;
   //负责人
	@Column(name = "MANAGER")
   private String manager;
   //是否成立专门的管理部门
	@Column(name = "IF_BUILD_MANAGER")
   private String ifBuildManager;
   //登记时间
	@Column(name = "REG_TIME")
   private String regTime;
   //登记证号
	@Column(name = "REG_NUMBER")
   private String regNumber;
   //帐户
	@Column(name = "ACCOUNTS")
   private String accounts;
   //住所
	@Column(name = "ADDRESS")
   private String address;
   //开户银行
	@Column(name = "DEPOSIT_BANK")
   private String depositBank;
   //账号
	@Column(name = "DEPOSIT_BANK_ACCOUNTS")
   private String depositBankAccounts;
	
   private String checkinType;
   
   private String moneySum;
   
   private String moneyOutSum;
   /**
    * getter for 管理机构情况主键
    * @generated
    */
   public String getId(){
      return this.id;
   }
   /**
    * setter for 管理机构情况主键
    * @generated
    */
   public void setId(String id){
      this.id = id;
   }

   /**
    * getter for 业务编号
    * @generated
    */
   public String getTaskCode(){
      return this.taskCode;
   }
   /**
    * setter for 业务编号
    * @generated
    */
   public void setTaskCode(String taskCode){
      this.taskCode = taskCode;
   }

   /**
    * getter for 机构类型
    * @generated
    */
   public String getOrganType(){
      return this.organType;
   }
   /**
    * setter for 机构类型
    * @generated
    */
   public void setOrganType(String organType){
      this.organType = organType;
   }

   /**
    * getter for 序号
    * @generated
    */
   public String getSequence(){
      return this.sequence;
   }
   /**
    * setter for 序号
    * @generated
    */
   public void setSequence(String sequence){
      this.sequence = sequence;
   }

   /**
    * getter for 名称
    * @generated
    */
   public String getOrganName(){
      return this.organName;
   }
   /**
    * setter for 名称
    * @generated
    */
   public void setOrganName(String organName){
      this.organName = organName;
   }

   /**
    * getter for 负责人
    * @generated
    */
   public String getManager(){
      return this.manager;
   }
   /**
    * setter for 负责人
    * @generated
    */
   public void setManager(String manager){
      this.manager = manager;
   }

   /**
    * getter for 是否成立专门的管理部门
    * @generated
    */
   public String getIfBuildManager(){
      return this.ifBuildManager;
   }
   /**
    * setter for 是否成立专门的管理部门
    * @generated
    */
   public void setIfBuildManager(String ifBuildManager){
      this.ifBuildManager = ifBuildManager;
   }

   /**
    * getter for 登记时间
    * @generated
    */
   public String getRegTime(){
      return this.regTime;
   }
   /**
    * setter for 登记时间
    * @generated
    */
   public void setRegTime(String regTime){
      this.regTime = regTime;
   }

   /**
    * getter for 登记证号
    * @generated
    */
   public String getRegNumber(){
      return this.regNumber;
   }
   /**
    * setter for 登记证号
    * @generated
    */
   public void setRegNumber(String regNumber){
      this.regNumber = regNumber;
   }

   /**
    * getter for 帐户
    * @generated
    */
   public String getAccounts(){
      return this.accounts;
   }
   /**
    * setter for 帐户
    * @generated
    */
   public void setAccounts(String accounts){
      this.accounts = accounts;
   }

   /**
    * getter for 住所
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for 住所
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for 开户银行
    * @generated
    */
   public String getDepositBank(){
      return this.depositBank;
   }
   /**
    * setter for 开户银行
    * @generated
    */
   public void setDepositBank(String depositBank){
      this.depositBank = depositBank;
   }

   /**
    * getter for 账号
    * @generated
    */
   public String getDepositBankAccounts(){
      return this.depositBankAccounts;
   }
   /**
    * setter for 账号
    * @generated
    */
   public void setDepositBankAccounts(String depositBankAccounts){
      this.depositBankAccounts = depositBankAccounts;
   }
public String getCheckinType() {
	return checkinType;
}
public void setCheckinType(String checkinType) {
	this.checkinType = checkinType;
}
public String getMoneySum() {
	return moneySum;
}
public void setMoneySum(String moneySum) {
	this.moneySum = moneySum;
}
public String getMoneyOutSum() {
	return moneyOutSum;
}
public void setMoneyOutSum(String moneyOutSum) {
	this.moneyOutSum = moneyOutSum;
}

}