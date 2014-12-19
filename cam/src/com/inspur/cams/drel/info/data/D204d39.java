package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 地税-投资方纳税信息databean
 * @author 
 * @date 2014-08-26
 */
@Table(tableName = "D204D39", keyFields = "d204d39Id")
public class D204d39 extends StatefulDatabean {

	// ID
	private String d204d39Id;

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

	// 投资人人名称
	private String d204d390001;

	// 投资企业名称
	private String d204d390002;

	// 投资企业税号
	private String d204d390003;

	// 投资企业纳税合计
	private String d204d390004;

	// 投资人个人所得税
	private String d204d390005;

	// 投资比例
	private String d204d390006;

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

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204d39Id() {
		return d204d39Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204d39Id(String d204d39Id) {
		this.d204d39Id = d204d39Id;
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
	 * 获取 投资人人名称
	 * @return String
	 */
	public String getD204d390001() {
		return d204d390001;
	}

	/**
	 * 设置 投资人人名称
	 */
	public void setD204d390001(String d204d390001) {
		this.d204d390001 = d204d390001;
	}

	/**
	 * 获取 投资企业名称
	 * @return String
	 */
	public String getD204d390002() {
		return d204d390002;
	}

	/**
	 * 设置 投资企业名称
	 */
	public void setD204d390002(String d204d390002) {
		this.d204d390002 = d204d390002;
	}

	/**
	 * 获取 投资企业税号
	 * @return String
	 */
	public String getD204d390003() {
		return d204d390003;
	}

	/**
	 * 设置 投资企业税号
	 */
	public void setD204d390003(String d204d390003) {
		this.d204d390003 = d204d390003;
	}

	/**
	 * 获取 投资企业纳税合计
	 * @return String
	 */
	public String getD204d390004() {
		return d204d390004;
	}

	/**
	 * 设置 投资企业纳税合计
	 */
	public void setD204d390004(String d204d390004) {
		this.d204d390004 = d204d390004;
	}

	/**
	 * 获取 投资人个人所得税
	 * @return String
	 */
	public String getD204d390005() {
		return d204d390005;
	}

	/**
	 * 设置 投资人个人所得税
	 */
	public void setD204d390005(String d204d390005) {
		this.d204d390005 = d204d390005;
	}

	/**
	 * 获取 投资比例
	 * @return String
	 */
	public String getD204d390006() {
		return d204d390006;
	}

	/**
	 * 设置 投资比例
	 */
	public void setD204d390006(String d204d390006) {
		this.d204d390006 = d204d390006;
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

}