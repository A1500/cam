package com.inspur.cams.drel.mbalance.data;

import java.math.BigDecimal;

/**
 * 结算前准备查询方法返回值
 * @author 路国隋
 *	2011-10-17
 */
public class BalancePreReturn {
	//姓名
	private String name;
	//身份证号码
	private String idCard;	
	//是否停助
	private String pauseFlag;
	//本次医疗救助最大额度
	private BigDecimal maxPay;
	//其他救助金额
	private BigDecimal otherPay;
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
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getPauseFlag() {
		return pauseFlag;
	}
	public void setPauseFlag(String pauseFlag) {
		this.pauseFlag = pauseFlag;
	}
	public BigDecimal getMaxPay() {
		return maxPay;
	}
	public void setMaxPay(BigDecimal maxPay) {
		this.maxPay = maxPay;
	}
	public BigDecimal getOtherPay() {
		return otherPay;
	}
	public void setOtherPay(BigDecimal otherPay) {
		this.otherPay = otherPay;
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
	
}
