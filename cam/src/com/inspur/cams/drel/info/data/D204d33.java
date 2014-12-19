package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 纳税情况databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204D33", keyFields = "d204d33Id")
public class D204d33 extends StatefulDatabean {

	// ID
	private String d204d33Id;

	// 纳税人名称
	private String d204d330001;

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

	// 纳税人企业名称
	private String d204d330002;

	// 纳税人单位注册地址
	private String d204d330003;

	// 纳税人单位经营地址
	private String d204d330004;

	// 纳税人单位联系电话
	private String d204d330005;

	// 申报日期
	private String d204d330006;

	// 税种
	private String d204d330007;

	// 税目
	private String d204d330008;

	// 收入
	private BigDecimal d204d330009;

	// 税额
	private BigDecimal d204d330010;

	// 税务登记证号
	private String d204d330011;

	// 税务登记类型
	private String d204d330012;

	// 纳税人企业编号
	private String d204d330013;

	// 征税机构
	private String d204d330014;

	// 免税收入
	private BigDecimal d204d330015;

	// 纳税人状态
	private String d204d330016;

	// 注册资本
	private String d204d330017;
	
	public String getD204d330017() {
		return d204d330017;
	}

	public void setD204d330017(String d204d330017) {
		this.d204d330017 = d204d330017;
	}

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204d33Id() {
		return d204d33Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204d33Id(String d204d33Id) {
		this.d204d33Id = d204d33Id;
	}

	/**
	 * 获取 纳税人名称
	 * @return String
	 */
	public String getD204d330001() {
		return d204d330001;
	}

	/**
	 * 设置 纳税人名称
	 */
	public void setD204d330001(String d204d330001) {
		this.d204d330001 = d204d330001;
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
	 * 获取 纳税人企业名称
	 * @return String
	 */
	public String getD204d330002() {
		return d204d330002;
	}

	/**
	 * 设置 纳税人企业名称
	 */
	public void setD204d330002(String d204d330002) {
		this.d204d330002 = d204d330002;
	}

	/**
	 * 获取 纳税人单位注册地址
	 * @return String
	 */
	public String getD204d330003() {
		return d204d330003;
	}

	/**
	 * 设置 纳税人单位注册地址
	 */
	public void setD204d330003(String d204d330003) {
		this.d204d330003 = d204d330003;
	}

	/**
	 * 获取 纳税人单位经营地址
	 * @return String
	 */
	public String getD204d330004() {
		return d204d330004;
	}

	/**
	 * 设置 纳税人单位经营地址
	 */
	public void setD204d330004(String d204d330004) {
		this.d204d330004 = d204d330004;
	}

	/**
	 * 获取 纳税人单位联系电话
	 * @return String
	 */
	public String getD204d330005() {
		return d204d330005;
	}

	/**
	 * 设置 纳税人单位联系电话
	 */
	public void setD204d330005(String d204d330005) {
		this.d204d330005 = d204d330005;
	}

	/**
	 * 获取 申报日期
	 * @return String
	 */
	public String getD204d330006() {
		return d204d330006;
	}

	/**
	 * 设置 申报日期
	 */
	public void setD204d330006(String d204d330006) {
		this.d204d330006 = d204d330006;
	}

	/**
	 * 获取 税种
	 * @return String
	 */
	public String getD204d330007() {
		return d204d330007;
	}

	/**
	 * 设置 税种
	 */
	public void setD204d330007(String d204d330007) {
		this.d204d330007 = d204d330007;
	}

	/**
	 * 获取 税目
	 * @return String
	 */
	public String getD204d330008() {
		return d204d330008;
	}

	/**
	 * 设置 税目
	 */
	public void setD204d330008(String d204d330008) {
		this.d204d330008 = d204d330008;
	}

	/**
	 * 获取 收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204d330009() {
		return d204d330009;
	}

	/**
	 * 设置 收入
	 */
	public void setD204d330009(BigDecimal d204d330009) {
		this.d204d330009 = d204d330009;
	}

	/**
	 * 获取 税额
	 * @return BigDecimal
	 */
	public BigDecimal getD204d330010() {
		return d204d330010;
	}

	/**
	 * 设置 税额
	 */
	public void setD204d330010(BigDecimal d204d330010) {
		this.d204d330010 = d204d330010;
	}

	/**
	 * 获取 税务登记证号
	 * @return String
	 */
	public String getD204d330011() {
		return d204d330011;
	}

	/**
	 * 设置 税务登记证号
	 */
	public void setD204d330011(String d204d330011) {
		this.d204d330011 = d204d330011;
	}

	/**
	 * 获取 税务登记类型
	 * @return String
	 */
	public String getD204d330012() {
		return d204d330012;
	}

	/**
	 * 设置 税务登记类型
	 */
	public void setD204d330012(String d204d330012) {
		this.d204d330012 = d204d330012;
	}

	/**
	 * 获取 纳税人企业编号
	 * @return String
	 */
	public String getD204d330013() {
		return d204d330013;
	}

	/**
	 * 设置 纳税人企业编号
	 */
	public void setD204d330013(String d204d330013) {
		this.d204d330013 = d204d330013;
	}

	/**
	 * 获取 征税机构
	 * @return String
	 */
	public String getD204d330014() {
		return d204d330014;
	}

	/**
	 * 设置 征税机构
	 */
	public void setD204d330014(String d204d330014) {
		this.d204d330014 = d204d330014;
	}

	/**
	 * 获取 免税收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204d330015() {
		return d204d330015;
	}

	/**
	 * 设置 免税收入
	 */
	public void setD204d330015(BigDecimal d204d330015) {
		this.d204d330015 = d204d330015;
	}

	/**
	 * 获取 纳税人状态
	 * @return String
	 */
	public String getD204d330016() {
		return d204d330016;
	}

	/**
	 * 设置 纳税人状态
	 */
	public void setD204d330016(String d204d330016) {
		this.d204d330016 = d204d330016;
	}

}