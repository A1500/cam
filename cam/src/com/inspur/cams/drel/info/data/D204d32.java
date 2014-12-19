package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会保险缴费databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204D32", keyFields = "d204d32Id")
public class D204d32 extends StatefulDatabean {

	// ID
	private String d204d32Id;

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

	// 上年度平均月收入
	private BigDecimal d204d320001;

	// 养老保险缴纳金额
	private BigDecimal d204d320002;

	// 失业保险缴纳金额
	private BigDecimal d204d320003;

	// 医疗保险缴纳金额
	private BigDecimal d204d320004;

	// 缴费单位名称
	private String d204d320005;

	// 缴费月份
	private String d204d320006;

	// 个人属性
	private String d204d320007;

	// 社保姓名
	private String d204d320008;

	// 社会保障号
	private String d204d320009;

	// 缴费基数
	private BigDecimal d204d320010;

	// 缴费金额
	private BigDecimal d204d320011;

	// 末次缴费时间
	private String d204d320012;

	// 险种类别
	private String d204d320013;

	// 险种名称
	private String d204d320014;

	// 退休时间
	private String d204d320015;

	// 退休金额
	private BigDecimal d204d320016;

	// 领取时间
	private String d204d320017;

	// 领取金额
	private BigDecimal d204d320018;

	// 入院时间
	private String d204d320019;

	// 出院时间
	private String d204d320020;

	// 诊治医院
	private String d204d320021;

	// 治疗费用总额
	private BigDecimal d204d320022;

	// 不符合补偿费用
	private BigDecimal d204d320023;

	// 医保补偿金额
	private BigDecimal d204d320024;

	// 医保补偿时间
	private String d204d320025;
	
