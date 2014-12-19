package com.inspur.cams.drel.application.cityLow.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 低收入家庭成员可支配收入表databean
 * @author 
 * @date 2014-03-11
 */
@Table(tableName = "SAM_LOW_PEOPLE_INCOME", keyFields = "incomeId")
public class SamLowPeopleIncome extends StatefulDatabean {

	// 收入ID
	private String incomeId;

	// 人员编号
	private String peopleId;

	// 工资性收入
	private BigDecimal salaryIncome;

	// 经营性净收入
	private BigDecimal manageIncome;

	// 财产性收入
	private BigDecimal propertyIncome;

	// 转移性收入
	private BigDecimal transferIncome;

	// 其它收入
	private BigDecimal otherIncome;

	// 总收入
	private BigDecimal totalIncome;

	/**
	 * 获取 收入ID
	 * @return String
	 */
	public String getIncomeId() {
		return incomeId;
	}

	/**
	 * 设置 收入ID
	 */
	public void setIncomeId(String incomeId) {
		this.incomeId = incomeId;
	}

	/**
	 * 获取 人员编号
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员编号
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 工资性收入
	 * @return BigDecimal
	 */
	public BigDecimal getSalaryIncome() {
		return salaryIncome;
	}

	/**
	 * 设置 工资性收入
	 */
	public void setSalaryIncome(BigDecimal salaryIncome) {
		this.salaryIncome = salaryIncome;
	}

	/**
	 * 获取 经营性净收入
	 * @return BigDecimal
	 */
	public BigDecimal getManageIncome() {
		return manageIncome;
	}

	/**
	 * 设置 经营性净收入
	 */
	public void setManageIncome(BigDecimal manageIncome) {
		this.manageIncome = manageIncome;
	}

	/**
	 * 获取 财产性收入
	 * @return BigDecimal
	 */
	public BigDecimal getPropertyIncome() {
		return propertyIncome;
	}

	/**
	 * 设置 财产性收入
	 */
	public void setPropertyIncome(BigDecimal propertyIncome) {
		this.propertyIncome = propertyIncome;
	}

	/**
	 * 获取 转移性收入
	 * @return BigDecimal
	 */
	public BigDecimal getTransferIncome() {
		return transferIncome;
	}

	/**
	 * 设置 转移性收入
	 */
	public void setTransferIncome(BigDecimal transferIncome) {
		this.transferIncome = transferIncome;
	}

	/**
	 * 获取 其它收入
	 * @return BigDecimal
	 */
	public BigDecimal getOtherIncome() {
		return otherIncome;
	}

	/**
	 * 设置 其它收入
	 */
	public void setOtherIncome(BigDecimal otherIncome) {
		this.otherIncome = otherIncome;
	}

	/**
	 * 获取 总收入
	 * @return BigDecimal
	 */
	public BigDecimal getTotalIncome() {
		return totalIncome;
	}

	/**
	 * 设置 总收入
	 */
	public void setTotalIncome(BigDecimal totalIncome) {
		this.totalIncome = totalIncome;
	}

}