package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公积金缴纳情况databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204D34", keyFields = "d204d34Id")
public class D204d34 extends StatefulDatabean {

	// ID
	private String d204d34Id;

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

	// 当前核定月缴存额
	private BigDecimal d204d340001;

	// 当前活期余额
	private BigDecimal d204d340002;

	// 当前定期余额
	private BigDecimal d204d340003;

	// 末次缴交年月
	private String d204d340004;

	// 当前状态
	private String d204d340005;

	// 数据有无标志
	private String d204d340006;

	// 公积金姓名
	private String d204d340007;

	// 个人帐号
	private String d204d340008;

	// 单位代码
	private String d204d340009;

	// 提取类别
	private String d204d340010;

	// 提取日期
	private String d204d340011;

	// 提取发生额
	private BigDecimal d204d340012;

	// 提取利息
	private BigDecimal d204d340013;

	// 提取原因代码
	private String d204d340014;

	// 发生银行名称
	private String d204d340015;

	// 公积金缴纳单位编号
	private String d204d340016;

	// 公积金缴纳单位名称
	private String d204d340017;

	// 初次缴费时间
	private String d204d340018;

	// 缴存基数
	private BigDecimal d204d340019;

	// 个人缴纳比例
	private BigDecimal d204d340020;

	// 单位缴存比例
	private BigDecimal d204d340021;

	// 贷款金额
	private BigDecimal d204d340022;

	// 贷款利息
	private BigDecimal d204d340023;

	// 放贷日期
	private String d204d340024;

	// 贷款年限
	private BigDecimal d204d340025;

	// 月还款额
	private BigDecimal d204d340026;

