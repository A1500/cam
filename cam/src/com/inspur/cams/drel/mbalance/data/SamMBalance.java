package com.inspur.cams.drel.mbalance.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SamMedicalBalance
 * @description:一站式救助信息Bean
 * @author:luguosui
 * @since:2011-05-13
 * @version:1.0
*/
 @Table(tableName = "SAM_MEDICAL_BALANCE" , keyFields = "balanceId")
public class SamMBalance extends StatefulDatabean {
   //住院流水ID
	@Column(name = "balance_Id")
   private String balanceId;
   //家庭ID
	@Column(name = "family_Id")
   private String familyId;
   //人员ID
	@Column(name = "people_Id")
   private String peopleId;
	//救助状态
	@Column(name="status")
	private String status;
   //病种
   	@Rule(value="require")
	@Column(name = "disease")
   private String disease;
   	//病种代码
   	@Column(name="DISEASE_CODE")
   	private String diseaseCode;
   //保险险种
	@Column(name = "insurance_Type")
   private String insuranceType;
	//医疗保险号
	@Column(name = "MEDICAL_CODE")
	private String medicalCode;
   //医疗救助类型
	@Column(name = "assitance_Type")
   private String assitanceType;
	//医疗救助比例
	@Column(name="ASSITANCE_PER")
	private double assitancePer;
   	//优抚对象类
   	@Column(name="bpt_Type")
   	private String bptType;
   	//优抚证号
   	@Column(name="bpt_Card_No")
   	private String bptCardNo;
   	//伤残等级
   	@Column(name="disability_Level_Code")
   	private String disabilityLevelCode;
   //证书编号
	@Column(name = "sam_Card_No")
   private String samCardNo;
   //住院日期起
   	@Rule(value="require")
	@Column(name = "in_Date")
   private String inDate;
   //住院日期止
	@Column(name = "leave_Date")
   private String leaveDate;
   //住院号
   	@Rule(value="require")
	@Column(name = "hospital_Record_Id")
   private String hospitalRecordId;
   //医院ID
	@Column(name = "hospital_Id")
   private String hospitalId;
	@Column(name="HOSPITAL_DEP")
	private String hospitalDep;
   //结算日期
	@Column(name = "balance_Time")
   private String balanceTime;
   //住院总费用
	@Column(name = "total_Expense")
   private double totalExpense;
   //保内费用
	@Column(name = "insurance_Expense")
   private double insuranceExpense;
   //保险机构支付费用
	@Column(name = "insurance_Pay")
   private double insurancePay;
	//大病保险报销费用
	@Column(name = "ILLNESS_INSURANCE_PAY")
   private double illnessInsurancePay;
	//其他救助
	@Column(name="OTHER_PAY")
   private double otherPay;
   //医疗救助费用
	@Column(name = "assitance_Pay")
   private double assitancePay;
	//医院减免费用
	@Column(name="HOSPITAL_PAY")
	private double hospitalPay;
	//优抚补助
	@Column(name="SPECIAL_PAY")
	private double specialPay;
	//优抚补助比例
	@Column(name="SPECIAL_PER")
	private double specialPer;
   //个人支付费用
	@Column(name = "personal_Pay")
   private double personalPay;
   //医院所属行政区划
	@Column(name="HOSPITAL_AREA")
   private String hospitalArea;
	//录入人ID
	@Column(name="REG_ID")
	private String regID;
	//录入人姓名
	@Column(name="reg_People")
	private String regPeople;
	//录入时间
	@Column(name="REG_Time")
	private String regTime;
	//修改人ID
	@Column(name="MOD_ID")
	private String modID;
	//修改人姓名
	@Column(name="mod_People")
	private String modPeople;
	//修改时间
	@Column(name="MOD_TIME")
	private String modTime;
	//结算操作人ID
	@Column(name="BALANCE_PEOPLE_ID")
	private String balancePeopleId;
	//冲账状态
	@Column(name="STRIKE_STATUS")
	private String strikeStatus;
	//冲账住院流水ID
	@Column(name="STRIKE_BALANCE_ID")
	private String strikeBalanceId;
	@Column(name="HOSPITAL_NAME")
	private String hospitalName;
	@Column(name="DATA_SOURCE")
	private String dataSource;
	
