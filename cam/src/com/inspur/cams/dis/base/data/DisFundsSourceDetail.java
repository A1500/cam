package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 资金拨付明细表databean
 * @author 
 * @date 2013-01-04
 */
@Table(tableName = "DIS_FUNDS_SOURCE_DETAIL", keyFields = "allocationDetailId")
public class DisFundsSourceDetail extends StatefulDatabean {

	// 拨付明细编号
	private String allocationDetailId;

	// 来源编号
	private String sourceId;

	// 批次号
	private String batchId;

	// 捐赠类型
	private String allocationType;

	// 物资类型
	private String meterialType;

	// 物资数量
	private BigDecimal meterialNum;

	// 物资单价
	private BigDecimal meterialUnitprice;

	// 物资单位
	private String meterialUnit;

	// 物资总价
	private BigDecimal meterialAccount;

	// 物资数量结余
	private BigDecimal meterialNumBalance;

	// 物资总价结余
	private BigDecimal meterialAccountBalance;

	// 资金标识
	private String fundsType;

	// 关系标志
	private String inRef;

	// 是否使用
	private String inUse;

	// 源拨付明细编号
	private String oldAllocationDetailId;
	
	//源拨付明细
	private String oldAllocationDetail;
	
	// 发放前总数量/实际发放物资数量
	@Transient
	private BigDecimal realMeterialNumTotal;
	@Transient
	private BigDecimal realMeterialNum;
	
	// 发放前总价/实际发放物资总价
	@Transient
	private BigDecimal realMeterialAccountTotal;
	@Transient
	private BigDecimal realMeterialAccount;

	/**
	 * 获取 拨付明细编号
	 * @return String
	 */
	public String getAllocationDetailId() {
		return allocationDetailId;
	}

	/**
	 * 设置 拨付明细编号
	 */
	public void setAllocationDetailId(String allocationDetailId) {
		this.allocationDetailId = allocationDetailId;
	}

	/**
	 * 获取 来源编号
	 * @return String
	 */
	public String getSourceId() {
		return sourceId;
	}

	/**
	 * 设置 来源编号
	 */
	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}

	/**
	 * 获取 批次号
	 * @return String
	 */
	public String getBatchId() {
		return batchId;
	}

	/**
	 * 设置 批次号
	 */
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	/**
	 * 获取 捐赠类型
	 * @return String
	 */
	public String getAllocationType() {
		return allocationType;
	}

	/**
	 * 设置 捐赠类型
	 */
	public void setAllocationType(String allocationType) {
		this.allocationType = allocationType;
	}

	/**
	 * 获取 物资类型
	 * @return String
	 */
	public String getMeterialType() {
		return meterialType;
	}

	/**
	 * 设置 物资类型
	 */
	public void setMeterialType(String meterialType) {
		this.meterialType = meterialType;
	}

	/**
	 * 获取 物资数量
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialNum() {
		return meterialNum;
	}

	/**
	 * 设置 物资数量
	 */
	public void setMeterialNum(BigDecimal meterialNum) {
		this.meterialNum = meterialNum;
	}

	/**
	 * 获取 物资单价
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialUnitprice() {
		return meterialUnitprice;
	}

	/**
	 * 设置 物资单价
	 */
	public void setMeterialUnitprice(BigDecimal meterialUnitprice) {
		this.meterialUnitprice = meterialUnitprice;
	}

	/**
	 * 获取 物资单位
	 * @return String
	 */
	public String getMeterialUnit() {
		return meterialUnit;
	}

	/**
	 * 设置 物资单位
	 */
	public void setMeterialUnit(String meterialUnit) {
		this.meterialUnit = meterialUnit;
	}

	/**
	 * 获取 物资总价
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialAccount() {
		return meterialAccount;
	}

	/**
	 * 设置 物资总价
	 */
	public void setMeterialAccount(BigDecimal meterialAccount) {
		this.meterialAccount = meterialAccount;
	}

	/**
	 * 获取 物资数量结余
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialNumBalance() {
		return meterialNumBalance;
	}

	/**
	 * 设置 物资数量结余
	 */
	public void setMeterialNumBalance(BigDecimal meterialNumBalance) {
		this.meterialNumBalance = meterialNumBalance;
	}

	/**
	 * 获取 物资总价结余
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialAccountBalance() {
		return meterialAccountBalance;
	}

	/**
	 * 设置 物资总价结余
	 */
	public void setMeterialAccountBalance(BigDecimal meterialAccountBalance) {
		this.meterialAccountBalance = meterialAccountBalance;
	}

	/**
	 * 获取 资金标识
	 * @return String
	 */
	public String getFundsType() {
		return fundsType;
	}

	/**
	 * 设置 资金标识
	 */
	public void setFundsType(String fundsType) {
		this.fundsType = fundsType;
	}

	/**
	 * 获取 关系标志
	 * @return String
	 */
	public String getInRef() {
		return inRef;
	}

	/**
	 * 设置 关系标志
	 */
	public void setInRef(String inRef) {
		this.inRef = inRef;
	}

	/**
	 * 获取 是否使用
	 * @return String
	 */
	public String getInUse() {
		return inUse;
	}

	/**
	 * 设置 是否使用
	 */
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}

	public BigDecimal getRealMeterialNum() {
		return realMeterialNum;
	}

	public void setRealMeterialNum(BigDecimal realMeterialNum) {
		this.realMeterialNum = realMeterialNum;
	}

	public BigDecimal getRealMeterialAccount() {
		return realMeterialAccount;
	}

	public void setRealMeterialAccount(BigDecimal realMeterialAccount) {
		this.realMeterialAccount = realMeterialAccount;
	}

	public String getOldAllocationDetailId() {
		return oldAllocationDetailId;
	}

	public void setOldAllocationDetailId(String oldAllocationDetailId) {
		this.oldAllocationDetailId = oldAllocationDetailId;
	}

	public String getOldAllocationDetail() {
		return oldAllocationDetail;
	}

	public void setOldAllocationDetail(String oldAllocationDetail) {
		this.oldAllocationDetail = oldAllocationDetail;
	}

	public BigDecimal getRealMeterialNumTotal() {
		return realMeterialNumTotal;
	}

	public void setRealMeterialNumTotal(BigDecimal realMeterialNumTotal) {
		this.realMeterialNumTotal = realMeterialNumTotal;
	}

	public BigDecimal getRealMeterialAccountTotal() {
		return realMeterialAccountTotal;
	}

	public void setRealMeterialAccountTotal(BigDecimal realMeterialAccountTotal) {
		this.realMeterialAccountTotal = realMeterialAccountTotal;
	}

}