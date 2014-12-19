package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @author 徐连冬
 * 
 */
@Table(tableName = "BPT_DISABILITY_OPEN", keyFields = "applyId")
public class BptDisabilityOpen extends StatefulDatabean {

	/**
	 * 申请id
	 */
	@Rule(value = "require")
	@Column(name = "APPLY_ID")
	private String applyId;

	/**
	 * 人员Id
	 */
	@Rule(value = "require")
	@Column(name = "PEOPLE_ID")
	private String peopleId;

	/**
	 * 公示日期起
	 */
	@Rule(value = "require")
	@Column(name = "OPENSTART_DATE")
	private String openstartDate;

	/**
	 * 公示日期止
	 */
	@Rule(value = "require")
	@Column(name = "OPENEND_DATE")
	private String openendDate;

	/**
	 * 致残时间
	 */
	@Column(name = "DISABILITY_DATE")
	private String disabilityDate;

	/**
	 * 致残地点
	 */
	@Column(name = "DISABILITY_ADD")
	private String disabilityAdd;

	/**
	 * 致残原因
	 */
	@Column(name = "DISABILITY_REASON")
	private String disabilityReason;

	/**
	 * 残疾情况
	 */
	@Column(name = "DISABILITY_CONDITION")
	private String disabilityCondition;

	/**
	 * 公示书出具日期
	 */
	@Rule(value = "require")
	@Column(name = "OPEN_DATE")
	private String openDate;

	/**
	 * 公示书出具单位
	 */
	@Rule(value = "require")
	@Column(name = "ORGAN_ID")
	private String organId;

	// 伤残性质
	@Column(name = "DISABILITY_CASE_CODE")
	private String disabilityCaseCode;

	// 伤残等级
	@Column(name = "DISABILITY_LEVEL_CODE")
	private String disabilityLevelCode;

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getPeopleId() {
		return peopleId;
	}

	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	public String getOpenstartDate() {
		return openstartDate;
	}

	public void setOpenstartDate(String openstartDate) {
		this.openstartDate = openstartDate;
	}

	public String getOpenendDate() {
		return openendDate;
	}

	public void setOpenendDate(String openendDate) {
		this.openendDate = openendDate;
	}

	public String getDisabilityDate() {
		return disabilityDate;
	}

	public void setDisabilityDate(String disabilityDate) {
		this.disabilityDate = disabilityDate;
	}

	public String getDisabilityAdd() {
		return disabilityAdd;
	}

	public void setDisabilityAdd(String disabilityAdd) {
		this.disabilityAdd = disabilityAdd;
	}

	public String getDisabilityReason() {
		return disabilityReason;
	}

	public void setDisabilityReason(String disabilityReason) {
		this.disabilityReason = disabilityReason;
	}

	public String getDisabilityCondition() {
		return disabilityCondition;
	}

	public void setDisabilityCondition(String disabilityCondition) {
		this.disabilityCondition = disabilityCondition;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public String getDisabilityCaseCode() {
		return disabilityCaseCode;
	}

	public void setDisabilityCaseCode(String disabilityCaseCode) {
		this.disabilityCaseCode = disabilityCaseCode;
	}

	public String getDisabilityLevelCode() {
		return disabilityLevelCode;
	}

	public void setDisabilityLevelCode(String disabilityLevelCode) {
		this.disabilityLevelCode = disabilityLevelCode;
	}

}
