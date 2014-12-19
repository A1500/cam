package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:个人收入信息databean
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
@Table(tableName = "SAM_PEOPLE_INCOME", keyFields = "incomeId")
public class SamPeopleIncome extends StatefulDatabean {
	// 个人收入ID
	private String incomeId;
	// 人员ID
	private String peopleId;
	// 收入类型
	private String incomeType;
	// 收入名称
	private String incomeName;
	// 收入金额
	private String incomeNum;
	// 计入金额
	private String calculateNum;
	// 不计入金额
	private String eliminateNum;
	// 收入计算方式
	private String computeMode;
	// 备注
	private String remarks;

	public String getIncomeId() {
		return incomeId;
	}

	public void setIncomeId(String incomeId) {
		this.incomeId = incomeId;
	}

	public String getPeopleId() {
		return peopleId;
	}

	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	public String getIncomeType() {
		return incomeType;
	}

	public void setIncomeType(String incomeType) {
		this.incomeType = incomeType;
	}

	public String getIncomeName() {
		return incomeName;
	}

	public void setIncomeName(String incomeName) {
		this.incomeName = incomeName;
	}

	public String getIncomeNum() {
		return incomeNum;
	}

	public void setIncomeNum(String incomeNum) {
		this.incomeNum = incomeNum;
	}

	public String getCalculateNum() {
		return calculateNum;
	}

	public void setCalculateNum(String calculateNum) {
		this.calculateNum = calculateNum;
	}

	public String getEliminateNum() {
		return eliminateNum;
	}

	public void setEliminateNum(String eliminateNum) {
		this.eliminateNum = eliminateNum;
	}

	public String getComputeMode() {
		return computeMode;
	}

	public void setComputeMode(String computeMode) {
		this.computeMode = computeMode;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}