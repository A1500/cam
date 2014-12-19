package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓年检整改历史记录表databean
 * @author 
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_CHECK_HISTORY", keyFields = "hisId")
public class FisCemeCheckHistory extends StatefulDatabean {

	// 流程历史记录ID
	private String hisId;

	// 业务审批编码
	private String cemeApplyId;
	
	private String createTime;

	// 公墓记录编码
	private String recordId;

	// 年检年份
	private String checkYear;

	// 年检次数
	private String checkNum;

	// 县级审核时间
	private String firstTime;

	// 县级审核结果
	private String firstResult;

	// 县级审核备注
	private String firstRemarks;

	// 县级审核总得分
	private BigDecimal firstTotalScore;

	// 县级审核年检报告
	private String firstAnnuareport;

	// 县级审核单位ID
	private String firstUnitId;

	// 县级审核单位
	private String firstUnit;

	// 县级审核意见
	private String firstOpinion;

	// 市级审批时间
	private String secondTime;

	// 市级审批结果
	private String secondResult;

	// 市级审批备注
	private String secondRemarks;

	// 市级审批总得分
	private BigDecimal secondTotalScore;

	// 市级审批年检报告
	private String secondAnnuareport;

	// 市级审批单位ID
	private String secondUnitId;

	// 市级审批单位
	private String secondUnit;

	// 市级审批意见
	private String secondOpinion;
	
	// 省级审批时间
	private String thirdTime;

	// 省级审批结果
	private String thirdResult;
	
	// 省级审批单位ID
	private String thirdUnitId;

	// 省级审批单位
	private String thirdUnit;

	// 省级审批意见
	private String thirdOpinion;

	// 年检结果
	private String checkResult;

	// 是否领证
	private String isTakeproof;

	// 上报状态
	private String isReport;

	/**
	 * 获取 流程历史记录ID
	 * @return String
	 */
	public String getHisId() {
		return hisId;
	}

	/**
	 * 设置 流程历史记录ID
	 */
	public void setHisId(String hisId) {
		this.hisId = hisId;
	}

	/**
	 * 获取 业务审批编码
	 * @return String
	 */
	public String getCemeApplyId() {
		return cemeApplyId;
	}

	/**
	 * 设置 业务审批编码
	 */
	public void setCemeApplyId(String cemeApplyId) {
		this.cemeApplyId = cemeApplyId;
	}

	/**
	 * 获取 公墓记录编码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 公墓记录编码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 年检年份
	 * @return String
	 */
	public String getCheckYear() {
		return checkYear;
	}

	/**
	 * 设置 年检年份
	 */
	public void setCheckYear(String checkYear) {
		this.checkYear = checkYear;
	}

	/**
	 * 获取 年检次数
	 * @return String
	 */
	public String getCheckNum() {
		return checkNum;
	}

	/**
	 * 设置 年检次数
	 */
	public void setCheckNum(String checkNum) {
		this.checkNum = checkNum;
	}

	/**
	 * 获取 县级审核时间
	 * @return String
	 */
	public String getFirstTime() {
		return firstTime;
	}

	/**
	 * 设置 县级审核时间
	 */
	public void setFirstTime(String firstTime) {
		this.firstTime = firstTime;
	}

	/**
	 * 获取 县级审核结果
	 * @return String
	 */
	public String getFirstResult() {
		return firstResult;
	}

	/**
	 * 设置 县级审核结果
	 */
	public void setFirstResult(String firstResult) {
		this.firstResult = firstResult;
	}

	/**
	 * 获取 县级审核备注
	 * @return String
	 */
	public String getFirstRemarks() {
		return firstRemarks;
	}

	/**
	 * 设置 县级审核备注
	 */
	public void setFirstRemarks(String firstRemarks) {
		this.firstRemarks = firstRemarks;
	}

	/**
	 * 获取 县级审核总得分
	 * @return BigDecimal
	 */
	public BigDecimal getFirstTotalScore() {
		return firstTotalScore;
	}

	/**
	 * 设置 县级审核总得分
	 */
	public void setFirstTotalScore(BigDecimal firstTotalScore) {
		this.firstTotalScore = firstTotalScore;
	}

	/**
	 * 获取 县级审核年检报告
	 * @return String
	 */
	public String getFirstAnnuareport() {
		return firstAnnuareport;
	}

	/**
	 * 设置 县级审核年检报告
	 */
	public void setFirstAnnuareport(String firstAnnuareport) {
		this.firstAnnuareport = firstAnnuareport;
	}

	/**
	 * 获取 县级审核单位ID
	 * @return String
	 */
	public String getFirstUnitId() {
		return firstUnitId;
	}

	/**
	 * 设置 县级审核单位ID
	 */
	public void setFirstUnitId(String firstUnitId) {
		this.firstUnitId = firstUnitId;
	}

