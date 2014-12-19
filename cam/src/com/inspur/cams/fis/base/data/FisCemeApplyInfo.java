package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 公墓审批业务表databean
 * 
 * @author
 * @date 2013-08-01
 */
@Table(tableName = "FIS_CEME_APPLY_INFO", keyFields = "cemeApplyId")
public class FisCemeApplyInfo extends StatefulDatabean {

	// 业务审批编码
	private String cemeApplyId;

	// 公墓记录编码
	private String recordId;

	// 业务标识
	private String applyFlag;

	// 业务状态
	private String applyState;

	// 流程编码
	private String wfId;

	// 当前环节
	private String curActivity;

	// 当前单位编码
	private String curOrganCode;

	// 当前单位名称
	private String curOrgan;

	// 接收时间
	private String recTime;

	// 处理时间
	private String comTime;

	// 年检年份
	private String checkYear;

	// 年检次数
	private String checkNum;
	
	//乡级审核时间
	private String zeroTime;
	
	//乡级审核结果
	
	private String zeroResult;
	
	//乡级审核单位ID
	private String zeroUnitId;
	
	//乡级审核单位
	private String zeroUnit;
	
	//乡级审核意见
	private String zeroOpinion;

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

	// 省级审批单位ID
	private String thirdUnitId;

	// 年检结果
	private String checkResult;

	// 是否领证
	private String isTakeproof;

	// 上报状态
	private String isReport;

	// 省级审批时间
	private String thirdTime;

	// 省级审批结果
	private String thirdResult;

	// 省级审批备注
	private String thirdRemarks;

	// 省级审批单位
	private String thirdUnit;

	// 省级审批意见
	private String thirdOpinion;

	// 发起单位编码
	private String fillOrganCode;

	// 发起单位名称
	private String fillOrganName;

	private String firstReportName;
	private String firstReportNumber;
	private String firstReportTime;
	private String secondReportName;
	private String secondReportNumber;
	private String secondReportTime;
	private String thirdReportName;
	private String thirdReportNumber;
	private String thirdReportTime;

	public String getFirstReportName() {
		return firstReportName;
	}

	public void setFirstReportName(String firstReportName) {
		this.firstReportName = firstReportName;
	}

	public String getFirstReportNumber() {
		return firstReportNumber;
	}

	public void setFirstReportNumber(String firstReportNumber) {
		this.firstReportNumber = firstReportNumber;
	}

	public String getFirstReportTime() {
		return firstReportTime;
	}

	public void setFirstReportTime(String firstReportTime) {
		this.firstReportTime = firstReportTime;
	}

	public String getSecondReportName() {
		return secondReportName;
	}

	public void setSecondReportName(String secondReportName) {
		this.secondReportName = secondReportName;
	}

	public String getSecondReportNumber() {
		return secondReportNumber;
	}

	public void setSecondReportNumber(String secondReportNumber) {
		this.secondReportNumber = secondReportNumber;
	}

	public String getSecondReportTime() {
		return secondReportTime;
	}

	public void setSecondReportTime(String secondReportTime) {
		this.secondReportTime = secondReportTime;
	}

	public String getThirdReportName() {
		return thirdReportName;
	}

	public void setThirdReportName(String thirdReportName) {
		this.thirdReportName = thirdReportName;
	}

	public String getThirdReportNumber() {
		return thirdReportNumber;
	}

	public void setThirdReportNumber(String thirdReportNumber) {
		this.thirdReportNumber = thirdReportNumber;
	}

	public String getThirdReportTime() {
		return thirdReportTime;
	}

	public void setThirdReportTime(String thirdReportTime) {
		this.thirdReportTime = thirdReportTime;
	}

	public String getFillOrganCode() {
		return fillOrganCode;
	}

	public void setFillOrganCode(String fillOrganCode) {
		this.fillOrganCode = fillOrganCode;
	}

	public String getFillOrganName() {
		return fillOrganName;
	}

	public void setFillOrganName(String fillOrganName) {
		this.fillOrganName = fillOrganName;
	}

	/**
	 * 获取 业务审批编码
	 * 
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
	 * 
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
	 * 获取 业务标识
	 * 
	 * @return String
	 */
	public String getApplyFlag() {
		return applyFlag;
	}

	/**
	 * 设置 业务标识
	 */
	public void setApplyFlag(String applyFlag) {
		this.applyFlag = applyFlag;
	}

	/**
	 * 获取 业务状态
	 * 
	 * @return String
	 */
	public String getApplyState() {
		return applyState;
	}

	/**
	 * 设置 业务状态
	 */
	public void setApplyState(String applyState) {
		this.applyState = applyState;
	}

	/**
	 * 获取 流程编码
	 * 
	 * @return String
	 */
	public String getWfId() {
		return wfId;
	}

	/**
	 * 设置 流程编码
	 */
	public void setWfId(String wfId) {
		this.wfId = wfId;
	}

	/**
	 * 获取 当前环节
	 * 
	 * @return String
	 */
	public String getCurActivity() {
		return curActivity;
	}

