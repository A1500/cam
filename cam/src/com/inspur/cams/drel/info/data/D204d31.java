package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公共事业缴费databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204D31", keyFields = "d204d31Id")
public class D204d31 extends StatefulDatabean {

	// ID
	private String d204d31Id;

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

	// 缴费项目
	private String d204d310001;

	// 缴费金额
	private BigDecimal d204d310002;

	// 缴费时间
	private String d204d310003;

	// 缴费人
	private String d204d310004;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204d31Id() {
		return d204d31Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204d31Id(String d204d31Id) {
		this.d204d31Id = d204d31Id;
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
	 * 获取 缴费项目
	 * @return String
	 */
	public String getD204d310001() {
		return d204d310001;
	}

	/**
	 * 设置 缴费项目
	 */
	public void setD204d310001(String d204d310001) {
		this.d204d310001 = d204d310001;
	}

	/**
	 * 获取 缴费金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d310002() {
		return d204d310002;
	}

	/**
	 * 设置 缴费金额
	 */
	public void setD204d310002(BigDecimal d204d310002) {
		this.d204d310002 = d204d310002;
	}

	/**
	 * 获取 缴费时间
	 * @return String
	 */
	public String getD204d310003() {
		return d204d310003;
	}

	/**
	 * 设置 缴费时间
	 */
	public void setD204d310003(String d204d310003) {
		this.d204d310003 = d204d310003;
	}

	/**
	 * 获取 缴费人
	 * @return String
	 */
	public String getD204d310004() {
		return d204d310004;
	}

	/**
	 * 设置 缴费人
	 */
	public void setD204d310004(String d204d310004) {
		this.d204d310004 = d204d310004;
	}

}