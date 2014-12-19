package com.inspur.cams.drel.funds.release.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SamReleaseSummary
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
 */
@Table(tableName = "SAM_RELEASE_SUMMARY", keyFields = "releaseId")
public class SamReleaseSummary extends StatefulDatabean {
	// RELEASE_ID
	@Column(name = "RELEASE_ID")
	private String releaseId;
	// 救助类别
	@Column(name = "ASSISTANCE_TYPE")
	private String assistanceType;
   	//发放项目
   	@Column(name="RELEASE_ITEM")
   	private String releaseItem;
	// 名册类别
	@Column(name = "RELEASE_TYPE")
	private String releaseType;
	// 发放方式
	@Column(name = "RELEASE_WAY")
	private String releaseWay;
	// 发放标准
	@Column(name = "RELEASE_STANDARD")
	private BigDecimal releaseStandard;
	// 发放区域
	@Column(name = "RELEASE_AREA_CODE")
	private String releaseAreaCode;
	// 发放区域名称
	@Column(name = "RELEASE_AREA_NAME")
	private String releaseAreaName;
	// 发放日期
	@Column(name = "RELEASE_DATE")
	private String releaseDate;
	// 发放开始日期
	@Column(name = "RELEASE_BEGIN_DATE")
	private String releaseBeginDate;
	// 发放结束日期
	@Column(name = "RELEASE_END_DATE")
	private String releaseEndDate;
	// 发放月数
	@Column(name = "RELEASE_MONTH_NUM")
	private String releaseMonthNum;
	// 发放对象
	@Column(name = "RELEASE_TARGET")
	private String releaseTarget;
	// 发放总额
	@Column(name = "RELEASE_FUND_SUM")
	private BigDecimal releaseFundSum;
	// 发放总户数
	@Column(name = "RELEASE_FAMILY_SUM")
	private BigDecimal releaseFamilySum;
	// 救助金总额
	@Column(name = "BASE_MON_SUM")
	private BigDecimal baseMonSum;
	// 发放总人数
	@Column(name = "RELEASE_PEOPLE_NUM")
	private BigDecimal releasePeopleNum;
	// 分类施保金总额
	@Column(name = "CLASS_MON_SUM")
	private BigDecimal classMonSum;
	// 人均发放额
	@Column(name = "RELEASE_AVERAGE")
	private BigDecimal releaseAverage;
	// 发放状态标志
	@Column(name = "RELEASE_STATUS")
	private String releaseStatus;
	// 确认日期
	@Column(name = "CONFIRM_DATE")
	private String confirmDate;
	// 是否专项救助
	@Column(name = "IS_SPECIAL")
	private String isSpecial;
	// 反馈状态
	@Column(name = "FEEDBACK_STATUS")
	private String feedbackStatus;
	// 备注
	@Column(name = "REMARKS")
	private String remarks;
	// REG_ID
	@Column(name = "REG_ID")
	private String regId;
	// 生成单位行政区划
	@Column(name = "REG_AREA_CODE")
	private String regAreaCode;
	// REG_TIME
	@Column(name = "REG_TIME")
	private String regTime;
	// MOD_ID
	@Column(name = "MOD_ID")
	private String modId;
	// MOD_TIME
	@Column(name = "MOD_TIME")
	private String modTime;

	/**
	 * getter for RELEASE_ID
	 * 
	 * @generated
	 */
	public String getReleaseId() {
		return this.releaseId;
	}

	/**
	 * setter for RELEASE_ID
	 * 
	 * @generated
	 */
	public void setReleaseId(String releaseId) {
		this.releaseId = releaseId;
	}

	/**
	 * getter for 救助类别
	 * 
	 * @generated
	 */
	public String getAssistanceType() {
		return this.assistanceType;
	}

	/**
	 * setter for 救助类别
	 * 
	 * @generated
	 */
	public void setAssistanceType(String assistanceType) {
		this.assistanceType = assistanceType;
	}

	/**
	 * @return the releaseWay
	 */
	public String getReleaseWay() {
		return releaseWay;
	}

	/**
	 * @param releaseWay
	 *            the releaseWay to set
	 */
	public void setReleaseWay(String releaseWay) {
		this.releaseWay = releaseWay;
	}

	/**
	 * getter for 发放类别
	 * 
	 * @generated
	 */
	public String getReleaseType() {
		return this.releaseType;
	}

	/**
	 * setter for 发放类别
	 * 
	 * @generated
	 */
	public void setReleaseType(String releaseType) {
		this.releaseType = releaseType;
	}

	/**
	 * getter for 发放区域
	 * 
	 * @generated
	 */
	public String getReleaseAreaCode() {
		return this.releaseAreaCode;
	}

	/**
	 * setter for 发放区域
	 * 
	 * @generated
	 */
	public void setReleaseAreaCode(String releaseAreaCode) {
		this.releaseAreaCode = releaseAreaCode;
	}

	/**
	 * getter for 发放区域名称
	 * 
	 * @generated
	 */
	public String getReleaseAreaName() {
		return this.releaseAreaName;
	}

