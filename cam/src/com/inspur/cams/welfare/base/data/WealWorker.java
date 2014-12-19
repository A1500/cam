package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealWorker
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 @Table(tableName = "WEAL_WORKER" , keyFields = "workerId")
public class WealWorker extends StatefulDatabean {
   //WORKER_ID
   	@Rule(value="require")
	@Column(name = "WORKER_ID")
   private String workerId;
   //TASK_CODE
   	@Rule(value="require")
	@Column(name = "TASK_CODE")
   private String taskCode;
   //CORPORATION_TYPE
	@Column(name = "CORPORATION_TYPE")
   private String corporationType;
   //ID_CARD
   	@Rule(value="require")
	@Column(name = "ID_CARD")
   private String idCard;
   //NAME
	@Column(name = "NAME")
   private String name;
   //SEX
	@Column(name = "SEX")
   private String sex;
   //DISABILITY_TYPE
	@Column(name = "DISABILITY_TYPE")
   private String disabilityType;
   //DISABILITY_LEVEL
	@Column(name = "DISABILITY_LEVEL")
   private String disabilityLevel;
   //EDUCATION
	@Column(name = "EDUCATION")
   private String education;
   //ADDRESS
	@Column(name = "ADDRESS")
   private String address;
	@Column(name = "PHONE")
	   private String phone;
   //ENTRY_DATE
	@Column(name = "ENTRY_DATE")
   private String entryDate;
   //ENTRY_TYPE
	@Column(name = "ENTRY_TYPE")
   private String entryType;
   //JOB_LEVEL
	@Column(name = "JOB_LEVEL")
   private String jobLevel;
   //REAL_WAGES
   	
	@Column(name = "REAL_WAGES")
   private BigDecimal realWages;
   //SOCIAL_INSURANCE
   	
	@Column(name = "SOCIAL_INSURANCE")
   private BigDecimal socialInsurance;
    //ENDOWMENT_INSURANCE
   	
	@Column(name = "ENDOWMENT_INSURANCE")
   private BigDecimal endowmentInsurance;
  	
	@Column(name = "MEDICAL_INSURANCE")
   private BigDecimal medicalInsurance;
  	
	@Column(name = "UNEMPLOYED_INSURANCE")
   private BigDecimal unemployedInsurance;
	
	@Column(name = "INJURY_INSURANCE")
   private BigDecimal injuryInsurance;
	
	@Column(name = "MATERNITY_INSURANCE")
   private BigDecimal maternityInsurance;
	
	@Column(name = "HOUSING_FUND")
   private BigDecimal housingFund;
   //BUS_INSURANCE
   	
	@Column(name = "BUS_INSURANCE")
   private BigDecimal busInsurance;
   //DIS_SUBSIDY
   	
	@Column(name = "DIS_SUBSIDY")
   private BigDecimal disSubsidy;
 	
