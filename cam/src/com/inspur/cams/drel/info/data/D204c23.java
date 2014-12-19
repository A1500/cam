package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 存款databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204C23", keyFields = "d204c23Id")
public class D204c23 extends StatefulDatabean {

	// ID
	private String d204c23Id;

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

	// 银行名称
	private String d204c230001;

	// 同一银行所有账户存款总额
	private BigDecimal d204c230002;

	// 账号/卡号
	private String d204c230003;

	// 储蓄类型
	private String d204c230004;

	// 查询时间
	private String d204c230005;

	// 账户余额
	private BigDecimal d204c230006;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204c23Id() {
		return d204c23Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204c23Id(String d204c23Id) {
		this.d204c23Id = d204c23Id;
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
	 * 获取 银行名称
	 * @return String
	 */
	public String getD204c230001() {
		return d204c230001;
	}

	/**
	 * 设置 银行名称
	 */
	public void setD204c230001(String d204c230001) {
		this.d204c230001 = d204c230001;
	}

	/**
	 * 获取 同一银行所有账户存款总额
	 * @return BigDecimal
	 */
	public BigDecimal getD204c230002() {
		return d204c230002;
	}

	/**
	 * 设置 同一银行所有账户存款总额
	 */
	public void setD204c230002(BigDecimal d204c230002) {
		this.d204c230002 = d204c230002;
	}

	/**
	 * 获取 账号/卡号
	 * @return String
	 */
	public String getD204c230003() {
		return d204c230003;
	}

	/**
	 * 设置 账号/卡号
	 */
	public void setD204c230003(String d204c230003) {
		this.d204c230003 = d204c230003;
	}

	/**
	 * 获取 储蓄类型
	 * @return String
	 */
	public String getD204c230004() {
		return d204c230004;
	}

	/**
	 * 设置 储蓄类型
	 */
	public void setD204c230004(String d204c230004) {
		this.d204c230004 = d204c230004;
	}

	/**
	 * 获取 查询时间
	 * @return String
	 */
	public String getD204c230005() {
		return d204c230005;
	}

	/**
	 * 设置 查询时间
	 */
	public void setD204c230005(String d204c230005) {
		this.d204c230005 = d204c230005;
	}

	/**
	 * 获取 账户余额
	 * @return BigDecimal
	 */
	public BigDecimal getD204c230006() {
		return d204c230006;
	}

	/**
	 * 设置 账户余额
	 */
	public void setD204c230006(BigDecimal d204c230006) {
		this.d204c230006 = d204c230006;
	}

}