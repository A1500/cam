package com.inspur.sdmz.jzfa.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 救助方案明细bean
 * @author shgtch
 * @date 2011-4-16
 */
@Table(tableName = "SAM_PLAN_DETAIL", keyFields = {"DETAIL_ID"})
public class Detail extends StatefulDatabean {

	// 救助方案明细ID
	@Rule(value="require")
	@Column(name="DETAIL_ID")
	private String detailId;
	
	// 救助方案ID
	@Column(name="PLAN_ID")
	private String planId;
	
	// 受助对象ID
	@Column(name="ASSISTED_ID")
	private String assistedId;
	
	// 受助对象名称
	@Column(name="ASSISTED_NAME")
	private String assistedName;
	
	// 受助对象类型
	@Column(name="ASSISTED_TYPE")
	private String assistedType;
	
	// 受助对象身份证号
	@Column(name="ID_CARD")
	private String idCard;
	
	// 救助日期
	@Column(name="ASSITANCE_DATE")
	private String assitanceDate;
	
	// 救助资金现金金额
	@Column(name="CAPTIAL")
	private BigDecimal captial;
	
	// 救助物品名称
	@Column(name="GOODS_NAME")
	private String goodsName;
	
	// 救助物品数量
	@Column(name="GOODS_NUM")
	private BigDecimal goodsNum;
	
	// 救助物品折价金额
	@Column(name="GOODS_NUMS")
	private BigDecimal goodsNums;
	
	// 救助资金合计金额
	@Column(name="TOTAL_FUND")
	private BigDecimal totalFund;
	
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
	private String regOrgId;
	
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
	@Column(name="MOD_TIME")
	private String modTime;
	
	// 救助方向
	@Column(name="ASSISTED_SIDE")
	private String assistedSide;
	
	//残疾证号
	@Column(name = "HANDICAP_NUM")
	private String handicapNum;
	
	//年龄
	@Column(name="AGE")
	private String age;
	
	//残疾类型
	@Column(name="DISABILITY_TYPE")
	private String disabilityType;
	
	@Column(name="DISABILITY_LEVEL")
	private String disabilityLevel;


	public String getHandicapNum() {
		return handicapNum;
	}

	public void setHandicapNum(String handicapNum) {
		this.handicapNum = handicapNum;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getDisabilityType() {
		return disabilityType;
	}

	public void setDisabilityType(String disabilityType) {
		this.disabilityType = disabilityType;
	}

	public String getDisabilityLevel() {
		return disabilityLevel;
	}

	public void setDisabilityLevel(String disabilityLevel) {
		this.disabilityLevel = disabilityLevel;
	}

	public String getDetailId() {
		return detailId;
	}

	public void setDetailId(String detailId) {
		this.detailId = detailId;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String getAssistedId() {
		return assistedId;
	}

	public void setAssistedId(String assistedId) {
		this.assistedId = assistedId;
	}

	public String getAssistedName() {
		return assistedName;
	}

	public void setAssistedName(String assistedName) {
		this.assistedName = assistedName;
	}

	
	public String getAssistedType() {
		return assistedType;
	}

	public void setAssistedType(String assistedType) {
		this.assistedType = assistedType;
	}
	
 

	public String getAssitanceDate() {
		return assitanceDate;
	}

	public void setAssitanceDate(String assitanceDate) {
		this.assitanceDate = assitanceDate;
	}

	public BigDecimal getCaptial() {
		return captial;
	}

	public void setCaptial(BigDecimal captial) {
		this.captial = captial;
	}
	

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
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

	public BigDecimal getGoodsNum() {
		return goodsNum;
	}

	public void setGoodsNum(BigDecimal goodsNum) {
		this.goodsNum = goodsNum;
	}

	public BigDecimal getGoodsNums() {
		return goodsNums;
	}

	public void setGoodsNums(BigDecimal goodsNums) {
		this.goodsNums = goodsNums;
	}

	public BigDecimal getTotalFund() {
		return totalFund;
	}

	public void setTotalFund(BigDecimal totalFund) {
		this.totalFund = totalFund;
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

	public String getRegOrgId() {
		return regOrgId;
	}

	public void setRegOrgId(String regOrgId) {
		this.regOrgId = regOrgId;
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

	public String getModTime() {
		return modTime;
	}

	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	public String getAssistedSide() {
		return assistedSide;
	}

	public void setAssistedSide(String assistedSide) {
		this.assistedSide = assistedSide;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	
}
