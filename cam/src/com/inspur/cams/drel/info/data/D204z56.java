package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 核对统计信息databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204Z56", keyFields = "d204z56Id")
public class D204z56 extends StatefulDatabean {

	// ID
	private String d204z56Id;

	// 统计人
	private String inputPeople;

	// 统计人编码
	private String inputPeopleId;

	// 统计单位
	private String inputOrgan;

	// 统计单位编码
	private String inputOrganId;

	// 统计时间
	private String inputTime;

	// 核对对象人次
	private BigDecimal d204z560001;

	// 终止核对对象人次
	private BigDecimal d204z560002;

	// 委托单位委托核对总人次
	private BigDecimal d204z560003;

	// 委托单位中止总人次
	private BigDecimal d204z560004;

	// 中止总人次的所占比例
	private String d204z560005;

	// 核对项目核对总人次
	private BigDecimal d204z560006;

	// 信息共享指标数量统计
	private BigDecimal d204z560007;

	// 核对项目信息查询总人次
	private BigDecimal d204z560008;

	// 出具核对结果报告总份数
	private BigDecimal d204z560009;

	// 出具核对中止报告总份数
	private BigDecimal d204z560010;

	// 接收核对报告复议
	private BigDecimal d204z560011;

	// 委托单位终止核对总人次
	private BigDecimal d204z560012;

	// 核对机构委托核对总人次
	private BigDecimal d204z560013;

	// 核对人次环比增长率
	private String d204z560014;

	// 核对人员超出工作时限次数
	private BigDecimal d204z560015;

	// 核对报告复议率
	private String d204z560016;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204z56Id() {
		return d204z56Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204z56Id(String d204z56Id) {
		this.d204z56Id = d204z56Id;
	}

	/**
	 * 获取 统计人
	 * @return String
	 */
	public String getInputPeople() {
		return inputPeople;
	}

	/**
	 * 设置 统计人
	 */
	public void setInputPeople(String inputPeople) {
		this.inputPeople = inputPeople;
	}

	/**
	 * 获取 统计人编码
	 * @return String
	 */
	public String getInputPeopleId() {
		return inputPeopleId;
	}

	/**
	 * 设置 统计人编码
	 */
	public void setInputPeopleId(String inputPeopleId) {
		this.inputPeopleId = inputPeopleId;
	}

	/**
	 * 获取 统计单位
	 * @return String
	 */
	public String getInputOrgan() {
		return inputOrgan;
	}

	/**
	 * 设置 统计单位
	 */
	public void setInputOrgan(String inputOrgan) {
		this.inputOrgan = inputOrgan;
	}

	/**
	 * 获取 统计单位编码
	 * @return String
	 */
	public String getInputOrganId() {
		return inputOrganId;
	}

	/**
	 * 设置 统计单位编码
	 */
	public void setInputOrganId(String inputOrganId) {
		this.inputOrganId = inputOrganId;
	}

	/**
	 * 获取 统计时间
	 * @return String
	 */
	public String getInputTime() {
		return inputTime;
	}

	/**
	 * 设置 统计时间
	 */
	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}

	/**
	 * 获取 核对对象人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560001() {
		return d204z560001;
	}

	/**
	 * 设置 核对对象人次
	 */
	public void setD204z560001(BigDecimal d204z560001) {
		this.d204z560001 = d204z560001;
	}

	/**
	 * 获取 终止核对对象人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560002() {
		return d204z560002;
	}

	/**
	 * 设置 终止核对对象人次
	 */
	public void setD204z560002(BigDecimal d204z560002) {
		this.d204z560002 = d204z560002;
	}

	/**
	 * 获取 委托单位委托核对总人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560003() {
		return d204z560003;
	}

	/**
	 * 设置 委托单位委托核对总人次
	 */
	public void setD204z560003(BigDecimal d204z560003) {
		this.d204z560003 = d204z560003;
	}

	/**
	 * 获取 委托单位中止总人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560004() {
		return d204z560004;
	}

	/**
	 * 设置 委托单位中止总人次
	 */
	public void setD204z560004(BigDecimal d204z560004) {
		this.d204z560004 = d204z560004;
	}

	/**
	 * 获取 中止总人次的所占比例
	 * @return String
	 */
	public String getD204z560005() {
		return d204z560005;
	}

	/**
	 * 设置 中止总人次的所占比例
	 */
	public void setD204z560005(String d204z560005) {
		this.d204z560005 = d204z560005;
	}

	/**
	 * 获取 核对项目核对总人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560006() {
		return d204z560006;
	}

	/**
	 * 设置 核对项目核对总人次
	 */
	public void setD204z560006(BigDecimal d204z560006) {
		this.d204z560006 = d204z560006;
	}

	/**
	 * 获取 信息共享指标数量统计
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560007() {
		return d204z560007;
	}

	/**
	 * 设置 信息共享指标数量统计
	 */
	public void setD204z560007(BigDecimal d204z560007) {
		this.d204z560007 = d204z560007;
	}

	/**
	 * 获取 核对项目信息查询总人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560008() {
		return d204z560008;
	}

	/**
	 * 设置 核对项目信息查询总人次
	 */
	public void setD204z560008(BigDecimal d204z560008) {
		this.d204z560008 = d204z560008;
	}

	/**
	 * 获取 出具核对结果报告总份数
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560009() {
		return d204z560009;
	}

	/**
	 * 设置 出具核对结果报告总份数
	 */
	public void setD204z560009(BigDecimal d204z560009) {
		this.d204z560009 = d204z560009;
	}

	/**
	 * 获取 出具核对中止报告总份数
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560010() {
		return d204z560010;
	}

	/**
	 * 设置 出具核对中止报告总份数
	 */
	public void setD204z560010(BigDecimal d204z560010) {
		this.d204z560010 = d204z560010;
	}

	/**
	 * 获取 接收核对报告复议
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560011() {
		return d204z560011;
	}

	/**
	 * 设置 接收核对报告复议
	 */
	public void setD204z560011(BigDecimal d204z560011) {
		this.d204z560011 = d204z560011;
	}

	/**
	 * 获取 委托单位终止核对总人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560012() {
		return d204z560012;
	}

	/**
	 * 设置 委托单位终止核对总人次
	 */
	public void setD204z560012(BigDecimal d204z560012) {
		this.d204z560012 = d204z560012;
	}

	/**
	 * 获取 核对机构委托核对总人次
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560013() {
		return d204z560013;
	}

	/**
	 * 设置 核对机构委托核对总人次
	 */
	public void setD204z560013(BigDecimal d204z560013) {
		this.d204z560013 = d204z560013;
	}

	/**
	 * 获取 核对人次环比增长率
	 * @return String
	 */
	public String getD204z560014() {
		return d204z560014;
	}

	/**
	 * 设置 核对人次环比增长率
	 */
	public void setD204z560014(String d204z560014) {
		this.d204z560014 = d204z560014;
	}

	/**
	 * 获取 核对人员超出工作时限次数
	 * @return BigDecimal
	 */
	public BigDecimal getD204z560015() {
		return d204z560015;
	}

	/**
	 * 设置 核对人员超出工作时限次数
	 */
	public void setD204z560015(BigDecimal d204z560015) {
		this.d204z560015 = d204z560015;
	}

	/**
	 * 获取 核对报告复议率
	 * @return String
	 */
	public String getD204z560016() {
		return d204z560016;
	}

	/**
	 * 设置 核对报告复议率
	 */
	public void setD204z560016(String d204z560016) {
		this.d204z560016 = d204z560016;
	}

}