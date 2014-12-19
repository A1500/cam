package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 地税-法人纳税信息databean
 * @author 
 * @date 2014-08-26
 */
@Table(tableName = "D204D37", keyFields = "d204d37Id")
public class D204d37 extends StatefulDatabean {

	// ID
	private String d204d37Id;

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

	// 纳税人名称
	private String d204d370001;

	// 纳税企业名称
	private String d204d370002;

	// 纳税企业税号
	private String d204d370003;

	// 纳税企业纳税合计
	private String d204d370004;

	// 纳税人个人所得税
	private String d204d370005;

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
	public String getD204d37Id() {
		return d204d37Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204d37Id(String d204d37Id) {
		this.d204d37Id = d204d37Id;
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
	 * 获取 纳税人名称
	 * @return String
	 */
	public String getD204d370001() {
		return d204d370001;
	}

	/**
	 * 设置 纳税人名称
	 */
	public void setD204d370001(String d204d370001) {
		this.d204d370001 = d204d370001;
	}

	/**
	 * 获取 纳税企业名称
	 * @return String
	 */
	public String getD204d370002() {
		return d204d370002;
	}

	/**
	 * 设置 纳税企业名称
	 */
	public void setD204d370002(String d204d370002) {
		this.d204d370002 = d204d370002;
	}

	/**
	 * 获取 纳税企业税号
	 * @return String
	 */
	public String getD204d370003() {
		return d204d370003;
	}

	/**
	 * 设置 纳税企业税号
	 */
	public void setD204d370003(String d204d370003) {
		this.d204d370003 = d204d370003;
	}

	/**
	 * 获取 纳税企业纳税合计
	 * @return String
	 */
	public String getD204d370004() {
		return d204d370004;
	}

	/**
	 * 设置 纳税企业纳税合计
	 */
	public void setD204d370004(String d204d370004) {
		this.d204d370004 = d204d370004;
	}

	/**
	 * 获取 纳税人个人所得税
	 * @return String
	 */
	public String getD204d370005() {
		return d204d370005;
	}

	/**
	 * 设置 纳税人个人所得税
	 */
	public void setD204d370005(String d204d370005) {
		this.d204d370005 = d204d370005;
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