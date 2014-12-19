package com.inspur.cams.dis.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.ws.databinding.types.soapencoding.Decimal;

/**
 * @title:DisReliefInfo
 * @description:
 * @author:
 * @since:2012-11-01
 * @version:1.0
 */
@Table(tableName = "DIS_RELIEF_INFO", keyFields = "infoId")
public class DisReliefInfo extends StatefulDatabean {
	/** 信息录入保存，转入待提交状态 */
	public static final String STATUS_DTJ = "0";
	/** 信息录入提交，转入待审批状态 */
	public static final String STATUS_DSP = "1";
	/** 资金发放结束 */
	public static final String STATUS_DFF = "2";
	/** 资金待发放，审批通过 */
	public static final String STATUS_FFJS = "3";
	/** 信息审批不同意 */
	public static final String STATUS_SPBTY = "4";
	/** 信息需补齐补正 */
	public static final String STATUS_BQBZ = "5";

	// 编号
	@Column(name = "INFO_ID")
	private String infoId;
	// 批次明细ID
	@Column(name = "BATCH_DETAIL_ID")
	private String batchDetailId;
	// 档案编号
	@Column(name = "RECORD_ID")
	private String recordId;
	// 填报类型
	@Column(name = "FILL_TYPE")
	private String fillType;
	// 救助类型
	@Column(name = "RELIEF_TYPE")
	private String reliefType;
	// 需口粮救助（公斤）
	@Rule(value = "number")
	@Column(name = "REQUIRED_FOR_FOOD")
	private BigDecimal requiredForFood;
	// 需衣被救助（件）
	@Rule(value = "number")
	@Column(name = "REQUIRED_FOR_CLOTHES")
	private BigDecimal requiredForClothes;
	// 需取暖救助（元）
	@Rule(value = "number")
	@Column(name = "REQUIRED_FOR_HEAT")
	private BigDecimal requiredForHeat;
	// 需伤病救助（元）
	@Rule(value = "number")
	@Column(name = "REQUIRED_FOR_DISEASE")
	private BigDecimal requiredForDisease;
	// 需其他救助（元）
	@Rule(value = "number")
	@Column(name = "REQUIRED_FOR_OTHERS")
	private BigDecimal requiredForOthers;
	// 受灾时间
	@Column(name = "DAMAGE_TIME")
	private String damageTime;
	// 灾害种类
	@Column(name = "DISASTER_TYPE")
	private String disasterType;
	// 倒塌房屋（间）
	@Rule(value = "number")
	@Column(name = "COLLAPSED_HOUSE")
	private BigDecimal collapsedHouse;
	// 严重损坏房屋（间）
	@Rule(value = "number")
	@Column(name = "SERIOUS_DAMAGE_HOUSE")
	private BigDecimal seriousDamageHouse;
	// 一般损坏房屋（间）
	@Column(name = "GENERAL_DAMAGE_HOUSE")
	private BigDecimal generalDamageHouse;
	// 需重建房屋（间）
	@Column(name = "REBUILD_HOUSE")
	private BigDecimal rebuildHouse;
	// 需修缮房屋（间）
	@Column(name = "REPAIRED_HOUSE")
	private BigDecimal repairedHouse;
	// 死者姓名
	@Column(name = "DEAD_NAME")
	private String deadName;
	// 死者性别
	@Column(name = "DEAD_SEX")
	private String deadSex;
	// 死者年龄
	@Column(name = "DEAD_AGE")
	private String deadAge;
	// 死者民族
	@Column(name = "DEAD_FOLK")
	private String deadFolk;
	// 死者户口所在地
	@Column(name = "DEAD_POPULACE")
	private String deadPopulace;
	// 死亡（失踪）地点
	@Column(name = "DEAD_MISSING_PLACE")
	private String deadMissingPlace;
	// 死亡（失踪）时间
	@Column(name = "DEAD_MISSING_TIME")
	private String deadMissingTime;
	// 死亡（失踪）原因
	@Column(name = "DEAD_MISSING_REASON")
	private String deadMissingReason;
	// 核准救助户数
	@Rule(value = "number")
	@Column(name = "APPROVAL_FAMILY_NUM")
	private BigDecimal approvalFamilyNum;
	// 核准救助时段
	@Column(name = "APPROVAL_TIMES")
	private String approvalTimes;
	// 核准救助粮食（公斤）
	@Rule(value = "number")
	@Column(name = "APPROVAL_FOOD")
	private BigDecimal approvalFood;
	// 核准救助衣被（件）
	@Rule(value = "number")
	@Column(name = "APPROVAL_CLOTHES")
	private BigDecimal approvalClothes;
	// 核准重建间数（间）
	@Rule(value = "number")
	@Column(name = "APPROVAL_REBUILED_HOUSE")
	private BigDecimal approvalRebuiledHouse;
	// 核准修缮间数（间）
	@Rule(value = "number")
	@Column(name = "APPROVAL_REPAIRED_HOUSE")
	private BigDecimal approvalRepairedHouse;
	// 核准救助资金（元）
	@Rule(value = "number")
	@Column(name = "APPROVAL_MONRY")
	private BigDecimal approvalMonry;
	// 资金发放类型
	@Column(name = "ALLOCATION_TYPE")
	private String allocationType;
	// 开户银行
	@Column(name = "BANK")
	private String bank;
	// 开户银行地址
	@Column(name = "BANK_ADDS")
	private String bankAdds;
	// 开户银行帐号
	@Column(name = "ACCOUNT_CODE")
	private String accountCode;
	// 村级填报人姓名
	@Column(name = "ACCEPT_PEOPLE_NAME")
	private String acceptPeopleName;
	// 村级填报日期
	@Column(name = "ACCEPT_DATE")
	private String acceptDate;
	// 村级行政区划
	@Column(name = "ACCEPT_AREA_CODE")
	private String acceptAreaCode;
	// 村级行政区划名称
	@Column(name = "ACCEPT_AREA_NAME")
	private String acceptAreaName;
	// 乡镇（街道）名称
	@Column(name = "CHECK_ORGAN_NAME")
	private String checkOrganName;
	// 乡镇（街道）区划
	@Column(name = "CHECK_ORGAN_CODE")
	private String checkOrganCode;
	// 乡镇（街道）审核人名称
	@Column(name = "CHECK_PEOPLE_NAME")
	private String checkPeopleName;
	// 审核日期
	@Column(name = "CHECK_DATE")
	private String checkDate;
	// 县级名称
	@Column(name = "AUDIT_ORGAN_NAME")
	private String auditOrganName;
	// 县区划
	@Column(name = "AUDIT_ORGAN_CODE")
	private String auditOrganCode;
	// 县级批准人名称
	@Column(name = "AUDIT_PEOPLE_NAME")
	private String auditPeopleName;
	// 批准日期
	@Column(name = "AUDIT_DATE")
	private String auditDate;
	// 发放单位名称
	@Column(name = "GRANT_ORGAN_NAME")
	private String grantOrganName;
	// 发放单位区划
	@Column(name = "GRANT_ORGAN_CODE")
	private String grantOrganCode;
	// 发放人名称
	@Column(name = "GRANT_PEOPLE_NAME")
	private String grantPeopleName;
	// 发放日期
	@Column(name = "GRANT_TIME")
	private String grantTime;
	// 填报单位代码
	@Column(name = "ORGAN_CODE")
	private String organCode;
	// 填报单位名称
	@Column(name = "ORGAN_NAME")
	private String organName;
	// 填报时间
	@Column(name = "FILL_TIME")
	private String fillTime;
	// 备注
	@Column(name = "NOTE")
	private String note;
	// 流程跳转状态
	@Column(name = "WORKFLOW_STATUS")
	private String workflowStatus;
	// 发放类型 01:县级;02:乡镇级
	@Column(name = "GRANT_TYPE")
	private String grantType;

