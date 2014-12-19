package com.inspur.cams.sorg.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SomOrganHis
 * @description:
 * @author:
 * @since:2012-05-28
 * @version:1.0
*/
 @Table(tableName = "SOM_ORGAN_HIS" , keyFields = "id")
public class SomOrganHis extends StatefulDatabean {
   //ID
	@Column(name = "ID")
   private String id;
   //APPLY_TYPE
	@Column(name = "TASK_CODE")
   private String taskCode;
   //SORG_ID
	@Column(name = "SORG_ID")
   private String sorgId;
   //SORG_STATUS
	@Column(name = "SORG_STATUS")
   private String sorgStatus;
   //SORG_TYPE
	@Column(name = "SORG_TYPE")
   private String sorgType;
   //IF_BRANCH
	@Column(name = "IF_BRANCH")
   private String ifBranch;
   //MAIN_SORG_NAME
	@Column(name = "MAIN_SORG_NAME")
   private String mainSorgName;
   //MAIN_SORG_ID
	@Column(name = "MAIN_SORG_ID")
   private String mainSorgId;
   //MAIN_SORG_CODE
	@Column(name = "MAIN_SORG_CODE")
   private String mainSorgCode;
   //SORG_KIND
	@Column(name = "SORG_KIND")
   private String sorgKind;
   //ORGAN_CODE
	@Column(name = "ORGAN_CODE")
   private String organCode;
   //SORG_CODE
	@Column(name = "SORG_CODE")
   private String sorgCode;
   //CN_NAME
   	@Rule(value="require")
	@Column(name = "CN_NAME")
   private String cnName;
   //EN_NAME
	@Column(name = "EN_NAME")
   private String enName;
   //AB_NAME
	@Column(name = "AB_NAME")
   private String abName;
   //SORG_PHONE
	@Column(name = "SORG_PHONE")
   private String sorgPhone;
   //SORG_FAX
	@Column(name = "SORG_FAX")
   private String sorgFax;
   //SORG_POST
	@Column(name = "SORG_POST")
   private String sorgPost;
   //SORG_ADDS
	@Column(name = "SORG_ADDS")
   private String sorgAdds;
   //SORG_WEB
	@Column(name = "SORG_WEB")
   private String sorgWeb;
   //SORG_EMAIL
	@Column(name = "SORG_EMAIL")
   private String sorgEmail;
   //PURPOSE
	@Column(name = "PURPOSE")
   private String purpose;
   //BUSINESS
	@Column(name = "BUSINESS")
   private String business;
	// 打印在证书上的业务范围
	private String businessForPrint;
   //BUSINESS_CODE
	@Column(name = "BUSINESS_CODE")
   private String businessCode;
   //BUS_SCOPE
	@Column(name = "BUS_SCOPE")
   private String busScope;
   //BORG_NAME
	@Column(name = "BORG_NAME")
   private String borgName;
   //BORG_PHONE
	@Column(name = "BORG_PHONE")
   private String borgPhone;
   //BORG_PEOPLE
	@Column(name = "BORG_PEOPLE")
   private String borgPeople;
   //ACT_AREA
	@Column(name = "ACT_AREA")
   private String actArea;
   //RESIDE_SOURCE
	@Column(name = "RESIDE_SOURCE")
   private String resideSource;
   //RESIDENCE
	@Column(name = "RESIDENCE")
   private String residence;
   //HOUSING_ORGAN
	@Column(name = "HOUSING_ORGAN")
   private String housingOrgan;
   //HOUSING_AREA
   	@Rule(value="number")
	@Column(name = "HOUSING_AREA")
   private BigDecimal housingArea;
   //LEASE_PERIOD
	@Column(name = "LEASE_PERIOD")
   private String leasePeriod;
   //REG_MON
	@Column(name = "REG_MON")
   private String regMon;
   //CURRENCY
	@Column(name = "CURRENCY")
   private String currency;
   //FUNDING_PEOPLE
	@Column(name = "FUNDING_PEOPLE")
   private String fundingPeople;
   //CHECK_CAPITAL_ORGAN
	@Column(name = "CHECK_CAPITAL_ORGAN")
   private String checkCapitalOrgan;
   //MONEY_SOURCE
	@Column(name = "MONEY_SOURCE")
   private String moneySource;
   //BUILD_STATUS
	@Column(name = "BUILD_STATUS")
   private String buildStatus;
   //ABSORP_MEMBER
	@Column(name = "ABSORP_MEMBER")
   private String absorpMember;
   //PREPARE_FILE_CODE
	@Column(name = "PREPARE_FILE_CODE")
   private String prepareFileCode;
   //FACILITIES
	@Column(name = "FACILITIES")
   private String facilities;
   //UNITS_NUM
   	@Rule(value="number")
	@Column(name = "UNITS_NUM")
   private BigDecimal unitsNum;
   //PEOPLE_NUM
   	@Rule(value="number")
	@Column(name = "PEOPLE_NUM")
   private BigDecimal peopleNum;
   //COUNCIL_NUM
   	@Rule(value="number")
	@Column(name = "COUNCIL_NUM")
   private BigDecimal councilNum;
   //STAND_COUNCIL_NUM
   	@Rule(value="number")
	@Column(name = "STAND_COUNCIL_NUM")
   private BigDecimal standCouncilNum;
   //MEMBER_NUM
   	@Rule(value="number")
	@Column(name = "MEMBER_NUM")
   private BigDecimal memberNum;
   //ENGAGED_NUM
   	@Rule(value="number")
	@Column(name = "ENGAGED_NUM")
   private BigDecimal engagedNum;
   //PRACTICE_NUM
   	@Rule(value="number")
	@Column(name = "PRACTICE_NUM")
   private BigDecimal practiceNum;
   //CHECK_YEAR
	@Column(name = "CHECK_YEAR")
   private String checkYear;
   //APP_REASON
	@Column(name = "APP_REASON")
   private String appReason;
   //BUILD_DATE
	@Column(name = "BUILD_DATE")
   private String buildDate;
   //REG_DATE
	@Column(name = "REG_DATE")
   private String regDate;
   //CANCEL_REASON
	@Column(name = "CANCEL_REASON")
   private String cancelReason;
   //CANCEL_REASON_DESC
	@Column(name = "CANCEL_REASON_DESC")
   private String cancelReasonDesc;
   //CANCEL_DATE
	@Column(name = "CANCEL_DATE")
   private String cancelDate;
   //LIQ_RESULT
	@Column(name = "LIQ_RESULT")
   private String liqResult;
   //CREDIT
	@Column(name = "CREDIT")
   private String credit;
   //MORG_NAME
   	@Rule(value="require")
	@Column(name = "MORG_NAME")
   private String morgName;
   //MORG_AREA
   	@Rule(value="require")
	@Column(name = "MORG_AREA")
   private String morgArea;
   //LEGAL_PEOPLE
	@Column(name = "LEGAL_PEOPLE")
   private String legalPeople;
   //BRANCH_CHARGER
	@Column(name = "BRANCH_CHARGER")
   private String branchCharger;
	//SORG_PEOPLE
	@Column(name = "SORG_PEOPLE")
	 private String sorgPeople;
	//联系电话 sorg_people_phone
	@Column(name = "SORG_PEOPLE_PHONE")
	private String sorgPeoplePhone;

