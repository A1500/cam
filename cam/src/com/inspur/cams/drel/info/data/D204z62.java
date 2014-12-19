package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 殡葬信息databean
 * @author 
 * @date 2014-08-21
 */
@Table(tableName = "D204Z62", keyFields = "d204z62Id")
public class D204z62 extends StatefulDatabean {

	// ID
	private String d204z62Id;

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

	// 逝者名称
	private String d204z620001;

	// 性别
	private String d204z620002;

	// 证件类型
	private String d204z620003;

	// 证件号码
	private String d204z620004;

	// 出生日期
	private String d204z620005;

	// 户口所在地
	private String d204z620006;

	// 死亡日期
	private String d204z620007;

	// 死亡地点
	private String d204z620008;

	// 死亡原因
	private String d204z620009;

	// 单位编码
	private String createOrgan;

	// 单位名称
	private String createOrganName;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z62Id() {
		return d204z62Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z62Id(String d204z62Id) {
		this.d204z62Id = d204z62Id;
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
	 * 获取 逝者名称
	 * @return String
	 */
	public String getD204z620001() {
		return d204z620001;
	}

	/**
	 * 设置 逝者名称
	 */
	public void setD204z620001(String d204z620001) {
		this.d204z620001 = d204z620001;
	}

	/**
	 * 获取 性别
	 * @return String
	 */
	public String getD204z620002() {
		return d204z620002;
	}

	/**
	 * 设置 性别
	 */
	public void setD204z620002(String d204z620002) {
		this.d204z620002 = d204z620002;
	}

	/**
	 * 获取 证件类型
	 * @return String
	 */
	public String getD204z620003() {
		return d204z620003;
	}

	/**
	 * 设置 证件类型
	 */
	public void setD204z620003(String d204z620003) {
		this.d204z620003 = d204z620003;
	}

	/**
	 * 获取 证件号码
	 * @return String
	 */
	public String getD204z620004() {
		return d204z620004;
	}

	/**
	 * 设置 证件号码
	 */
	public void setD204z620004(String d204z620004) {
		this.d204z620004 = d204z620004;
	}

	/**
	 * 获取 出生日期
	 * @return String
	 */
	public String getD204z620005() {
		return d204z620005;
	}

	/**
	 * 设置 出生日期
	 */
	public void setD204z620005(String d204z620005) {
		this.d204z620005 = d204z620005;
	}

	/**
	 * 获取 户口所在地
	 * @return String
	 */
	public String getD204z620006() {
		return d204z620006;
	}

	/**
	 * 设置 户口所在地
	 */
	public void setD204z620006(String d204z620006) {
		this.d204z620006 = d204z620006;
	}

	/**
	 * 获取 死亡日期
	 * @return String
	 */
	public String getD204z620007() {
		return d204z620007;
	}

	/**
	 * 设置 死亡日期
	 */
	public void setD204z620007(String d204z620007) {
		this.d204z620007 = d204z620007;
	}

	/**
	 * 获取 死亡地点
	 * @return String
	 */
	public String getD204z620008() {
		return d204z620008;
	}

	/**
	 * 设置 死亡地点
	 */
	public void setD204z620008(String d204z620008) {
		this.d204z620008 = d204z620008;
	}

	/**
	 * 获取 死亡原因
	 * @return String
	 */
	public String getD204z620009() {
		return d204z620009;
	}

	/**
	 * 设置 死亡原因
	 */
	public void setD204z620009(String d204z620009) {
		this.d204z620009 = d204z620009;
	}

	/**
	 * 获取 单位编码
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 单位编码
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 单位名称
	 * @return String
	 */
	public String getCreateOrganName() {
		return createOrganName;
	}

	/**
	 * 设置 单位名称
	 */
	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

}