package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 经营性收入databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204B12", keyFields = "d204b12Id")
public class D204b12 extends StatefulDatabean {

	// ID
	private String d204b12Id;

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

	// 从事经工商和劳动部门登记的经营活动的净收入
	private BigDecimal d204b120001;

	// 从事未经工商和劳动部门登记的经营活动的净收入
	private BigDecimal d204b120002;

	// 注册号
	private String d204b120003;

	// 企业名称
	private String d204b120004;

	// 主要负责人姓名
	private String d204b120005;

	// 主要负责人有效身份证号码
	private String d204b120006;

	// 职务
	private String d204b120007;

	// 注册资本
	private BigDecimal d204b120008;

	// 实收资本
	private BigDecimal d204b120009;

	// 经济性质
	private String d204b120010;

	// 经营方式
	private String d204b120011;

	// 经营范围
	private String d204b120012;

	// 发证机关
	private String d204b120013;

	// 发证日期
	private String d204b120014;

	// 成立日期
	private String d204b120015;

	// 营业起始时间
	private String d204b120016;

	// 营业结束时间
	private String d204b120017;

	// 投资人姓名
	private String d204b120018;

	// 投资人有效身份证件号码
	private String d204b120019;

	// 投资人认缴出资额
	private BigDecimal d204b120020;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204b12Id() {
		return d204b12Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204b12Id(String d204b12Id) {
		this.d204b12Id = d204b12Id;
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
	 * 获取 从事经工商和劳动部门登记的经营活动的净收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b120001() {
		return d204b120001;
	}

	/**
	 * 设置 从事经工商和劳动部门登记的经营活动的净收入
	 */
	public void setD204b120001(BigDecimal d204b120001) {
		this.d204b120001 = d204b120001;
	}

	/**
	 * 获取 从事未经工商和劳动部门登记的经营活动的净收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b120002() {
		return d204b120002;
	}

	/**
	 * 设置 从事未经工商和劳动部门登记的经营活动的净收入
	 */
	public void setD204b120002(BigDecimal d204b120002) {
		this.d204b120002 = d204b120002;
	}

	/**
	 * 获取 注册号
	 * @return String
	 */
	public String getD204b120003() {
		return d204b120003;
	}

	/**
	 * 设置 注册号
	 */
	public void setD204b120003(String d204b120003) {
		this.d204b120003 = d204b120003;
	}

	/**
	 * 获取 企业名称
	 * @return String
	 */
	public String getD204b120004() {
		return d204b120004;
	}

	/**
	 * 设置 企业名称
	 */
	public void setD204b120004(String d204b120004) {
		this.d204b120004 = d204b120004;
	}

	/**
	 * 获取 主要负责人姓名
	 * @return String
	 */
	public String getD204b120005() {
		return d204b120005;
	}

	/**
	 * 设置 主要负责人姓名
	 */
	public void setD204b120005(String d204b120005) {
		this.d204b120005 = d204b120005;
	}

	/**
	 * 获取 主要负责人有效身份证号码
	 * @return String
	 */
	public String getD204b120006() {
		return d204b120006;
	}

	/**
	 * 设置 主要负责人有效身份证号码
	 */
	public void setD204b120006(String d204b120006) {
		this.d204b120006 = d204b120006;
	}

	/**
	 * 获取 职务
	 * @return String
	 */
	public String getD204b120007() {
		return d204b120007;
	}

	/**
	 * 设置 职务
	 */
	public void setD204b120007(String d204b120007) {
		this.d204b120007 = d204b120007;
	}

	/**
	 * 获取 注册资本
	 * @return BigDecimal
	 */
	public BigDecimal getD204b120008() {
		return d204b120008;
	}

	/**
	 * 设置 注册资本
	 */
	public void setD204b120008(BigDecimal d204b120008) {
		this.d204b120008 = d204b120008;
	}

	/**
	 * 获取 实收资本
	 * @return BigDecimal
	 */
	public BigDecimal getD204b120009() {
		return d204b120009;
	}

	/**
	 * 设置 实收资本
	 */
	public void setD204b120009(BigDecimal d204b120009) {
		this.d204b120009 = d204b120009;
	}

	/**
	 * 获取 经济性质
	 * @return String
	 */
	public String getD204b120010() {
		return d204b120010;
	}

	/**
	 * 设置 经济性质
	 */
	public void setD204b120010(String d204b120010) {
		this.d204b120010 = d204b120010;
	}

	/**
	 * 获取 经营方式
	 * @return String
	 */
	public String getD204b120011() {
		return d204b120011;
	}

	/**
	 * 设置 经营方式
	 */
	public void setD204b120011(String d204b120011) {
		this.d204b120011 = d204b120011;
	}

	/**
	 * 获取 经营范围
	 * @return String
	 */
	public String getD204b120012() {
		return d204b120012;
	}

	/**
	 * 设置 经营范围
	 */
	public void setD204b120012(String d204b120012) {
		this.d204b120012 = d204b120012;
	}

	/**
	 * 获取 发证机关
	 * @return String
	 */
	public String getD204b120013() {
		return d204b120013;
	}

	/**
	 * 设置 发证机关
	 */
	public void setD204b120013(String d204b120013) {
		this.d204b120013 = d204b120013;
	}

	/**
	 * 获取 发证日期
	 * @return String
	 */
	public String getD204b120014() {
		return d204b120014;
	}

	/**
	 * 设置 发证日期
	 */
	public void setD204b120014(String d204b120014) {
		this.d204b120014 = d204b120014;
	}

	/**
	 * 获取 成立日期
	 * @return String
	 */
	public String getD204b120015() {
		return d204b120015;
	}

	/**
	 * 设置 成立日期
	 */
	public void setD204b120015(String d204b120015) {
		this.d204b120015 = d204b120015;
	}

	/**
	 * 获取 营业起始时间
	 * @return String
	 */
	public String getD204b120016() {
		return d204b120016;
	}

	/**
	 * 设置 营业起始时间
	 */
	public void setD204b120016(String d204b120016) {
		this.d204b120016 = d204b120016;
	}

	/**
	 * 获取 营业结束时间
	 * @return String
	 */
	public String getD204b120017() {
		return d204b120017;
	}

	/**
	 * 设置 营业结束时间
	 */
	public void setD204b120017(String d204b120017) {
		this.d204b120017 = d204b120017;
	}

	/**
	 * 获取 投资人姓名
	 * @return String
	 */
	public String getD204b120018() {
		return d204b120018;
	}

	/**
	 * 设置 投资人姓名
	 */
	public void setD204b120018(String d204b120018) {
		this.d204b120018 = d204b120018;
	}

	/**
	 * 获取 投资人有效身份证件号码
	 * @return String
	 */
	public String getD204b120019() {
		return d204b120019;
	}

	/**
	 * 设置 投资人有效身份证件号码
	 */
	public void setD204b120019(String d204b120019) {
		this.d204b120019 = d204b120019;
	}

	/**
	 * 获取 投资人认缴出资额
	 * @return BigDecimal
	 */
	public BigDecimal getD204b120020() {
		return d204b120020;
	}

	/**
	 * 设置 投资人认缴出资额
	 */
	public void setD204b120020(BigDecimal d204b120020) {
		this.d204b120020 = d204b120020;
	}

}