package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基金databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204C25", keyFields = "d204c25Id")
public class D204c25 extends StatefulDatabean {

	// ID
	private String d204c25Id;

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

	// 是否开放式
	private String d204c250001;

	// 开放式基金销售机构
	private String d204c250002;

	// 开放式基金总市值
	private BigDecimal d204c250003;

	// 封闭式基金指定交易或计算券商
	private String d204c250004;

	// 封闭式基金总市值
	private BigDecimal d204c250005;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204c25Id() {
		return d204c25Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204c25Id(String d204c25Id) {
		this.d204c25Id = d204c25Id;
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
	 * 获取 是否开放式
	 * @return String
	 */
	public String getD204c250001() {
		return d204c250001;
	}

	/**
	 * 设置 是否开放式
	 */
	public void setD204c250001(String d204c250001) {
		this.d204c250001 = d204c250001;
	}

	/**
	 * 获取 开放式基金销售机构
	 * @return String
	 */
	public String getD204c250002() {
		return d204c250002;
	}

	/**
	 * 设置 开放式基金销售机构
	 */
	public void setD204c250002(String d204c250002) {
		this.d204c250002 = d204c250002;
	}

	/**
	 * 获取 开放式基金总市值
	 * @return BigDecimal
	 */
	public BigDecimal getD204c250003() {
		return d204c250003;
	}

	/**
	 * 设置 开放式基金总市值
	 */
	public void setD204c250003(BigDecimal d204c250003) {
		this.d204c250003 = d204c250003;
	}

	/**
	 * 获取 封闭式基金指定交易或计算券商
	 * @return String
	 */
	public String getD204c250004() {
		return d204c250004;
	}

	/**
	 * 设置 封闭式基金指定交易或计算券商
	 */
	public void setD204c250004(String d204c250004) {
		this.d204c250004 = d204c250004;
	}

	/**
	 * 获取 封闭式基金总市值
	 * @return BigDecimal
	 */
	public BigDecimal getD204c250005() {
		return d204c250005;
	}

	/**
	 * 设置 封闭式基金总市值
	 */
	public void setD204c250005(BigDecimal d204c250005) {
		this.d204c250005 = d204c250005;
	}

}