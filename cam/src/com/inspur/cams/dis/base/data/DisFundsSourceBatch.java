package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 资金拨付批次表databean
 * 
 * @author
 * @date 2013-01-04
 */
@Table(tableName = "DIS_FUNDS_SOURCE_BATCH", keyFields = "batchId")
public class DisFundsSourceBatch extends StatefulDatabean {

	// 批次编码
	private String batchId;

	// 年度
	private String disYear;

	// 资金来源类型
	private String sourceType;

	// 上级拨款资金文号
	private String upAllocationNum;

	// 拨款类型
	private String upAllocationType;

	// 资金用途
	private String upAllocationPurpose;

	// 接收单位名称
	private String receiveOrganName;

	// 接收单位区划
	private String receiveOrganCode;

	// 填报单位区划
	private String fillOrganCode;

	// 填报单位名称
	private String fillOrganName;

	// 填报人
	private String fillPeopleName;

	// 填报时间
	private String fillTime;

	// 拨款总额
	private BigDecimal amountTotal;

	// 拨款资金金额
	private BigDecimal amount;

	// 拨款物资金额
	private BigDecimal meterial;

	// 拨款资金金额结余
	private BigDecimal amountBalance;

	// 拨款物资金额结余
	private BigDecimal meterialBalance;

	// 中央拨款资金金额
	private BigDecimal amountTotalCentral;

	// 省拨款资金金额
	private BigDecimal amountTotalDepartment;

	// 市拨款总额
	private BigDecimal amountTotalCity;

	// 市拨款资金金额
	private BigDecimal amountCity;

	// 市拨款物资金额
	private BigDecimal meterialCity;

	// 县拨款总额
	private BigDecimal amountTotalCounty;

	// 县拨款资金金额
	private BigDecimal amountCounty;

	// 县拨款物资金额
	private BigDecimal meterialCounty;

	// 是否确认
	private String inConfirm;

	// 确认时间
	private String confirmTime;

	// 确认人
	private String confirmPeopleName;
	
	// 更新人
	private String updatePeopleName;

	// 更新时间
	private String updateTime;

	// 拨付信息
	@Transient
	private List<DisFundsSource> disFundsSourceList = new ArrayList<DisFundsSource>();

	/**
	 * 获取 批次编码
	 * 
	 * @return String
	 */
	public String getBatchId() {
		return batchId;
	}

	/**
	 * 设置 批次编码
	 */
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	/**
	 * 获取 年度
	 * 
	 * @return String
	 */
	public String getDisYear() {
		return disYear;
	}

	/**
	 * 设置 年度
	 */
	public void setDisYear(String disYear) {
		this.disYear = disYear;
	}

	/**
	 * 获取 资金来源类型
	 * 
	 * @return String
	 */
	public String getSourceType() {
		return sourceType;
	}

	/**
	 * 设置 资金来源类型
	 */
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	/**
	 * 获取 上级拨款资金文号
	 * 
	 * @return String
	 */
	public String getUpAllocationNum() {
		return upAllocationNum;
	}

	/**
	 * 设置 上级拨款资金文号
	 */
	public void setUpAllocationNum(String upAllocationNum) {
		this.upAllocationNum = upAllocationNum;
	}

	/**
	 * 获取 拨款类型
	 * 
	 * @return String
	 */
	public String getUpAllocationType() {
		return upAllocationType;
	}

	/**
	 * 设置 拨款类型
	 */
	public void setUpAllocationType(String upAllocationType) {
		this.upAllocationType = upAllocationType;
	}

	/**
	 * 获取 资金用途
	 * 
	 * @return String
	 */
	public String getUpAllocationPurpose() {
		return upAllocationPurpose;
	}

	/**
	 * 设置 资金用途
	 */
	public void setUpAllocationPurpose(String upAllocationPurpose) {
		this.upAllocationPurpose = upAllocationPurpose;
	}

	/**
	 * 获取 接收单位名称
	 * 
	 * @return String
	 */
	public String getReceiveOrganName() {
		return receiveOrganName;
	}

	/**
	 * 设置 接收单位名称
	 */
	public void setReceiveOrganName(String receiveOrganName) {
		this.receiveOrganName = receiveOrganName;
	}

	/**
	 * 获取 接收单位区划
	 * 
	 * @return String
	 */
	public String getReceiveOrganCode() {
		return receiveOrganCode;
	}

	/**
	 * 设置 接收单位区划
	 */
	public void setReceiveOrganCode(String receiveOrganCode) {
		this.receiveOrganCode = receiveOrganCode;
	}

	/**
	 * 获取 填报单位区划
	 * 
	 * @return String
	 */
	public String getFillOrganCode() {
		return fillOrganCode;
	}

	/**
	 * 设置 填报单位区划
	 */
	public void setFillOrganCode(String fillOrganCode) {
		this.fillOrganCode = fillOrganCode;
	}

	/**
	 * 获取 填报单位名称
	 * 
	 * @return String
	 */
	public String getFillOrganName() {
		return fillOrganName;
	}

	/**
	 * 设置 填报单位名称
	 */
	public void setFillOrganName(String fillOrganName) {
		this.fillOrganName = fillOrganName;
	}