	/**
	 * getter for 编号
	 * 
	 * @generated
	 */
	public String getInfoId() {
		return this.infoId;
	}

	/**
	 * setter for 编号
	 * 
	 * @generated
	 */
	public void setInfoId(String infoId) {
		this.infoId = infoId;
	}

	/**
	 * getter for 批次明细ID
	 * 
	 * @generated
	 */
	public String getBatchDetailId() {
		return this.batchDetailId;
	}

	/**
	 * setter for 批次明细ID
	 * 
	 * @generated
	 */
	public void setBatchDetailId(String batchDetailId) {
		this.batchDetailId = batchDetailId;
	}

	/**
	 * getter for 档案编号
	 * 
	 * @generated
	 */
	public String getRecordId() {
		return this.recordId;
	}

	/**
	 * setter for 档案编号
	 * 
	 * @generated
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * getter for 填报类型
	 * 
	 * @generated
	 */
	public String getFillType() {
		return this.fillType;
	}

	/**
	 * setter for 填报类型
	 * 
	 * @generated
	 */
	public void setFillType(String fillType) {
		this.fillType = fillType;
	}

	/**
	 * getter for 救助类型
	 * 
	 * @generated
	 */
	public String getReliefType() {
		return this.reliefType;
	}

	/**
	 * setter for 救助类型
	 * 
	 * @generated
	 */
	public void setReliefType(String reliefType) {
		this.reliefType = reliefType;
	}