	// 已还金额
	private BigDecimal d204d340027;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204d34Id() {
		return d204d34Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204d34Id(String d204d34Id) {
		this.d204d34Id = d204d34Id;
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
	 * 获取 当前核定月缴存额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340001() {
		return d204d340001;
	}

	/**
	 * 设置 当前核定月缴存额
	 */
	public void setD204d340001(BigDecimal d204d340001) {
		this.d204d340001 = d204d340001;
	}

	/**
	 * 获取 当前活期余额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340002() {
		return d204d340002;
	}

	/**
	 * 设置 当前活期余额
	 */
	public void setD204d340002(BigDecimal d204d340002) {
		this.d204d340002 = d204d340002;
	}

	/**
	 * 获取 当前定期余额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340003() {
		return d204d340003;
	}

	/**
	 * 设置 当前定期余额
	 */
	public void setD204d340003(BigDecimal d204d340003) {
		this.d204d340003 = d204d340003;
	}

	/**
	 * 获取 末次缴交年月
	 * @return String
	 */
	public String getD204d340004() {
		return d204d340004;
	}

	/**
	 * 设置 末次缴交年月
	 */
	public void setD204d340004(String d204d340004) {
		this.d204d340004 = d204d340004;
	}

	/**
	 * 获取 当前状态
	 * @return String
	 */
	public String getD204d340005() {
		return d204d340005;
	}

	/**
	 * 设置 当前状态
	 */
	public void setD204d340005(String d204d340005) {
		this.d204d340005 = d204d340005;
	}

	/**
	 * 获取 数据有无标志
	 * @return String
	 */
	public String getD204d340006() {
		return d204d340006;
	}

	/**
	 * 设置 数据有无标志
	 */
	public void setD204d340006(String d204d340006) {
		this.d204d340006 = d204d340006;
	}

	/**
	 * 获取 公积金姓名
	 * @return String
	 */
	public String getD204d340007() {
		return d204d340007;
	}

	/**
	 * 设置 公积金姓名
	 */
	public void setD204d340007(String d204d340007) {
		this.d204d340007 = d204d340007;
	}

	/**
	 * 获取 个人帐号
	 * @return String
	 */
	public String getD204d340008() {
		return d204d340008;
	}

	/**
	 * 设置 个人帐号
	 */
	public void setD204d340008(String d204d340008) {
		this.d204d340008 = d204d340008;
	}

	/**
	 * 获取 单位代码
	 * @return String
	 */
	public String getD204d340009() {
		return d204d340009;
	}

	/**
	 * 设置 单位代码
	 */
	public void setD204d340009(String d204d340009) {
		this.d204d340009 = d204d340009;
	}

	/**
	 * 获取 提取类别
	 * @return String
	 */
	public String getD204d340010() {
		return d204d340010;
	}

	/**
	 * 设置 提取类别
	 */
	public void setD204d340010(String d204d340010) {
		this.d204d340010 = d204d340010;
	}

	/**
	 * 获取 提取日期
	 * @return String
	 */
	public String getD204d340011() {
		return d204d340011;
	}

	/**
	 * 设置 提取日期
	 */
	public void setD204d340011(String d204d340011) {
		this.d204d340011 = d204d340011;
	}

	/**
	 * 获取 提取发生额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340012() {
		return d204d340012;
	}

	/**
	 * 设置 提取发生额
	 */
	public void setD204d340012(BigDecimal d204d340012) {
		this.d204d340012 = d204d340012;
	}

	/**
	 * 获取 提取利息
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340013() {
		return d204d340013;
	}

	/**
	 * 设置 提取利息
	 */
	public void setD204d340013(BigDecimal d204d340013) {
		this.d204d340013 = d204d340013;
	}

	/**
	 * 获取 提取原因代码
	 * @return String
	 */
	public String getD204d340014() {
		return d204d340014;
	}

	/**
	 * 设置 提取原因代码
	 */
	public void setD204d340014(String d204d340014) {
		this.d204d340014 = d204d340014;
	}

	/**
	 * 获取 发生银行名称
	 * @return String
	 */
	public String getD204d340015() {
		return d204d340015;
	}

	/**
	 * 设置 发生银行名称
	 */
	public void setD204d340015(String d204d340015) {
		this.d204d340015 = d204d340015;
	}

	/**
	 * 获取 公积金缴纳单位编号
	 * @return String
	 */
	public String getD204d340016() {
		return d204d340016;
	}

	/**
	 * 设置 公积金缴纳单位编号
	 */
	public void setD204d340016(String d204d340016) {
		this.d204d340016 = d204d340016;
	}

	/**
	 * 获取 公积金缴纳单位名称
	 * @return String
	 */
	public String getD204d340017() {
		return d204d340017;
	}

	/**
	 * 设置 公积金缴纳单位名称
	 */
	public void setD204d340017(String d204d340017) {
		this.d204d340017 = d204d340017;
	}

	/**
	 * 获取 初次缴费时间
	 * @return String
	 */
	public String getD204d340018() {
		return d204d340018;
	}

	/**
	 * 设置 初次缴费时间
	 */
	public void setD204d340018(String d204d340018) {
		this.d204d340018 = d204d340018;
	}

	/**
	 * 获取 缴存基数
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340019() {
		return d204d340019;
	}

	/**
	 * 设置 缴存基数
	 */
	public void setD204d340019(BigDecimal d204d340019) {
		this.d204d340019 = d204d340019;
	}

	/**
	 * 获取 个人缴纳比例
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340020() {
		return d204d340020;
	}

	/**
	 * 设置 个人缴纳比例
	 */
	public void setD204d340020(BigDecimal d204d340020) {
		this.d204d340020 = d204d340020;
	}

	/**
	 * 获取 单位缴存比例
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340021() {
		return d204d340021;
	}

	/**
	 * 设置 单位缴存比例
	 */
	public void setD204d340021(BigDecimal d204d340021) {
		this.d204d340021 = d204d340021;
	}

	/**
	 * 获取 贷款金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340022() {
		return d204d340022;
	}

	/**
	 * 设置 贷款金额
	 */
	public void setD204d340022(BigDecimal d204d340022) {
		this.d204d340022 = d204d340022;
	}

	/**
	 * 获取 贷款利息
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340023() {
		return d204d340023;
	}

	/**
	 * 设置 贷款利息
	 */
	public void setD204d340023(BigDecimal d204d340023) {
		this.d204d340023 = d204d340023;
	}

	/**
	 * 获取 放贷日期
	 * @return String
	 */
	public String getD204d340024() {
		return d204d340024;
	}

	/**
	 * 设置 放贷日期
	 */
	public void setD204d340024(String d204d340024) {
		this.d204d340024 = d204d340024;
	}

	/**
	 * 获取 贷款年限
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340025() {
		return d204d340025;
	}

	/**
	 * 设置 贷款年限
	 */
	public void setD204d340025(BigDecimal d204d340025) {
		this.d204d340025 = d204d340025;
	}

	/**
	 * 获取 月还款额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340026() {
		return d204d340026;
	}

	/**
	 * 设置 月还款额
	 */
	public void setD204d340026(BigDecimal d204d340026) {
		this.d204d340026 = d204d340026;
	}

	/**
	 * 获取 已还金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d340027() {
		return d204d340027;
	}

	/**
	 * 设置 已还金额
	 */
	public void setD204d340027(BigDecimal d204d340027) {
		this.d204d340027 = d204d340027;
	}

}