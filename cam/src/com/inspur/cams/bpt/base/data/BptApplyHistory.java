package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptApplyHistory
 * @description:审批记录历史
 * @author zhanghui
 * 
 */
@Table(tableName = "BPT_APPLY_HISTORY", keyFields = "historyId")
public class BptApplyHistory extends StatefulDatabean {

	// 审批记录id
	@Rule(value = "require")
	@Column(name = "HISTORY_ID")
	private String historyId;

	// 审批id
	@Rule(value = "require")
	@Column(name = "APPLY_ID")
	private String applyId;

	// 环节名称
	@Rule(value = "require")
	@Column(name = "ACTDEF_NAME")
	private String actdefName;

	// 记录时间
	@Rule(value = "require")
	@Column(name = "CREATE_TIME")
	private String createTime;

	// 审批意见
	@Column(name = "APPLY_ADVICE")
	private String applyAdvice;

	// 审批人
	@Column(name = "APPLY_INCHARGE")
	private String applyIncharge;

	// 审批时间
	@Column(name = "APPLY_TOWN_TIME")
	private String applyTownTime;
	
	// 乡审批意见
	@Column(name = "APPLY_TOWN_ADVICE")
	private String applyTownAdvice;

	// 乡审批人
	@Column(name = "APPLY_TOWN_INCHARGE")
	private String applyTownIncharge;

	// 乡审批时间
	@Column(name = "APPLY_TIME")
	private String applyTime;

	// 伤残性质
	@Column(name = "DISABILITY_CASE")
	private String disabilityCase;

	// 伤残等级
	@Column(name = "DISABILITY_LEVEL")
	private String disabilityLevel;

	// 审批意见（同意审批或不予认定）
	@Column(name = "APPLY_FLAG")
	private String applyFlag;

	// 是否上报
	@Column(name = "REPORT")
	private String report;

	public String getApplyTownTime() {
		return applyTownTime;
	}

	public void setApplyTownTime(String applyTownTime) {
		this.applyTownTime = applyTownTime;
	}

	public String getApplyTownAdvice() {
		return applyTownAdvice;
	}

	public void setApplyTownAdvice(String applyTownAdvice) {
		this.applyTownAdvice = applyTownAdvice;
	}

	public String getApplyTownIncharge() {
		return applyTownIncharge;
	}

	public void setApplyTownIncharge(String applyTownIncharge) {
		this.applyTownIncharge = applyTownIncharge;
	}

	public String getHistoryId() {
		return historyId;
	}

	public void setHistoryId(String historyId) {
		this.historyId = historyId;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getActdefName() {
		return actdefName;
	}

	public void setActdefName(String actdefName) {
		this.actdefName = actdefName;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getApplyAdvice() {
		return applyAdvice;
	}

	public void setApplyAdvice(String applyAdvice) {
		this.applyAdvice = applyAdvice;
	}

	public String getApplyIncharge() {
		return applyIncharge;
	}

	public void setApplyIncharge(String applyIncharge) {
		this.applyIncharge = applyIncharge;
	}

	public String getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	public String getDisabilityCase() {
		return disabilityCase;
	}

	public void setDisabilityCase(String disabilityCase) {
		this.disabilityCase = disabilityCase;
	}

	public String getDisabilityLevel() {
		return disabilityLevel;
	}

	public void setDisabilityLevel(String disabilityLevel) {
		this.disabilityLevel = disabilityLevel;
	}

	public String getApplyFlag() {
		return applyFlag;
	}

	public void setApplyFlag(String applyFlag) {
		this.applyFlag = applyFlag;
	}

	public String getReport() {
		return report;
	}

	public void setReport(String report) {
		this.report = report;
	}

}