	/**
	 * getter for 需口粮救助（公斤）
	 * 
	 * @generated
	 */
	public BigDecimal getRequiredForFood() {
		return this.requiredForFood;
	}

	/**
	 * setter for 需口粮救助（公斤）
	 * 
	 * @generated
	 */
	public void setRequiredForFood(BigDecimal requiredForFood) {
		this.requiredForFood = requiredForFood;
	}

	/**
	 * getter for 需衣被救助（件）
	 * 
	 * @generated
	 */
	public BigDecimal getRequiredForClothes() {
		return this.requiredForClothes;
	}

	/**
	 * setter for 需衣被救助（件）
	 * 
	 * @generated
	 */
	public void setRequiredForClothes(BigDecimal requiredForClothes) {
		this.requiredForClothes = requiredForClothes;
	}

	/**
	 * getter for 需取暖救助（元）
	 * 
	 * @generated
	 */
	public BigDecimal getRequiredForHeat() {
		return this.requiredForHeat;
	}

	/**
	 * setter for 需取暖救助（元）
	 * 
	 * @generated
	 */
	public void setRequiredForHeat(BigDecimal requiredForHeat) {
		this.requiredForHeat = requiredForHeat;
	}

	/**
	 * getter for 需伤病救助（元）
	 * 
	 * @generated
	 */
	public BigDecimal getRequiredForDisease() {
		return this.requiredForDisease;
	}

	/**
	 * setter for 需伤病救助（元）
	 * 
	 * @generated
	 */
	public void setRequiredForDisease(BigDecimal requiredForDisease) {
		this.requiredForDisease = requiredForDisease;
	}

	/**
	 * getter for 需其他救助（元）
	 * 
	 * @generated
	 */
	public BigDecimal getRequiredForOthers() {
		return this.requiredForOthers;
	}

	/**
	 * setter for 需其他救助（元）
	 * 
	 * @generated
	 */
	public void setRequiredForOthers(BigDecimal requiredForOthers) {
		this.requiredForOthers = requiredForOthers;
	}

	/**
	 * getter for 受灾时间
	 * 
	 * @generated
	 */
	public String getDamageTime() {
		return this.damageTime;
	}

	/**
	 * setter for 受灾时间
	 * 
	 * @generated
	 */
	public void setDamageTime(String damageTime) {
		this.damageTime = damageTime;
	}

	/**
	 * getter for 灾害种类
	 * 
	 * @generated
	 */
	public String getDisasterType() {
		return this.disasterType;
	}

	/**
	 * setter for 灾害种类
	 * 
	 * @generated
	 */
	public void setDisasterType(String disasterType) {
		this.disasterType = disasterType;
	}

