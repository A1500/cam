package com.inspur.sdmz.jzfa.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 救助方案bean
 * @author shgtch
 * @date 2011-4-16
 */
@Table(tableName = "SAM_PLAN", keyFields = {"PLAN_ID"})
public class Plan extends StatefulDatabean {

	// 救助方案ID
	@Column(name="PLAN_ID")
	private String planId;
	
	// 救助类型代码
	@Column(name="PLAN_TYPE")
	private String planType;
	
	// 救助方案名称
	@Column(name="PLAN_NAME")
	private String planName;
	
	// 救助单位Id
	@Column(name="PLAN_ORGAN_ID")
	private String planOrgId;
	
	// 救助单位名称
	@Column(name="PLAN_ORGAN_NAME")
	private String planOrgName;
	
	// 救助单位区划
	@Column(name="PLAN_ORGAN_REGION")
	private String planOrgRegion;
	
	// 救助日期起
	
	@Column(name="PLAN_BEGIN")
	private String planBegin;
	
	// 救助日期止
	@Column(name="PLAN_END")
	private String planEnd;
	
	// 救助资金金额
	@Column(name="FUND")
	private BigDecimal fund;
	
	// 救助户数
	@Column(name="FAMILY_NUM")
	private BigDecimal familyNum;
	
	// 救助人数
	@Column(name="PEOPLE_NUM")
	private BigDecimal peopleNum;
	
	// 实施状态标志
	@Column(name="STATUS")
	private String status;
	
	// 录入人姓名
	@Column(name="REG_NAME")
	private String regName;
	
	// 录入人ID
	@Column(name="REG_ID")
	private String regId;
	
	// 录入单位名称
	@Column(name="REG_ORGAN_NAME")
	private String regOrgName;
	
	// 录入单位区划
	@Column(name="REG_ORGAN_REGION")
	private String regOrgRegion;
	
	// 录入单位ID
	@Column(name="REG_ORGAN_ID")
	private String regOrgID;
	
	// 录入时间
	@Column(name="REG_TIME")
	private String regTime;
	
	// 修改人姓名
	@Column(name="MOD_NAME")
	private String modName;
	
	// 修改人ID
	@Column(name="MOD_ID")
	private String modId;

	// 修改单位名称
	@Column(name="MOD_ORGAN_NAME")
	private String modOrgName;
	
	// 修改单位区划
	@Column(name="MOD_ORGAN_REGION")
	private String modOrgRegion;
	
	// 修改单位ID
	@Column(name="MOD_ORGAN_ID")
	private String modOrgId;
	
	// 修改时间
	@Column(name="MOD_DATE")
	private String modDate;
	// 登记单位类型
	@Column(name="REG_ORGAN_TYPE")
	private String regOrganType;
	
	
	//救助户数非表列
	@Transient
	private String familySum;
	
	//救助人数非表列
	@Transient
	private String peopleSum;
	
	//投入资金非表列
	@Transient
	private String moneySum;

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	

	public BigDecimal getFund() {
		return fund;
	}

	public void setFund(BigDecimal fund) {
		this.fund = fund;
	}


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}



	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}


	public String getFamilySum() {
		return familySum;
	}

	public void setFamilySum(String familySum) {
		this.familySum = familySum;
	}

	public String getPeopleSum() {
		return peopleSum;
	}

	public void setPeopleSum(String peopleSum) {
		this.peopleSum = peopleSum;
	}

	public String getMoneySum() {
		return moneySum;
	}

	public void setMoneySum(String moneySum) {
		this.moneySum = moneySum;
	}

	public String getPlanType() {
		return planType;
	}

	public void setPlanType(String planType) {
		this.planType = planType;
	}


	public String getPlanName() {
		return planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}

	public String getPlanOrgId() {
		return planOrgId;
	}

	public void setPlanOrgId(String planOrgId) {
		this.planOrgId = planOrgId;
	}

	public String getPlanOrgName() {
		return planOrgName;
	}

	public void setPlanOrgName(String planOrgName) {
		this.planOrgName = planOrgName;
	}

	public String getPlanOrgRegion() {
		return planOrgRegion;
	}

	public void setPlanOrgRegion(String planOrgRegion) {
		this.planOrgRegion = planOrgRegion;
	}

	public String getPlanBegin() {
		return planBegin;
	}

	public void setPlanBegin(String planBegin) {
		this.planBegin = planBegin;
	}

	public String getPlanEnd() {
		return planEnd;
	}

	public void setPlanEnd(String planEnd) {
		this.planEnd = planEnd;
	}

	public BigDecimal getFamilyNum() {
		return familyNum;
	}

	public void setFamilyNum(BigDecimal familyNum) {
		this.familyNum = familyNum;
	}

	public BigDecimal getPeopleNum() {
		return peopleNum;
	}

	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getRegOrgName() {
		return regOrgName;
	}

	public void setRegOrgName(String regOrgName) {
		this.regOrgName = regOrgName;
	}

	public String getRegOrgRegion() {
		return regOrgRegion;
	}

	public void setRegOrgRegion(String regOrgRegion) {
		this.regOrgRegion = regOrgRegion;
	}

	public String getRegOrgID() {
		return regOrgID;
	}

	public void setRegOrgID(String regOrgID) {
		this.regOrgID = regOrgID;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public String getModName() {
		return modName;
	}

	public void setModName(String modName) {
		this.modName = modName;
	}

	public String getModOrgName() {
		return modOrgName;
	}

	public void setModOrgName(String modOrgName) {
		this.modOrgName = modOrgName;
	}

	public String getModOrgRegion() {
		return modOrgRegion;
	}

	public void setModOrgRegion(String modOrgRegion) {
		this.modOrgRegion = modOrgRegion;
	}

	public String getModOrgId() {
		return modOrgId;
	}

	public void setModOrgId(String modOrgId) {
		this.modOrgId = modOrgId;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getRegOrganType() {
		return regOrganType;
	}

	public void setRegOrganType(String regOrganType) {
		this.regOrganType = regOrganType;
	}
	
	
	
}