	/**
	 * 获取 填报人
	 * 
	 * @return String
	 */
	public String getFillPeopleName() {
		return fillPeopleName;
	}

	/**
	 * 设置 填报人
	 */
	public void setFillPeopleName(String fillPeopleName) {
		this.fillPeopleName = fillPeopleName;
	}

	/**
	 * 获取 填报时间
	 * 
	 * @return String
	 */
	public String getFillTime() {
		return fillTime;
	}

	/**
	 * 设置 填报时间
	 */
	public void setFillTime(String fillTime) {
		this.fillTime = fillTime;
	}

	/**
	 * 获取 拨款总额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountTotal() {
		return amountTotal;
	}

	/**
	 * 设置 拨款总额
	 */
	public void setAmountTotal(BigDecimal amountTotal) {
		this.amountTotal = amountTotal;
	}

	/**
	 * 获取 拨款资金金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmount() {
		return amount;
	}

	/**
	 * 设置 拨款资金金额
	 */
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	/**
	 * 获取 拨款物资金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getMeterial() {
		return meterial;
	}

	/**
	 * 设置 拨款物资金额
	 */
	public void setMeterial(BigDecimal meterial) {
		this.meterial = meterial;
	}

	/**
	 * 获取 拨款资金金额结余
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountBalance() {
		return amountBalance;
	}

	/**
	 * 设置 拨款资金金额结余
	 */
	public void setAmountBalance(BigDecimal amountBalance) {
		this.amountBalance = amountBalance;
	}

	/**
	 * 获取 拨款物资金额结余
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialBalance() {
		return meterialBalance;
	}

	/**
	 * 设置 拨款物资金额结余
	 */
	public void setMeterialBalance(BigDecimal meterialBalance) {
		this.meterialBalance = meterialBalance;
	}

	/**
	 * 获取 中央拨款资金金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountTotalCentral() {
		return amountTotalCentral;
	}

	/**
	 * 设置 中央拨款资金金额
	 */
	public void setAmountTotalCentral(BigDecimal amountTotalCentral) {
		this.amountTotalCentral = amountTotalCentral;
	}

	/**
	 * 获取 省拨款资金金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountTotalDepartment() {
		return amountTotalDepartment;
	}

	/**
	 * 设置 省拨款资金金额
	 */
	public void setAmountTotalDepartment(BigDecimal amountTotalDepartment) {
		this.amountTotalDepartment = amountTotalDepartment;
	}

	/**
	 * 获取 市拨款总额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountTotalCity() {
		return amountTotalCity;
	}

	/**
	 * 设置 市拨款总额
	 */
	public void setAmountTotalCity(BigDecimal amountTotalCity) {
		this.amountTotalCity = amountTotalCity;
	}

	/**
	 * 获取 市拨款资金金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountCity() {
		return amountCity;
	}

	/**
	 * 设置 市拨款资金金额
	 */
	public void setAmountCity(BigDecimal amountCity) {
		this.amountCity = amountCity;
	}

	/**
	 * 获取 市拨款物资金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialCity() {
		return meterialCity;
	}

	/**
	 * 设置 市拨款物资金额
	 */
	public void setMeterialCity(BigDecimal meterialCity) {
		this.meterialCity = meterialCity;
	}

	/**
	 * 获取 县拨款总额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountTotalCounty() {
		return amountTotalCounty;
	}

	/**
	 * 设置 县拨款总额
	 */
	public void setAmountTotalCounty(BigDecimal amountTotalCounty) {
		this.amountTotalCounty = amountTotalCounty;
	}

	/**
	 * 获取 县拨款资金金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getAmountCounty() {
		return amountCounty;
	}

	/**
	 * 设置 县拨款资金金额
	 */
	public void setAmountCounty(BigDecimal amountCounty) {
		this.amountCounty = amountCounty;
	}

	/**
	 * 获取 县拨款物资金额
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialCounty() {
		return meterialCounty;
	}

	/**
	 * 设置 县拨款物资金额
	 */
	public void setMeterialCounty(BigDecimal meterialCounty) {
		this.meterialCounty = meterialCounty;
	}

	/**
	 * 获取 是否确认
	 * 
	 * @return String
	 */
	public String getInConfirm() {
		return inConfirm;
	}

	/**
	 * 设置 是否确认
	 */
	public void setInConfirm(String inConfirm) {
		this.inConfirm = inConfirm;
	}

	public List<DisFundsSource> getDisFundsSourceList() {
		return disFundsSourceList;
	}

	public void setDisFundsSourceList(List<DisFundsSource> disFundsSourceList) {
		this.disFundsSourceList = disFundsSourceList;
	}

	public String getConfirmTime() {
		return confirmTime;
	}

	public void setConfirmTime(String confirmTime) {
		this.confirmTime = confirmTime;
	}

	public String getConfirmPeopleName() {
		return confirmPeopleName;
	}

	public void setConfirmPeopleName(String confirmPeopleName) {
		this.confirmPeopleName = confirmPeopleName;
	}

	public String getUpdatePeopleName() {
		return updatePeopleName;
	}

	public void setUpdatePeopleName(String updatePeopleName) {
		this.updatePeopleName = updatePeopleName;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

}