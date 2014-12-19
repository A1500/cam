package com.inspur.cams.drel.mbalance.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;

/**
 * 救助对象信息查询方法返回值
 * @author 路国隋
 *	2011-10-17
 */
public class CheckReturn {
	
	//姓名
	private String name;
	//性别
	private String sex;	
	//出生日期 
	private String birthday;
	//身份证号码
	private String idCard;	
	//优抚对象类
   	private String bptType;
    //优抚对象类
   	private String bptCardNo;
   	//伤残等级
   	private String disabilityLevel;
	//救助对象类别
	private String assitanceType;	
	//证件编号	
	private String	samCardNo;		
	//救助对象属地
	private String	domicileCode;	
	//本次医疗救助最大额度
	private BigDecimal maxPay;
	//返回代码
	private String returnCode;
	//返回代码描述
	private String returnCodeDes;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getAssitanceType() {
		return assitanceType;
	}
	public void setAssitanceType(String assitanceType) {
		this.assitanceType = assitanceType;
	}
	public String getSamCardNo() {
		return samCardNo;
	}
	public void setSamCardNo(String samCardNo) {
		this.samCardNo = samCardNo;
	}
	
	public String getReturnCode() {
		return returnCode;
	}
	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}
	public String getReturnCodeDes() {
		return returnCodeDes;
	}
	public void setReturnCodeDes(String returnCodeDes) {
		this.returnCodeDes = returnCodeDes;
	}
	public BigDecimal getMaxPay() {
		return maxPay;
	}
	public void setMaxPay(BigDecimal maxPay) {
		this.maxPay = maxPay;
	}
	/**
	 * @return the domicileCode
	 */
	public String getDomicileCode() {
		return domicileCode;
	}
	/**
	 * @param domicileCode the domicileCode to set
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
	public String getBptType() {
		return bptType;
	}
	public void setBptType(String bptType) {
		this.bptType = bptType;
	}
	/**
	 * @return the bptCardNo
	 */
	public String getBptCardNo() {
		return bptCardNo;
	}
	/**
	 * @param bptCardNo the bptCardNo to set
	 */
	public void setBptCardNo(String bptCardNo) {
		this.bptCardNo = bptCardNo;
	}
	/**
	 * @return the disabilityLevel
	 */
	public String getDisabilityLevel() {
		return disabilityLevel;
	}
	/**
	 * @param disabilityLevel the disabilityLevel to set
	 */
	public void setDisabilityLevel(String disabilityLevel) {
		this.disabilityLevel = disabilityLevel;
	}	
}
