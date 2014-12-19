package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 商业保险databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204C26", keyFields = "d204c26Id")
public class D204c26 extends StatefulDatabean {

	// ID
	private String d204c26Id;

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

	// 商业保险名称
	private String d204c260001;

	// 商业保险总市值
	private BigDecimal d204c260002;

	// 商业保险公司名称
	private String d204c260003;

	// 保险缴纳金额
	private BigDecimal d204c260004;

	// 末次缴费时间
	private String d204c260005;

	// 领取时间
	private String d204c260006;

	// 领取金额
	private BigDecimal d204c260007;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204c26Id() {
		return d204c26Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204c26Id(String d204c26Id) {
		this.d204c26Id = d204c26Id;
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
	 * 获取 商业保险名称
	 * @return String
	 */
	public String getD204c260001() {
		return d204c260001;
	}

	/**
	 * 设置 商业保险名称
	 */
	public void setD204c260001(String d204c260001) {
		this.d204c260001 = d204c260001;
	}

	/**
	 * 获取 商业保险总市值
	 * @return BigDecimal
	 */
	public BigDecimal getD204c260002() {
		return d204c260002;
	}

	/**
	 * 设置 商业保险总市值
	 */
	public void setD204c260002(BigDecimal d204c260002) {
		this.d204c260002 = d204c260002;
	}

	/**
	 * 获取 商业保险公司名称
	 * @return String
	 */
	public String getD204c260003() {
		return d204c260003;
	}

	/**
	 * 设置 商业保险公司名称
	 */
	public void setD204c260003(String d204c260003) {
		this.d204c260003 = d204c260003;
	}

	/**
	 * 获取 保险缴纳金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204c260004() {
		return d204c260004;
	}

	/**
	 * 设置 保险缴纳金额
	 */
	public void setD204c260004(BigDecimal d204c260004) {
		this.d204c260004 = d204c260004;
	}

	/**
	 * 获取 末次缴费时间
	 * @return String
	 */
	public String getD204c260005() {
		return d204c260005;
	}

	/**
	 * 设置 末次缴费时间
	 */
	public void setD204c260005(String d204c260005) {
		this.d204c260005 = d204c260005;
	}

	/**
	 * 获取 领取时间
	 * @return String
	 */
	public String getD204c260006() {
		return d204c260006;
	}

	/**
	 * 设置 领取时间
	 */
	public void setD204c260006(String d204c260006) {
		this.d204c260006 = d204c260006;
	}

	/**
	 * 获取 领取金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204c260007() {
		return d204c260007;
	}

	/**
	 * 设置 领取金额
	 */
	public void setD204c260007(BigDecimal d204c260007) {
		this.d204c260007 = d204c260007;
	}

}