	private String name ;
	private String idCard ;
	private String sex ;
	private String birthday ;
	private String domicileCode ;
	
	
	
//	//姓名 
//	@Column(name = "NAME",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String name;   
//	//身份证件号码  
//	@Column(name = "ID_CARD",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String idCard; 
//  //性别   
//	@Column(name = "SEX",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String sex;   
//   //出生日期 
//	@Column(name = "BIRTHDAY",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String birthday;   
//   //民族 
//	@Column(name = "NATION",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String nation;   
//   //文化程度   
//	@Column(name = "EDU_CODE",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String eduCode;  
//	//联系方式_手机   
//	@Column(name = "TEL_MOBILE",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String telMobile; 
//   //住址   
//	@Column(name = "ADDRESS",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String address;
//	//工作单位_名称   
//	@Column(name = "WORK_UNIT_NAME",reference=true,foreignTable="BASEINFO_PEOPLE")
//   private String workUnitName;  
   /**
    * getter for 住院流水ID
    * @generated
    */
   public String getBalanceId(){
      return this.balanceId;
   }
   /**
    * setter for 住院流水ID
    * @generated
    */
   public void setBalanceId(String balanceId){
      this.balanceId = balanceId;
   }

   /**
    * getter for 家庭ID
    * @generated
    */
   public String getFamilyId(){
      return this.familyId;
   }
   /**
    * setter for 家庭ID
    * @generated
    */
   public void setFamilyId(String familyId){
      this.familyId = familyId;
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
    * getter for 病种
    * @generated
    */
   public String getDisease(){
      return this.disease;
   }
   /**
    * setter for 病种
    * @generated
    */
   public void setDisease(String disease){
      this.disease = disease;
   }

   /**
    * getter for 保险险种
    * @generated
    */
   public String getInsuranceType(){
      return this.insuranceType;
   }
   /**
    * setter for 保险险种
    * @generated
    */
   public void setInsuranceType(String insuranceType){
      this.insuranceType = insuranceType;
   }

   /**
    * getter for 医疗救助类型
    * @generated
    */
   public String getAssitanceType(){
      return this.assitanceType;
   }
   /**
    * setter for 医疗救助类型
    * @generated
    */
   public void setAssitanceType(String assitanceType){
      this.assitanceType = assitanceType;
   }

   /**
    * getter for 住院日期起
    * @generated
    */
  
   public String getSamCardNo() {
	return samCardNo;
}
public void setSamCardNo(String samCardNo) {
	this.samCardNo = samCardNo;
}
/**
    * getter for 住院号
    * @generated
    */
   public String getHospitalRecordId(){
      return this.hospitalRecordId;
   }
   /**
    * setter for 住院号
    * @generated
    */
   public void setHospitalRecordId(String hospitalRecordId){
      this.hospitalRecordId = hospitalRecordId;
   }

   /**
    * getter for 医院ID
    * @generated
    */
   public String getHospitalId(){
      return this.hospitalId;
   }
   /**
    * setter for 医院ID
    * @generated
    */
   public void setHospitalId(String hospitalId){
      this.hospitalId = hospitalId;
   }

   /**
    * getter for 结算日期
    * @generated
    */
   public String getBalanceTime(){
      return this.balanceTime;
   }
   /**
    * setter for 结算日期
    * @generated
    */
   public void setBalanceTime(String balanceTime){
      this.balanceTime = balanceTime;
   }
	public double getTotalExpense() {
		return totalExpense;
	}
	public void setTotalExpense(double totalExpense) {
		this.totalExpense = totalExpense;
	}
	public double getInsuranceExpense() {
		return insuranceExpense;
	}
	public void setInsuranceExpense(double insuranceExpense) {
		this.insuranceExpense = insuranceExpense;
	}
	public double getInsurancePay() {
		return insurancePay;
	}
	public void setInsurancePay(double insurancePay) {
		this.insurancePay = insurancePay;
	}
	public double getAssitancePay() {
		return assitancePay;
	}
	public void setAssitancePay(double assitancePay) {
		this.assitancePay = assitancePay;
	}
	public double getPersonalPay() {
		return personalPay;
	}
	public void setPersonalPay(double personalPay) {
		this.personalPay = personalPay;
	}
	public String getInDate() {
		return inDate;
	}
	public void setInDate(String inDate) {
		this.inDate = inDate;
	}
	public String getLeaveDate() {
		return leaveDate;
	}
	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}
	public double getOtherPay() {
		return otherPay;
	}
	public void setOtherPay(double otherPay) {
		this.otherPay = otherPay;
	}
	public String getHospitalArea() {
		return hospitalArea;
	}
	public void setHospitalArea(String hospitalArea) {
		this.hospitalArea = hospitalArea;
	}
	public String getRegID() {
		return regID;
	}
	public void setRegID(String regID) {
		this.regID = regID;
	}
	public String getRegTime() {
		return regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	public String getModID() {
		return modID;
	}
	public void setModID(String modID) {
		this.modID = modID;
	}
	public String getModTime() {
		return modTime;
	}
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
	public String getBalancePeopleId() {
		return balancePeopleId;
	}
	public void setBalancePeopleId(String balancePeopleId) {
		this.balancePeopleId = balancePeopleId;
	}
	public String getHospitalDep() {
		return hospitalDep;
	}
	public void setHospitalDep(String hospitalDep) {
		this.hospitalDep = hospitalDep;
	}
	public String getBptType() {
		return bptType;
	}
	public void setBptType(String bptType) {
		this.bptType = bptType;
	}
	public String getBptCardNo() {
		return bptCardNo;
	}
	public void setBptCardNo(String bptCardNo) {
		this.bptCardNo = bptCardNo;
	}
	public String getDisabilityLevelCode() {
		return disabilityLevelCode;
	}
	public void setDisabilityLevelCode(String disabilityLevelCode) {
		this.disabilityLevelCode = disabilityLevelCode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getHospitalPay() {
		return hospitalPay;
	}
	public void setHospitalPay(double hospitalPay) {
		this.hospitalPay = hospitalPay;
	}
	public double getSpecialPay() {
		return specialPay;
	}
	public void setSpecialPay(double specialPay) {
		this.specialPay = specialPay;
	}
	public String getRegPeople() {
		return regPeople;
	}
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}
	public String getModPeople() {
		return modPeople;
	}
	public void setModPeople(String modPeople) {
		this.modPeople = modPeople;
	}
	public double getAssitancePer() {
		return assitancePer;
	}
	public void setAssitancePer(double assitancePer) {
		this.assitancePer = assitancePer;
	}
	public double getSpecialPer() {
		return specialPer;
	}
	public void setSpecialPer(double specialPer) {
		this.specialPer = specialPer;
	}
	public String getDiseaseCode() {
		return diseaseCode;
	}
	public void setDiseaseCode(String diseaseCode) {
		this.diseaseCode = diseaseCode;
	}
	public String getMedicalCode() {
		return medicalCode;
	}
	public void setMedicalCode(String medicalCode) {
		this.medicalCode = medicalCode;
	}
	public String getStrikeStatus() {
		return strikeStatus;
	}
	public void setStrikeStatus(String strikeStatus) {
		this.strikeStatus = strikeStatus;
	}
	public String getStrikeBalanceId() {
		return strikeBalanceId;
	}
	public void setStrikeBalanceId(String strikeBalanceId) {
		this.strikeBalanceId = strikeBalanceId;
	}
	/**
	 * @return the hospitalName
	 */
	public String getHospitalName() {
		return hospitalName;
	}
	/**
	 * @param hospitalName the hospitalName to set
	 */
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	/**
	 * @return the dataSource
	 */
	public String getDataSource() {
		return dataSource;
	}
	/**
	 * @param dataSource the dataSource to set
	 */
	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}
	public double getIllnessInsurancePay() {
		return illnessInsurancePay;
	}
	public void setIllnessInsurancePay(double illnessInsurancePay) {
		this.illnessInsurancePay = illnessInsurancePay;
	}
 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getDomicileCode() {
		return domicileCode;
	}
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
}