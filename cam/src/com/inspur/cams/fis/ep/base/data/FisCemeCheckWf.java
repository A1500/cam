package com.inspur.cams.fis.ep.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:FisCemeCheckAudit
 * @description:公墓年检审核记录
 * @author:
 * @since:2011-11-29
 * @version:1.0
 */
@Table(tableName = "FIS_CEME_CHECK_WF", keyFields = "wfId")
public class FisCemeCheckWf extends StatefulDatabean {
	// 流程记录ID
	@Column(name = "WF_ID")
	private String wfId;
	// 公墓ID
	@Column(name = "CEME_ID")
	private String cemeId;
	// 年检年份
	@Column(name = "CHECK_YEAR")
	private String checkYear;
	// 年检次数
	@Column(name = "CHECK_NUM")
	private String checkNum;
	// 年检结果
	@Column(name = "CHECK_RESULT")
	private String checkResult;
	// 公墓名称
	@Column(name = "CEME_NAME")
	private String cemeName;
	// 公墓性质
	@Column(name = "PROP")
	private String prop;
	// 管理级别
	@Column(name = "MANA_LEVEL")
	private String manaLevel;
	// 管理级别ID
	@Column(name = "MANA_LEVEL_ID")
	private String manaLevelId;
	// 所在区
	@Column(name = "AREA_LEVEL")
	private String areaLevel;
	// 所在区ID
	@Column(name = "AREA_LEVEL_ID")
	private String areaLevelId;
	// 是否上报
	@Column(name = "IS_REPORT")
	private String isReport;
	// 当前环节
	@Column(name = "CURRENT_ORGAN")
	private String currentOrgan;
	//上报时间
	@Column(name = "REPORT_TIME")
	private String reportTime;
	//上报人
	@Column(name = "REPORT_PERSON")
	private String reportPerson;
	//最后一次年检记录ID
	@Column(name = "END_APPLY_ID")
	private String endApplyId;
	//是否修改
	@Column(name = "IS_EDIT")
	private String isEdit;
	
	@Transient
	private FisCemeCheckInfo fisCemeCheckInfo = new FisCemeCheckInfo();
	@Transient
	private FisCemeCheckAudit fisCemeCheckAudit = new FisCemeCheckAudit();
	@Transient
	private FisCemeCheckScore fisCemeCheckScore = new FisCemeCheckScore();
	@Transient
	private FisCemeCheckResult fisCemeCheckResult = new FisCemeCheckResult();
	
	public String getWfId() {
		return wfId;
	}
	public void setWfId(String wfId) {
		this.wfId = wfId;
	}
	public String getCemeId() {
		return cemeId;
	}
	public void setCemeId(String cemeId) {
		this.cemeId = cemeId;
	}
	public String getCheckYear() {
		return checkYear;
	}
	public void setCheckYear(String checkYear) {
		this.checkYear = checkYear;
	}
	public String getCheckNum() {
		return checkNum;
	}
	public void setCheckNum(String checkNum) {
		this.checkNum = checkNum;
	}
	public String getCemeName() {
		return cemeName;
	}
	public void setCemeName(String cemeName) {
		this.cemeName = cemeName;
	}
	public String getProp() {
		return prop;
	}
	public void setProp(String prop) {
		this.prop = prop;
	}
	public String getManaLevel() {
		return manaLevel;
	}
	public void setManaLevel(String manaLevel) {
		this.manaLevel = manaLevel;
	}
	public String getManaLevelId() {
		return manaLevelId;
	}
	public void setManaLevelId(String manaLevelId) {
		this.manaLevelId = manaLevelId;
	}
	public String getAreaLevel() {
		return areaLevel;
	}
	public void setAreaLevel(String areaLevel) {
		this.areaLevel = areaLevel;
	}
	public String getAreaLevelId() {
		return areaLevelId;
	}
	public void setAreaLevelId(String areaLevelId) {
		this.areaLevelId = areaLevelId;
	}
	public String getIsReport() {
		return isReport;
	}
	public void setIsReport(String isReport) {
		this.isReport = isReport;
	}
	public String getCurrentOrgan() {
		return currentOrgan;
	}
	public void setCurrentOrgan(String currentOrgan) {
		this.currentOrgan = currentOrgan;
	}
	public String getReportTime() {
		return reportTime;
	}
	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}
	public String getReportPerson() {
		return reportPerson;
	}
	public void setReportPerson(String reportPerson) {
		this.reportPerson = reportPerson;
	}
	public FisCemeCheckInfo getFisCemeCheckInfo() {
		return fisCemeCheckInfo;
	}
	public void setFisCemeCheckInfo(FisCemeCheckInfo fisCemeCheckInfo) {
		this.fisCemeCheckInfo = fisCemeCheckInfo;
	}
	public FisCemeCheckAudit getFisCemeCheckAudit() {
		return fisCemeCheckAudit;
	}
	public void setFisCemeCheckAudit(FisCemeCheckAudit fisCemeCheckAudit) {
		this.fisCemeCheckAudit = fisCemeCheckAudit;
	}
	public FisCemeCheckScore getFisCemeCheckScore() {
		return fisCemeCheckScore;
	}
	public void setFisCemeCheckScore(FisCemeCheckScore fisCemeCheckScore) {
		this.fisCemeCheckScore = fisCemeCheckScore;
	}
	public FisCemeCheckResult getFisCemeCheckResult() {
		return fisCemeCheckResult;
	}
	public void setFisCemeCheckResult(FisCemeCheckResult fisCemeCheckResult) {
		this.fisCemeCheckResult = fisCemeCheckResult;
	}
	public String getIsEdit() {
		return isEdit;
	}
	public void setIsEdit(String isEdit) {
		this.isEdit = isEdit;
	}
	public String getEndApplyId() {
		return endApplyId;
	}
	public void setEndApplyId(String endApplyId) {
		this.endApplyId = endApplyId;
	}
	public String getCheckResult() {
		return checkResult;
	}
	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}
}