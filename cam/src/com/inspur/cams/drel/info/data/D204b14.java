package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 转移性收入databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204B14", keyFields = "d204b14Id")
public class D204b14 extends StatefulDatabean {

	// ID
	private String d204b14Id;

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

	// 失业保险金
	private BigDecimal d204b140001;

	// 养老金
	private BigDecimal d204b140002;

	// 离退休金
	private BigDecimal d204b140003;

	// 政府生活救助收入
	private BigDecimal d204b140004;

	// 就业岗位补贴
	private BigDecimal d204b140005;

	// 社会保险费补贴
	private BigDecimal d204b140006;

	// 遗属补助金
	private BigDecimal d204b140007;

	// 彩票收益
	private BigDecimal d204b140008;

	// 赡（抚、扶）养费
	private BigDecimal d204b140009;

	// 辞退金
	private BigDecimal d204b140010;

	// 赔偿收入
	private BigDecimal d204b140011;

	// 捐赠
	private BigDecimal d204b140012;

	// 赠予收入
	private BigDecimal d204b140013;

	// 接受遗产收入
	private BigDecimal d204b140014;

	// 奖学金
	private BigDecimal d204b140015;

	// 义务兵自谋职业补助金
	private BigDecimal d204b140016;

	// 高温补贴费
	private BigDecimal d204b140017;

	// 取暖补贴费
	private BigDecimal d204b140018;

	// 亲友搭伙费
	private BigDecimal d204b140019;

	// 一次性支取的补充养老金
	private BigDecimal d204b140020;

	// 一次性支取的住房公积金（不含补充住房公积金）
	private BigDecimal d204b140021;

	// 一次性支取的补充住房公积金
	private BigDecimal d204b140022;

