package com.inspur.cams.welfare.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WealFitInfo
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 @Table(tableName = "WEAL_FIT_INFO" , keyFields = "taskCode")
public class WealFitInfo extends StatefulDatabean {
	@Transient
	private List<WealWorker> wealWorkerList = new ArrayList<WealWorker>();
	@Transient
	private List<WealFitDevice> WealFitDeviceList = new ArrayList<WealFitDevice>();
	@Transient
	private List<WealFitProductivepower> WealFitProductivepowerList = new ArrayList<WealFitProductivepower>();
   //TASK_CODE
   	@Rule(value="require")
	@Column(name = "TASK_CODE")
   private String taskCode;
   //APPLY_TYPE
	@Column(name = "APPLY_TYPE")
   private String applyType;
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
   //INCOME_YEAR
   	@Rule(value="number")
	@Column(name = "INCOME_YEAR")
   private BigDecimal incomeYear;
   //PROFIT_YEAR
   	@Rule(value="number")
	@Column(name = "PROFIT_YEAR")
   private BigDecimal profitYear;
   //OPERATE_SITUATION
	@Column(name = "OPERATE_SITUATION")
   private String operateSituation;
   //ADDED_TAX_YEAR
   	@Rule(value="number")
	@Column(name = "ADDED_TAX_YEAR")
   private BigDecimal addedTaxYear;
   //INCOME_TAX_YEAR
   	@Rule(value="number")
	@Column(name = "INCOME_TAX_YEAR")
   private BigDecimal incomeTaxYear;
   //SHOULDREDUE_TAX_YEAR
   	@Rule(value="number")
	@Column(name = "SHOULDREDUE_TAX_YEAR")
   private BigDecimal shouldredueTaxYear;
   //REALREDUE_TAX_YEAR
   	@Rule(value="number")
	@Column(name = "REALREDUE_TAX_YEAR")
   private BigDecimal realredueTaxYear;
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
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
   	@Column(name = "COGNIZANCE_DATE")
    private String cognizanceDate;
	@Column(name = "BUSINESS_SCOPE")
	private String businessScope;
   public String getBusinessScope() {
		return businessScope;
	}
	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
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
    * getter for APPLY_TYPE
    * @generated
    */
   public String getApplyType(){
      return this.applyType;
   }
   /**
    * setter for APPLY_TYPE
    * @generated
    */
   public void setApplyType(String applyType){
      this.applyType = applyType;
   }

   /**
    * getter for APPLY_YEAR
    * @generated
    */
   public String getApplyYear(){
      return this.applyYear;
   }
   /**
    * setter for APPLY_YEAR
    * @generated
    */
   public void setApplyYear(String applyYear){
      this.applyYear = applyYear;
   }

   /**
    * getter for SERIAL_NUM
    * @generated
    */
   public String getSerialNum(){
      return this.serialNum;
   }
   /**
    * setter for SERIAL_NUM
    * @generated
    */
   public void setSerialNum(String serialNum){
      this.serialNum = serialNum;
   }

