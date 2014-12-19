package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会组织管理信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z54", keyFields = "d204z54Id")
public class D204z54 extends StatefulDatabean {

	// ID
	private String d204z54Id;

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

	// 组织名称
	private String d204z540001;

	// 组织类型
	private String d204z540002;

	// 登记证号
	private String d204z540003;

	// 组织机构代码
	private String d204z540004;

	// 业务主管单位
	private String d204z540005;

	// 登记管理机关
	private String d204z540006;

	// 开办资金
	private BigDecimal d204z540007;

	// 行业分类
	private String d204z540008;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z54Id() {
		return d204z54Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z54Id(String d204z54Id) {
		this.d204z54Id = d204z54Id;
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
	 * 获取 组织名称
	 * @return String
	 */
	public String getD204z540001() {
		return d204z540001;
	}

	/**
	 * 设置 组织名称
	 */
	public void setD204z540001(String d204z540001) {
		this.d204z540001 = d204z540001;
	}

	/**
	 * 获取 组织类型
	 * @return String
	 */
	public String getD204z540002() {
		return d204z540002;
	}

	/**
	 * 设置 组织类型
	 */
	public void setD204z540002(String d204z540002) {
		this.d204z540002 = d204z540002;
	}

	/**
	 * 获取 登记证号
	 * @return String
	 */
	public String getD204z540003() {
		return d204z540003;
	}

	/**
	 * 设置 登记证号
	 */
	public void setD204z540003(String d204z540003) {
		this.d204z540003 = d204z540003;
	}

	/**
	 * 获取 组织机构代码
	 * @return String
	 */
	public String getD204z540004() {
		return d204z540004;
	}

	/**
	 * 设置 组织机构代码
	 */
	public void setD204z540004(String d204z540004) {
		this.d204z540004 = d204z540004;
	}

	/**
	 * 获取 业务主管单位
	 * @return String
	 */
	public String getD204z540005() {
		return d204z540005;
	}

	/**
	 * 设置 业务主管单位
	 */
	public void setD204z540005(String d204z540005) {
		this.d204z540005 = d204z540005;
	}

	/**
	 * 获取 登记管理机关
	 * @return String
	 */
	public String getD204z540006() {
		return d204z540006;
	}

	/**
	 * 设置 登记管理机关
	 */
	public void setD204z540006(String d204z540006) {
		this.d204z540006 = d204z540006;
	}

	/**
	 * 获取 开办资金
	 * @return BigDecimal
	 */
	public BigDecimal getD204z540007() {
		return d204z540007;
	}

	/**
	 * 设置 开办资金
	 */
	public void setD204z540007(BigDecimal d204z540007) {
		this.d204z540007 = d204z540007;
	}

	/**
	 * 获取 行业分类
	 * @return String
	 */
	public String getD204z540008() {
		return d204z540008;
	}

	/**
	 * 设置 行业分类
	 */
	public void setD204z540008(String d204z540008) {
		this.d204z540008 = d204z540008;
	}

}