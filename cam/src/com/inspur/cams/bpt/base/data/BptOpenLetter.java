package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @author 徐连冬
 * 
 */
@Table(tableName = "BPT_OPEN_LETTER", keyFields = "applyId")
public class BptOpenLetter extends StatefulDatabean {

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
	 * 入伍时间
	 */
	@Column(name = "CONSCRIPTC_DATE")
	private String conscriptcDate;
	
	/**
	 * 退伍时间
	 */
	@Column(name = "DECRUITMENT_DATE")
	private String decruitmentDate;
	
	/**
	 * 在部队情况
	 */
	@Column(name = "ARMY_CONDITION")
	private String armyCondition;

	/**
	 * 将享受待遇
	 */
	@Column(name = "TREATMENT")
	private String treatment;

	/**
	 * 致病时间
	 */
	@Column(name = "ILL_DATE")
	private String illDate;

	/**
	 * 致病地点
	 */
	@Column(name = "ILL_ADDRESS")
	private String illAddress;

	/**
	 * 体检结果
	 */
	@Column(name = "ILL_BODY_CHECK")
	private String illBodyCheck;
	
	/**
	 * 法规
	 */
	@Column(name = "LAW")
	private String law;
	
	/**
	 * 公示时间(天)
	 */
	@Column(name = "OPEN_DAYS")
	private String openDays;
	
	/**
	 * 反映部门
	 */
	@Column(name = "TO_ORGAN_ID")
	private String toOrganId;
	
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

	public String getConscriptcDate() {
		return conscriptcDate;
	}

	public void setConscriptcDate(String conscriptcDate) {
		this.conscriptcDate = conscriptcDate;
	}

	public String getDecruitmentDate() {
		return decruitmentDate;
	}

	public void setDecruitmentDate(String decruitmentDate) {
		this.decruitmentDate = decruitmentDate;
	}

	public String getArmyCondition() {
		return armyCondition;
	}

	public void setArmyCondition(String armyCondition) {
		this.armyCondition = armyCondition;
	}

	public String getTreatment() {
		return treatment;
	}

	public void setTreatment(String treatment) {
		this.treatment = treatment;
	}

	public String getIllDate() {
		return illDate;
	}

	public void setIllDate(String illDate) {
		this.illDate = illDate;
	}

	public String getIllAddress() {
		return illAddress;
	}

	public void setIllAddress(String illAddress) {
		this.illAddress = illAddress;
	}

	public String getIllBodyCheck() {
		return illBodyCheck;
	}

	public void setIllBodyCheck(String illBodyCheck) {
		this.illBodyCheck = illBodyCheck;
	}

	public String getLaw() {
		return law;
	}

	public void setLaw(String law) {
		this.law = law;
	}

	public String getOpenDays() {
		return openDays;
	}

	public void setOpenDays(String openDays) {
		this.openDays = openDays;
	}

	public String getToOrganId() {
		return toOrganId;
	}

	public void setToOrganId(String toOrganId) {
		this.toOrganId = toOrganId;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

}