	/**
	 * getter for 倒塌房屋（间）
	 * 
	 * @generated
	 */
	public BigDecimal getCollapsedHouse() {
		return this.collapsedHouse;
	}

	/**
	 * setter for 倒塌房屋（间）
	 * 
	 * @generated
	 */
	public void setCollapsedHouse(BigDecimal collapsedHouse) {
		this.collapsedHouse = collapsedHouse;
	}

	/**
	 * getter for 严重损坏房屋（间）
	 * 
	 * @generated
	 */
	public BigDecimal getSeriousDamageHouse() {
		return this.seriousDamageHouse;
	}

	/**
	 * setter for 严重损坏房屋（间）
	 * 
	 * @generated
	 */
	public void setSeriousDamageHouse(BigDecimal seriousDamageHouse) {
		this.seriousDamageHouse = seriousDamageHouse;
	}

	/**
	 * getter for 一般损坏房屋（间）
	 * 
	 * @generated
	 */
	public BigDecimal getGeneralDamageHouse() {
		return this.generalDamageHouse;
	}

	/**
	 * setter for 一般损坏房屋（间）
	 * 
	 * @generated
	 */
	public void setGeneralDamageHouse(BigDecimal generalDamageHouse) {
		this.generalDamageHouse = generalDamageHouse;
	}

	/**
	 * getter for 需重建房屋（间）
	 * 
	 * @generated
	 */
	public BigDecimal getRebuildHouse() {
		return this.rebuildHouse;
	}

	/**
	 * setter for 需重建房屋（间）
	 * 
	 * @generated
	 */
	public void setRebuildHouse(BigDecimal rebuildHouse) {
		this.rebuildHouse = rebuildHouse;
	}

	/**
	 * getter for 需修缮房屋（间）
	 * 
	 * @generated
	 */
	public BigDecimal getRepairedHouse() {
		return this.repairedHouse;
	}

	/**
	 * setter for 需修缮房屋（间）
	 * 
	 * @generated
	 */
	public void setRepairedHouse(BigDecimal repairedHouse) {
		this.repairedHouse = repairedHouse;
	}

	/**
	 * getter for 死者姓名
	 * 
	 * @generated
	 */
	public String getDeadName() {
		return this.deadName;
	}

	/**
	 * setter for 死者姓名
	 * 
	 * @generated
	 */
	public void setDeadName(String deadName) {
		this.deadName = deadName;
	}

	/**
	 * getter for 死者性别
	 * 
	 * @generated
	 */
	public String getDeadSex() {
		return this.deadSex;
	}

	/**
	 * setter for 死者性别
	 * 
	 * @generated
	 */
	public void setDeadSex(String deadSex) {
		this.deadSex = deadSex;
	}

	/**
	 * getter for 死者年龄
	 * 
	 * @generated
	 */
	public String getDeadAge() {
		return this.deadAge;
	}

	/**
	 * setter for 死者年龄
	 * 
	 * @generated
	 */
	public void setDeadAge(String deadAge) {
		this.deadAge = deadAge;
	}

	/**
	 * getter for 死者民族
	 * 
	 * @generated
	 */
	public String getDeadFolk() {
		return this.deadFolk;
	}

	/**
	 * setter for 死者民族
	 * 
	 * @generated
	 */
	public void setDeadFolk(String deadFolk) {
		this.deadFolk = deadFolk;
	}

	/**
	 * getter for 死者户口所在地
	 * 
	 * @generated
	 */
	public String getDeadPopulace() {
		return this.deadPopulace;
	}

	/**
	 * setter for 死者户口所在地
	 * 
	 * @generated
	 */
	public void setDeadPopulace(String deadPopulace) {
		this.deadPopulace = deadPopulace;
	}

	/**
	 * getter for 死亡（失踪）地点
	 * 
	 * @generated
	 */
	public String getDeadMissingPlace() {
		return this.deadMissingPlace;
	}

