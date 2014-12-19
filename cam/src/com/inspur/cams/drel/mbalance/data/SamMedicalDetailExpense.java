package com.inspur.cams.drel.mbalance.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
/**
 * 一站式结算费用明细
 * @author lgs
 *
 */
@Table(tableName = "SAM_MEDICAL_DETAIL_EXPENSE" , keyFields = "EXPENSE_ID")
public class SamMedicalDetailExpense extends StatefulDatabean {
	
	//费用流水ID
	@Column(name="EXPENSE_ID")
	private String expenseid;
	//住院流水ID
	@Column(name="BALANCE_ID")
	private String balanceId;
	//费用代码
	@Column(name="CODE")
	private String code;
	//费用名称
	@Column(name="EXP_NAME")
	private String expName;
	//规格
	@Column(name="TYPE")
	private String type;
	
	//剂型
	@Column(name="FORM")
	private String form;

	//日期
	@Column(name="EXP_DATE")
	private String expDate;
	//数量
	@Column(name="NUM")
	private BigDecimal num;
	//单价
	@Column(name="PRICE")
	private BigDecimal price;

	//金额
	@Column(name="EXP_MONEY")
	private BigDecimal expMoney;

	public String getExpenseid() {
		return expenseid;
	}

	public void setExpenseid(String expenseid) {
		this.expenseid = expenseid;
	}

	public String getBalanceId() {
		return balanceId;
	}

	public void setBalanceId(String balanceId) {
		this.balanceId = balanceId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getExpName() {
		return expName;
	}

	public void setExpName(String expName) {
		this.expName = expName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getForm() {
		return form;
	}

	public void setForm(String form) {
		this.form = form;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public BigDecimal getNum() {
		return num;
	}

	public void setNum(BigDecimal num) {
		this.num = num;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getExpMoney() {
		return expMoney;
	}

	public void setExpMoney(BigDecimal expMoney) {
		this.expMoney = expMoney;
	}
}
	