	@Column(name = "ALLOCATION_TYPE")
   private BigDecimal allocationType;
   //IF_PRODUCTOR
	@Column(name = "IF_PRODUCTOR")
   private String ifProductor;
   //CERT_SITUATION 假肢制作师证书持有情况
	@Column(name = "CERT_SITUATION")
   private String certSituation;
   //CERT_CODE
	@Column(name = "CERT_CODE")
   private String certCode;
   //CERT_DATE
	@Column(name = "CERT_DATE")
   private String certDate;
	@Column(name = "CERT_TIME")
	   private String certTime;
	//矫形器制作师证书情况
	@Column(name = "CERT_ORTHOSIS_SITUATION")
	   private String certOrthosisSituation;
		@Column(name = "CERT_ORTHOSIS_CODE")
	   private String certOrthosisCode;
		@Column(name = "CERT_ORTHOSIS_DATE")
	   private String certOrthosisDate;
		@Column(name = "CERT_ORTHOSIS_TIME")
		   private String certOrthosisTime;
   //CERT_SPECIAL_SITUATION
	@Column(name = "CERT_SPECIAL_SITUATION")
   private String certSpecialSituation;
   //CERT_SPECIAL_CODE
	@Column(name = "CERT_SPECIAL_CODE")
   private String certSpecialCode;
   //CERT_SPECIAL_DATE
	@Column(name = "CERT_SPECIAL_DATE")
   private String certSpecialDate;
	@Column(name = "CERT_SPECIAL_TIME")
	   private String certSpecialTime;
	@Column(name = "MOD_TIME")
	private String modTime;
   public BigDecimal getAllocationType() {
		return allocationType;
	}
	public void setAllocationType(BigDecimal allocationType) {
		this.allocationType = allocationType;
	}
/**
    * getter for WORKER_ID
    * @generated
    */
   public String getWorkerId(){
      return this.workerId;
   }
   /**
    * setter for WORKER_ID
    * @generated
    */
   public void setWorkerId(String workerId){
      this.workerId = workerId;
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
    * getter for CORPORATION_TYPE
    * @generated
    */
   public String getCorporationType(){
      return this.corporationType;
   }
   /**
    * setter for CORPORATION_TYPE
    * @generated
    */
   public void setCorporationType(String corporationType){
      this.corporationType = corporationType;
   }

   /**
    * getter for ID_CARD
    * @generated
    */
   public String getIdCard(){
      return this.idCard;
   }
   /**
    * setter for ID_CARD
    * @generated
    */
   public void setIdCard(String idCard){
      this.idCard = idCard;
   }

   /**
    * getter for NAME
    * @generated
    */
   public String getName(){
      return this.name;
   }
   /**
    * setter for NAME
    * @generated
    */
   public void setName(String name){
      this.name = name;
   }

   /**
    * getter for SEX
    * @generated
    */
   public String getSex(){
      return this.sex;
   }
   /**
    * setter for SEX
    * @generated
    */
   public void setSex(String sex){
      this.sex = sex;
   }

   /**
    * getter for DISABILITY_TYPE
    * @generated
    */
   public String getDisabilityType(){
      return this.disabilityType;
   }
   /**
    * setter for DISABILITY_TYPE
    * @generated
    */
   public void setDisabilityType(String disabilityType){
      this.disabilityType = disabilityType;
   }

   /**
    * getter for DISABILITY_LEVEL
    * @generated
    */
   public String getDisabilityLevel(){
      return this.disabilityLevel;
   }
   /**
    * setter for DISABILITY_LEVEL
    * @generated
    */
   public void setDisabilityLevel(String disabilityLevel){
      this.disabilityLevel = disabilityLevel;
   }

   /**
    * getter for EDUCATION
    * @generated
    */
   public String getEducation(){
      return this.education;
   }
   /**
    * setter for EDUCATION
    * @generated
    */
   public void setEducation(String education){
      this.education = education;
   }

   /**
    * getter for ADDRESS
    * @generated
    */
   public String getAddress(){
      return this.address;
   }
   /**
    * setter for ADDRESS
    * @generated
    */
   public void setAddress(String address){
      this.address = address;
   }

   /**
    * getter for ENTRY_DATE
    * @generated
    */
   public String getEntryDate(){
      return this.entryDate;
   }
   /**
    * setter for ENTRY_DATE
    * @generated
    */
   public void setEntryDate(String entryDate){
      this.entryDate = entryDate;
   }

   /**
    * getter for ENTRY_TYPE
    * @generated
    */
   public String getEntryType(){
      return this.entryType;
   }
   /**
    * setter for ENTRY_TYPE
    * @generated
    */
   public void setEntryType(String entryType){
      this.entryType = entryType;
   }

   /**
    * getter for JOB_LEVEL
    * @generated
    */
   public String getJobLevel(){
      return this.jobLevel;
   }
   /**
    * setter for JOB_LEVEL
    * @generated
    */
   public void setJobLevel(String jobLevel){
      this.jobLevel = jobLevel;
   }

   /**
    * getter for REAL_WAGES
    * @generated
    */
   public BigDecimal getRealWages(){
      return this.realWages;
   }
   /**
    * setter for REAL_WAGES
    * @generated
    */
   public void setRealWages(BigDecimal realWages){
      this.realWages = realWages;
   }

   /**
    * getter for SOCIAL_INSURANCE
    * @generated
    */
   public BigDecimal getSocialInsurance(){
      return this.socialInsurance;
   }
   /**
    * setter for SOCIAL_INSURANCE
    * @generated
    */
   public void setSocialInsurance(BigDecimal socialInsurance){
      this.socialInsurance = socialInsurance;
   }

   /**
    * getter for BUS_INSURANCE
    * @generated
    */
   public BigDecimal getBusInsurance(){
      return this.busInsurance;
   }
   /**
    * setter for BUS_INSURANCE
    * @generated
    */
   public void setBusInsurance(BigDecimal busInsurance){
      this.busInsurance = busInsurance;
   }

   /**
    * getter for DIS_SUBSIDY
    * @generated
    */
   public BigDecimal getDisSubsidy(){
      return this.disSubsidy;
   }
   /**
    * setter for DIS_SUBSIDY
    * @generated
    */
   public void setDisSubsidy(BigDecimal disSubsidy){
      this.disSubsidy = disSubsidy;
   }

   /**
    * getter for IF_PRODUCTOR
    * @generated
    */
   public String getIfProductor(){
      return this.ifProductor;
   }
   /**
    * setter for IF_PRODUCTOR
    * @generated
    */
   public void setIfProductor(String ifProductor){
      this.ifProductor = ifProductor;
   }



public String getCertOrthosisSituation() {
	return certOrthosisSituation;
}
public void setCertOrthosisSituation(String certOrthosisSituation) {
	this.certOrthosisSituation = certOrthosisSituation;
}
public String getCertOrthosisCode() {
	return certOrthosisCode;
}
public void setCertOrthosisCode(String certOrthosisCode) {
	this.certOrthosisCode = certOrthosisCode;
}
public String getCertOrthosisDate() {
	return certOrthosisDate;
}
public void setCertOrthosisDate(String certOrthosisDate) {
	this.certOrthosisDate = certOrthosisDate;
}
/**
    * getter for CERT_SPECIAL_SITUATION
    * @generated
    */
   public String getCertSpecialSituation(){
      return this.certSpecialSituation;
   }
   /**
    * setter for CERT_SPECIAL_SITUATION
    * @generated
    */
   public void setCertSpecialSituation(String certSpecialSituation){
      this.certSpecialSituation = certSpecialSituation;
   }

   /**
    * getter for CERT_SPECIAL_CODE
    * @generated
    */
   public String getCertSpecialCode(){
      return this.certSpecialCode;
   }
   /**
    * setter for CERT_SPECIAL_CODE
    * @generated
    */
   public void setCertSpecialCode(String certSpecialCode){
      this.certSpecialCode = certSpecialCode;
   }

   /**
    * getter for CERT_SPECIAL_DATE
    * @generated
    */
   public String getCertSpecialDate(){
      return this.certSpecialDate;
   }
   /**
    * setter for CERT_SPECIAL_DATE
    * @generated
    */
   public void setCertSpecialDate(String certSpecialDate){
      this.certSpecialDate = certSpecialDate;
   }
public BigDecimal getEndowmentInsurance() {
	return endowmentInsurance;
}
public void setEndowmentInsurance(BigDecimal endowmentInsurance) {
	this.endowmentInsurance = endowmentInsurance;
}
public BigDecimal getMedicalInsurance() {
	return medicalInsurance;
}
public void setMedicalInsurance(BigDecimal medicalInsurance) {
	this.medicalInsurance = medicalInsurance;
}
public BigDecimal getUnemployedInsurance() {
	return unemployedInsurance;
}
public void setUnemployedInsurance(BigDecimal unemployedInsurance) {
	this.unemployedInsurance = unemployedInsurance;
}
public BigDecimal getInjuryInsurance() {
	return injuryInsurance;
}
public void setInjuryInsurance(BigDecimal injuryInsurance) {
	this.injuryInsurance = injuryInsurance;
}
public BigDecimal getMaternityInsurance() {
	return maternityInsurance;
}
public void setMaternityInsurance(BigDecimal maternityInsurance) {
	this.maternityInsurance = maternityInsurance;
}
public BigDecimal getHousingFund() {
	return housingFund;
}
public void setHousingFund(BigDecimal housingFund) {
	this.housingFund = housingFund;
}
public String getModTime() {
	return modTime;
}
public void setModTime(String modTime) {
	this.modTime = modTime;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getCertSituation() {
	return certSituation;
}
public void setCertSituation(String certSituation) {
	this.certSituation = certSituation;
}
public String getCertCode() {
	return certCode;
}
public void setCertCode(String certCode) {
	this.certCode = certCode;
}
public String getCertDate() {
	return certDate;
}
public void setCertDate(String certDate) {
	this.certDate = certDate;
}
public String getCertTime() {
	return certTime;
}
public void setCertTime(String certTime) {
	this.certTime = certTime;
}
public String getCertOrthosisTime() {
	return certOrthosisTime;
}
public void setCertOrthosisTime(String certOrthosisTime) {
	this.certOrthosisTime = certOrthosisTime;
}
public String getCertSpecialTime() {
	return certSpecialTime;
}
public void setCertSpecialTime(String certSpecialTime) {
	this.certSpecialTime = certSpecialTime;
}

}