package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 家庭成员就业信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204A02", keyFields = "d204a02Id")
public class D204a02 extends StatefulDatabean {

	// ID
	private String d204a02Id;

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

	// 就业状态
	private String d204a020001;

	// 工作单位
	private String d204a020002;

	// 单位所属类别
	private String d204a020003;

	// 单位所属行业
	private String d204a020004;

	// 报告就业状态起始年月
	private String d204a020005;

	// 报告就业状态截至年月
	private String d204a020006;

	// 单位性质
	private String d204a020007;

	// 单位隶属关系
	private String d204a020008;

	// 单位通信地址
	private String d204a020009;

	// 单位联系电话号码
	private String d204a020010;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204a02Id() {
		return d204a02Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204a02Id(String d204a02Id) {
		this.d204a02Id = d204a02Id;
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
	 * 获取 就业状态
	 * @return String
	 */
	public String getD204a020001() {
		return d204a020001;
	}

	/**
	 * 设置 就业状态
	 */
	public void setD204a020001(String d204a020001) {
		this.d204a020001 = d204a020001;
	}

	/**
	 * 获取 工作单位
	 * @return String
	 */
	public String getD204a020002() {
		return d204a020002;
	}

	/**
	 * 设置 工作单位
	 */
	public void setD204a020002(String d204a020002) {
		this.d204a020002 = d204a020002;
	}

	/**
	 * 获取 单位所属类别
	 * @return String
	 */
	public String getD204a020003() {
		return d204a020003;
	}

	/**
	 * 设置 单位所属类别
	 */
	public void setD204a020003(String d204a020003) {
		this.d204a020003 = d204a020003;
	}

	/**
	 * 获取 单位所属行业
	 * @return String
	 */
	public String getD204a020004() {
		return d204a020004;
	}

	/**
	 * 设置 单位所属行业
	 */
	public void setD204a020004(String d204a020004) {
		this.d204a020004 = d204a020004;
	}

	/**
	 * 获取 报告就业状态起始年月
	 * @return String
	 */
	public String getD204a020005() {
		return d204a020005;
	}

	/**
	 * 设置 报告就业状态起始年月
	 */
	public void setD204a020005(String d204a020005) {
		this.d204a020005 = d204a020005;
	}

	/**
	 * 获取 报告就业状态截至年月
	 * @return String
	 */
	public String getD204a020006() {
		return d204a020006;
	}

	/**
	 * 设置 报告就业状态截至年月
	 */
	public void setD204a020006(String d204a020006) {
		this.d204a020006 = d204a020006;
	}

	/**
	 * 获取 单位性质
	 * @return String
	 */
	public String getD204a020007() {
		return d204a020007;
	}

	/**
	 * 设置 单位性质
	 */
	public void setD204a020007(String d204a020007) {
		this.d204a020007 = d204a020007;
	}

	/**
	 * 获取 单位隶属关系
	 * @return String
	 */
	public String getD204a020008() {
		return d204a020008;
	}

	/**
	 * 设置 单位隶属关系
	 */
	public void setD204a020008(String d204a020008) {
		this.d204a020008 = d204a020008;
	}

	/**
	 * 获取 单位通信地址
	 * @return String
	 */
	public String getD204a020009() {
		return d204a020009;
	}

	/**
	 * 设置 单位通信地址
	 */
	public void setD204a020009(String d204a020009) {
		this.d204a020009 = d204a020009;
	}

	/**
	 * 获取 单位联系电话号码
	 * @return String
	 */
	public String getD204a020010() {
		return d204a020010;
	}

	/**
	 * 设置 单位联系电话号码
	 */
	public void setD204a020010(String d204a020010) {
		this.d204a020010 = d204a020010;
	}

}