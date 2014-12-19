package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 成员信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204A01", keyFields = "peopleId")
public class D204a01 extends StatefulDatabean {

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
	
	//是否核查对象
	private String inCheck;

	// 姓名
	private String d204a010001;

	// 性别
	private String d204a010002;

	// 出生日期
	private String d204a010003;

	// 证件类型
	private String d204a010004;

	// 有效身份证件号码
	private String d204a010005;

	// 民族
	private String d204a010006;

	// 国籍
	private String d204a010007;

	// 政治面貌
	private String d204a010008;

	// 婚姻状况
	private String d204a010009;

	// 登记日期
	private String d204a010010;

	// 户籍类别
	private String d204a010011;

	// 户籍地址
	private String d204a010012;

	// 户籍所在地行政区划代码
	private String d204a010013;

	// 现居住地地址
	private String d204a010014;

	// 现居住地行政区划代码
	private String d204a010015;

	// 现居住地开始居住时间
	private String d204a010016;

	// 文化程度
	private String d204a010017;

	// 健康状况
	private String d204a010018;

	// 劳动能力丧失情况
	private String d204a010019;

	// 残疾等级
	private String d204a010020;

	// 所患主要疾病名称
	private String d204a010021;

	// 是否主申请人
	private String d204a010022;

	// 与主申请人关系
	private String d204a010023;

	// 曾用名
	private String d204a010024;

	// 开户银行
	private BigDecimal d204a010025;

	// 开户银行名称
	private String d204a010026;

	// 银行账号
	private BigDecimal d204a010027;

	// 残疾类别
	private String d204a010028;

	// 配偶姓名
	private String d204a010029;

	// 配偶曾用名
	private String d204a010030;

	// 配偶证件类型
	private String d204a010031;

	// 配偶证件号码
	private String d204a010032;

	// 配偶国籍
	private String d204a010033;

	// 配偶户籍所在地
	private String d204a010034;

	// 登记类型
	private String d204a010035;

	// 死亡时间
	private String d204a010036;

	// 出境周期
	private String d204a010037;

	// 出境原因
	private String d204a010038;

	// 出境目的地
	private String d204a010039;

	// 护照号码
	private String d204a010040;

	// 护照签发地
	private String d204a010041;

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
	 * 获取 姓名
	 * @return String
	 */
	public String getD204a010001() {
		return d204a010001;
	}

	/**
	 * 设置 姓名
	 */
	public void setD204a010001(String d204a010001) {
		this.d204a010001 = d204a010001;
	}

	/**
	 * 获取 性别
	 * @return String
	 */
	public String getD204a010002() {
		return d204a010002;
	}

	/**
	 * 设置 性别
	 */
	public void setD204a010002(String d204a010002) {
		this.d204a010002 = d204a010002;
	}

	/**
	 * 获取 出生日期
	 * @return String
	 */
	public String getD204a010003() {
		return d204a010003;
	}

	/**
	 * 设置 出生日期
	 */
	public void setD204a010003(String d204a010003) {
		this.d204a010003 = d204a010003;
	}

	/**
	 * 获取 证件类型
	 * @return String
	 */
	public String getD204a010004() {
		return d204a010004;
	}

	/**
	 * 设置 证件类型
	 */
	public void setD204a010004(String d204a010004) {
		this.d204a010004 = d204a010004;
	}

	/**
	 * 获取 有效身份证件号码
	 * @return String
	 */
	public String getD204a010005() {
		return d204a010005;
	}

	/**
	 * 设置 有效身份证件号码
	 */
	public void setD204a010005(String d204a010005) {
		this.d204a010005 = d204a010005;
	}

	/**
	 * 获取 民族
	 * @return String
	 */
	public String getD204a010006() {
		return d204a010006;
	}

	/**
	 * 设置 民族
	 */
	public void setD204a010006(String d204a010006) {
		this.d204a010006 = d204a010006;
	}

	/**
	 * 获取 国籍
	 * @return String
	 */
	public String getD204a010007() {
		return d204a010007;
	}

	/**
	 * 设置 国籍
	 */
	public void setD204a010007(String d204a010007) {
		this.d204a010007 = d204a010007;
	}

	/**
	 * 获取 政治面貌
	 * @return String
	 */
	public String getD204a010008() {
		return d204a010008;
	}

	/**
	 * 设置 政治面貌
	 */
	public void setD204a010008(String d204a010008) {
		this.d204a010008 = d204a010008;
	}

	/**
	 * 获取 婚姻状况
	 * @return String
	 */
	public String getD204a010009() {
		return d204a010009;
	}

	/**
	 * 设置 婚姻状况
	 */
	public void setD204a010009(String d204a010009) {
		this.d204a010009 = d204a010009;
	}