   /**
    * getter for COMPANY_NAME
    * @generated
    */
   public String getCompanyName(){
      return this.companyName;
   }
   /**
    * setter for COMPANY_NAME
    * @generated
    */
   public void setCompanyName(String companyName){
      this.companyName = companyName;
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
    * getter for POST_CODE
    * @generated
    */
   public String getPostCode(){
      return this.postCode;
   }
   /**
    * setter for POST_CODE
    * @generated
    */
   public void setPostCode(String postCode){
      this.postCode = postCode;
   }

   /**
    * getter for LEGAL_PEOPLE
    * @generated
    */
   public String getLegalPeople(){
      return this.legalPeople;
   }
   /**
    * setter for LEGAL_PEOPLE
    * @generated
    */
   public void setLegalPeople(String legalPeople){
      this.legalPeople = legalPeople;
   }

   /**
    * getter for LEGAL_ID_CARD
    * @generated
    */
   public String getLegalIdCard(){
      return this.legalIdCard;
   }
   /**
    * setter for LEGAL_ID_CARD
    * @generated
    */
   public void setLegalIdCard(String legalIdCard){
      this.legalIdCard = legalIdCard;
   }

   /**
    * getter for LEGAL_PHONE
    * @generated
    */
   public String getLegalPhone(){
      return this.legalPhone;
   }
   /**
    * setter for LEGAL_PHONE
    * @generated
    */
   public void setLegalPhone(String legalPhone){
      this.legalPhone = legalPhone;
   }

   /**
    * getter for LEGAL_TELPHONE
    * @generated
    */
   public String getLegalTelphone(){
      return this.legalTelphone;
   }
   /**
    * setter for LEGAL_TELPHONE
    * @generated
    */
   public void setLegalTelphone(String legalTelphone){
      this.legalTelphone = legalTelphone;
   }

   /**
    * getter for LEGAL_EMAIL
    * @generated
    */
   public String getLegalEmail(){
      return this.legalEmail;
   }
   /**
    * setter for LEGAL_EMAIL
    * @generated
    */
   public void setLegalEmail(String legalEmail){
      this.legalEmail = legalEmail;
   }

   /**
    * getter for AGENT_PEOPLE
    * @generated
    */
   public String getAgentPeople(){
      return this.agentPeople;
   }
   /**
    * setter for AGENT_PEOPLE
    * @generated
    */
   public void setAgentPeople(String agentPeople){
      this.agentPeople = agentPeople;
   }

   /**
    * getter for AGENT_ID_CARD
    * @generated
    */
   public String getAgentIdCard(){
      return this.agentIdCard;
   }
   /**
    * setter for AGENT_ID_CARD
    * @generated
    */
   public void setAgentIdCard(String agentIdCard){
      this.agentIdCard = agentIdCard;
   }

   /**
    * getter for AGENT_PHONE
    * @generated
    */
   public String getAgentPhone(){
      return this.agentPhone;
   }
   /**
    * setter for AGENT_PHONE
    * @generated
    */
   public void setAgentPhone(String agentPhone){
      this.agentPhone = agentPhone;
   }

   /**
    * getter for AGENT_TELPHONE
    * @generated
    */
   public String getAgentTelphone(){
      return this.agentTelphone;
   }
   /**
    * setter for AGENT_TELPHONE
    * @generated
    */
   public void setAgentTelphone(String agentTelphone){
      this.agentTelphone = agentTelphone;
   }

   /**
    * getter for AGENT_EMAIL
    * @generated
    */
   public String getAgentEmail(){
      return this.agentEmail;
   }
   /**
    * setter for AGENT_EMAIL
    * @generated
    */
   public void setAgentEmail(String agentEmail){
      this.agentEmail = agentEmail;
   }

   /**
    * getter for WEB_ADDRESS
    * @generated
    */
   public String getWebAddress(){
      return this.webAddress;
   }
   /**
    * setter for WEB_ADDRESS
    * @generated
    */
   public void setWebAddress(String webAddress){
      this.webAddress = webAddress;
   }

   /**
    * getter for ECONOMIC_NATURE_CODE
    * @generated
    */
   public String getEconomicNatureCode(){
      return this.economicNatureCode;
   }
   /**
    * setter for ECONOMIC_NATURE_CODE
    * @generated
    */
   public void setEconomicNatureCode(String economicNatureCode){
      this.economicNatureCode = economicNatureCode;
   }

   /**
    * getter for ECONOMIC_NATURE_NAME
    * @generated
    */
   public String getEconomicNatureName(){
      return this.economicNatureName;
   }
   /**
    * setter for ECONOMIC_NATURE_NAME
    * @generated
    */
   public void setEconomicNatureName(String economicNatureName){
      this.economicNatureName = economicNatureName;
   }

   /**
    * getter for ORGAN_CODE
    * @generated
    */
   public String getOrganCode(){
      return this.organCode;
   }
   /**
    * setter for ORGAN_CODE
    * @generated
    */
   public void setOrganCode(String organCode){
      this.organCode = organCode;
   }

   /**
    * getter for LICENSE_CODE
    * @generated
    */
   public String getLicenseCode(){
      return this.licenseCode;
   }
   /**
    * setter for LICENSE_CODE
    * @generated
    */
   public void setLicenseCode(String licenseCode){
      this.licenseCode = licenseCode;
   }

   /**
    * getter for REGISTRATION_CODE
    * @generated
    */
   public String getRegistrationCode(){
      return this.registrationCode;
   }
   /**
    * setter for REGISTRATION_CODE
    * @generated
    */
   public void setRegistrationCode(String registrationCode){
      this.registrationCode = registrationCode;
   }

   /**
    * getter for REG_FUND
    * @generated
    */
   public BigDecimal getRegFund(){
      return this.regFund;
   }
   /**
    * setter for REG_FUND
    * @generated
    */
   public void setRegFund(BigDecimal regFund){
      this.regFund = regFund;
   }

   /**
    * getter for INCOME_YEAR
    * @generated
    */
   public BigDecimal getIncomeYear(){
      return this.incomeYear;
   }
   /**
    * setter for INCOME_YEAR
    * @generated
    */
   public void setIncomeYear(BigDecimal incomeYear){
      this.incomeYear = incomeYear;
   }

   /**
    * getter for PROFIT_YEAR
    * @generated
    */
   public BigDecimal getProfitYear(){
      return this.profitYear;
   }
   /**
    * setter for PROFIT_YEAR
    * @generated
    */
   public void setProfitYear(BigDecimal profitYear){
      this.profitYear = profitYear;
   }

   /**
    * getter for OPERATE_SITUATION
    * @generated
    */
   public String getOperateSituation(){
      return this.operateSituation;
   }
   /**
    * setter for OPERATE_SITUATION
    * @generated
    */
   public void setOperateSituation(String operateSituation){
      this.operateSituation = operateSituation;
   }

   /**
    * getter for ADDED_TAX_YEAR
    * @generated
    */
   public BigDecimal getAddedTaxYear(){
      return this.addedTaxYear;
   }
   /**
    * setter for ADDED_TAX_YEAR
    * @generated
    */
   public void setAddedTaxYear(BigDecimal addedTaxYear){
      this.addedTaxYear = addedTaxYear;
   }

   /**
    * getter for INCOME_TAX_YEAR
    * @generated
    */
   public BigDecimal getIncomeTaxYear(){
      return this.incomeTaxYear;
   }
   /**
    * setter for INCOME_TAX_YEAR
    * @generated
    */
   public void setIncomeTaxYear(BigDecimal incomeTaxYear){
      this.incomeTaxYear = incomeTaxYear;
   }

   /**
    * getter for SHOULDREDUE_TAX_YEAR
    * @generated
    */
   public BigDecimal getShouldredueTaxYear(){
      return this.shouldredueTaxYear;
   }
   /**
    * setter for SHOULDREDUE_TAX_YEAR
    * @generated
    */
   public void setShouldredueTaxYear(BigDecimal shouldredueTaxYear){
      this.shouldredueTaxYear = shouldredueTaxYear;
   }

   /**
    * getter for REALREDUE_TAX_YEAR
    * @generated
    */
   public BigDecimal getRealredueTaxYear(){
      return this.realredueTaxYear;
   }
   /**
    * setter for REALREDUE_TAX_YEAR
    * @generated
    */
   public void setRealredueTaxYear(BigDecimal realredueTaxYear){
      this.realredueTaxYear = realredueTaxYear;
   }

   /**
    * getter for OPERATE_AREA
    * @generated
    */
   public BigDecimal getOperateArea(){
      return this.operateArea;
   }
   /**
    * setter for OPERATE_AREA
    * @generated
    */
   public void setOperateArea(BigDecimal operateArea){
      this.operateArea = operateArea;
   }

   /**
    * getter for PRODUCT_AREA
    * @generated
    */
   public BigDecimal getProductArea(){
      return this.productArea;
   }
   /**
    * setter for PRODUCT_AREA
    * @generated
    */
   public void setProductArea(BigDecimal productArea){
      this.productArea = productArea;
   }

   /**
    * getter for RECOVERY_AREA
    * @generated
    */
   public BigDecimal getRecoveryArea(){
      return this.recoveryArea;
   }
   /**
    * setter for RECOVERY_AREA
    * @generated
    */
   public void setRecoveryArea(BigDecimal recoveryArea){
      this.recoveryArea = recoveryArea;
   }

   /**
    * getter for RECEPTION_AREA
    * @generated
    */
   public BigDecimal getReceptionArea(){
      return this.receptionArea;
   }
   /**
    * setter for RECEPTION_AREA
    * @generated
    */
   public void setReceptionArea(BigDecimal receptionArea){
      this.receptionArea = receptionArea;
   }

   /**
    * getter for TRAIN_AREA
    * @generated
    */
   public BigDecimal getTrainArea(){
      return this.trainArea;
   }
   /**
    * setter for TRAIN_AREA
    * @generated
    */
   public void setTrainArea(BigDecimal trainArea){
      this.trainArea = trainArea;
   }

   /**
    * getter for TREATMENT_AREA
    * @generated
    */
   public BigDecimal getTreatmentArea(){
      return this.treatmentArea;
   }
   /**
    * setter for TREATMENT_AREA
    * @generated
    */
   public void setTreatmentArea(BigDecimal treatmentArea){
      this.treatmentArea = treatmentArea;
   }

   /**
    * getter for WORK_AREA
    * @generated
    */
   public BigDecimal getWorkArea(){
      return this.workArea;
   }
   /**
    * setter for WORK_AREA
    * @generated
    */
   public void setWorkArea(BigDecimal workArea){
      this.workArea = workArea;
   }

   /**
    * getter for LEISURE_AREA
    * @generated
    */
   public BigDecimal getLeisureArea(){
      return this.leisureArea;
   }
   /**
    * setter for LEISURE_AREA
    * @generated
    */
   public void setLeisureArea(BigDecimal leisureArea){
      this.leisureArea = leisureArea;
   }

   /**
    * getter for OTHER_AREA
    * @generated
    */
   public BigDecimal getOtherArea(){
      return this.otherArea;
   }
   /**
    * setter for OTHER_AREA
    * @generated
    */
   public void setOtherArea(BigDecimal otherArea){
      this.otherArea = otherArea;
   }

   /**
    * getter for REG_DATE
    * @generated
    */
   public String getRegDate(){
      return this.regDate;
   }
   /**
    * setter for REG_DATE
    * @generated
    */
   public void setRegDate(String regDate){
      this.regDate = regDate;
   }
public List<WealWorker> getWealWorkerList() {
	return wealWorkerList;
}
public void setWealWorkerList(List<WealWorker> wealWorkerList) {
	this.wealWorkerList = wealWorkerList;
}
public List<WealFitDevice> getWealFitDeviceList() {
	return WealFitDeviceList;
}
public void setWealFitDeviceList(List<WealFitDevice> wealFitDeviceList) {
	WealFitDeviceList = wealFitDeviceList;
}
public List<WealFitProductivepower> getWealFitProductivepowerList() {
	return WealFitProductivepowerList;
}
public void setWealFitProductivepowerList(List<WealFitProductivepower> wealFitProductivepowerList) {
	WealFitProductivepowerList = wealFitProductivepowerList;
}
public String getCognizanceDate() {
	return cognizanceDate;
}
public void setCognizanceDate(String cognizanceDate) {
	this.cognizanceDate = cognizanceDate;
}

}