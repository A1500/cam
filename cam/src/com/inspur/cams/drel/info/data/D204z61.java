package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 船舶信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z61", keyFields = "d204z61Id")
public class D204z61 extends StatefulDatabean {

	// ID
	private String d204z61Id;

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

	// 共有人
	private String d204z610001;

	// 共有人证件号码
	private String d204z610002;

	// 船名号
	private String d204z610003;

	// 船籍港
	private String d204z610004;

	// 所有权登记证书编号
	private String d204z610005;

	// 船舶用途
	private String d204z610006;

	// 总吨位
	private BigDecimal d204z610007;

	// 主机功率
	private String d204z610008;

	// 财产估价(万元)
	private BigDecimal d204z610009;

	// 取得所有权日期
	private String d204z610010;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z61Id() {
		return d204z61Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z61Id(String d204z61Id) {
		this.d204z61Id = d204z61Id;
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
	 * 获取 共有人
	 * @return String
	 */
	public String getD204z610001() {
		return d204z610001;
	}

	/**
	 * 设置 共有人
	 */
	public void setD204z610001(String d204z610001) {
		this.d204z610001 = d204z610001;
	}

	/**
	 * 获取 共有人证件号码
	 * @return String
	 */
	public String getD204z610002() {
		return d204z610002;
	}

	/**
	 * 设置 共有人证件号码
	 */
	public void setD204z610002(String d204z610002) {
		this.d204z610002 = d204z610002;
	}

	/**
	 * 获取 船名号
	 * @return String
	 */
	public String getD204z610003() {
		return d204z610003;
	}

	/**
	 * 设置 船名号
	 */
	public void setD204z610003(String d204z610003) {
		this.d204z610003 = d204z610003;
	}

	/**
	 * 获取 船籍港
	 * @return String
	 */
	public String getD204z610004() {
		return d204z610004;
	}

	/**
	 * 设置 船籍港
	 */
	public void setD204z610004(String d204z610004) {
		this.d204z610004 = d204z610004;
	}

	/**
	 * 获取 所有权登记证书编号
	 * @return String
	 */
	public String getD204z610005() {
		return d204z610005;
	}

	/**
	 * 设置 所有权登记证书编号
	 */
	public void setD204z610005(String d204z610005) {
		this.d204z610005 = d204z610005;
	}

	/**
	 * 获取 船舶用途
	 * @return String
	 */
	public String getD204z610006() {
		return d204z610006;
	}

	/**
	 * 设置 船舶用途
	 */
	public void setD204z610006(String d204z610006) {
		this.d204z610006 = d204z610006;
	}

	/**
	 * 获取 总吨位
	 * @return BigDecimal
	 */
	public BigDecimal getD204z610007() {
		return d204z610007;
	}

	/**
	 * 设置 总吨位
	 */
	public void setD204z610007(BigDecimal d204z610007) {
		this.d204z610007 = d204z610007;
	}

	/**
	 * 获取 主机功率
	 * @return String
	 */
	public String getD204z610008() {
		return d204z610008;
	}

	/**
	 * 设置 主机功率
	 */
	public void setD204z610008(String d204z610008) {
		this.d204z610008 = d204z610008;
	}

	/**
	 * 获取 财产估价(万元)
	 * @return BigDecimal
	 */
	public BigDecimal getD204z610009() {
		return d204z610009;
	}

	/**
	 * 设置 财产估价(万元)
	 */
	public void setD204z610009(BigDecimal d204z610009) {
		this.d204z610009 = d204z610009;
	}

	/**
	 * 获取 取得所有权日期
	 * @return String
	 */
	public String getD204z610010() {
		return d204z610010;
	}

	/**
	 * 设置 取得所有权日期
	 */
	public void setD204z610010(String d204z610010) {
		this.d204z610010 = d204z610010;
	}

}