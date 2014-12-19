package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 司法援助信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z53", keyFields = "d204z53Id")
public class D204z53 extends StatefulDatabean {

	// ID
	private String d204z53Id;

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

	// 援助原因
	private String d204z530001;

	// 援助形式
	private String d204z530002;

	// 援助机构
	private String d204z530003;

	// 援助时间
	private String d204z530004;

	// 援助内容
	private String d204z530005;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z53Id() {
		return d204z53Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z53Id(String d204z53Id) {
		this.d204z53Id = d204z53Id;
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
	 * 获取 援助原因
	 * @return String
	 */
	public String getD204z530001() {
		return d204z530001;
	}

	/**
	 * 设置 援助原因
	 */
	public void setD204z530001(String d204z530001) {
		this.d204z530001 = d204z530001;
	}

	/**
	 * 获取 援助形式
	 * @return String
	 */
	public String getD204z530002() {
		return d204z530002;
	}

	/**
	 * 设置 援助形式
	 */
	public void setD204z530002(String d204z530002) {
		this.d204z530002 = d204z530002;
	}

	/**
	 * 获取 援助机构
	 * @return String
	 */
	public String getD204z530003() {
		return d204z530003;
	}

	/**
	 * 设置 援助机构
	 */
	public void setD204z530003(String d204z530003) {
		this.d204z530003 = d204z530003;
	}

	/**
	 * 获取 援助时间
	 * @return String
	 */
	public String getD204z530004() {
		return d204z530004;
	}

	/**
	 * 设置 援助时间
	 */
	public void setD204z530004(String d204z530004) {
		this.d204z530004 = d204z530004;
	}

	/**
	 * 获取 援助内容
	 * @return String
	 */
	public String getD204z530005() {
		return d204z530005;
	}

	/**
	 * 设置 援助内容
	 */
	public void setD204z530005(String d204z530005) {
		this.d204z530005 = d204z530005;
	}

}