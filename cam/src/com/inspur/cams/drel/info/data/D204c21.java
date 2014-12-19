package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 车辆databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204C21", keyFields = "d204c21Id")
public class D204c21 extends StatefulDatabean {

	// ID
	private String d204c21Id;

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

	// 车辆品牌名称
	private String d204c210001;

	// 车牌号码
	private String d204c210002;

	// 车辆现值
	private BigDecimal d204c210003;

	// 机动车类型
	private String d204c210004;

	// 初次登记日期
	private String d204c210005;

	// 机动车登记原值
	private BigDecimal d204c210006;

	// 使用性质
	private String d204c210007;

	// 检验有效日期
	private String d204c210008;

	// 所有人变更情况
	private String d204c210009;

	// 车辆购值
	private BigDecimal d204c210010;

	// 购置时间
	private String d204c210011;

	// 用途
	private String d204c210012;

	// 使用状态
	private String d204c210013;

	// 车辆所有人
	private BigDecimal d204c210014;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204c21Id() {
		return d204c21Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204c21Id(String d204c21Id) {
		this.d204c21Id = d204c21Id;
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
	 * 获取 车辆品牌名称
	 * @return String
	 */
	public String getD204c210001() {
		return d204c210001;
	}

	/**
	 * 设置 车辆品牌名称
	 */
	public void setD204c210001(String d204c210001) {
		this.d204c210001 = d204c210001;
	}

	/**
	 * 获取 车牌号码
	 * @return String
	 */
	public String getD204c210002() {
		return d204c210002;
	}

	/**
	 * 设置 车牌号码
	 */
	public void setD204c210002(String d204c210002) {
		this.d204c210002 = d204c210002;
	}

	/**
	 * 获取 车辆现值
	 * @return BigDecimal
	 */
	public BigDecimal getD204c210003() {
		return d204c210003;
	}

	/**
	 * 设置 车辆现值
	 */
	public void setD204c210003(BigDecimal d204c210003) {
		this.d204c210003 = d204c210003;
	}

	/**
	 * 获取 机动车类型
	 * @return String
	 */
	public String getD204c210004() {
		return d204c210004;
	}

	/**
	 * 设置 机动车类型
	 */
	public void setD204c210004(String d204c210004) {
		this.d204c210004 = d204c210004;
	}

	/**
	 * 获取 初次登记日期
	 * @return String
	 */
	public String getD204c210005() {
		return d204c210005;
	}

	/**
	 * 设置 初次登记日期
	 */
	public void setD204c210005(String d204c210005) {
		this.d204c210005 = d204c210005;
	}

	/**
	 * 获取 机动车登记原值
	 * @return BigDecimal
	 */
	public BigDecimal getD204c210006() {
		return d204c210006;
	}

	/**
	 * 设置 机动车登记原值
	 */
	public void setD204c210006(BigDecimal d204c210006) {
		this.d204c210006 = d204c210006;
	}

	/**
	 * 获取 使用性质
	 * @return String
	 */
	public String getD204c210007() {
		return d204c210007;
	}

	/**
	 * 设置 使用性质
	 */
	public void setD204c210007(String d204c210007) {
		this.d204c210007 = d204c210007;
	}

	/**
	 * 获取 检验有效日期
	 * @return String
	 */
	public String getD204c210008() {
		return d204c210008;
	}

	/**
	 * 设置 检验有效日期
	 */
	public void setD204c210008(String d204c210008) {
		this.d204c210008 = d204c210008;
	}

	/**
	 * 获取 所有人变更情况
	 * @return String
	 */
	public String getD204c210009() {
		return d204c210009;
	}

	/**
	 * 设置 所有人变更情况
	 */
	public void setD204c210009(String d204c210009) {
		this.d204c210009 = d204c210009;
	}

	/**
	 * 获取 车辆购值
	 * @return BigDecimal
	 */
	public BigDecimal getD204c210010() {
		return d204c210010;
	}

	/**
	 * 设置 车辆购值
	 */
	public void setD204c210010(BigDecimal d204c210010) {
		this.d204c210010 = d204c210010;
	}

	/**
	 * 获取 购置时间
	 * @return String
	 */
	public String getD204c210011() {
		return d204c210011;
	}

	/**
	 * 设置 购置时间
	 */
	public void setD204c210011(String d204c210011) {
		this.d204c210011 = d204c210011;
	}

	/**
	 * 获取 用途
	 * @return String
	 */
	public String getD204c210012() {
		return d204c210012;
	}

	/**
	 * 设置 用途
	 */
	public void setD204c210012(String d204c210012) {
		this.d204c210012 = d204c210012;
	}

	/**
	 * 获取 使用状态
	 * @return String
	 */
	public String getD204c210013() {
		return d204c210013;
	}

	/**
	 * 设置 使用状态
	 */
	public void setD204c210013(String d204c210013) {
		this.d204c210013 = d204c210013;
	}

	/**
	 * 获取 车辆所有人
	 * @return BigDecimal
	 */
	public BigDecimal getD204c210014() {
		return d204c210014;
	}

	/**
	 * 设置 车辆所有人
	 */
	public void setD204c210014(BigDecimal d204c210014) {
		this.d204c210014 = d204c210014;
	}

}