		// 养老保险单位缴纳金额
		private String d204d320026;
		// 失业保险单位缴纳金额
		private String d204d320027;
		// 医疗保险单位缴纳金额
		private String d204d320028;
		// 单位属性
		private String d204d320029;
		// 失业金
		private String d204d320030;
		// 养老金
		private String d204d320031;
		// 比对情况
		private String compareType;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204d32Id() {
		return d204d32Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204d32Id(String d204d32Id) {
		this.d204d32Id = d204d32Id;
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
	 * 获取 上年度平均月收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320001() {
		return d204d320001;
	}

	/**
	 * 设置 上年度平均月收入
	 */
	public void setD204d320001(BigDecimal d204d320001) {
		this.d204d320001 = d204d320001;
	}

	/**
	 * 获取 养老保险缴纳金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320002() {
		return d204d320002;
	}

	/**
	 * 设置 养老保险缴纳金额
	 */
	public void setD204d320002(BigDecimal d204d320002) {
		this.d204d320002 = d204d320002;
	}

	/**
	 * 获取 失业保险缴纳金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320003() {
		return d204d320003;
	}

	/**
	 * 设置 失业保险缴纳金额
	 */
	public void setD204d320003(BigDecimal d204d320003) {
		this.d204d320003 = d204d320003;
	}

	/**
	 * 获取 医疗保险缴纳金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320004() {
		return d204d320004;
	}

	/**
	 * 设置 医疗保险缴纳金额
	 */
	public void setD204d320004(BigDecimal d204d320004) {
		this.d204d320004 = d204d320004;
	}

	/**
	 * 获取 缴费单位名称
	 * @return String
	 */
	public String getD204d320005() {
		return d204d320005;
	}

	/**
	 * 设置 缴费单位名称
	 */
	public void setD204d320005(String d204d320005) {
		this.d204d320005 = d204d320005;
	}

	/**
	 * 获取 缴费月份
	 * @return String
	 */
	public String getD204d320006() {
		return d204d320006;
	}

	/**
	 * 设置 缴费月份
	 */
	public void setD204d320006(String d204d320006) {
		this.d204d320006 = d204d320006;
	}

	/**
	 * 获取 个人属性
	 * @return String
	 */
	public String getD204d320007() {
		return d204d320007;
	}

	/**
	 * 设置 个人属性
	 */
	public void setD204d320007(String d204d320007) {
		this.d204d320007 = d204d320007;
	}

	/**
	 * 获取 社保姓名
	 * @return String
	 */
	public String getD204d320008() {
		return d204d320008;
	}

	/**
	 * 设置 社保姓名
	 */
	public void setD204d320008(String d204d320008) {
		this.d204d320008 = d204d320008;
	}

	/**
	 * 获取 社会保障号
	 * @return String
	 */
	public String getD204d320009() {
		return d204d320009;
	}

	/**
	 * 设置 社会保障号
	 */
	public void setD204d320009(String d204d320009) {
		this.d204d320009 = d204d320009;
	}

	/**
	 * 获取 缴费基数
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320010() {
		return d204d320010;
	}

	/**
	 * 设置 缴费基数
	 */
	public void setD204d320010(BigDecimal d204d320010) {
		this.d204d320010 = d204d320010;
	}

	/**
	 * 获取 缴费金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320011() {
		return d204d320011;
	}

	/**
	 * 设置 缴费金额
	 */
	public void setD204d320011(BigDecimal d204d320011) {
		this.d204d320011 = d204d320011;
	}

	/**
	 * 获取 末次缴费时间
	 * @return String
	 */
	public String getD204d320012() {
		return d204d320012;
	}

	/**
	 * 设置 末次缴费时间
	 */
	public void setD204d320012(String d204d320012) {
		this.d204d320012 = d204d320012;
	}

	/**
	 * 获取 险种类别
	 * @return String
	 */
	public String getD204d320013() {
		return d204d320013;
	}

	/**
	 * 设置 险种类别
	 */
	public void setD204d320013(String d204d320013) {
		this.d204d320013 = d204d320013;
	}

	/**
	 * 获取 险种名称
	 * @return String
	 */
	public String getD204d320014() {
		return d204d320014;
	}

	/**
	 * 设置 险种名称
	 */
	public void setD204d320014(String d204d320014) {
		this.d204d320014 = d204d320014;
	}

	/**
	 * 获取 退休时间
	 * @return String
	 */
	public String getD204d320015() {
		return d204d320015;
	}

	/**
	 * 设置 退休时间
	 */
	public void setD204d320015(String d204d320015) {
		this.d204d320015 = d204d320015;
	}

	/**
	 * 获取 退休金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320016() {
		return d204d320016;
	}

	/**
	 * 设置 退休金额
	 */
	public void setD204d320016(BigDecimal d204d320016) {
		this.d204d320016 = d204d320016;
	}

	/**
	 * 获取 领取时间
	 * @return String
	 */
	public String getD204d320017() {
		return d204d320017;
	}

	/**
	 * 设置 领取时间
	 */
	public void setD204d320017(String d204d320017) {
		this.d204d320017 = d204d320017;
	}

	/**
	 * 获取 领取金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320018() {
		return d204d320018;
	}

	/**
	 * 设置 领取金额
	 */
	public void setD204d320018(BigDecimal d204d320018) {
		this.d204d320018 = d204d320018;
	}

	/**
	 * 获取 入院时间
	 * @return String
	 */
	public String getD204d320019() {
		return d204d320019;
	}

	/**
	 * 设置 入院时间
	 */
	public void setD204d320019(String d204d320019) {
		this.d204d320019 = d204d320019;
	}

	/**
	 * 获取 出院时间
	 * @return String
	 */
	public String getD204d320020() {
		return d204d320020;
	}

	/**
	 * 设置 出院时间
	 */
	public void setD204d320020(String d204d320020) {
		this.d204d320020 = d204d320020;
	}

	/**
	 * 获取 诊治医院
	 * @return String
	 */
	public String getD204d320021() {
		return d204d320021;
	}

	/**
	 * 设置 诊治医院
	 */
	public void setD204d320021(String d204d320021) {
		this.d204d320021 = d204d320021;
	}

	/**
	 * 获取 治疗费用总额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320022() {
		return d204d320022;
	}

	/**
	 * 设置 治疗费用总额
	 */
	public void setD204d320022(BigDecimal d204d320022) {
		this.d204d320022 = d204d320022;
	}

	/**
	 * 获取 不符合补偿费用
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320023() {
		return d204d320023;
	}

	/**
	 * 设置 不符合补偿费用
	 */
	public void setD204d320023(BigDecimal d204d320023) {
		this.d204d320023 = d204d320023;
	}

	/**
	 * 获取 医保补偿金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d320024() {
		return d204d320024;
	}

	/**
	 * 设置 医保补偿金额
	 */
	public void setD204d320024(BigDecimal d204d320024) {
		this.d204d320024 = d204d320024;
	}

	/**
	 * 获取 医保补偿时间
	 * @return String
	 */
	public String getD204d320025() {
		return d204d320025;
	}

	/**
	 * 设置 医保补偿时间
	 */
	public void setD204d320025(String d204d320025) {
		this.d204d320025 = d204d320025;
	}

	public String getD204d320026() {
		return d204d320026;
	}

	public void setD204d320026(String d204d320026) {
		this.d204d320026 = d204d320026;
	}

	public String getD204d320027() {
		return d204d320027;
	}

	public void setD204d320027(String d204d320027) {
		this.d204d320027 = d204d320027;
	}

	public String getD204d320028() {
		return d204d320028;
	}

	public void setD204d320028(String d204d320028) {
		this.d204d320028 = d204d320028;
	}

	public String getD204d320029() {
		return d204d320029;
	}

	public void setD204d320029(String d204d320029) {
		this.d204d320029 = d204d320029;
	}

	public String getD204d320030() {
		return d204d320030;
	}

	public void setD204d320030(String d204d320030) {
		this.d204d320030 = d204d320030;
	}

	public String getD204d320031() {
		return d204d320031;
	}

	public void setD204d320031(String d204d320031) {
		this.d204d320031 = d204d320031;
	}

	public String getCompareType() {
		return compareType;
	}

	public void setCompareType(String compareType) {
		this.compareType = compareType;
	}

}