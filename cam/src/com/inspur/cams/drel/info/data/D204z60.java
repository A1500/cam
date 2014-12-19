package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 第三方支付信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z60", keyFields = "d204z60Id")
public class D204z60 extends StatefulDatabean {

	// ID
	private String d204z60Id;

	// 人员ID
	private String peopleId;

	// 家庭ID
	private String familyId;

	// 委托代码
	private String commissionId;

	// 信息来源
	private String sourceType;

	// 信息查询编码
	private String infoQueryId;

	// 入库人
	private String inputPeople;

	// 入库人编码
	private String inputPeopleId;

	// 入库单位
	private String inputOrgan;

	// 入库单位编码
	private String inputOrganId;

	// 入库批次
	private String inputBatchCode;

	// 入库时间
	private String inputTime;

	// 运营商名称
	private String d204z600001;

	// 账户用户名
	private String d204z600002;

	// 账户余额
	private BigDecimal d204z600003;

	// 近1年支付总额
	private BigDecimal d204z600004;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z60Id() {
		return d204z60Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z60Id(String d204z60Id) {
		this.d204z60Id = d204z60Id;
	}

	/**
	 * 获取 人员ID
	 * @return String
	 */
	public String getPeopleId() {
		return peopleId;
	}

	/**
	 * 设置 人员ID
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * 获取 家庭ID
	 * @return String
	 */
	public String getFamilyId() {
		return familyId;
	}

	/**
	 * 设置 家庭ID
	 */
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}

	/**
	 * 获取 委托代码
	 * @return String
	 */
	public String getCommissionId() {
		return commissionId;
	}

	/**
	 * 设置 委托代码
	 */
	public void setCommissionId(String commissionId) {
		this.commissionId = commissionId;
	}

	/**
	 * 获取 信息来源
	 * @return String
	 */
	public String getSourceType() {
		return sourceType;
	}

	/**
	 * 设置 信息来源
	 */
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	/**
	 * 获取 信息查询编码
	 * @return String
	 */
	public String getInfoQueryId() {
		return infoQueryId;
	}

	/**
	 * 设置 信息查询编码
	 */
	public void setInfoQueryId(String infoQueryId) {
		this.infoQueryId = infoQueryId;
	}

	/**
	 * 获取 入库人
	 * @return String
	 */
	public String getInputPeople() {
		return inputPeople;
	}

	/**
	 * 设置 入库人
	 */
	public void setInputPeople(String inputPeople) {
		this.inputPeople = inputPeople;
	}

	/**
	 * 获取 入库人编码
	 * @return String
	 */
	public String getInputPeopleId() {
		return inputPeopleId;
	}

	/**
	 * 设置 入库人编码
	 */
	public void setInputPeopleId(String inputPeopleId) {
		this.inputPeopleId = inputPeopleId;
	}

	/**
	 * 获取 入库单位
	 * @return String
	 */
	public String getInputOrgan() {
		return inputOrgan;
	}

	/**
	 * 设置 入库单位
	 */
	public void setInputOrgan(String inputOrgan) {
		this.inputOrgan = inputOrgan;
	}

	/**
	 * 获取 入库单位编码
	 * @return String
	 */
	public String getInputOrganId() {
		return inputOrganId;
	}

	/**
	 * 设置 入库单位编码
	 */
	public void setInputOrganId(String inputOrganId) {
		this.inputOrganId = inputOrganId;
	}

	/**
	 * 获取 入库批次
	 * @return String
	 */
	public String getInputBatchCode() {
		return inputBatchCode;
	}

	/**
	 * 设置 入库批次
	 */
	public void setInputBatchCode(String inputBatchCode) {
		this.inputBatchCode = inputBatchCode;
	}

	/**
	 * 获取 入库时间
	 * @return String
	 */
	public String getInputTime() {
		return inputTime;
	}

	/**
	 * 设置 入库时间
	 */
	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}

	/**
	 * 获取 运营商名称
	 * @return String
	 */
	public String getD204z600001() {
		return d204z600001;
	}

	/**
	 * 设置 运营商名称
	 */
	public void setD204z600001(String d204z600001) {
		this.d204z600001 = d204z600001;
	}

	/**
	 * 获取 账户用户名
	 * @return String
	 */
	public String getD204z600002() {
		return d204z600002;
	}

	/**
	 * 设置 账户用户名
	 */
	public void setD204z600002(String d204z600002) {
		this.d204z600002 = d204z600002;
	}

	/**
	 * 获取 账户余额
	 * @return BigDecimal
	 */
	public BigDecimal getD204z600003() {
		return d204z600003;
	}

	/**
	 * 设置 账户余额
	 */
	public void setD204z600003(BigDecimal d204z600003) {
		this.d204z600003 = d204z600003;
	}

	/**
	 * 获取 近1年支付总额
	 * @return BigDecimal
	 */
	public BigDecimal getD204z600004() {
		return d204z600004;
	}

	/**
	 * 设置 近1年支付总额
	 */
	public void setD204z600004(BigDecimal d204z600004) {
		this.d204z600004 = d204z600004;
	}

}