	/**
	 * setter for 死亡（失踪）地点
	 * 
	 * @generated
	 */
	public void setDeadMissingPlace(String deadMissingPlace) {
		this.deadMissingPlace = deadMissingPlace;
	}

	/**
	 * getter for 死亡（失踪）时间
	 * 
	 * @generated
	 */
	public String getDeadMissingTime() {
		return this.deadMissingTime;
	}

	/**
	 * setter for 死亡（失踪）时间
	 * 
	 * @generated
	 */
	public void setDeadMissingTime(String deadMissingTime) {
		this.deadMissingTime = deadMissingTime;
	}

	/**
	 * getter for 死亡（失踪）原因
	 * 
	 * @generated
	 */
	public String getDeadMissingReason() {
		return this.deadMissingReason;
	}

	/**
	 * setter for 死亡（失踪）原因
	 * 
	 * @generated
	 */
	public void setDeadMissingReason(String deadMissingReason) {
		this.deadMissingReason = deadMissingReason;
	}

	/**
	 * getter for 核准救助户数
	 * 
	 * @generated
	 */
	public BigDecimal getApprovalFamilyNum() {
		return this.approvalFamilyNum;
	}

	/**
	 * setter for 核准救助户数
	 * 
	 * @generated
	 */
	public void setApprovalFamilyNum(BigDecimal approvalFamilyNum) {
		this.approvalFamilyNum = approvalFamilyNum;
	}

	/**
	 * getter for 核准救助时段
	 * 
	 * @generated
	 */
	public String getApprovalTimes() {
		return this.approvalTimes;
	}

	/**
	 * setter for 核准救助时段
	 * 
	 * @generated
	 */
	public void setApprovalTimes(String approvalTimes) {
		this.approvalTimes = approvalTimes;
	}

	/**
	 * getter for 核准救助粮食（公斤）
	 * 
	 * @generated
	 */
	public BigDecimal getApprovalFood() {
		return this.approvalFood;
	}

	/**
	 * setter for 核准救助粮食（公斤）
	 * 
	 * @generated
	 */
	public void setApprovalFood(BigDecimal approvalFood) {
		this.approvalFood = approvalFood;
	}

	/**
	 * getter for 核准救助衣被（件）
	 * 
	 * @generated
	 */
	public BigDecimal getApprovalClothes() {
		return this.approvalClothes;
	}

	/**
	 * setter for 核准救助衣被（件）
	 * 
	 * @generated
	 */
	public void setApprovalClothes(BigDecimal approvalClothes) {
		this.approvalClothes = approvalClothes;
	}

	/**
	 * getter for 核准重建间数（间）
	 * 
	 * @generated
	 */
	public BigDecimal getApprovalRebuiledHouse() {
		return this.approvalRebuiledHouse;
	}

	/**
	 * setter for 核准重建间数（间）
	 * 
	 * @generated
	 */
	public void setApprovalRebuiledHouse(BigDecimal approvalRebuiledHouse) {
		this.approvalRebuiledHouse = approvalRebuiledHouse;
	}

	/**
	 * getter for 核准修缮间数（间）
	 * 
	 * @generated
	 */
	public BigDecimal getApprovalRepairedHouse() {
		return this.approvalRepairedHouse;
	}

	/**
	 * setter for 核准修缮间数（间）
	 * 
	 * @generated
	 */
	public void setApprovalRepairedHouse(BigDecimal approvalRepairedHouse) {
		this.approvalRepairedHouse = approvalRepairedHouse;
	}

	/**
	 * getter for 核准救助资金（元）
	 * 
	 * @generated
	 */
	public BigDecimal getApprovalMonry() {
		return this.approvalMonry;
	}

	/**
	 * setter for 核准救助资金（元）
	 * 
	 * @generated
	 */
	public void setApprovalMonry(BigDecimal approvalMonry) {
		this.approvalMonry = approvalMonry;
	}

	/**
	 * getter for 资金发放类型
	 * 
	 * @generated
	 */
	public String getAllocationType() {
		return this.allocationType;
	}

