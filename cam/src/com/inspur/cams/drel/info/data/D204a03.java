package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 家庭基本信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204A03", keyFields = "familyId")
public class D204a03 extends StatefulDatabean {
	
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

	// 省（直辖市）名称
	private String d204a030001;

	// 市名称
	private String d204a030002;

	// 区县名称
	private String d204a030003;

	// 街道名称
	private String d204a030004;

	// 社区名称
	private String d204a030005;

	// 户主姓名
	private String d204a030006;

	// 户主有效身份证件号码
	private String d204a030007;

	// 家庭人口数
	private BigDecimal d204a030008;

	// 邮政编码
	private String d204a030009;

	// 住房性质
	private String d204a030010;

	// 住房结构
	private String d204a030011;

	// 住房面积
	private BigDecimal d204a030012;

	// 非农业人口数量
	private BigDecimal d204a030013;

	// 农业人口数量
	private BigDecimal d204a030014;

	// 财产核定总计
	private BigDecimal d204a030015;

	// 收入核定总计
	private BigDecimal d204a030016;

	// 支出核定总计
	private BigDecimal d204a030017;

	// 是否超出标准
	private String d204a030018;

	// 超标类型
	private String d204a030019;

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
	public void setFamiliyId(String familyId) {
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
	 * 获取 省（直辖市）名称
	 * @return String
	 */
	public String getD204a030001() {
		return d204a030001;
	}

	/**
	 * 设置 省（直辖市）名称
	 */
	public void setD204a030001(String d204a030001) {
		this.d204a030001 = d204a030001;
	}

	/**
	 * 获取 市名称
	 * @return String
	 */
	public String getD204a030002() {
		return d204a030002;
	}

	/**
	 * 设置 市名称
	 */
	public void setD204a030002(String d204a030002) {
		this.d204a030002 = d204a030002;
	}

	/**
	 * 获取 区县名称
	 * @return String
	 */
	public String getD204a030003() {
		return d204a030003;
	}

	/**
	 * 设置 区县名称
	 */
	public void setD204a030003(String d204a030003) {
		this.d204a030003 = d204a030003;
	}

	/**
	 * 获取 街道名称
	 * @return String
	 */
	public String getD204a030004() {
		return d204a030004;
	}

	/**
	 * 设置 街道名称
	 */
	public void setD204a030004(String d204a030004) {
		this.d204a030004 = d204a030004;
	}

	/**
	 * 获取 社区名称
	 * @return String
	 */
	public String getD204a030005() {
		return d204a030005;
	}

	/**
	 * 设置 社区名称
	 */
	public void setD204a030005(String d204a030005) {
		this.d204a030005 = d204a030005;
	}

	/**
	 * 获取 户主姓名
	 * @return String
	 */
	public String getD204a030006() {
		return d204a030006;
	}

	/**
	 * 设置 户主姓名
	 */
	public void setD204a030006(String d204a030006) {
		this.d204a030006 = d204a030006;
	}

	/**
	 * 获取 户主有效身份证件号码
	 * @return String
	 */
	public String getD204a030007() {
		return d204a030007;
	}

	/**
	 * 设置 户主有效身份证件号码
	 */
	public void setD204a030007(String d204a030007) {
		this.d204a030007 = d204a030007;
	}

	/**
	 * 获取 家庭人口数
	 * @return BigDecimal
	 */
	public BigDecimal getD204a030008() {
		return d204a030008;
	}

	/**
	 * 设置 家庭人口数
	 */
	public void setD204a030008(BigDecimal d204a030008) {
		this.d204a030008 = d204a030008;
	}

	/**
	 * 获取 邮政编码
	 * @return String
	 */
	public String getD204a030009() {
		return d204a030009;
	}

	/**
	 * 设置 邮政编码
	 */
	public void setD204a030009(String d204a030009) {
		this.d204a030009 = d204a030009;
	}

	/**
	 * 获取 住房性质
	 * @return String
	 */
	public String getD204a030010() {
		return d204a030010;
	}

	/**
	 * 设置 住房性质
	 */
	public void setD204a030010(String d204a030010) {
		this.d204a030010 = d204a030010;
	}

	/**
	 * 获取 住房结构
	 * @return String
	 */
	public String getD204a030011() {
		return d204a030011;
	}

	/**
	 * 设置 住房结构
	 */
	public void setD204a030011(String d204a030011) {
		this.d204a030011 = d204a030011;
	}

	/**
	 * 获取 住房面积
	 * @return BigDecimal
	 */
	public BigDecimal getD204a030012() {
		return d204a030012;
	}

	/**
	 * 设置 住房面积
	 */
	public void setD204a030012(BigDecimal d204a030012) {
		this.d204a030012 = d204a030012;
	}

	/**
	 * 获取 非农业人口数量
	 * @return BigDecimal
	 */
	public BigDecimal getD204a030013() {
		return d204a030013;
	}

	/**
	 * 设置 非农业人口数量
	 */
	public void setD204a030013(BigDecimal d204a030013) {
		this.d204a030013 = d204a030013;
	}

	/**
	 * 获取 农业人口数量
	 * @return BigDecimal
	 */
	public BigDecimal getD204a030014() {
		return d204a030014;
	}

	/**
	 * 设置 农业人口数量
	 */
	public void setD204a030014(BigDecimal d204a030014) {
		this.d204a030014 = d204a030014;
	}

	/**
	 * 获取 财产核定总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a030015() {
		return d204a030015;
	}

	/**
	 * 设置 财产核定总计
	 */
	public void setD204a030015(BigDecimal d204a030015) {
		this.d204a030015 = d204a030015;
	}

	/**
	 * 获取 收入核定总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a030016() {
		return d204a030016;
	}

	/**
	 * 设置 收入核定总计
	 */
	public void setD204a030016(BigDecimal d204a030016) {
		this.d204a030016 = d204a030016;
	}

	/**
	 * 获取 支出核定总计
	 * @return BigDecimal
	 */
	public BigDecimal getD204a030017() {
		return d204a030017;
	}

	/**
	 * 设置 支出核定总计
	 */
	public void setD204a030017(BigDecimal d204a030017) {
		this.d204a030017 = d204a030017;
	}

	/**
	 * 获取 是否超出标准
	 * @return String
	 */
	public String getD204a030018() {
		return d204a030018;
	}

	/**
	 * 设置 是否超出标准
	 */
	public void setD204a030018(String d204a030018) {
		this.d204a030018 = d204a030018;
	}

	/**
	 * 获取 超标类型
	 * @return String
	 */
	public String getD204a030019() {
		return d204a030019;
	}

	/**
	 * 设置 超标类型
	 */
	public void setD204a030019(String d204a030019) {
		this.d204a030019 = d204a030019;
	}

	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}
}