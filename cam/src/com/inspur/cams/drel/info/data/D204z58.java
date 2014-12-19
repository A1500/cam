package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 涉农信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z58", keyFields = "d204z58Id")
public class D204z58 extends StatefulDatabean {

	// ID
	private String d204z58Id;

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

	// 宅基地面积
	private BigDecimal d204z580001;

	// 农用地面积
	private BigDecimal d204z580002;

	// 补贴总金额
	private String d204z580003;

	// 代发银行
	private String d204z580004;

	// 银行卡号
	private String d204z580005;

	// 惠农补贴项目
	private String d204z580006;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z58Id() {
		return d204z58Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z58Id(String d204z58Id) {
		this.d204z58Id = d204z58Id;
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
	 * 获取 宅基地面积
	 * @return BigDecimal
	 */
	public BigDecimal getD204z580001() {
		return d204z580001;
	}

	/**
	 * 设置 宅基地面积
	 */
	public void setD204z580001(BigDecimal d204z580001) {
		this.d204z580001 = d204z580001;
	}

	/**
	 * 获取 农用地面积
	 * @return BigDecimal
	 */
	public BigDecimal getD204z580002() {
		return d204z580002;
	}

	/**
	 * 设置 农用地面积
	 */
	public void setD204z580002(BigDecimal d204z580002) {
		this.d204z580002 = d204z580002;
	}

	/**
	 * 获取 补贴总金额
	 * @return String
	 */
	public String getD204z580003() {
		return d204z580003;
	}

	/**
	 * 设置 补贴总金额
	 */
	public void setD204z580003(String d204z580003) {
		this.d204z580003 = d204z580003;
	}

	/**
	 * 获取 代发银行
	 * @return String
	 */
	public String getD204z580004() {
		return d204z580004;
	}

	/**
	 * 设置 代发银行
	 */
	public void setD204z580004(String d204z580004) {
		this.d204z580004 = d204z580004;
	}

	/**
	 * 获取 银行卡号
	 * @return String
	 */
	public String getD204z580005() {
		return d204z580005;
	}

	/**
	 * 设置 银行卡号
	 */
	public void setD204z580005(String d204z580005) {
		this.d204z580005 = d204z580005;
	}

	/**
	 * 获取 惠农补贴项目
	 * @return String
	 */
	public String getD204z580006() {
		return d204z580006;
	}

	/**
	 * 设置 惠农补贴项目
	 */
	public void setD204z580006(String d204z580006) {
		this.d204z580006 = d204z580006;
	}

}