	// 其它补贴
	private BigDecimal d204b140023;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204b14Id() {
		return d204b14Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204b14Id(String d204b14Id) {
		this.d204b14Id = d204b14Id;
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
	 * 获取 失业保险金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140001() {
		return d204b140001;
	}

	/**
	 * 设置 失业保险金
	 */
	public void setD204b140001(BigDecimal d204b140001) {
		this.d204b140001 = d204b140001;
	}

	/**
	 * 获取 养老金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140002() {
		return d204b140002;
	}

	/**
	 * 设置 养老金
	 */
	public void setD204b140002(BigDecimal d204b140002) {
		this.d204b140002 = d204b140002;
	}

	/**
	 * 获取 离退休金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140003() {
		return d204b140003;
	}

	/**
	 * 设置 离退休金
	 */
	public void setD204b140003(BigDecimal d204b140003) {
		this.d204b140003 = d204b140003;
	}

	/**
	 * 获取 政府生活救助收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140004() {
		return d204b140004;
	}

	/**
	 * 设置 政府生活救助收入
	 */
	public void setD204b140004(BigDecimal d204b140004) {
		this.d204b140004 = d204b140004;
	}

	/**
	 * 获取 就业岗位补贴
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140005() {
		return d204b140005;
	}

	/**
	 * 设置 就业岗位补贴
	 */
	public void setD204b140005(BigDecimal d204b140005) {
		this.d204b140005 = d204b140005;
	}

	/**
	 * 获取 社会保险费补贴
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140006() {
		return d204b140006;
	}

	/**
	 * 设置 社会保险费补贴
	 */
	public void setD204b140006(BigDecimal d204b140006) {
		this.d204b140006 = d204b140006;
	}

	/**
	 * 获取 遗属补助金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140007() {
		return d204b140007;
	}

	/**
	 * 设置 遗属补助金
	 */
	public void setD204b140007(BigDecimal d204b140007) {
		this.d204b140007 = d204b140007;
	}

	/**
	 * 获取 彩票收益
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140008() {
		return d204b140008;
	}

	/**
	 * 设置 彩票收益
	 */
	public void setD204b140008(BigDecimal d204b140008) {
		this.d204b140008 = d204b140008;
	}

	/**
	 * 获取 赡（抚、扶）养费
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140009() {
		return d204b140009;
	}

	/**
	 * 设置 赡（抚、扶）养费
	 */
	public void setD204b140009(BigDecimal d204b140009) {
		this.d204b140009 = d204b140009;
	}

	/**
	 * 获取 辞退金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140010() {
		return d204b140010;
	}

	/**
	 * 设置 辞退金
	 */
	public void setD204b140010(BigDecimal d204b140010) {
		this.d204b140010 = d204b140010;
	}

	/**
	 * 获取 赔偿收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140011() {
		return d204b140011;
	}

	/**
	 * 设置 赔偿收入
	 */
	public void setD204b140011(BigDecimal d204b140011) {
		this.d204b140011 = d204b140011;
	}

	/**
	 * 获取 捐赠
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140012() {
		return d204b140012;
	}

	/**
	 * 设置 捐赠
	 */
	public void setD204b140012(BigDecimal d204b140012) {
		this.d204b140012 = d204b140012;
	}

	/**
	 * 获取 赠予收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140013() {
		return d204b140013;
	}

	/**
	 * 设置 赠予收入
	 */
	public void setD204b140013(BigDecimal d204b140013) {
		this.d204b140013 = d204b140013;
	}

	/**
	 * 获取 接受遗产收入
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140014() {
		return d204b140014;
	}

	/**
	 * 设置 接受遗产收入
	 */
	public void setD204b140014(BigDecimal d204b140014) {
		this.d204b140014 = d204b140014;
	}

	/**
	 * 获取 奖学金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140015() {
		return d204b140015;
	}

	/**
	 * 设置 奖学金
	 */
	public void setD204b140015(BigDecimal d204b140015) {
		this.d204b140015 = d204b140015;
	}

	/**
	 * 获取 义务兵自谋职业补助金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140016() {
		return d204b140016;
	}

	/**
	 * 设置 义务兵自谋职业补助金
	 */
	public void setD204b140016(BigDecimal d204b140016) {
		this.d204b140016 = d204b140016;
	}

	/**
	 * 获取 高温补贴费
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140017() {
		return d204b140017;
	}

	/**
	 * 设置 高温补贴费
	 */
	public void setD204b140017(BigDecimal d204b140017) {
		this.d204b140017 = d204b140017;
	}

	/**
	 * 获取 取暖补贴费
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140018() {
		return d204b140018;
	}

	/**
	 * 设置 取暖补贴费
	 */
	public void setD204b140018(BigDecimal d204b140018) {
		this.d204b140018 = d204b140018;
	}

	/**
	 * 获取 亲友搭伙费
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140019() {
		return d204b140019;
	}

	/**
	 * 设置 亲友搭伙费
	 */
	public void setD204b140019(BigDecimal d204b140019) {
		this.d204b140019 = d204b140019;
	}

	/**
	 * 获取 一次性支取的补充养老金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140020() {
		return d204b140020;
	}

	/**
	 * 设置 一次性支取的补充养老金
	 */
	public void setD204b140020(BigDecimal d204b140020) {
		this.d204b140020 = d204b140020;
	}

	/**
	 * 获取 一次性支取的住房公积金（不含补充住房公积金）
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140021() {
		return d204b140021;
	}

	/**
	 * 设置 一次性支取的住房公积金（不含补充住房公积金）
	 */
	public void setD204b140021(BigDecimal d204b140021) {
		this.d204b140021 = d204b140021;
	}

	/**
	 * 获取 一次性支取的补充住房公积金
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140022() {
		return d204b140022;
	}

	/**
	 * 设置 一次性支取的补充住房公积金
	 */
	public void setD204b140022(BigDecimal d204b140022) {
		this.d204b140022 = d204b140022;
	}

	/**
	 * 获取 其它补贴
	 * @return BigDecimal
	 */
	public BigDecimal getD204b140023() {
		return d204b140023;
	}

	/**
	 * 设置 其它补贴
	 */
	public void setD204b140023(BigDecimal d204b140023) {
		this.d204b140023 = d204b140023;
	}

}