	/**
	 * setter for 资金发放类型
	 * 
	 * @generated
	 */
	public void setAllocationType(String allocationType) {
		this.allocationType = allocationType;
	}

	/**
	 * getter for 开户银行
	 * 
	 * @generated
	 */
	public String getBank() {
		return this.bank;
	}

	/**
	 * setter for 开户银行
	 * 
	 * @generated
	 */
	public void setBank(String bank) {
		this.bank = bank;
	}

	/**
	 * getter for 开户银行地址
	 * 
	 * @generated
	 */
	public String getBankAdds() {
		return this.bankAdds;
	}

	/**
	 * setter for 开户银行地址
	 * 
	 * @generated
	 */
	public void setBankAdds(String bankAdds) {
		this.bankAdds = bankAdds;
	}

	/**
	 * getter for 开户银行帐号
	 * 
	 * @generated
	 */
	public String getAccountCode() {
		return this.accountCode;
	}

	/**
	 * setter for 开户银行帐号
	 * 
	 * @generated
	 */
	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	/**
	 * getter for 村级填报人姓名
	 * 
	 * @generated
	 */
	public String getAcceptPeopleName() {
		return this.acceptPeopleName;
	}

	/**
	 * setter for 村级填报人姓名
	 * 
	 * @generated
	 */
	public void setAcceptPeopleName(String acceptPeopleName) {
		this.acceptPeopleName = acceptPeopleName;
	}

	/**
	 * getter for 村级填报日期
	 * 
	 * @generated
	 */
	public String getAcceptDate() {
		return this.acceptDate;
	}

	/**
	 * setter for 村级填报日期
	 * 
	 * @generated
	 */
	public void setAcceptDate(String acceptDate) {
		this.acceptDate = acceptDate;
	}

	/**
	 * getter for 村级行政区划
	 * 
	 * @generated
	 */
	public String getAcceptAreaCode() {
		return this.acceptAreaCode;
	}

	/**
	 * setter for 村级行政区划
	 * 
	 * @generated
	 */
	public void setAcceptAreaCode(String acceptAreaCode) {
		this.acceptAreaCode = acceptAreaCode;
	}

	/**
	 * getter for 村级行政区划名称
	 * 
	 * @generated
	 */
	public String getAcceptAreaName() {
		return this.acceptAreaName;
	}

	/**
	 * setter for 村级行政区划名称
	 * 
	 * @generated
	 */
	public void setAcceptAreaName(String acceptAreaName) {
		this.acceptAreaName = acceptAreaName;
	}

	/**
	 * getter for 乡镇（街道）名称
	 * 
	 * @generated
	 */
	public String getCheckOrganName() {
		return this.checkOrganName;
	}

	/**
	 * setter for 乡镇（街道）名称
	 * 
	 * @generated
	 */
	public void setCheckOrganName(String checkOrganName) {
		this.checkOrganName = checkOrganName;
	}

	/**
	 * getter for 乡镇（街道）区划
	 * 
	 * @generated
	 */
	public String getCheckOrganCode() {
		return this.checkOrganCode;
	}

	/**
	 * setter for 乡镇（街道）区划
	 * 
	 * @generated
	 */
	public void setCheckOrganCode(String checkOrganCode) {
		this.checkOrganCode = checkOrganCode;
	}

	/**
	 * getter for 乡镇（街道）审核人名称
	 * 
	 * @generated
	 */
	public String getCheckPeopleName() {
		return this.checkPeopleName;
	}

	/**
	 * setter for 乡镇（街道）审核人名称
	 * 
	 * @generated
	 */
	public void setCheckPeopleName(String checkPeopleName) {
		this.checkPeopleName = checkPeopleName;
	}

	/**
	 * getter for 审核日期
	 * 
	 * @generated
	 */
	public String getCheckDate() {
		return this.checkDate;
	}

