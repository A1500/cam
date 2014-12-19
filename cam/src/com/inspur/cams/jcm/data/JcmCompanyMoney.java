package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 工作经费信息databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "JCM_COMPANY_MONEY", keyFields = "companyMoneyId")
public class JcmCompanyMoney extends StatefulDatabean {

	// 单位主键
	private String companyId;

	// 工作经费主键
	private String companyMoneyId;

	// 工作经费类别
	private String moneyType;

	// 工作经费金额
	private BigDecimal moneyCost;

	// 备注
	private String note;
	
	// 年度
	private String year;

	/**
	 * 获取 单位主键
	 * @return String
	 */
	public String getCompanyId() {
		return companyId;
	}

	/**
	 * 设置 单位主键
	 */
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	/**
	 * 获取 工作经费主键
	 * @return String
	 */
	public String getCompanyMoneyId() {
		return companyMoneyId;
	}

	/**
	 * 设置 工作经费主键
	 */
	public void setCompanyMoneyId(String companyMoneyId) {
		this.companyMoneyId = companyMoneyId;
	}

	/**
	 * 获取 工作经费类别
	 * @return String
	 */
	public String getMoneyType() {
		return moneyType;
	}

	/**
	 * 设置 工作经费类别
	 */
	public void setMoneyType(String moneyType) {
		this.moneyType = moneyType;
	}

	/**
	 * 获取 工作经费金额
	 * @return BigDecimal
	 */
	public BigDecimal getMoneyCost() {
		return moneyCost;
	}

	/**
	 * 设置 工作经费金额
	 */
	public void setMoneyCost(BigDecimal moneyCost) {
		this.moneyCost = moneyCost;
	}

	/**
	 * 获取 备注
	 * @return BigDecimal
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}
	
}