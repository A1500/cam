package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 单位当前物资情况表databean
 * 
 * @author
 * @date 2012-11-05
 */
@Table(tableName = "DIS_CURRENT_MONEY_DETAIL", keyFields = "meterialRecordId")
public class DisCurrentMoneyDetail extends StatefulDatabean {

	// 物资记录内码
	private String meterialRecordId;

	// 记录内码
	private String recordId;

	// 物资类型
	private String meterialType;

	// 物资数量
	private BigDecimal meterialNum;

	// 物资单价
	private BigDecimal meterialUnitprice;

	// 物资单位
	private String meterialUnit;

	// 物资合计
	private BigDecimal meterialAccount;

	/**
	 * 获取 物资记录内码
	 * 
	 * @return String
	 */
	public String getMeterialRecordId() {
		return meterialRecordId;
	}

	/**
	 * 设置 物资记录内码
	 */
	public void setMeterialRecordId(String meterialRecordId) {
		this.meterialRecordId = meterialRecordId;
	}

	/**
	 * 获取 记录内码
	 * 
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 记录内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 物资类型
	 * 
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
	 * 
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
	 * 
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
	 * 获取 物资合计
	 * 
	 * @return BigDecimal
	 */
	public BigDecimal getMeterialAccount() {
		return meterialAccount;
	}

	/**
	 * 设置 物资合计
	 */
	public void setMeterialAccount(BigDecimal meterialAccount) {
		this.meterialAccount = meterialAccount;
	}

	public String getMeterialUnit() {
		return meterialUnit;
	}

	public void setMeterialUnit(String meterialUnit) {
		this.meterialUnit = meterialUnit;
	}

}