	/**
	 * setter for 审核日期
	 * 
	 * @generated
	 */
	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}

	/**
	 * getter for 县级名称
	 * 
	 * @generated
	 */
	public String getAuditOrganName() {
		return this.auditOrganName;
	}

	/**
	 * setter for 县级名称
	 * 
	 * @generated
	 */
	public void setAuditOrganName(String auditOrganName) {
		this.auditOrganName = auditOrganName;
	}

	/**
	 * getter for 县区划
	 * 
	 * @generated
	 */
	public String getAuditOrganCode() {
		return this.auditOrganCode;
	}

	/**
	 * setter for 县区划
	 * 
	 * @generated
	 */
	public void setAuditOrganCode(String auditOrganCode) {
		this.auditOrganCode = auditOrganCode;
	}

	/**
	 * getter for 县级批准人名称
	 * 
	 * @generated
	 */
	public String getAuditPeopleName() {
		return this.auditPeopleName;
	}

	/**
	 * setter for 县级批准人名称
	 * 
	 * @generated
	 */
	public void setAuditPeopleName(String auditPeopleName) {
		this.auditPeopleName = auditPeopleName;
	}

	/**
	 * getter for 批准日期
	 * 
	 * @generated
	 */
	public String getAuditDate() {
		return this.auditDate;
	}

	/**
	 * setter for 批准日期
	 * 
	 * @generated
	 */
	public void setAuditDate(String auditDate) {
		this.auditDate = auditDate;
	}

	/**
	 * getter for 发放单位名称
	 * 
	 * @generated
	 */
	public String getGrantOrganName() {
		return this.grantOrganName;
	}

	/**
	 * setter for 发放单位名称
	 * 
	 * @generated
	 */
	public void setGrantOrganName(String grantOrganName) {
		this.grantOrganName = grantOrganName;
	}

	/**
	 * getter for 发放单位区划
	 * 
	 * @generated
	 */
	public String getGrantOrganCode() {
		return this.grantOrganCode;
	}

	/**
	 * setter for 发放单位区划
	 * 
	 * @generated
	 */
	public void setGrantOrganCode(String grantOrganCode) {
		this.grantOrganCode = grantOrganCode;
	}

	/**
	 * getter for 发放人名称
	 * 
	 * @generated
	 */
	public String getGrantPeopleName() {
		return this.grantPeopleName;
	}

	/**
	 * setter for 发放人名称
	 * 
	 * @generated
	 */
	public void setGrantPeopleName(String grantPeopleName) {
		this.grantPeopleName = grantPeopleName;
	}

	/**
	 * getter for 发放日期
	 * 
	 * @generated
	 */
	public String getGrantTime() {
		return this.grantTime;
	}

	/**
	 * setter for 发放日期
	 * 
	 * @generated
	 */
	public void setGrantTime(String grantTime) {
		this.grantTime = grantTime;
	}

	/**
	 * getter for 填报单位代码
	 * 
	 * @generated
	 */
	public String getOrganCode() {
		return this.organCode;
	}

	/**
	 * setter for 填报单位代码
	 * 
	 * @generated
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * getter for 填报单位名称
	 * 
	 * @generated
	 */
	public String getOrganName() {
		return this.organName;
	}

	/**
	 * setter for 填报单位名称
	 * 
	 * @generated
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * getter for 填报时间
	 * 
	 * @generated
	 */
	public String getFillTime() {
		return this.fillTime;
	}

	/**
	 * setter for 填报时间
	 * 
	 * @generated
	 */
	public void setFillTime(String fillTime) {
		this.fillTime = fillTime;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * getter for 流程跳转状态
	 * 
	 * @generated
	 */
	public String getWorkflowStatus() {
		return this.workflowStatus;
	}

	/**
	 * setter for 流程跳转状态
	 * 
	 * @generated
	 */
	public void setWorkflowStatus(String workflowStatus) {
		this.workflowStatus = workflowStatus;
	}

	/**
	 * getter for 发放类型
	 * 
	 * @generated
	 */
	public String getGrantType() {
		return grantType;
	}


	/**
	 * setter for 发放类型
	 * 
	 * @generated
	 */
	public void setGrantType(String grantType) {
		this.grantType = grantType;
	}

}