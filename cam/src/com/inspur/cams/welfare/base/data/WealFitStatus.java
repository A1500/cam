package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealFitStatus
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 @Table(tableName = "WEAL_FIT_STATUS" , keyFields = "fitId")
public class WealFitStatus extends StatefulDatabean {
   //FIT_ID
   	@Rule(value="require")
	@Column(name = "FIT_ID")
   private String fitId;
   //TASK_CODE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //STATUS
	@Column(name = "STATUS")
   private String status;
   //NEXT_CHECK
	@Column(name = "NEXT_CHECK")
   private String nextCheck;
   //NEXT_CHAGNE_CERT
	@Column(name = "NEXT_CHAGNE_CERT")
   private String nextChagneCert;
 
	 //APPLY_YEAR
		@Column(name = "APPLY_YEAR")
	   private String applyYear;
	   //SERIAL_NUM
		@Column(name = "SERIAL_NUM")
	   private String serialNum;
	   //COMPANY_NAME
	   	@Rule(value="require")
		@Column(name = "COMPANY_NAME")
	   private String companyName;
	   //ADDRESS
		@Column(name = "ADDRESS")
	   private String address;
	   //POST_CODE
		@Column(name = "POST_CODE")
	   private String postCode;
	   //LEGAL_PEOPLE
		@Column(name = "LEGAL_PEOPLE")
	   private String legalPeople;
	   //LEGAL_ID_CARD
		@Column(name = "LEGAL_ID_CARD")
	   private String legalIdCard;
	   //LEGAL_PHONE
		@Column(name = "LEGAL_PHONE")
	   private String legalPhone;
	   //LEGAL_TELPHONE
		@Column(name = "LEGAL_TELPHONE")
	   private String legalTelphone;
	   //LEGAL_EMAIL
		@Column(name = "LEGAL_EMAIL")
	   private String legalEmail;
	   //AGENT_PEOPLE
		@Column(name = "AGENT_PEOPLE")
	   private String agentPeople;
	   //AGENT_ID_CARD
		@Column(name = "AGENT_ID_CARD")
	   private String agentIdCard;
	   //AGENT_PHONE
		@Column(name = "AGENT_PHONE")
	   private String agentPhone;
	   //AGENT_TELPHONE
		@Column(name = "AGENT_TELPHONE")
	   private String agentTelphone;
	   //AGENT_EMAIL
		@Column(name = "AGENT_EMAIL")
	   private String agentEmail;
	   //WEB_ADDRESS
		@Column(name = "WEB_ADDRESS")
	   private String webAddress;
	   //ECONOMIC_NATURE_CODE
		@Column(name = "ECONOMIC_NATURE_CODE")
	   private String economicNatureCode;
	   //ECONOMIC_NATURE_NAME
		@Column(name = "ECONOMIC_NATURE_NAME")
	   private String economicNatureName;
	   //ORGAN_CODE
		@Column(name = "ORGAN_CODE")
	   private String organCode;
	   //LICENSE_CODE
		@Column(name = "LICENSE_CODE")
	   private String licenseCode;
	   //REGISTRATION_CODE
		@Column(name = "REGISTRATION_CODE")
	   private String registrationCode;
	   //REG_FUND
	   	@Rule(value="number")
		@Column(name = "REG_FUND")
	   private BigDecimal regFund;
	   //OPERATE_AREA
	   	@Rule(value="number")
		@Column(name = "OPERATE_AREA")
	   private BigDecimal operateArea;
	   //PRODUCT_AREA
	   	@Rule(value="number")
		@Column(name = "PRODUCT_AREA")
	   private BigDecimal productArea;
	   //RECOVERY_AREA
	   	@Rule(value="number")
		@Column(name = "RECOVERY_AREA")
	   private BigDecimal recoveryArea;
	   //RECEPTION_AREA
	   	@Rule(value="number")
		@Column(name = "RECEPTION_AREA")
	   private BigDecimal receptionArea;
	   //TRAIN_AREA
	   	@Rule(value="number")
		@Column(name = "TRAIN_AREA")
	   private BigDecimal trainArea;
	   //TREATMENT_AREA
	   	@Rule(value="number")
		@Column(name = "TREATMENT_AREA")
	   private BigDecimal treatmentArea;
	   //WORK_AREA
	   	@Rule(value="number")
		@Column(name = "WORK_AREA")
	   private BigDecimal workArea;
	   //LEISURE_AREA
	   	@Rule(value="number")
		@Column(name = "LEISURE_AREA")
	   private BigDecimal leisureArea;
	   //OTHER_AREA
	   	@Rule(value="number")
		@Column(name = "OTHER_AREA")
	   private BigDecimal otherArea;
		
	   	@Column(name = "BUSINESS_SCOPE")
		private String businessScope;
	   	
	   	@Rule(value="require")
		@Column(name = "MORG_NAME")
	   private String morgName;
	   
		@Rule(value="require")
		@Column(name = "MORG_AREA")
	   private String morgArea;
	   	
	   	@Column(name = "COGNIZANCE_DATE")
	    private String cognizanceDate;
	   	