	/**
	 * setter for 发放区域名称
	 * 
	 * @generated
	 */
	public void setReleaseAreaName(String releaseAreaName) {
		this.releaseAreaName = releaseAreaName;
	}

	/**
	 * getter for 发放日期
	 * 
	 * @generated
	 */
	public String getReleaseDate() {
		return this.releaseDate;
	}

	/**
	 * setter for 发放日期
	 * 
	 * @generated
	 */
	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	/**
	 * getter for 发放总额
	 * 
	 * @generated
	 */
	public BigDecimal getReleaseFundSum() {
		return this.releaseFundSum;
	}

	/**
	 * setter for 发放总额
	 * 
	 * @generated
	 */
	public void setReleaseFundSum(BigDecimal releaseFundSum) {
		this.releaseFundSum = releaseFundSum;
	}

	/**
	 * getter for 发放总户数
	 * 
	 * @generated
	 */
	public BigDecimal getReleaseFamilySum() {
		return this.releaseFamilySum;
	}

	/**
	 * setter for 发放总户数
	 * 
	 * @generated
	 */
	public void setReleaseFamilySum(BigDecimal releaseFamilySum) {
		this.releaseFamilySum = releaseFamilySum;
	}

	/**
	 * getter for 发放总人数
	 * 
	 * @generated
	 */
	public BigDecimal getReleasePeopleNum() {
		return this.releasePeopleNum;
	}

	/**
	 * setter for 发放总人数
	 * 
	 * @generated
	 */
	public void setReleasePeopleNum(BigDecimal releasePeopleNum) {
		this.releasePeopleNum = releasePeopleNum;
	}

	

	
	public String getReleaseItem() {
		return releaseItem;
	}

	public void setReleaseItem(String releaseItem) {
		this.releaseItem = releaseItem;
	}

	public String getReleaseBeginDate() {
		return releaseBeginDate;
	}

	public void setReleaseBeginDate(String releaseBeginDate) {
		this.releaseBeginDate = releaseBeginDate;
	}

	public String getReleaseEndDate() {
		return releaseEndDate;
	}

	public void setReleaseEndDate(String releaseEndDate) {
		this.releaseEndDate = releaseEndDate;
	}

	public String getReleaseMonthNum() {
		return releaseMonthNum;
	}

	public void setReleaseMonthNum(String releaseMonthNum) {
		this.releaseMonthNum = releaseMonthNum;
	}

	public String getReleaseTarget() {
		return releaseTarget;
	}

	public void setReleaseTarget(String releaseTarget) {
		this.releaseTarget = releaseTarget;
	}

	public BigDecimal getBaseMonSum() {
		return baseMonSum;
	}

	public void setBaseMonSum(BigDecimal baseMonSum) {
		this.baseMonSum = baseMonSum;
	}

	public BigDecimal getClassMonSum() {
		return classMonSum;
	}

	public void setClassMonSum(BigDecimal classMonSum) {
		this.classMonSum = classMonSum;
	}

	public String getIsSpecial() {
		return isSpecial;
	}

	public void setIsSpecial(String isSpecial) {
		this.isSpecial = isSpecial;
	}

	public String getFeedbackStatus() {
		return feedbackStatus;
	}

	public void setFeedbackStatus(String feedbackStatus) {
		this.feedbackStatus = feedbackStatus;
	}

	/**
	 * getter for 发放状态标志
	 * 
	 * @generated
	 */
	public String getReleaseStatus() {
		return this.releaseStatus;
	}

	/**
	 * setter for 发放状态标志
	 * 
	 * @generated
	 */
	public void setReleaseStatus(String releaseStatus) {
		this.releaseStatus = releaseStatus;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getRemarks() {
		return this.remarks;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	/**
	 * getter for REG_ID
	 * 
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for REG_ID
	 * 
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for REG_TIME
	 * 
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for REG_TIME
	 * 
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for MOD_ID
	 * 
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for MOD_ID
	 * 
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for MOD_TIME
	 * 
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for MOD_TIME
	 * 
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	/**
	 * @return the confirmDate
	 */
	public String getConfirmDate() {
		return confirmDate;
	}

	/**
	 * @param confirmDate
	 *            the confirmDate to set
	 */
	public void setConfirmDate(String confirmDate) {
		this.confirmDate = confirmDate;
	}

	/**
	 * @return the regAreaCode
	 */
	public String getRegAreaCode() {
		return regAreaCode;
	}

	/**
	 * @param regAreaCode
	 *            the regAreaCode to set
	 */
	public void setRegAreaCode(String regAreaCode) {
		this.regAreaCode = regAreaCode;
	}

	public BigDecimal getReleaseStandard() {
		return releaseStandard;
	}

	public void setReleaseStandard(BigDecimal releaseStandard) {
		this.releaseStandard = releaseStandard;
	}

	public BigDecimal getReleaseAverage() {
		return releaseAverage;
	}

	public void setReleaseAverage(BigDecimal releaseAverage) {
		this.releaseAverage = releaseAverage;
	}

}