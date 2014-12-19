package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 财产性收入databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204B13", keyFields = "d204b13Id")
public class D204b13 extends StatefulDatabean {

	// ID
	private String d204b13Id;

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

	// 银行存款利息收入
	private BigDecimal d204b130001;

	// 基金收益
	private BigDecimal d204b130002;

	// 股票与红利收入
	private BigDecimal d204b130003;

	// 保险收益
	private BigDecimal d204b130004;

	// 出租房屋或其他财产收益
	private BigDecimal d204b130005;

	// 知识产品收益
	private BigDecimal d204b130006;

	// 其他投资收益
	private BigDecimal d204b130007;

	// 其他财产性收益
	private BigDecimal d204b130008;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204b13Id() {
		return d204b13Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204b13Id(String d204b13Id) {
		this.d204b13Id = d204b13Id;
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
	 * 获取 银行存款利息收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130001() {
		return d204b130001;
	}

	/**
	 * 设置 银行存款利息收入
	 */
	public void setD204b130001(BigDecimal d204b130001) {
		this.d204b130001 = d204b130001;
	}

	/**
	 * 获取 基金收益
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130002() {
		return d204b130002;
	}

	/**
	 * 设置 基金收益
	 */
	public void setD204b130002(BigDecimal d204b130002) {
		this.d204b130002 = d204b130002;
	}

	/**
	 * 获取 股票与红利收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130003() {
		return d204b130003;
	}

	/**
	 * 设置 股票与红利收入
	 */
	public void setD204b130003(BigDecimal d204b130003) {
		this.d204b130003 = d204b130003;
	}

	/**
	 * 获取 保险收益
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130004() {
		return d204b130004;
	}

	/**
	 * 设置 保险收益
	 */
	public void setD204b130004(BigDecimal d204b130004) {
		this.d204b130004 = d204b130004;
	}

	/**
	 * 获取 出租房屋或其他财产收益
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130005() {
		return d204b130005;
	}

	/**
	 * 设置 出租房屋或其他财产收益
	 */
	public void setD204b130005(BigDecimal d204b130005) {
		this.d204b130005 = d204b130005;
	}

	/**
	 * 获取 知识产品收益
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130006() {
		return d204b130006;
	}

	/**
	 * 设置 知识产品收益
	 */
	public void setD204b130006(BigDecimal d204b130006) {
		this.d204b130006 = d204b130006;
	}

	/**
	 * 获取 其他投资收益
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130007() {
		return d204b130007;
	}

	/**
	 * 设置 其他投资收益
	 */
	public void setD204b130007(BigDecimal d204b130007) {
		this.d204b130007 = d204b130007;
	}

	/**
	 * 获取 其他财产性收益
	 * @return BigDecimal
	 */
	public BigDecimal getD204b130008() {
		return d204b130008;
	}

	/**
	 * 设置 其他财产性收益
	 */
	public void setD204b130008(BigDecimal d204b130008) {
		this.d204b130008 = d204b130008;
	}

}