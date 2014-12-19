package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 救助信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z52", keyFields = "d204z52Id")
public class D204z52 extends StatefulDatabean {

	// ID
	private String d204z52Id;

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

	// 救助业务名称
	private String d204z520001;

	// 救助证号
	private String d204z520002;

	// 救助金额
	private BigDecimal d204z520003;

	// 享受救助待遇开始年月
	private String d204z520004;

	// 享受救助待遇截止年月
	private String d204z520005;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z52Id() {
		return d204z52Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z52Id(String d204z52Id) {
		this.d204z52Id = d204z52Id;
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
	 * 获取 救助业务名称
	 * @return String
	 */
	public String getD204z520001() {
		return d204z520001;
	}

	/**
	 * 设置 救助业务名称
	 */
	public void setD204z520001(String d204z520001) {
		this.d204z520001 = d204z520001;
	}

	/**
	 * 获取 救助证号
	 * @return String
	 */
	public String getD204z520002() {
		return d204z520002;
	}

	/**
	 * 设置 救助证号
	 */
	public void setD204z520002(String d204z520002) {
		this.d204z520002 = d204z520002;
	}

	/**
	 * 获取 救助金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204z520003() {
		return d204z520003;
	}

	/**
	 * 设置 救助金额
	 */
	public void setD204z520003(BigDecimal d204z520003) {
		this.d204z520003 = d204z520003;
	}

	/**
	 * 获取 享受救助待遇开始年月
	 * @return String
	 */
	public String getD204z520004() {
		return d204z520004;
	}

	/**
	 * 设置 享受救助待遇开始年月
	 */
	public void setD204z520004(String d204z520004) {
		this.d204z520004 = d204z520004;
	}

	/**
	 * 获取 享受救助待遇截止年月
	 * @return String
	 */
	public String getD204z520005() {
		return d204z520005;
	}

	/**
	 * 设置 享受救助待遇截止年月
	 */
	public void setD204z520005(String d204z520005) {
		this.d204z520005 = d204z520005;
	}

}