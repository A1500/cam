package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 核对总体情况databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204A00", keyFields = "d204a00Id")
public class D204a00 extends StatefulDatabean {

	// ID
	private String d204a00Id;

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

	// 申请唯一号
	private String d204a000001;

	// 受理编号
	private String d204a000002;

	// 主申请人姓名
	private String d204a000003;

	// 主申请人证件类型
	private String d204a000004;

	// 主申请人证件号码
	private String d204a000005;

	// 可支配收入核定起始日期
	private String d204a000006;

	// 可支配收入核定截止日期
	private String d204a000007;

	// 可支配收入报告总计
	private BigDecimal d204a000008;

	// 可支配收入核定总计
	private BigDecimal d204a000009;

	// 财产核定日期
	private String d204a000010;

	// 财产报告总计
	private BigDecimal d204a000011;

	// 财产核定总计
	private BigDecimal d204a000012;

	// 就业状态起始日期
	private String d204a000013;

	// 就业状态截止日期
	private String d204a000014;

	// 支出起始日期
	private String d204a000015;

	// 支出截止日期
	private String d204a000016;

	// 支出报告总计
	private BigDecimal d204a000017;

	// 支出核定总计
	private BigDecimal d204a000018;

	// 核对开始日期
	private String d204a000019;

	// 核对截止日期
	private String d204a000020;

	// 核对编号
	private String d204a000021;

	// 发起查询的核对机构代码
	private String d204a000022;

	// 发起查询的核对机构名称
	private String d204a000023;

	// 发出查询反馈的核对机构代码
	private String d204a000024;

	// 发出查询反馈的核对机构名称
	private String d204a000025;

	// 核对项目编号
	private String d204a000026;

	// 核对项目名称
	private String d204a000027;

