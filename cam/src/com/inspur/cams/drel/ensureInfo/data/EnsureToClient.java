package com.inspur.cams.drel.ensureInfo.data;



import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 核查业务反馈表databean
 * @author 
 * @date 2014-07-23
 */
@Table(tableName = "ENSURE_TO_CLIENT", keyFields = "ensureId")
public class EnsureToClient extends StatefulDatabean {

	// 业务主键
	private String ensureId;

	// 历史信息主键
	private String historyInfoId;

	// 委托业务
	private String applyId;

	// 核查业务
	private String commissionId;

	// 接收单位主键
	private String acceptUnitId;

	// 接收单位
	private String acceptUnit;

	// 所属行政区划代码
	private String areaCode;

	// 所属行政区划名称
	private String areaName;

	// 户主姓名
	private String familyName;

	// 户主身份证号
	private String familyIdCard;

	// 核查单位主键
	private String ensureUnitId;

	// 核查单位
	private String ensureUnit;

	// 核查收入
	private String ensureIncome;

	// 核查支出
	private String ensureExpend;

	// 核查财产
	private String ensureProperty;

	// 反馈时间
	private String feedbackTime;

	// 反馈结果
	private String feedbackResult;

	// 查看标示
	private String readStatus;

	// 导入导出标识
	private String inOutStatus;

	// 当前标识
	private String currentStatus;

	/**
	 * 获取 业务主键
	 * @return String
	 */
	public String getEnsureId() {
		return ensureId;
	}

	/**
	 * 设置 业务主键
	 */
	public void setEnsureId(String ensureId) {
		this.ensureId = ensureId;
	}

	/**
	 * 获取 历史信息主键
	 * @return String
	 */
	public String getHistoryInfoId() {
		return historyInfoId;
	}

	/**
	 * 设置 历史信息主键
	 */
	public void setHistoryInfoId(String historyInfoId) {
		this.historyInfoId = historyInfoId;
	}

	/**
	 * 获取 委托业务
	 * @return String
	 */
	public String getApplyId() {
		return applyId;
	}

	/**
	 * 设置 委托业务
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * 获取 核查业务
	 * @return String
	 */
	public String getCommissionId() {
		return commissionId;
	}

	/**
	 * 设置 核查业务
	 */
	public void setCommissionId(String commissionId) {
		this.commissionId = commissionId;
	}

	/**
	 * 获取 接收单位主键
	 * @return String
	 */
	public String getAcceptUnitId() {
		return acceptUnitId;
	}

	/**
	 * 设置 接收单位主键
	 */
	public void setAcceptUnitId(String acceptUnitId) {
		this.acceptUnitId = acceptUnitId;
	}

	/**
	 * 获取 接收单位
	 * @return String
	 */
	public String getAcceptUnit() {
		return acceptUnit;
	}

	/**
	 * 设置 接收单位
	 */
	public void setAcceptUnit(String acceptUnit) {
		this.acceptUnit = acceptUnit;
	}

	/**
	 * 获取 所属行政区划代码
	 * @return String
	 */
	public String getAreaCode() {
		return areaCode;
	}

	/**
	 * 设置 所属行政区划代码
	 */
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	/**
	 * 获取 所属行政区划名称
	 * @return String
	 */
	public String getAreaName() {
		return areaName;
	}

	/**
	 * 设置 所属行政区划名称
	 */
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	/**
	 * 获取 户主姓名
	 * @return String
	 */
	public String getFamilyName() {
		return familyName;
	}

	/**
	 * 设置 户主姓名
	 */
	public void setFamilyName(String familyName) {
		this.familyName = familyName;
	}

	/**
	 * 获取 户主身份证号
	 * @return String
	 */
	public String getFamilyIdCard() {
		return familyIdCard;
	}

	/**
	 * 设置 户主身份证号
	 */
	public void setFamilyIdCard(String familyIdCard) {
		this.familyIdCard = familyIdCard;
	}

	/**
	 * 获取 核查单位主键
	 * @return String
	 */
	public String getEnsureUnitId() {
		return ensureUnitId;
	}

	/**
	 * 设置 核查单位主键
	 */
	public void setEnsureUnitId(String ensureUnitId) {
		this.ensureUnitId = ensureUnitId;
	}

	/**
	 * 获取 核查单位
	 * @return String
	 */
	public String getEnsureUnit() {
		return ensureUnit;
	}

	/**
	 * 设置 核查单位
	 */
	public void setEnsureUnit(String ensureUnit) {
		this.ensureUnit = ensureUnit;
	}

	/**
	 * 获取 核查收入
	 * @return String
	 */
	public String getEnsureIncome() {
		return ensureIncome;
	}

	/**
	 * 设置 核查收入
	 */
	public void setEnsureIncome(String ensureIncome) {
		this.ensureIncome = ensureIncome;
	}

	/**
	 * 获取 核查支出
	 * @return String
	 */
	public String getEnsureExpend() {
		return ensureExpend;
	}

	/**
	 * 设置 核查支出
	 */
	public void setEnsureExpend(String ensureExpend) {
		this.ensureExpend = ensureExpend;
	}

	/**
	 * 获取 核查财产
	 * @return String
	 */
	public String getEnsureProperty() {
		return ensureProperty;
	}

	/**
	 * 设置 核查财产
	 */
	public void setEnsureProperty(String ensureProperty) {
		this.ensureProperty = ensureProperty;
	}

	/**
	 * 获取 反馈时间
	 * @return String
	 */
	public String getFeedbackTime() {
		return feedbackTime;
	}

	/**
	 * 设置 反馈时间
	 */
	public void setFeedbackTime(String feedbackTime) {
		this.feedbackTime = feedbackTime;
	}

	/**
	 * 获取 反馈结果
	 * @return String
	 */
	public String getFeedbackResult() {
		return feedbackResult;
	}

	/**
	 * 设置 反馈结果
	 */
	public void setFeedbackResult(String feedbackResult) {
		this.feedbackResult = feedbackResult;
	}

	/**
	 * 获取 查看标示
	 * @return String
	 */
	public String getReadStatus() {
		return readStatus;
	}

	/**
	 * 设置 查看标示
	 */
	public void setReadStatus(String readStatus) {
		this.readStatus = readStatus;
	}

	/**
	 * 获取 导入导出标识
	 * @return String
	 */
	public String getInOutStatus() {
		return inOutStatus;
	}

	/**
	 * 设置 导入导出标识
	 */
	public void setInOutStatus(String inOutStatus) {
		this.inOutStatus = inOutStatus;
	}

	/**
	 * 获取 当前标识
	 * @return String
	 */
	public String getCurrentStatus() {
		return currentStatus;
	}

	/**
	 * 设置 当前标识
	 */
	public void setCurrentStatus(String currentStatus) {
		this.currentStatus = currentStatus;
	}

}