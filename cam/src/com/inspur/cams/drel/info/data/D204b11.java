package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 工资性收入databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204B11", keyFields = "d204b11Id")
public class D204b11 extends StatefulDatabean {

	// ID
	private String d204b11Id;

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

	// 工资性收入
	private BigDecimal d204b110001;

	// 奖金收入
	private BigDecimal d204b110002;

	// 补贴收入
	private BigDecimal d204b110003;

	// 加班收入
	private BigDecimal d204b110004;

	// 第二职业收入
	private BigDecimal d204b110005;

	// 兼职收入
	private BigDecimal d204b110006;

	// 零星劳动收入
	private BigDecimal d204b110007;

	// 从事农副业成产获得的收入
	private BigDecimal d204b110008;

	// 集体经济分配收入
	private BigDecimal d204b110009;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204b11Id() {
		return d204b11Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204b11Id(String d204b11Id) {
		this.d204b11Id = d204b11Id;
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
	 * 获取 工资性收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110001() {
		return d204b110001;
	}

	/**
	 * 设置 工资性收入
	 */
	public void setD204b110001(BigDecimal d204b110001) {
		this.d204b110001 = d204b110001;
	}

	/**
	 * 获取 奖金收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110002() {
		return d204b110002;
	}

	/**
	 * 设置 奖金收入
	 */
	public void setD204b110002(BigDecimal d204b110002) {
		this.d204b110002 = d204b110002;
	}

	/**
	 * 获取 补贴收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110003() {
		return d204b110003;
	}

	/**
	 * 设置 补贴收入
	 */
	public void setD204b110003(BigDecimal d204b110003) {
		this.d204b110003 = d204b110003;
	}

	/**
	 * 获取 加班收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110004() {
		return d204b110004;
	}

	/**
	 * 设置 加班收入
	 */
	public void setD204b110004(BigDecimal d204b110004) {
		this.d204b110004 = d204b110004;
	}

	/**
	 * 获取 第二职业收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110005() {
		return d204b110005;
	}

	/**
	 * 设置 第二职业收入
	 */
	public void setD204b110005(BigDecimal d204b110005) {
		this.d204b110005 = d204b110005;
	}

	/**
	 * 获取 兼职收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110006() {
		return d204b110006;
	}

	/**
	 * 设置 兼职收入
	 */
	public void setD204b110006(BigDecimal d204b110006) {
		this.d204b110006 = d204b110006;
	}

	/**
	 * 获取 零星劳动收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110007() {
		return d204b110007;
	}

	/**
	 * 设置 零星劳动收入
	 */
	public void setD204b110007(BigDecimal d204b110007) {
		this.d204b110007 = d204b110007;
	}

	/**
	 * 获取 从事农副业成产获得的收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110008() {
		return d204b110008;
	}

	/**
	 * 设置 从事农副业成产获得的收入
	 */
	public void setD204b110008(BigDecimal d204b110008) {
		this.d204b110008 = d204b110008;
	}

	/**
	 * 获取 集体经济分配收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b110009() {
		return d204b110009;
	}

	/**
	 * 设置 集体经济分配收入
	 */
	public void setD204b110009(BigDecimal d204b110009) {
		this.d204b110009 = d204b110009;
	}

}