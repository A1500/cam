package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 房产databean
 * @author 
 * @date 2014-06-09
 */
@Table(tableName = "D204C22", keyFields = "d204c22Id")
public class D204c22 extends StatefulDatabean {

	// ID
	private String d204c22Id;

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

	// 房产证编号
	private String d204c220001;

	// 房屋坐落位置
	private String d204c220002;

	// 房屋类型
	private String d204c220003;

	// 房屋产权类型
	private String d204c220004;

	// 房屋建筑面积
	private BigDecimal d204c220005;

	// 是否居住类房产
	private String d204c220006;

	// 房屋权利人/共有人
	private String d204c220007;

	// 房屋购值
	private BigDecimal d204c220008;

	// 房产证发证时间
	private String d204c220009;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204c22Id() {
		return d204c22Id;
	}

	/**
	 * 设置 ID
	 */
	public void setD204c22Id(String d204c22Id) {
		this.d204c22Id = d204c22Id;
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
	 * 获取 房产证编号
	 * @return String
	 */
	public String getD204c220001() {
		return d204c220001;
	}

	/**
	 * 设置 房产证编号
	 */
	public void setD204c220001(String d204c220001) {
		this.d204c220001 = d204c220001;
	}

	/**
	 * 获取 房屋坐落位置
	 * @return String
	 */
	public String getD204c220002() {
		return d204c220002;
	}

	/**
	 * 设置 房屋坐落位置
	 */
	public void setD204c220002(String d204c220002) {
		this.d204c220002 = d204c220002;
	}

	/**
	 * 获取 房屋类型
	 * @return String
	 */
	public String getD204c220003() {
		return d204c220003;
	}

	/**
	 * 设置 房屋类型
	 */
	public void setD204c220003(String d204c220003) {
		this.d204c220003 = d204c220003;
	}

	/**
	 * 获取 房屋产权类型
	 * @return String
	 */
	public String getD204c220004() {
		return d204c220004;
	}

	/**
	 * 设置 房屋产权类型
	 */
	public void setD204c220004(String d204c220004) {
		this.d204c220004 = d204c220004;
	}

	/**
	 * 获取 房屋建筑面积
	 * @return BigDecimal
	 */
	public BigDecimal getD204c220005() {
		return d204c220005;
	}

	/**
	 * 设置 房屋建筑面积
	 */
	public void setD204c220005(BigDecimal d204c220005) {
		this.d204c220005 = d204c220005;
	}

	/**
	 * 获取 是否居住类房产
	 * @return String
	 */
	public String getD204c220006() {
		return d204c220006;
	}

	/**
	 * 设置 是否居住类房产
	 */
	public void setD204c220006(String d204c220006) {
		this.d204c220006 = d204c220006;
	}

	/**
	 * 获取 房屋权利人/共有人
	 * @return String
	 */
	public String getD204c220007() {
		return d204c220007;
	}

	/**
	 * 设置 房屋权利人/共有人
	 */
	public void setD204c220007(String d204c220007) {
		this.d204c220007 = d204c220007;
	}

	/**
	 * 获取 房屋购值
	 * @return BigDecimal
	 */
	public BigDecimal getD204c220008() {
		return d204c220008;
	}

	/**
	 * 设置 房屋购值
	 */
	public void setD204c220008(BigDecimal d204c220008) {
		this.d204c220008 = d204c220008;
	}

	/**
	 * 获取 房产证发证时间
	 * @return String
	 */
	public String getD204c220009() {
		return d204c220009;
	}

	/**
	 * 设置 房产证发证时间
	 */
	public void setD204c220009(String d204c220009) {
		this.d204c220009 = d204c220009;
	}

}