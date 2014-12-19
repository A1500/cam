package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 婚姻信息databean
 * @author 
 * @date 2014-08-21
 */
@Table(tableName = "D204Z63", keyFields = "d204z63Id")
public class D204z63 extends StatefulDatabean {

	// ID
	private String d204z63Id;

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

	// 户主名称
	private String d204z630001;

	// 户主性别
	private String d204z630002;

	// 户主身份证号
	private String d204z630003;

	// 配偶名称
	private String d204z630004;

	// 配偶身份证号
	private String d204z630005;

	// 登记单位
	private String d204z630006;

	// 登记日期
	private String d204z630007;

	// 登记状态
	private String d204z630008;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z63Id() {
		return d204z63Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z63Id(String d204z63Id) {
		this.d204z63Id = d204z63Id;
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
	 * 获取 户主名称
	 * @return String
	 */
	public String getD204z630001() {
		return d204z630001;
	}

	/**
	 * 设置 户主名称
	 */
	public void setD204z630001(String d204z630001) {
		this.d204z630001 = d204z630001;
	}

	/**
	 * 获取 户主性别
	 * @return String
	 */
	public String getD204z630002() {
		return d204z630002;
	}

	/**
	 * 设置 户主性别
	 */
	public void setD204z630002(String d204z630002) {
		this.d204z630002 = d204z630002;
	}

	/**
	 * 获取 户主身份证号
	 * @return String
	 */
	public String getD204z630003() {
		return d204z630003;
	}

	/**
	 * 设置 户主身份证号
	 */
	public void setD204z630003(String d204z630003) {
		this.d204z630003 = d204z630003;
	}

	/**
	 * 获取 配偶名称
	 * @return String
	 */
	public String getD204z630004() {
		return d204z630004;
	}

	/**
	 * 设置 配偶名称
	 */
	public void setD204z630004(String d204z630004) {
		this.d204z630004 = d204z630004;
	}

	/**
	 * 获取 配偶身份证号
	 * @return String
	 */
	public String getD204z630005() {
		return d204z630005;
	}

	/**
	 * 设置 配偶身份证号
	 */
	public void setD204z630005(String d204z630005) {
		this.d204z630005 = d204z630005;
	}

	/**
	 * 获取 登记单位
	 * @return String
	 */
	public String getD204z630006() {
		return d204z630006;
	}

	/**
	 * 设置 登记单位
	 */
	public void setD204z630006(String d204z630006) {
		this.d204z630006 = d204z630006;
	}

	/**
	 * 获取 登记日期
	 * @return String
	 */
	public String getD204z630007() {
		return d204z630007;
	}

	/**
	 * 设置 登记日期
	 */
	public void setD204z630007(String d204z630007) {
		this.d204z630007 = d204z630007;
	}

	/**
	 * 获取 登记状态
	 * @return String
	 */
	public String getD204z630008() {
		return d204z630008;
	}

	/**
	 * 设置 登记状态
	 */
	public void setD204z630008(String d204z630008) {
		this.d204z630008 = d204z630008;
	}

}