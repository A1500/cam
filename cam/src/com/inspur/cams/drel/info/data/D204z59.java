package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 新农合信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z59", keyFields = "d204z59Id")
public class D204z59 extends StatefulDatabean {

	// ID
	private String d204z59Id;

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

	// 入院时间
	private String d204z590001;

	// 出院时间
	private String d204z590002;

	// 诊治医院
	private String d204z590003;

	// 治疗费用总额
	private BigDecimal d204z590004;

	// 不符合补偿费用
	private BigDecimal d204z590005;

	// 补偿金额
	private BigDecimal d204z590006;

	// 补偿时间
	private String d204z590007;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z59Id() {
		return d204z59Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z59Id(String d204z59Id) {
		this.d204z59Id = d204z59Id;
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
	 * 获取 入院时间
	 * @return String
	 */
	public String getD204z590001() {
		return d204z590001;
	}

	/**
	 * 设置 入院时间
	 */
	public void setD204z590001(String d204z590001) {
		this.d204z590001 = d204z590001;
	}

	/**
	 * 获取 出院时间
	 * @return String
	 */
	public String getD204z590002() {
		return d204z590002;
	}

	/**
	 * 设置 出院时间
	 */
	public void setD204z590002(String d204z590002) {
		this.d204z590002 = d204z590002;
	}

	/**
	 * 获取 诊治医院
	 * @return String
	 */
	public String getD204z590003() {
		return d204z590003;
	}

	/**
	 * 设置 诊治医院
	 */
	public void setD204z590003(String d204z590003) {
		this.d204z590003 = d204z590003;
	}

	/**
	 * 获取 治疗费用总额
	 * @return BigDecimal
	 */
	public BigDecimal getD204z590004() {
		return d204z590004;
	}

	/**
	 * 设置 治疗费用总额
	 */
	public void setD204z590004(BigDecimal d204z590004) {
		this.d204z590004 = d204z590004;
	}

	/**
	 * 获取 不符合补偿费用
	 * @return BigDecimal
	 */
	public BigDecimal getD204z590005() {
		return d204z590005;
	}

	/**
	 * 设置 不符合补偿费用
	 */
	public void setD204z590005(BigDecimal d204z590005) {
		this.d204z590005 = d204z590005;
	}

	/**
	 * 获取 补偿金额
	 * @return BigDecimal
	 */
	public BigDecimal getD204z590006() {
		return d204z590006;
	}

	/**
	 * 设置 补偿金额
	 */
	public void setD204z590006(BigDecimal d204z590006) {
		this.d204z590006 = d204z590006;
	}

	/**
	 * 获取 补偿时间
	 * @return String
	 */
	public String getD204z590007() {
		return d204z590007;
	}

	/**
	 * 设置 补偿时间
	 */
	public void setD204z590007(String d204z590007) {
		this.d204z590007 = d204z590007;
	}

}