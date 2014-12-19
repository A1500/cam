package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 优待抚恤信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z55", keyFields = "d204z55Id")
public class D204z55 extends StatefulDatabean {

	// ID
	private String d204z55Id;

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

	// 优抚对象状态
	private String d204z550001;

	// 发放类型
	private String d204z550002;

	// 工资待遇
	private BigDecimal d204z550003;

	// 开始享受待遇年度
	private String d204z550004;

	// 上次发至日期
	private String d204z550005;

	// 本次发至日期
	private String d204z550006;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z55Id() {
		return d204z55Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z55Id(String d204z55Id) {
		this.d204z55Id = d204z55Id;
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
	 * 获取 优抚对象状态
	 * @return String
	 */
	public String getD204z550001() {
		return d204z550001;
	}

	/**
	 * 设置 优抚对象状态
	 */
	public void setD204z550001(String d204z550001) {
		this.d204z550001 = d204z550001;
	}

	/**
	 * 获取 发放类型
	 * @return String
	 */
	public String getD204z550002() {
		return d204z550002;
	}

	/**
	 * 设置 发放类型
	 */
	public void setD204z550002(String d204z550002) {
		this.d204z550002 = d204z550002;
	}

	/**
	 * 获取 工资待遇
	 * @return BigDecimal
	 */
	public BigDecimal getD204z550003() {
		return d204z550003;
	}

	/**
	 * 设置 工资待遇
	 */
	public void setD204z550003(BigDecimal d204z550003) {
		this.d204z550003 = d204z550003;
	}

	/**
	 * 获取 开始享受待遇年度
	 * @return String
	 */
	public String getD204z550004() {
		return d204z550004;
	}

	/**
	 * 设置 开始享受待遇年度
	 */
	public void setD204z550004(String d204z550004) {
		this.d204z550004 = d204z550004;
	}

	/**
	 * 获取 上次发至日期
	 * @return String
	 */
	public String getD204z550005() {
		return d204z550005;
	}

	/**
	 * 设置 上次发至日期
	 */
	public void setD204z550005(String d204z550005) {
		this.d204z550005 = d204z550005;
	}

	/**
	 * 获取 本次发至日期
	 * @return String
	 */
	public String getD204z550006() {
		return d204z550006;
	}

	/**
	 * 设置 本次发至日期
	 */
	public void setD204z550006(String d204z550006) {
		this.d204z550006 = d204z550006;
	}

}