	/**
	 * 获取 登记日期
	 * @return String
	 */
	public String getD204a010010() {
		return d204a010010;
	}

	/**
	 * 设置 登记日期
	 */
	public void setD204a010010(String d204a010010) {
		this.d204a010010 = d204a010010;
	}

	/**
	 * 获取 户籍类别
	 * @return String
	 */
	public String getD204a010011() {
		return d204a010011;
	}

	/**
	 * 设置 户籍类别
	 */
	public void setD204a010011(String d204a010011) {
		this.d204a010011 = d204a010011;
	}

	/**
	 * 获取 户籍地址
	 * @return String
	 */
	public String getD204a010012() {
		return d204a010012;
	}

	/**
	 * 设置 户籍地址
	 */
	public void setD204a010012(String d204a010012) {
		this.d204a010012 = d204a010012;
	}

	/**
	 * 获取 户籍所在地行政区划代码
	 * @return String
	 */
	public String getD204a010013() {
		return d204a010013;
	}

	/**
	 * 设置 户籍所在地行政区划代码
	 */
	public void setD204a010013(String d204a010013) {
		this.d204a010013 = d204a010013;
	}

	/**
	 * 获取 现居住地地址
	 * @return String
	 */
	public String getD204a010014() {
		return d204a010014;
	}

	/**
	 * 设置 现居住地地址
	 */
	public void setD204a010014(String d204a010014) {
		this.d204a010014 = d204a010014;
	}

	/**
	 * 获取 现居住地行政区划代码
	 * @return String
	 */
	public String getD204a010015() {
		return d204a010015;
	}

	/**
	 * 设置 现居住地行政区划代码
	 */
	public void setD204a010015(String d204a010015) {
		this.d204a010015 = d204a010015;
	}

	/**
	 * 获取 现居住地开始居住时间
	 * @return String
	 */
	public String getD204a010016() {
		return d204a010016;
	}

	/**
	 * 设置 现居住地开始居住时间
	 */
	public void setD204a010016(String d204a010016) {
		this.d204a010016 = d204a010016;
	}

	/**
	 * 获取 文化程度
	 * @return String
	 */
	public String getD204a010017() {
		return d204a010017;
	}

	/**
	 * 设置 文化程度
	 */
	public void setD204a010017(String d204a010017) {
		this.d204a010017 = d204a010017;
	}

	/**
	 * 获取 健康状况
	 * @return String
	 */
	public String getD204a010018() {
		return d204a010018;
	}

	/**
	 * 设置 健康状况
	 */
	public void setD204a010018(String d204a010018) {
		this.d204a010018 = d204a010018;
	}

	/**
	 * 获取 劳动能力丧失情况
	 * @return String
	 */
	public String getD204a010019() {
		return d204a010019;
	}

	/**
	 * 设置 劳动能力丧失情况
	 */
	public void setD204a010019(String d204a010019) {
		this.d204a010019 = d204a010019;
	}

	/**
	 * 获取 残疾等级
	 * @return String
	 */
	public String getD204a010020() {
		return d204a010020;
	}

	/**
	 * 设置 残疾等级
	 */
	public void setD204a010020(String d204a010020) {
		this.d204a010020 = d204a010020;
	}

	/**
	 * 获取 所患主要疾病名称
	 * @return String
	 */
	public String getD204a010021() {
		return d204a010021;
	}

	/**
	 * 设置 所患主要疾病名称
	 */
	public void setD204a010021(String d204a010021) {
		this.d204a010021 = d204a010021;
	}

	/**
	 * 获取 是否主申请人
	 * @return String
	 */
	public String getD204a010022() {
		return d204a010022;
	}

	/**
	 * 设置 是否主申请人
	 */
	public void setD204a010022(String d204a010022) {
		this.d204a010022 = d204a010022;
	}

	/**
	 * 获取 与主申请人关系
	 * @return String
	 */
	public String getD204a010023() {
		return d204a010023;
	}

	/**
	 * 设置 与主申请人关系
	 */
	public void setD204a010023(String d204a010023) {
		this.d204a010023 = d204a010023;
	}

	/**
	 * 获取 曾用名
	 * @return String
	 */
	public String getD204a010024() {
		return d204a010024;
	}

	/**
	 * 设置 曾用名
	 */
	public void setD204a010024(String d204a010024) {
		this.d204a010024 = d204a010024;
	}

	/**
	 * 获取 开户银行
	 * @return BigDecimal
	 */
	public BigDecimal getD204a010025() {
		return d204a010025;
	}

	/**
	 * 设置 开户银行
	 */
	public void setD204a010025(BigDecimal d204a010025) {
		this.d204a010025 = d204a010025;
	}

