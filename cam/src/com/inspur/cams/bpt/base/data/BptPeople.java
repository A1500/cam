package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptPeople
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 @Table(tableName = "BPT_PEOPLE" , keyFields = "peopleId")
public class BptPeople extends StatefulDatabean {
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //伤残类别代码
	@Column(name = "DISABILITY_TYPE_CODE")
   private String disabilityTypeCode;
   //烈属类别代码
	@Column(name = "DEPENDANT_TYPE_CODE")
   private String dependantTypeCode;
   //三红类别代码
	@Column(name = "REDA_TYPE_CODE")
   private String redaTypeCode;
   //在乡类别代码
	@Column(name = "DEMOBILIZED_TYEP_CODE")
   private String demobilizedTyepCode;
   //参战参试类别代码
	@Column(name = "WAR_TYPE_CODE")
   private String warTypeCode;
	//60周岁以上农村籍退役士兵
   private String retiredTypeCode;
   //部分烈士（错杀被平反人员）子女
   private String martyrOffspringCode;
   //开户银行代码
	@Rule(value="require")
	@Column(name = "BANK")
   private String bank;
	
	//开户名称
	@Rule(value="require")
	@Column(name = "ACCOUNT_NAME")
   private String accountName;
	
	//银行账号
	@Rule(value="require")
	@Column(name = "ACCOUNT_CODE")
   private String accountCode;
   //是否精神病标志
   	@Rule(value="require")
	@Column(name = "INSANITY_FLAG")
   private String insanityFlag;
   //孤老标志
   	@Rule(value="require")
	@Column(name = "OLD_LONELY_FLAG")
   private String oldLonelyFlag;
   //孤儿标志
   	//@Rule(value="require")
	@Column(name = "ORPHAN_FLAG")
   private String orphanFlag;
   //劳动能力代码
   	@Rule(value="require")
	@Column(name = "WORK_ABILITY_CODE")
   private String workAbilityCode;
   //劳动能力描述
	@Column(name = "WORK_ABILITY_DESCRIBE")
   private String workAbilityDescribe;
   //优抚生活能力代码
   	@Rule(value="require")
	@Column(name = "VIABILITY_CODE")
   private String viabilityCode;
   //优抚供养方式
   	@Rule(value="require")
	@Column(name = "SUPPORT_PATTERN")
   private String supportPattern;
   //就业情况描述
	@Column(name = "JOB_STATUS_DESCRIBE")
   private String jobStatusDescribe;

	/**
	 * @return the retiredTypeCode
	 */
	public String getRetiredTypeCode() {
		return retiredTypeCode;
	}
	/**
	 * @param retiredTypeCode the retiredTypeCode to set
	 */
	public void setRetiredTypeCode(String retiredTypeCode) {
		this.retiredTypeCode = retiredTypeCode;
	}
/**
    * getter for 人员ID
    * @generated
    */
   public String getPeopleId(){
      return this.peopleId;
   }
   /**
    * setter for 人员ID
    * @generated
    */
   public void setPeopleId(String peopleId){
      this.peopleId = peopleId;
   }

   /**
    * getter for 伤残类别代码
    * @generated
    */
   public String getDisabilityTypeCode(){
      return this.disabilityTypeCode;
   }
   /**
    * setter for 伤残类别代码
    * @generated
    */
   public void setDisabilityTypeCode(String disabilityTypeCode){
      this.disabilityTypeCode = disabilityTypeCode;
   }

   /**
    * getter for 烈属类别代码
    * @generated
    */
   public String getDependantTypeCode(){
      return this.dependantTypeCode;
   }
   /**
    * setter for 烈属类别代码
    * @generated
    */
   public void setDependantTypeCode(String dependantTypeCode){
      this.dependantTypeCode = dependantTypeCode;
   }

   /**
    * getter for 三红类别代码
    * @generated
    */
   public String getRedaTypeCode(){
      return this.redaTypeCode;
   }
   /**
    * setter for 三红类别代码
    * @generated
    */
   public void setRedaTypeCode(String redaTypeCode){
      this.redaTypeCode = redaTypeCode;
   }