	/**
	 * 获取 县级审核单位
	 * @return String
	 */
	public String getFirstUnit() {
		return firstUnit;
	}

	/**
	 * 设置 县级审核单位
	 */
	public void setFirstUnit(String firstUnit) {
		this.firstUnit = firstUnit;
	}

	/**
	 * 获取 县级审核意见
	 * @return String
	 */
	public String getFirstOpinion() {
		return firstOpinion;
	}

	/**
	 * 设置 县级审核意见
	 */
	public void setFirstOpinion(String firstOpinion) {
		this.firstOpinion = firstOpinion;
	}

	/**
	 * 获取 市级审批时间
	 * @return String
	 */
	public String getSecondTime() {
		return secondTime;
	}

	/**
	 * 设置 市级审批时间
	 */
	public void setSecondTime(String secondTime) {
		this.secondTime = secondTime;
	}

	/**
	 * 获取 市级审批结果
	 * @return String
	 */
	public String getSecondResult() {
		return secondResult;
	}

	/**
	 * 设置 市级审批结果
	 */
	public void setSecondResult(String secondResult) {
		this.secondResult = secondResult;
	}

	/**
	 * 获取 市级审批备注
	 * @return String
	 */
	public String getSecondRemarks() {
		return secondRemarks;
	}

	/**
	 * 设置 市级审批备注
	 */
	public void setSecondRemarks(String secondRemarks) {
		this.secondRemarks = secondRemarks;
	}

	/**
	 * 获取 市级审批总得分
	 * @return BigDecimal
	 */
	public BigDecimal getSecondTotalScore() {
		return secondTotalScore;
	}

	/**
	 * 设置 市级审批总得分
	 */
	public void setSecondTotalScore(BigDecimal secondTotalScore) {
		this.secondTotalScore = secondTotalScore;
	}

	/**
	 * 获取 市级审批年检报告
	 * @return String
	 */
	public String getSecondAnnuareport() {
		return secondAnnuareport;
	}

	/**
	 * 设置 市级审批年检报告
	 */
	public void setSecondAnnuareport(String secondAnnuareport) {
		this.secondAnnuareport = secondAnnuareport;
	}

	/**
	 * 获取 市级审批单位ID
	 * @return String
	 */
	public String getSecondUnitId() {
		return secondUnitId;
	}

	/**
	 * 设置 市级审批单位ID
	 */
	public void setSecondUnitId(String secondUnitId) {
		this.secondUnitId = secondUnitId;
	}

	/**
	 * 获取 市级审批单位
	 * @return String
	 */
	public String getSecondUnit() {
		return secondUnit;
	}

	/**
	 * 设置 市级审批单位
	 */
	public void setSecondUnit(String secondUnit) {
		this.secondUnit = secondUnit;
	}

	/**
	 * 获取 市级审批意见
	 * @return String
	 */
	public String getSecondOpinion() {
		return secondOpinion;
	}

	/**
	 * 设置 市级审批意见
	 */
	public void setSecondOpinion(String secondOpinion) {
		this.secondOpinion = secondOpinion;
	}

	/**
	 * 获取 年检结果
	 * @return String
	 */
	public String getCheckResult() {
		return checkResult;
	}

	/**
	 * 设置 年检结果
	 */
	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	/**
	 * 获取 是否领证
	 * @return String
	 */
	public String getIsTakeproof() {
		return isTakeproof;
	}

	/**
	 * 设置 是否领证
	 */
	public void setIsTakeproof(String isTakeproof) {
		this.isTakeproof = isTakeproof;
	}

	/**
	 * 获取 上报状态
	 * @return String
	 */
	public String getIsReport() {
		return isReport;
	}

	/**
	 * 设置 上报状态
	 */
	public void setIsReport(String isReport) {
		this.isReport = isReport;
	}
	public String getThirdTime() {
		return thirdTime;
	}

	public void setThirdTime(String thirdTime) {
		this.thirdTime = thirdTime;
	}

	public String getThirdResult() {
		return thirdResult;
	}

	public void setThirdResult(String thirdResult) {
		this.thirdResult = thirdResult;
	}

	public String getThirdUnitId() {
		return thirdUnitId;
	}

	public void setThirdUnitId(String thirdUnitId) {
		this.thirdUnitId = thirdUnitId;
	}

	public String getThirdUnit() {
		return thirdUnit;
	}

	public void setThirdUnit(String thirdUnit) {
		this.thirdUnit = thirdUnit;
	}

	public String getThirdOpinion() {
		return thirdOpinion;
	}

	public void setThirdOpinion(String thirdOpinion) {
		this.thirdOpinion = thirdOpinion;
	}
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}