	/**
	 * 设置 当前环节
	 */
	public void setCurActivity(String curActivity) {
		this.curActivity = curActivity;
	}

	/**
	 * 获取 当前单位编码
	 * 
	 * @return String
	 */
	public String getCurOrganCode() {
		return curOrganCode;
	}

	/**
	 * 设置 当前单位编码
	 */
	public void setCurOrganCode(String curOrganCode) {
		this.curOrganCode = curOrganCode;
	}

	/**
	 * 获取 当前单位名称
	 * 
	 * @return String
	 */
	public String getCurOrgan() {
		return curOrgan;
	}

	/**
	 * 设置 当前单位名称
	 */
	public void setCurOrgan(String curOrgan) {
		this.curOrgan = curOrgan;
	}

	/**
	 * 获取 接收时间
	 * 
	 * @return String
	 */
	public String getRecTime() {
		return recTime;
	}

	/**
	 * 设置 接收时间
	 */
	public void setRecTime(String recTime) {
		this.recTime = recTime;
	}

	/**
	 * 获取 处理时间
	 * 
	 * @return String
	 */
	public String getComTime() {
		return comTime;
	}

	/**
	 * 设置 处理时间
	 */
	public void setComTime(String comTime) {
		this.comTime = comTime;
	}

	/**
	 * 获取 年检年份
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 
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
	 * 获取 省级审批单位ID
	 * 
	 * @return String
	 */
	public String getThirdUnitId() {
		return thirdUnitId;
	}

	/**
	 * 设置 省级审批单位ID
	 */
	public void setThirdUnitId(String thirdUnitId) {
		this.thirdUnitId = thirdUnitId;
	}

	/**
	 * 获取 年检结果
	 * 
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
	 * 
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
	 * 
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

	/**
	 * 获取 省级审批时间
	 * 
	 * @return String
	 */
	public String getThirdTime() {
		return thirdTime;
	}

	/**
	 * 设置 省级审批时间
	 */
	public void setThirdTime(String thirdTime) {
		this.thirdTime = thirdTime;
	}

	/**
	 * 获取 省级审批结果
	 * 
	 * @return String
	 */
	public String getThirdResult() {
		return thirdResult;
	}

	/**
	 * 设置 省级审批结果
	 */
	public void setThirdResult(String thirdResult) {
		this.thirdResult = thirdResult;
	}

	/**
	 * 获取 省级审批备注
	 * 
	 * @return String
	 */
	public String getThirdRemarks() {
		return thirdRemarks;
	}

	/**
	 * 设置 省级审批备注
	 */
	public void setThirdRemarks(String thirdRemarks) {
		this.thirdRemarks = thirdRemarks;
	}

	/**
	 * 获取 省级审批单位
	 * 
	 * @return String
	 */
	public String getThirdUnit() {
		return thirdUnit;
	}

	/**
	 * 设置 省级审批单位
	 */
	public void setThirdUnit(String thirdUnit) {
		this.thirdUnit = thirdUnit;
	}

	/**
	 * 获取 省级审批意见
	 * 
	 * @return String
	 */
	public String getThirdOpinion() {
		return thirdOpinion;
	}

	/**
	 * 设置 省级审批意见
	 */
	public void setThirdOpinion(String thirdOpinion) {
		this.thirdOpinion = thirdOpinion;
	}
	
	/**
	 * 获得 乡级审核时间
	 */
	public String getZeroTime(){
		return zeroTime;
	}
	
	/**
	 * 设置 乡级审核时间
	 */
	public void setZeroTime(String zeroTime){
		this.zeroTime=zeroTime;
	}
	
	/**
	 * 获得 乡级审核结果
	 */
	public String getZeroResult(){
		return zeroResult;
	}
	
	/**
	 * 设置 乡级审核结果
	 */
	public void setZeroResult(String zeroResult){
		this.zeroResult=zeroResult;
	}
	/**
	 * 获得 乡级审核单位ID
	 */
	public String getZeroUnitId(){
		return zeroUnitId;
	}
	
	/**
	 * 设置 乡级审核单位ID
	 */
	public void setZeroUnitId(String zeroUnitId){
		this.zeroUnitId=zeroUnitId;
	}
	/**
	 * 获得 乡级审核单位
	 */
	public String getZeroUnit(){
		return zeroUnit;
	}
	
	/**
	 * 设置 乡级审核单位
	 */
	public void setZeroUnit(String zeroUnit){
		this.zeroUnit=zeroUnit;
	}
	/**
	 * 获得 乡级审核意见
	 */
	public String getZeroOpinion(){
		return zeroOpinion;
	}
	
	/**
	 * 设置 乡级审核意见
	 */
	public void setZeroOpinion(String zeroOpinion){
		this.zeroOpinion=zeroOpinion;
	}
	//整顿截止日期
	private String  rectifyDeadline;
	
	public String getRectifyDeadline(){
		return rectifyDeadline;
	}
	public void setRectifyDeadline(String rectifyDeadline){
		this.rectifyDeadline=rectifyDeadline;
	}

}