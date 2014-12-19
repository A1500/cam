package com.inspur.cams.drel.mbalance.data;

/**
 * 入院备案信息对象
 * @author 路国隋
 *	2011-10-17
 */
public class HospitalRecord {
	//身份证号
	private String idCard;
	//新农合号
	private String insuranceNo;
	//住院号
	private String recordNo;
	//姓名
	private String name;
	//入院日期
	private String inDate;
	//入院科室
	private String department;
	//病种代码
	private String disease;
	//病种名称
	private String diseaseName;
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
	
	
}
