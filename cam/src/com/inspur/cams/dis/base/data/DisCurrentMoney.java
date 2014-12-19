package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 单位当前资金情况表databean
 * @author 
 * @date 2012-11-05
 */
@Table(tableName = "DIS_CURRENT_MONEY", keyFields = "recordId")
public class DisCurrentMoney extends StatefulDatabean {

	// 记录内码
	private String recordId;

	// 单位行政区划
	private String organCode;

	// 单位名称
	private String organName;

	// 现有资金金额
	private BigDecimal currentMoney;

	// 现有物资金额
	private BigDecimal currentMeterial;

	/**
	 * 获取 记录内码
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
	 * 获取 单位行政区划
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 单位行政区划
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 单位名称
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 单位名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 现有资金金额
	 * @return BigDecimal
	 */
	public BigDecimal getCurrentMoney() {
		return currentMoney;
	}

	/**
	 * 设置 现有资金金额
	 */
	public void setCurrentMoney(BigDecimal currentMoney) {
		this.currentMoney = currentMoney;
	}

	/**
	 * 获取 现有物资金额
	 * @return BigDecimal
	 */
	public BigDecimal getCurrentMeterial() {
		return currentMeterial;
	}

	/**
	 * 设置 现有物资金额
	 */
	public void setCurrentMeterial(BigDecimal currentMeterial) {
		this.currentMeterial = currentMeterial;
	}

}