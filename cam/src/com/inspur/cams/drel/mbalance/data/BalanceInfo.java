package com.inspur.cams.drel.mbalance.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;

import com.ibm.db2.jcc.a.b;



/**
 * 出院结算信息对象
 * @author 路国隋
 *	2011-10-17
 */
public class BalanceInfo {
	
	//身份证号
	private String idCard;
	//新农合号
	private String insuranceNo;
	//住院号
	private String recordNo;
	//姓名
	private String name;
	//住院总费用
	private BigDecimal totalExpense;
	//保内金额
	private BigDecimal insuranceExpense;
	//新农合或城镇职工（居民）医保报销金额
	private BigDecimal insurancePay;
	//入院日期
	private String inDate;
	//入院科室
	private String department;
	//病种代码
	private String disease;
	//病种名称
	private String diseaseName;
	//出院日期
	private String leaveDate;
    //医院减免费用
  	private BigDecimal hospitalPay;
  	//优抚补助
  	private BigDecimal specialPay;
  	//优抚补助比例
  	private BigDecimal specialPer;
	//其他救助金额
	private BigDecimal otherPay;
	//医疗救助金额
	private BigDecimal assistancePay;
	//救助比例
	private BigDecimal assistancePer;
	//自付费用
	private BigDecimal personalPay;
	//医院Id
	private String hospitalId;
	//医院名称
	private String hospitalName;
	//医院行政区划
	private String hospitalArea;
	
	public String getHospitalArea() {
		return hospitalArea;
	}
	public void setHospitalArea(String hospitalArea) {
		this.hospitalArea = hospitalArea;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getInsuranceNo() {
		return insuranceNo;
	}
	public void setInsuranceNo(String insuranceNo) {
		this.insuranceNo = insuranceNo;
	}
	public String getRecordNo() {
		return recordNo;
	}
	public void setRecordNo(String recordNo) {
		this.recordNo = recordNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getTotalExpense() {
		return totalExpense;
	}
	public void setTotalExpense(BigDecimal totalExpense) {
		this.totalExpense = totalExpense;
	}
	public BigDecimal getInsuranceExpense() {
		return insuranceExpense;
	}
	public void setInsuranceExpense(BigDecimal insuranceExpense) {
		this.insuranceExpense = insuranceExpense;
	}
	public BigDecimal getInsurancePay() {
		return insurancePay;
	}
	public void setInsurancePay(BigDecimal insurancePay) {
		this.insurancePay = insurancePay;
	}
	public String getInDate() {
		return inDate;
	}
	public void setInDate(String inDate) {
		this.inDate = inDate;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getDisease() {
		return disease;
	}
	public void setDisease(String disease) {
		this.disease = disease;
	}
	public String getDiseaseName() {
		return diseaseName;
	}
	public void setDiseaseName(String diseaseName) {
		this.diseaseName = diseaseName;
	}
	public String getLeaveDate() {
		return leaveDate;
	}
	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}
	public String getHospitalId() {
		return hospitalId;
	}
	public void setHospitalId(String hospitalId) {
		this.hospitalId = hospitalId;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	public BigDecimal getOtherPay() {
		return otherPay;
	}
	public void setOtherPay(BigDecimal otherPay) {
		this.otherPay = otherPay;
	}
	public BigDecimal getAssistancePay() {
		return assistancePay;
	}
	public void setAssistancePay(BigDecimal assistancePay) {
		this.assistancePay = assistancePay;
	}
	public BigDecimal getAssistancePer() {
		return assistancePer;
	}
	public void setAssistancePer(BigDecimal assistancePer) {
		this.assistancePer = assistancePer;
	}
	public BigDecimal getPersonalPay() {
		return personalPay;
	}
	public void setPersonalPay(BigDecimal personalPay) {
		this.personalPay = personalPay;
	}
	public BigDecimal getHospitalPay() {
		return hospitalPay;
	}
	public void setHospitalPay(BigDecimal hospitalPay) {
		this.hospitalPay = hospitalPay;
	}
	public BigDecimal getSpecialPay() {
		return specialPay;
	}
	public void setSpecialPay(BigDecimal specialPay) {
		this.specialPay = specialPay;
	}
	public BigDecimal getSpecialPer() {
		return specialPer;
	}
	public void setSpecialPer(BigDecimal specialPer) {
		this.specialPer = specialPer;
	}
	
}
