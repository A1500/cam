package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 教育信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z51", keyFields = "d204z51Id")
public class D204z51 extends StatefulDatabean {

	// ID
	private String d204z51Id;

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

	// 学校名称
	private String d204z510001;

	// 文化程度
	private String d204z510002;

	// 学业状况
	private String d204z510003;

	// 入学时间
	private String d204z510004;

	// 毕业时间
	private String d204z510005;

	// 助学原因
	private String d204z510006;

	// 助学机构名称
	private String d204z510007;

	// 助学时间
	private String d204z510008;

	// 助学金额
	private BigDecimal d204z510009;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z51Id() {
		return d204z51Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z51Id(String d204z51Id) {
		this.d204z51Id = d204z51Id;
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
	 * 获取 学校名称
	 * @return String
	 */
	public String getD204z510001() {
		return d204z510001;
	}

	/**
	 * 设置 学校名称
	 */
	public void setD204z510001(String d204z510001) {
		this.d204z510001 = d204z510001;
	}

	/**
	 * 获取 文化程度
	 * @return String
	 */
	public String getD204z510002() {
		return d204z510002;
	}

	/**
	 * 设置 文化程度
	 */
	public void setD204z510002(String d204z510002) {
		this.d204z510002 = d204z510002;
	}

	/**
	 * 获取 学业状况
	 * @return String
	 */
	public String getD204z510003() {
		return d204z510003;
	}

	/**
	 * 设置 学业状况
	 */
	public void setD204z510003(String d204z510003) {
		this.d204z510003 = d204z510003;
	}

	/**
	 * 获取 入学时间
	 * @return String
	 */
	public String getD204z510004() {
		return d204z510004;
	}

	/**
	 * 设置 入学时间
	 */
	public void setD204z510004(String d204z510004) {
		this.d204z510004 = d204z510004;
	}

	/**
	 * 获取 毕业时间
	 * @return String
	 */
	public String getD204z510005() {
		return d204z510005;
	}

	/**
	 * 设置 毕业时间
	 */
	public void setD204z510005(String d204z510005) {
		this.d204z510005 = d204z510005;
	}

	/**
	 * 获取 助学原因
	 * @return String
	 */
	public String getD204z510006() {
		return d204z510006;
	}

	/**
	 * 设置 助学原因
	 */
	public void setD204z510006(String d204z510006) {
		this.d204z510006 = d204z510006;
	}

	/**
	 * 获取 助学机构名称
	 * @return String
	 */
	public String getD204z510007() {
		return d204z510007;
	}

	/**
	 * 设置 助学机构名称
	 */
	public void setD204z510007(String d204z510007) {
		this.d204z510007 = d204z510007;
	}

	/**
	 * 获取 助学时间
	 * @return String
	 */
	public String getD204z510008() {
		return d204z510008;
	}

	/**
	 * 设置 助学时间
	 */
	public void setD204z510008(String d204z510008) {
		this.d204z510008 = d204z510008;
	}

	/**
	 * 获取 助学金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204z510009() {
		return d204z510009;
	}

	/**
	 * 设置 助学金额
	 */
	public void setD204z510009(BigDecimal d204z510009) {
		this.d204z510009 = d204z510009;
	}

}