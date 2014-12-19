package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 救灾资金年度预算表databean
 * @author 
 * @date 2012-11-15
 */
@Table(tableName = "DIS_FUNDS_YEAR_BUDGET", keyFields = "id")
public class DisFundsYearBudget extends StatefulDatabean {

	// ID
	private String id;

	// 年度
	private String disYear;

	// 预算类型
	private String budgetType;

	// 预算金额
	private BigDecimal budgetMoney;

	// 填报单位代码
	private String fillOrganCode;

	// 填报单位名称
	private String fillOrganName;

	// 填报人姓名
	private String fillPeopleName;

	// 填报时间
	private String fillTime;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getId() {
		return id;
	}

	/**
	 * 设置 ID
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * 获取 年度
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
	 * 获取 预算类型
	 * @return String
	 */
	public String getBudgetType() {
		return budgetType;
	}

	/**
	 * 设置 预算类型
	 */
	public void setBudgetType(String budgetType) {
		this.budgetType = budgetType;
	}

	/**
	 * 获取 预算金额
	 * @return BigDecimal
	 */
	public BigDecimal getBudgetMoney() {
		return budgetMoney;
	}

	/**
	 * 设置 预算金额
	 */
	public void setBudgetMoney(BigDecimal budgetMoney) {
		this.budgetMoney = budgetMoney;
	}

	/**
	 * 获取 填报单位代码
	 * @return String
	 */
	public String getFillOrganCode() {
		return fillOrganCode;
	}

	/**
	 * 设置 填报单位代码
	 */
	public void setFillOrganCode(String fillOrganCode) {
		this.fillOrganCode = fillOrganCode;
	}

	/**
	 * 获取 填报单位名称
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
	 * 获取 填报人姓名
	 * @return String
	 */
	public String getFillPeopleName() {
		return fillPeopleName;
	}

	/**
	 * 设置 填报人姓名
	 */
	public void setFillPeopleName(String fillPeopleName) {
		this.fillPeopleName = fillPeopleName;
	}

	/**
	 * 获取 填报时间
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

}