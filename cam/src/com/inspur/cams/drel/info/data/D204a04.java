package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 区划信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204A04", keyFields = "d204a04Id")
public class D204a04 extends StatefulDatabean {

	// ID
	private String d204a04Id;

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

	// 行政区划代码
	private String d204a040001;

	// 行政区划名称
	private String d204a040002;

	// 行政区划非农业人口数量
	private BigDecimal d204a040003;

	// 行政区划农业人口数量
	private BigDecimal d204a040004;

	// 发出查询核对机构所在行政区划
	private String d204a040005;

	// 信息反馈单位所在行政区划
	private String d204a040006;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204a04Id() {
		return d204a04Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204a04Id(String d204a04Id) {
		this.d204a04Id = d204a04Id;
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
	 * 获取 行政区划代码
	 * @return String
	 */
	public String getD204a040001() {
		return d204a040001;
	}

	/**
	 * 设置 行政区划代码
	 */
	public void setD204a040001(String d204a040001) {
		this.d204a040001 = d204a040001;
	}

	/**
	 * 获取 行政区划名称
	 * @return String
	 */
	public String getD204a040002() {
		return d204a040002;
	}

	/**
	 * 设置 行政区划名称
	 */
	public void setD204a040002(String d204a040002) {
		this.d204a040002 = d204a040002;
	}

	/**
	 * 获取 行政区划非农业人口数量
	 * @return BigDecimal
	 */
	public BigDecimal getD204a040003() {
		return d204a040003;
	}

	/**
	 * 设置 行政区划非农业人口数量
	 */
	public void setD204a040003(BigDecimal d204a040003) {
		this.d204a040003 = d204a040003;
	}

	/**
	 * 获取 行政区划农业人口数量
	 * @return BigDecimal
	 */
	public BigDecimal getD204a040004() {
		return d204a040004;
	}

	/**
	 * 设置 行政区划农业人口数量
	 */
	public void setD204a040004(BigDecimal d204a040004) {
		this.d204a040004 = d204a040004;
	}

	/**
	 * 获取 发出查询核对机构所在行政区划
	 * @return String
	 */
	public String getD204a040005() {
		return d204a040005;
	}

	/**
	 * 设置 发出查询核对机构所在行政区划
	 */
	public void setD204a040005(String d204a040005) {
		this.d204a040005 = d204a040005;
	}

	/**
	 * 获取 信息反馈单位所在行政区划
	 * @return String
	 */
	public String getD204a040006() {
		return d204a040006;
	}

	/**
	 * 设置 信息反馈单位所在行政区划
	 */
	public void setD204a040006(String d204a040006) {
		this.d204a040006 = d204a040006;
	}

}