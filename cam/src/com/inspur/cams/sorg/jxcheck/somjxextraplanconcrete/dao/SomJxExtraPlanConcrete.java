package com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西特设项目资金和物资使用计划具体情况
 * 
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
@Table(tableName = "SOM_JX_EXTRA_PLAN_CONCRETE", keyFields = "id")
public class SomJxExtraPlanConcrete extends StatefulDatabean {
	// ID
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// TYPE
	@Column(name = "TYPE")
	private String type;
	// PLAN_YEAR
	@Column(name = "PLAN_YEAR")
	private String planYear;
	// PLAN_MONEY
	@Column(name = "PLAN_MONEY")
	private BigDecimal planMoney;
	// PLAN_GOODS
	@Column(name = "PLAN_GOODS")
	private BigDecimal planGoods;

	/**
	 * getter for ID
	 * 
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for ID
	 * 
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for TASK_CODE
	 * 
	 * @generated
	 */
	public String getTaskCode() {
		return this.taskCode;
	}

	/**
	 * setter for TASK_CODE
	 * 
	 * @generated
	 */
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	/**
	 * getter for PLAN_YEAR
	 * 
	 * @generated
	 */
	public String getPlanYear() {
		return this.planYear;
	}

	/**
	 * setter for PLAN_YEAR
	 * 
	 * @generated
	 */
	public void setPlanYear(String planYear) {
		this.planYear = planYear;
	}

	/**
	 * getter for PLAN_MONEY
	 * 
	 * @generated
	 */
	public BigDecimal getPlanMoney() {
		return this.planMoney;
	}

	/**
	 * setter for PLAN_MONEY
	 * 
	 * @generated
	 */
	public void setPlanMoney(BigDecimal planMoney) {
		this.planMoney = planMoney;
	}

	/**
	 * getter for PLAN_GOODS
	 * 
	 * @generated
	 */
	public BigDecimal getPlanGoods() {
		return this.planGoods;
	}

	/**
	 * setter for PLAN_GOODS
	 * 
	 * @generated
	 */
	public void setPlanGoods(BigDecimal planGoods) {
		this.planGoods = planGoods;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}