	// 委托单位
	private String d204a000028;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204a00Id() {
		return d204a00Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204a00Id(String d204a00Id) {
		this.d204a00Id = d204a00Id;
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
	 * 获取 申请唯一号
	 * @return String
	 */
	public String getD204a000001() {
		return d204a000001;
	}

	/**
	 * 设置 申请唯一号
	 */
	public void setD204a000001(String d204a000001) {
		this.d204a000001 = d204a000001;
	}

	/**
	 * 获取 受理编号
	 * @return String
	 */
	public String getD204a000002() {
		return d204a000002;
	}

	/**
	 * 设置 受理编号
	 */
	public void setD204a000002(String d204a000002) {
		this.d204a000002 = d204a000002;
	}

	/**
	 * 获取 主申请人姓名
	 * @return String
	 */
	public String getD204a000003() {
		return d204a000003;
	}

	/**
	 * 设置 主申请人姓名
	 */
	public void setD204a000003(String d204a000003) {
		this.d204a000003 = d204a000003;
	}

	/**
	 * 获取 主申请人证件类型
	 * @return String
	 */
	public String getD204a000004() {
		return d204a000004;
	}

	/**
	 * 设置 主申请人证件类型
	 */
	public void setD204a000004(String d204a000004) {
		this.d204a000004 = d204a000004;
	}

	/**
	 * 获取 主申请人证件号码
	 * @return String
	 */
	public String getD204a000005() {
		return d204a000005;
	}

	/**
	 * 设置 主申请人证件号码
	 */
	public void setD204a000005(String d204a000005) {
		this.d204a000005 = d204a000005;
	}

	/**
	 * 获取 可支配收入核定起始日期
	 * @return String
	 */
	public String getD204a000006() {
		return d204a000006;
	}

	/**
	 * 设置 可支配收入核定起始日期
	 */
	public void setD204a000006(String d204a000006) {
		this.d204a000006 = d204a000006;
	}

	/**
	 * 获取 可支配收入核定截止日期
	 * @return String
	 */
	public String getD204a000007() {
		return d204a000007;
	}

	/**
	 * 设置 可支配收入核定截止日期
	 */
	public void setD204a000007(String d204a000007) {
		this.d204a000007 = d204a000007;
	}

	/**
	 * 获取 可支配收入报告总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a000008() {
		return d204a000008;
	}

	/**
	 * 设置 可支配收入报告总计
	 */
	public void setD204a000008(BigDecimal d204a000008) {
		this.d204a000008 = d204a000008;
	}

	/**
	 * 获取 可支配收入核定总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a000009() {
		return d204a000009;
	}

	/**
	 * 设置 可支配收入核定总计
	 */
	public void setD204a000009(BigDecimal d204a000009) {
		this.d204a000009 = d204a000009;
	}

	/**
	 * 获取 财产核定日期
	 * @return String
	 */
	public String getD204a000010() {
		return d204a000010;
	}

	/**
	 * 设置 财产核定日期
	 */
	public void setD204a000010(String d204a000010) {
		this.d204a000010 = d204a000010;
	}

	/**
	 * 获取 财产报告总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a000011() {
		return d204a000011;
	}

	/**
	 * 设置 财产报告总计
	 */
	public void setD204a000011(BigDecimal d204a000011) {
		this.d204a000011 = d204a000011;
	}

	/**
	 * 获取 财产核定总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a000012() {
		return d204a000012;
	}

	/**
	 * 设置 财产核定总计
	 */
	public void setD204a000012(BigDecimal d204a000012) {
		this.d204a000012 = d204a000012;
	}

	/**
	 * 获取 就业状态起始日期
	 * @return String
	 */
	public String getD204a000013() {
		return d204a000013;
	}

	/**
	 * 设置 就业状态起始日期
	 */
	public void setD204a000013(String d204a000013) {
		this.d204a000013 = d204a000013;
	}

	/**
	 * 获取 就业状态截止日期
	 * @return String
	 */
	public String getD204a000014() {
		return d204a000014;
	}

	/**
	 * 设置 就业状态截止日期
	 */
	public void setD204a000014(String d204a000014) {
		this.d204a000014 = d204a000014;
	}

	/**
	 * 获取 支出起始日期
	 * @return String
	 */
	public String getD204a000015() {
		return d204a000015;
	}

	/**
	 * 设置 支出起始日期
	 */
	public void setD204a000015(String d204a000015) {
		this.d204a000015 = d204a000015;
	}

	/**
	 * 获取 支出截止日期
	 * @return String
	 */
	public String getD204a000016() {
		return d204a000016;
	}

	/**
	 * 设置 支出截止日期
	 */
	public void setD204a000016(String d204a000016) {
		this.d204a000016 = d204a000016;
	}

	/**
	 * 获取 支出报告总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a000017() {
		return d204a000017;
	}

	/**
	 * 设置 支出报告总计
	 */
	public void setD204a000017(BigDecimal d204a000017) {
		this.d204a000017 = d204a000017;
	}

	/**
	 * 获取 支出核定总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a000018() {
		return d204a000018;
	}

	/**
	 * 设置 支出核定总计
	 */
	public void setD204a000018(BigDecimal d204a000018) {
		this.d204a000018 = d204a000018;
	}

	/**
	 * 获取 核对开始日期
	 * @return String
	 */
	public String getD204a000019() {
		return d204a000019;
	}

	/**
	 * 设置 核对开始日期
	 */
	public void setD204a000019(String d204a000019) {
		this.d204a000019 = d204a000019;
	}

	/**
	 * 获取 核对截止日期
	 * @return String
	 */
	public String getD204a000020() {
		return d204a000020;
	}

	/**
	 * 设置 核对截止日期
	 */
	public void setD204a000020(String d204a000020) {
		this.d204a000020 = d204a000020;
	}

	/**
	 * 获取 核对编号
	 * @return String
	 */
	public String getD204a000021() {
		return d204a000021;
	}

	/**
	 * 设置 核对编号
	 */
	public void setD204a000021(String d204a000021) {
		this.d204a000021 = d204a000021;
	}

	/**
	 * 获取 发起查询的核对机构代码
	 * @return String
	 */
	public String getD204a000022() {
		return d204a000022;
	}

	/**
	 * 设置 发起查询的核对机构代码
	 */
	public void setD204a000022(String d204a000022) {
		this.d204a000022 = d204a000022;
	}

	/**
	 * 获取 发起查询的核对机构名称
	 * @return String
	 */
	public String getD204a000023() {
		return d204a000023;
	}

	/**
	 * 设置 发起查询的核对机构名称
	 */
	public void setD204a000023(String d204a000023) {
		this.d204a000023 = d204a000023;
	}

	/**
	 * 获取 发出查询反馈的核对机构代码
	 * @return String
	 */
	public String getD204a000024() {
		return d204a000024;
	}

	/**
	 * 设置 发出查询反馈的核对机构代码
	 */
	public void setD204a000024(String d204a000024) {
		this.d204a000024 = d204a000024;
	}

	/**
	 * 获取 发出查询反馈的核对机构名称
	 * @return String
	 */
	public String getD204a000025() {
		return d204a000025;
	}

	/**
	 * 设置 发出查询反馈的核对机构名称
	 */
	public void setD204a000025(String d204a000025) {
		this.d204a000025 = d204a000025;
	}

	/**
	 * 获取 核对项目编号
	 * @return String
	 */
	public String getD204a000026() {
		return d204a000026;
	}

	/**
	 * 设置 核对项目编号
	 */
	public void setD204a000026(String d204a000026) {
		this.d204a000026 = d204a000026;
	}

	/**
	 * 获取 核对项目名称
	 * @return String
	 */
	public String getD204a000027() {
		return d204a000027;
	}

	/**
	 * 设置 核对项目名称
	 */
	public void setD204a000027(String d204a000027) {
		this.d204a000027 = d204a000027;
	}

	/**
	 * 获取 委托单位
	 * @return String
	 */
	public String getD204a000028() {
		return d204a000028;
	}

	/**
	 * 设置 委托单位
	 */
	public void setD204a000028(String d204a000028) {
		this.d204a000028 = d204a000028;
	}

}