		public String getMorgName() {
			return morgName;
		}
		public void setMorgName(String morgName) {
			this.morgName = morgName;
		}
		public String getMorgArea() {
			return morgArea;
		}
		public void setMorgArea(String morgArea) {
			this.morgArea = morgArea;
		}
   /**
    * getter for FIT_ID
    * @generated
    */
   public String getFitId(){
      return this.fitId;
   }
   public String getBusinessScope() {
	return businessScope;
}
public void setBusinessScope(String businessScope) {
	this.businessScope = businessScope;
}
/**
    * setter for FIT_ID
    * @generated
    */
   public void setFitId(String fitId){
      this.fitId = fitId;
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
    * getter for STATUS
    * @generated
    */
   public String getStatus(){
      return this.status;
   }
   /**
    * setter for STATUS
    * @generated
    */
   public void setStatus(String status){
      this.status = status;
   }

   /**
    * getter for NEXT_CHECK
    * @generated
    */
   public String getNextCheck(){
      return this.nextCheck;
   }
   /**
    * setter for NEXT_CHECK
    * @generated
    */
   public void setNextCheck(String nextCheck){
      this.nextCheck = nextCheck;
   }

   /**
    * getter for NEXT_CHAGNE_CERT
    * @generated
    */
   public String getNextChagneCert(){
      return this.nextChagneCert;
   }
   /**
    * setter for NEXT_CHAGNE_CERT
    * @generated
    */
   public void setNextChagneCert(String nextChagneCert){
      this.nextChagneCert = nextChagneCert;
   }
	public String getApplyYear() {
		return applyYear;
	}
	public void setApplyYear(String applyYear) {
		this.applyYear = applyYear;
	}
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getLegalPeople() {
		return legalPeople;
	}
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}
	public String getLegalIdCard() {
		return legalIdCard;
	}
	public void setLegalIdCard(String legalIdCard) {
		this.legalIdCard = legalIdCard;
	}
	public String getLegalPhone() {
		return legalPhone;
	}
	public void setLegalPhone(String legalPhone) {
		this.legalPhone = legalPhone;
	}
	public String getLegalTelphone() {
		return legalTelphone;
	}
	public void setLegalTelphone(String legalTelphone) {
		this.legalTelphone = legalTelphone;
	}
	public String getLegalEmail() {
		return legalEmail;
	}
	public void setLegalEmail(String legalEmail) {
		this.legalEmail = legalEmail;
	}
	public String getAgentPeople() {
		return agentPeople;
	}
	public void setAgentPeople(String agentPeople) {
		this.agentPeople = agentPeople;
	}
	public String getAgentIdCard() {
		return agentIdCard;
	}
	public void setAgentIdCard(String agentIdCard) {
		this.agentIdCard = agentIdCard;
	}
	public String getAgentPhone() {
		return agentPhone;
	}
	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}
	public String getAgentTelphone() {
		return agentTelphone;
	}
	public void setAgentTelphone(String agentTelphone) {
		this.agentTelphone = agentTelphone;
	}
	public String getAgentEmail() {
		return agentEmail;
	}
	public void setAgentEmail(String agentEmail) {
		this.agentEmail = agentEmail;
	}
	public String getWebAddress() {
		return webAddress;
	}
	public void setWebAddress(String webAddress) {
		this.webAddress = webAddress;
	}
	public String getEconomicNatureCode() {
		return economicNatureCode;
	}
	public void setEconomicNatureCode(String economicNatureCode) {
		this.economicNatureCode = economicNatureCode;
	}
	public String getEconomicNatureName() {
		return economicNatureName;
	}
	public void setEconomicNatureName(String economicNatureName) {
		this.economicNatureName = economicNatureName;
	}
	public String getOrganCode() {
		return organCode;
	}
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}
	public String getLicenseCode() {
		return licenseCode;
	}
	public void setLicenseCode(String licenseCode) {
		this.licenseCode = licenseCode;
	}
	public String getRegistrationCode() {
		return registrationCode;
	}
	public void setRegistrationCode(String registrationCode) {
		this.registrationCode = registrationCode;
	}
	public BigDecimal getRegFund() {
		return regFund;
	}
	public void setRegFund(BigDecimal regFund) {
		this.regFund = regFund;
	}
	public BigDecimal getOperateArea() {
		return operateArea;
	}
	public void setOperateArea(BigDecimal operateArea) {
		this.operateArea = operateArea;
	}
	public BigDecimal getProductArea() {
		return productArea;
	}
	public void setProductArea(BigDecimal productArea) {
		this.productArea = productArea;
	}
	public BigDecimal getRecoveryArea() {
		return recoveryArea;
	}
	public void setRecoveryArea(BigDecimal recoveryArea) {
		this.recoveryArea = recoveryArea;
	}
	public BigDecimal getReceptionArea() {
		return receptionArea;
	}
	public void setReceptionArea(BigDecimal receptionArea) {
		this.receptionArea = receptionArea;
	}
	public BigDecimal getTrainArea() {
		return trainArea;
	}
	public void setTrainArea(BigDecimal trainArea) {
		this.trainArea = trainArea;
	}
	public BigDecimal getTreatmentArea() {
		return treatmentArea;
	}
	public void setTreatmentArea(BigDecimal treatmentArea) {
		this.treatmentArea = treatmentArea;
	}
	public BigDecimal getWorkArea() {
		return workArea;
	}
	public void setWorkArea(BigDecimal workArea) {
		this.workArea = workArea;
	}
	public BigDecimal getLeisureArea() {
		return leisureArea;
	}
	public void setLeisureArea(BigDecimal leisureArea) {
		this.leisureArea = leisureArea;
	}
	public BigDecimal getOtherArea() {
		return otherArea;
	}
	public void setOtherArea(BigDecimal otherArea) {
		this.otherArea = otherArea;
	}
	public String getCognizanceDate() {
		return cognizanceDate;
	}
	public void setCognizanceDate(String cognizanceDate) {
		this.cognizanceDate = cognizanceDate;
	}

}