	public String getSorgPeoplePhone() {
		return sorgPeoplePhone;
	}
	public void setSorgPeoplePhone(String sorgPeoplePhone) {
		this.sorgPeoplePhone = sorgPeoplePhone;
	}
   public String getSorgPeople() {
		return sorgPeople;
	}
	public void setSorgPeople(String sorgPeople) {
		this.sorgPeople = sorgPeople;
	}
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
    * getter for SORG_ID
    * @generated
    */
   public String getSorgId(){
      return this.sorgId;
   }
   /**
    * setter for SORG_ID
    * @generated
    */
   public void setSorgId(String sorgId){
      this.sorgId = sorgId;
   }

   /**
    * getter for SORG_STATUS
    * @generated
    */
   public String getSorgStatus(){
      return this.sorgStatus;
   }
   /**
    * setter for SORG_STATUS
    * @generated
    */
   public void setSorgStatus(String sorgStatus){
      this.sorgStatus = sorgStatus;
   }

   /**
    * getter for SORG_TYPE
    * @generated
    */
   public String getSorgType(){
      return this.sorgType;
   }
   /**
    * setter for SORG_TYPE
    * @generated
    */
   public void setSorgType(String sorgType){
      this.sorgType = sorgType;
   }

   /**
    * getter for IF_BRANCH
    * @generated
    */
   public String getIfBranch(){
      return this.ifBranch;
   }
   /**
    * setter for IF_BRANCH
    * @generated
    */
   public void setIfBranch(String ifBranch){
      this.ifBranch = ifBranch;
   }

