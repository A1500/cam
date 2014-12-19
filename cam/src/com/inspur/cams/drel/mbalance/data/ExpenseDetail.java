package com.inspur.cams.drel.mbalance.data;

import java.math.BigDecimal;


/**
 * 费用明细信息对象
 * @author 路国隋
 * 2011-10-17
 */
public class ExpenseDetail {
	
	//身份证号
	private String idCard;
	//新农合号
	private String insuranceNo;
	//住院号
	private String recordNo;
	//姓名
	private String name;
	//费用代码
	private String expCode;
	//名称
	private String expName;
	//规格
	private String type;
	//剂型
	private String form;
	//日期
	private String expDate;
	//数量 
	private BigDecimal num;
	//单价
	private BigDecimal price;
	//金额
	private BigDecimal expMoney;
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
	public String getExpCode() {
		return expCode;
	}
	public void setExpCode(String expCode) {
		this.expCode = expCode;
	}
	public String getExpName() {
		return expName;
	}
	public void setExpName(String expName) {
		this.expName = expName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getForm() {
		return form;
	}
	public void setForm(String form) {
		this.form = form;
	}
	public String getExpDate() {
		return expDate;
	}
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
	public BigDecimal getNum() {
		return num;
	}
	public void setNum(BigDecimal num) {
		this.num = num;
	}
	public BigDecimal getExpMoney() {
		return expMoney;
	}
	public void setExpMoney(BigDecimal expMoney) {
		this.expMoney = expMoney;
	}
	/**
	 * @return the price
	 */
	public BigDecimal getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
}
