package com.inspur.cams.drel.info.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 户籍注销databean
 * @author
 * @date 2014-06-09
 */
@Table(tableName = "D204C21_DIE", keyFields = "d204c21DieId")
public class D204c21Die extends StatefulDatabean {

	// ID
	private String d204c21DieId;

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

	// 曾用名
	private String nameBefore;

	// 性别
	private String sex;

	// 出生地
	private String birthdayAd;

	// 出生时间
	private String birthday;

	// 死亡时间
	private String dieTime;

	// 所属派出所
	private String organAd;

	// 住所
	private String adress;

	/**
	 * 获取 ID
	 * @return String
	 */
	public String getD204c21DieId() {
		return d204c21DieId;
	}

	/**
	 * 设置 ID
	 */
	public void setD204c21DieId(String d204c21DieId) {
		this.d204c21DieId = d204c21DieId;
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
	 * 获取 曾用名
	 * @return String
	 */
	public String getNameBefore() {
		return nameBefore;
	}

	/**
	 * 设置 曾用名
	 */
	public void setNameBefore(String nameBefore) {
		this.nameBefore = nameBefore;
	}

	/**
	 * 获取 性别
	 * @return String
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * 设置 性别
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * 获取 出生地
	 * @return String
	 */
	public String getBirthdayAd() {
		return birthdayAd;
	}

	/**
	 * 设置 出生地
	 */
	public void setBirthdayAd(String birthdayAd) {
		this.birthdayAd = birthdayAd;
	}

	/**
	 * 获取 出生时间
	 * @return String
	 */
	public String getBirthday() {
		return birthday;
	}

	/**
	 * 设置 出生时间
	 */
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	/**
	 * 获取 死亡时间
	 * @return String
	 */
	public String getDieTime() {
		return dieTime;
	}

	/**
	 * 设置 死亡时间
	 */
	public void setDieTime(String dieTime) {
		this.dieTime = dieTime;
	}

	/**
	 * 获取 所属派出所
	 * @return String
	 */
	public String getOrganAd() {
		return organAd;
	}

	/**
	 * 设置 所属派出所
	 */
	public void setOrganAd(String organAd) {
		this.organAd = organAd;
	}

	/**
	 * 获取 住所
	 * @return String
	 */
	public String getAdress() {
		return adress;
	}

	/**
	 * 设置 住所
	 */
	public void setAdress(String adress) {
		this.adress = adress;
	}
}