   /**
    * getter for MAIN_SORG_NAME
    * @generated
    */
   public String getMainSorgName(){
      return this.mainSorgName;
   }
   /**
    * setter for MAIN_SORG_NAME
    * @generated
    */
   public void setMainSorgName(String mainSorgName){
      this.mainSorgName = mainSorgName;
   }

   /**
    * getter for MAIN_SORG_ID
    * @generated
    */
   public String getMainSorgId(){
      return this.mainSorgId;
   }
   /**
    * setter for MAIN_SORG_ID
    * @generated
    */
   public void setMainSorgId(String mainSorgId){
      this.mainSorgId = mainSorgId;
   }

   /**
    * getter for MAIN_SORG_CODE
    * @generated
    */
   public String getMainSorgCode(){
      return this.mainSorgCode;
   }
   /**
    * setter for MAIN_SORG_CODE
    * @generated
    */
   public void setMainSorgCode(String mainSorgCode){
      this.mainSorgCode = mainSorgCode;
   }

   /**
    * getter for SORG_KIND
    * @generated
    */
   public String getSorgKind(){
      return this.sorgKind;
   }
   /**
    * setter for SORG_KIND
    * @generated
    */
   public void setSorgKind(String sorgKind){
      this.sorgKind = sorgKind;
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
    * getter for CN_NAME
    * @generated
    */
   public String getCnName(){
      return this.cnName;
   }
   /**
    * setter for CN_NAME
    * @generated
    */
   public void setCnName(String cnName){
      this.cnName = cnName;
   }

   /**
    * getter for EN_NAME
    * @generated
    */
   public String getEnName(){
      return this.enName;
   }
   /**
    * setter for EN_NAME
    * @generated
    */
   public void setEnName(String enName){
      this.enName = enName;
   }

   /**
    * getter for AB_NAME
    * @generated
    */
   public String getAbName(){
      return this.abName;
   }
   /**
    * setter for AB_NAME
    * @generated
    */
   public void setAbName(String abName){
      this.abName = abName;
   }

   /**
    * getter for SORG_PHONE
    * @generated
    */
   public String getSorgPhone(){
      return this.sorgPhone;
   }
   /**
    * setter for SORG_PHONE
    * @generated
    */
   public void setSorgPhone(String sorgPhone){
      this.sorgPhone = sorgPhone;
   }

   /**
    * getter for SORG_FAX
    * @generated
    */
   public String getSorgFax(){
      return this.sorgFax;
   }
   /**
    * setter for SORG_FAX
    * @generated
    */
   public void setSorgFax(String sorgFax){
      this.sorgFax = sorgFax;
   }

   /**
    * getter for SORG_POST
    * @generated
    */
   public String getSorgPost(){
      return this.sorgPost;
   }
   /**
    * setter for SORG_POST
    * @generated
    */
   public void setSorgPost(String sorgPost){
      this.sorgPost = sorgPost;
   }

   /**
    * getter for SORG_ADDS
    * @generated
    */
   public String getSorgAdds(){
      return this.sorgAdds;
   }
   /**
    * setter for SORG_ADDS
    * @generated
    */
   public void setSorgAdds(String sorgAdds){
      this.sorgAdds = sorgAdds;
   }

   /**
    * getter for SORG_WEB
    * @generated
    */
   public String getSorgWeb(){
      return this.sorgWeb;
   }
   /**
    * setter for SORG_WEB
    * @generated
    */
   public void setSorgWeb(String sorgWeb){
      this.sorgWeb = sorgWeb;
   }

   /**
    * getter for SORG_EMAIL
    * @generated
    */
   public String getSorgEmail(){
      return this.sorgEmail;
   }
   /**
    * setter for SORG_EMAIL
    * @generated
    */
   public void setSorgEmail(String sorgEmail){
      this.sorgEmail = sorgEmail;
   }

   /**
    * getter for PURPOSE
    * @generated
    */
   public String getPurpose(){
      return this.purpose;
   }
   /**
    * setter for PURPOSE
    * @generated
    */
   public void setPurpose(String purpose){
      this.purpose = purpose;
   }

   /**
    * getter for BUSINESS
    * @generated
    */
   public String getBusiness(){
      return this.business;
   }
   /**
    * setter for BUSINESS
    * @generated
    */
   public void setBusiness(String business){
      this.business = business;
   }

   /**
    * getter for BUSINESS_CODE
    * @generated
    */
   public String getBusinessCode(){
      return this.businessCode;
   }
   /**
    * setter for BUSINESS_CODE
    * @generated
    */
   public void setBusinessCode(String businessCode){
      this.businessCode = businessCode;
   }

   /**
    * getter for BUS_SCOPE
    * @generated
    */
   public String getBusScope(){
      return this.busScope;
   }
   /**
    * setter for BUS_SCOPE
    * @generated
    */
   public void setBusScope(String busScope){
      this.busScope = busScope;
   }

   /**
    * getter for BORG_NAME
    * @generated
    */
   public String getBorgName(){
      return this.borgName;
   }
   /**
    * setter for BORG_NAME
    * @generated
    */
   public void setBorgName(String borgName){
      this.borgName = borgName;
   }

   /**
    * getter for BORG_PHONE
    * @generated
    */
   public String getBorgPhone(){
      return this.borgPhone;
   }
   /**
    * setter for BORG_PHONE
    * @generated
    */
   public void setBorgPhone(String borgPhone){
      this.borgPhone = borgPhone;
   }

   /**
    * getter for BORG_PEOPLE
    * @generated
    */
   public String getBorgPeople(){
      return this.borgPeople;
   }
   /**
    * setter for BORG_PEOPLE
    * @generated
    */
   public void setBorgPeople(String borgPeople){
      this.borgPeople = borgPeople;
   }

   /**
    * getter for ACT_AREA
    * @generated
    */
   public String getActArea(){
      return this.actArea;
   }
   /**
    * setter for ACT_AREA
    * @generated
    */
   public void setActArea(String actArea){
      this.actArea = actArea;
   }

   /**
    * getter for RESIDE_SOURCE
    * @generated
    */
   public String getResideSource(){
      return this.resideSource;
   }
   /**
    * setter for RESIDE_SOURCE
    * @generated
    */
   public void setResideSource(String resideSource){
      this.resideSource = resideSource;
   }

   /**
    * getter for RESIDENCE
    * @generated
    */
   public String getResidence(){
      return this.residence;
   }
   /**
    * setter for RESIDENCE
    * @generated
    */
   public void setResidence(String residence){
      this.residence = residence;
   }

   /**
    * getter for HOUSING_ORGAN
    * @generated
    */
   public String getHousingOrgan(){
      return this.housingOrgan;
   }
   /**
    * setter for HOUSING_ORGAN
    * @generated
    */
   public void setHousingOrgan(String housingOrgan){
      this.housingOrgan = housingOrgan;
   }

   /**
    * getter for HOUSING_AREA
    * @generated
    */
   public BigDecimal getHousingArea(){
      return this.housingArea;
   }
   /**
    * setter for HOUSING_AREA
    * @generated
    */
   public void setHousingArea(BigDecimal housingArea){
      this.housingArea = housingArea;
   }

   /**
    * getter for LEASE_PERIOD
    * @generated
    */
   public String getLeasePeriod(){
      return this.leasePeriod;
   }
   /**
    * setter for LEASE_PERIOD
    * @generated
    */
   public void setLeasePeriod(String leasePeriod){
      this.leasePeriod = leasePeriod;
   }

   /**
    * getter for REG_MON
    * @generated
    */
   public String getRegMon(){
      return this.regMon;
   }
   /**
    * setter for REG_MON
    * @generated
    */
   public void setRegMon(String regMon){
      this.regMon = regMon;
   }

   /**
    * getter for CURRENCY
    * @generated
    */
   public String getCurrency(){
      return this.currency;
   }
   /**
    * setter for CURRENCY
    * @generated
    */
   public void setCurrency(String currency){
      this.currency = currency;
   }

   /**
    * getter for FUNDING_PEOPLE
    * @generated
    */
   public String getFundingPeople(){
      return this.fundingPeople;
   }
   /**
    * setter for FUNDING_PEOPLE
    * @generated
    */
   public void setFundingPeople(String fundingPeople){
      this.fundingPeople = fundingPeople;
   }

   /**
    * getter for CHECK_CAPITAL_ORGAN
    * @generated
    */
   public String getCheckCapitalOrgan(){
      return this.checkCapitalOrgan;
   }
   /**
    * setter for CHECK_CAPITAL_ORGAN
    * @generated
    */
   public void setCheckCapitalOrgan(String checkCapitalOrgan){
      this.checkCapitalOrgan = checkCapitalOrgan;
   }

   /**
    * getter for MONEY_SOURCE
    * @generated
    */
   public String getMoneySource(){
      return this.moneySource;
   }
   /**
    * setter for MONEY_SOURCE
    * @generated
    */
   public void setMoneySource(String moneySource){
      this.moneySource = moneySource;
   }

   /**
    * getter for BUILD_STATUS
    * @generated
    */
   public String getBuildStatus(){
      return this.buildStatus;
   }
   /**
    * setter for BUILD_STATUS
    * @generated
    */
   public void setBuildStatus(String buildStatus){
      this.buildStatus = buildStatus;
   }

   /**
    * getter for ABSORP_MEMBER
    * @generated
    */
   public String getAbsorpMember(){
      return this.absorpMember;
   }
   /**
    * setter for ABSORP_MEMBER
    * @generated
    */
   public void setAbsorpMember(String absorpMember){
      this.absorpMember = absorpMember;
   }

   /**
    * getter for PREPARE_FILE_CODE
    * @generated
    */
   public String getPrepareFileCode(){
      return this.prepareFileCode;
   }
   /**
    * setter for PREPARE_FILE_CODE
    * @generated
    */
   public void setPrepareFileCode(String prepareFileCode){
      this.prepareFileCode = prepareFileCode;
   }

   /**
    * getter for FACILITIES
    * @generated
    */
   public String getFacilities(){
      return this.facilities;
   }
   /**
    * setter for FACILITIES
    * @generated
    */
   public void setFacilities(String facilities){
      this.facilities = facilities;
   }

   /**
    * getter for UNITS_NUM
    * @generated
    */
   public BigDecimal getUnitsNum(){
      return this.unitsNum;
   }
   /**
    * setter for UNITS_NUM
    * @generated
    */
   public void setUnitsNum(BigDecimal unitsNum){
      this.unitsNum = unitsNum;
   }

   /**
    * getter for PEOPLE_NUM
    * @generated
    */
   public BigDecimal getPeopleNum(){
      return this.peopleNum;
   }
   /**
    * setter for PEOPLE_NUM
    * @generated
    */
   public void setPeopleNum(BigDecimal peopleNum){
      this.peopleNum = peopleNum;
   }

   /**
    * getter for COUNCIL_NUM
    * @generated
    */
   public BigDecimal getCouncilNum(){
      return this.councilNum;
   }
   /**
    * setter for COUNCIL_NUM
    * @generated
    */
   public void setCouncilNum(BigDecimal councilNum){
      this.councilNum = councilNum;
   }

   /**
    * getter for STAND_COUNCIL_NUM
    * @generated
    */
   public BigDecimal getStandCouncilNum(){
      return this.standCouncilNum;
   }
   /**
    * setter for STAND_COUNCIL_NUM
    * @generated
    */
   public void setStandCouncilNum(BigDecimal standCouncilNum){
      this.standCouncilNum = standCouncilNum;
   }

   /**
    * getter for MEMBER_NUM
    * @generated
    */
   public BigDecimal getMemberNum(){
      return this.memberNum;
   }
   /**
    * setter for MEMBER_NUM
    * @generated
    */
   public void setMemberNum(BigDecimal memberNum){
      this.memberNum = memberNum;
   }

   /**
    * getter for ENGAGED_NUM
    * @generated
    */
   public BigDecimal getEngagedNum(){
      return this.engagedNum;
   }
   /**
    * setter for ENGAGED_NUM
    * @generated
    */
   public void setEngagedNum(BigDecimal engagedNum){
      this.engagedNum = engagedNum;
   }

   /**
    * getter for PRACTICE_NUM
    * @generated
    */
   public BigDecimal getPracticeNum(){
      return this.practiceNum;
   }
   /**
    * setter for PRACTICE_NUM
    * @generated
    */
   public void setPracticeNum(BigDecimal practiceNum){
      this.practiceNum = practiceNum;
   }

   /**
    * getter for CHECK_YEAR
    * @generated
    */
   public String getCheckYear(){
      return this.checkYear;
   }
   /**
    * setter for CHECK_YEAR
    * @generated
    */
   public void setCheckYear(String checkYear){
      this.checkYear = checkYear;
   }

   /**
    * getter for APP_REASON
    * @generated
    */
   public String getAppReason(){
      return this.appReason;
   }
   /**
    * setter for APP_REASON
    * @generated
    */
   public void setAppReason(String appReason){
      this.appReason = appReason;
   }

   /**
    * getter for BUILD_DATE
    * @generated
    */
   public String getBuildDate(){
      return this.buildDate;
   }
   /**
    * setter for BUILD_DATE
    * @generated
    */
   public void setBuildDate(String buildDate){
      this.buildDate = buildDate;
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

   /**
    * getter for CANCEL_REASON
    * @generated
    */
   public String getCancelReason(){
      return this.cancelReason;
   }
   /**
    * setter for CANCEL_REASON
    * @generated
    */
   public void setCancelReason(String cancelReason){
      this.cancelReason = cancelReason;
   }

   /**
    * getter for CANCEL_REASON_DESC
    * @generated
    */
   public String getCancelReasonDesc(){
      return this.cancelReasonDesc;
   }
   /**
    * setter for CANCEL_REASON_DESC
    * @generated
    */
   public void setCancelReasonDesc(String cancelReasonDesc){
      this.cancelReasonDesc = cancelReasonDesc;
   }

   /**
    * getter for CANCEL_DATE
    * @generated
    */
   public String getCancelDate(){
      return this.cancelDate;
   }
   /**
    * setter for CANCEL_DATE
    * @generated
    */
   public void setCancelDate(String cancelDate){
      this.cancelDate = cancelDate;
   }

   /**
    * getter for LIQ_RESULT
    * @generated
    */
   public String getLiqResult(){
      return this.liqResult;
   }
   /**
    * setter for LIQ_RESULT
    * @generated
    */
   public void setLiqResult(String liqResult){
      this.liqResult = liqResult;
   }

   /**
    * getter for CREDIT
    * @generated
    */
   public String getCredit(){
      return this.credit;
   }
   /**
    * setter for CREDIT
    * @generated
    */
   public void setCredit(String credit){
      this.credit = credit;
   }

   /**
    * getter for MORG_NAME
    * @generated
    */
   public String getMorgName(){
      return this.morgName;
   }
   /**
    * setter for MORG_NAME
    * @generated
    */
   public void setMorgName(String morgName){
      this.morgName = morgName;
   }

   /**
    * getter for MORG_AREA
    * @generated
    */
   public String getMorgArea(){
      return this.morgArea;
   }
   /**
    * setter for MORG_AREA
    * @generated
    */
   public void setMorgArea(String morgArea){
      this.morgArea = morgArea;
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
    * getter for BRANCH_CHARGER
    * @generated
    */
   public String getBranchCharger(){
      return this.branchCharger;
   }
   /**
    * setter for BRANCH_CHARGER
    * @generated
    */
   public void setBranchCharger(String branchCharger){
      this.branchCharger = branchCharger;
   }
public String getTaskCode() {
	return taskCode;
}
public void setTaskCode(String taskCode) {
	this.taskCode = taskCode;
}
public String getBusinessForPrint() {
	return businessForPrint;
}
public void setBusinessForPrint(String businessForPrint) {
	this.businessForPrint = businessForPrint;
}

}