	/**
	 * 获取 开户银行名称
	 * @return String
	 */
	public String getD204a010026() {
		return d204a010026;
	}

	/**
	 * 设置 开户银行名称
	 */
	public void setD204a010026(String d204a010026) {
		this.d204a010026 = d204a010026;
	}

	/**
	 * 获取 银行账号
	 * @return BigDecimal
	 */
	public BigDecimal getD204a010027() {
		return d204a010027;
	}

	/**
	 * 设置 银行账号
	 */
	public void setD204a010027(BigDecimal d204a010027) {
		this.d204a010027 = d204a010027;
	}

	/**
	 * 获取 残疾类别
	 * @return String
	 */
	public String getD204a010028() {
		return d204a010028;
	}

	/**
	 * 设置 残疾类别
	 */
	public void setD204a010028(String d204a010028) {
		this.d204a010028 = d204a010028;
	}

	/**
	 * 获取 配偶姓名
	 * @return String
	 */
	public String getD204a010029() {
		return d204a010029;
	}

	/**
	 * 设置 配偶姓名
	 */
	public void setD204a010029(String d204a010029) {
		this.d204a010029 = d204a010029;
	}

	/**
	 * 获取 配偶曾用名
	 * @return String
	 */
	public String getD204a010030() {
		return d204a010030;
	}

	/**
	 * 设置 配偶曾用名
	 */
	public void setD204a010030(String d204a010030) {
		this.d204a010030 = d204a010030;
	}

	/**
	 * 获取 配偶证件类型
	 * @return String
	 */
	public String getD204a010031() {
		return d204a010031;
	}

	/**
	 * 设置 配偶证件类型
	 */
	public void setD204a010031(String d204a010031) {
		this.d204a010031 = d204a010031;
	}

	/**
	 * 获取 配偶证件号码
	 * @return String
	 */
	public String getD204a010032() {
		return d204a010032;
	}

	/**
	 * 设置 配偶证件号码
	 */
	public void setD204a010032(String d204a010032) {
		this.d204a010032 = d204a010032;
	}

	/**
	 * 获取 配偶国籍
	 * @return String
	 */
	public String getD204a010033() {
		return d204a010033;
	}

	/**
	 * 设置 配偶国籍
	 */
	public void setD204a010033(String d204a010033) {
		this.d204a010033 = d204a010033;
	}

	/**
	 * 获取 配偶户籍所在地
	 * @return String
	 */
	public String getD204a010034() {
		return d204a010034;
	}

	/**
	 * 设置 配偶户籍所在地
	 */
	public void setD204a010034(String d204a010034) {
		this.d204a010034 = d204a010034;
	}

	/**
	 * 获取 登记类型
	 * @return String
	 */
	public String getD204a010035() {
		return d204a010035;
	}

	/**
	 * 设置 登记类型
	 */
	public void setD204a010035(String d204a010035) {
		this.d204a010035 = d204a010035;
	}

	/**
	 * 获取 死亡时间
	 * @return String
	 */
	public String getD204a010036() {
		return d204a010036;
	}

	/**
	 * 设置 死亡时间
	 */
	public void setD204a010036(String d204a010036) {
		this.d204a010036 = d204a010036;
	}

	/**
	 * 获取 出境周期
	 * @return String
	 */
	public String getD204a010037() {
		return d204a010037;
	}

	/**
	 * 设置 出境周期
	 */
	public void setD204a010037(String d204a010037) {
		this.d204a010037 = d204a010037;
	}

	/**
	 * 获取 出境原因
	 * @return String
	 */
	public String getD204a010038() {
		return d204a010038;
	}

	/**
	 * 设置 出境原因
	 */
	public void setD204a010038(String d204a010038) {
		this.d204a010038 = d204a010038;
	}

	/**
	 * 获取 出境目的地
	 * @return String
	 */
	public String getD204a010039() {
		return d204a010039;
	}

	/**
	 * 设置 出境目的地
	 */
	public void setD204a010039(String d204a010039) {
		this.d204a010039 = d204a010039;
	}

	/**
	 * 获取 护照号码
	 * @return String
	 */
	public String getD204a010040() {
		return d204a010040;
	}

	/**
	 * 设置 护照号码
	 */
	public void setD204a010040(String d204a010040) {
		this.d204a010040 = d204a010040;
	}

	/**
	 * 获取 护照签发地
	 * @return String
	 */
	public String getD204a010041() {
		return d204a010041;
	}

	/**
	 * 设置 护照签发地
	 */
	public void setD204a010041(String d204a010041) {
		this.d204a010041 = d204a010041;
	}
	public String getInCheck() {
		return inCheck;
	}

	public void setInCheck(String inCheck) {
		this.inCheck = inCheck;
	}

}