   /**
    * getter for 在乡类别代码
    * @generated
    */
   public String getDemobilizedTyepCode(){
      return this.demobilizedTyepCode;
   }
   /**
    * setter for 在乡类别代码
    * @generated
    */
   public void setDemobilizedTyepCode(String demobilizedTyepCode){
      this.demobilizedTyepCode = demobilizedTyepCode;
   }

   /**
    * getter for 参战参试类别代码
    * @generated
    */
   public String getWarTypeCode(){
      return this.warTypeCode;
   }
   /**
    * setter for 参战参试类别代码
    * @generated
    */
   public void setWarTypeCode(String warTypeCode){
      this.warTypeCode = warTypeCode;
   }

   /**
    * getter for 是否精神病标志
    * @generated
    */
   public String getInsanityFlag(){
      return this.insanityFlag;
   }
   /**
    * setter for 是否精神病标志
    * @generated
    */
   public void setInsanityFlag(String insanityFlag){
      this.insanityFlag = insanityFlag;
   }

   /**
    * getter for 孤老标志
    * @generated
    */
   public String getOldLonelyFlag(){
      return this.oldLonelyFlag;
   }
   /**
    * setter for 孤老标志
    * @generated
    */
   public void setOldLonelyFlag(String oldLonelyFlag){
      this.oldLonelyFlag = oldLonelyFlag;
   }

   /**
    * getter for 孤儿标志
    * @generated
    */
   public String getOrphanFlag(){
      return this.orphanFlag;
   }
   /**
    * setter for 孤儿标志
    * @generated
    */
   public void setOrphanFlag(String orphanFlag){
      this.orphanFlag = orphanFlag;
   }

   /**
    * getter for 劳动能力代码
    * @generated
    */
   public String getWorkAbilityCode(){
      return this.workAbilityCode;
   }
   /**
    * setter for 劳动能力代码
    * @generated
    */
   public void setWorkAbilityCode(String workAbilityCode){
      this.workAbilityCode = workAbilityCode;
   }

   /**
    * getter for 劳动能力描述
    * @generated
    */
   public String getWorkAbilityDescribe(){
      return this.workAbilityDescribe;
   }
   /**
    * setter for 劳动能力描述
    * @generated
    */
   public void setWorkAbilityDescribe(String workAbilityDescribe){
      this.workAbilityDescribe = workAbilityDescribe;
   }

   /**
    * getter for 优抚生活能力代码
    * @generated
    */
   public String getViabilityCode(){
      return this.viabilityCode;
   }
   /**
    * setter for 优抚生活能力代码
    * @generated
    */
   public void setViabilityCode(String viabilityCode){
      this.viabilityCode = viabilityCode;
   }

   /**
    * getter for 优抚供养方式
    * @generated
    */
   public String getSupportPattern(){
      return this.supportPattern;
   }
   /**
    * setter for 优抚供养方式
    * @generated
    */
   public void setSupportPattern(String supportPattern){
      this.supportPattern = supportPattern;
   }

   /**
    * getter for 就业情况描述
    * @generated
    */
   public String getJobStatusDescribe(){
      return this.jobStatusDescribe;
   }
   /**
    * setter for 就业情况描述
    * @generated
    */
   public void setJobStatusDescribe(String jobStatusDescribe){
      this.jobStatusDescribe = jobStatusDescribe;
   }
/**
 * @return the bank
 */
public String getBank() {
	return bank;
}
/**
 * @param bank the bank to set
 */
public void setBank(String bank) {
	this.bank = bank;
}
/**
 * @return the accountName
 */
public String getAccountName() {
	return accountName;
}
/**
 * @param accountName the accountName to set
 */
public void setAccountName(String accountName) {
	this.accountName = accountName;
}
/**
 * @return the accountCode
 */
public String getAccountCode() {
	return accountCode;
}
/**
 * @param accountCode the accountCode to set
 */
public void setAccountCode(String accountCode) {
	this.accountCode = accountCode;
}
public String getMartyrOffspringCode() {
	return martyrOffspringCode;
}
public void setMartyrOffspringCode(String martyrOffspringCode) {
	this.martyrOffspringCode = martyrOffspringCode;
}

}