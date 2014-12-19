package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主民主监督统计�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_SUPERVISE_REPORT", keyFields = "recordId")
public class CdcSuperviseReport extends StatefulDatabean {

	@Transient
	private List<CdcSuperviseReviewInfo> cdcSuperviseReviewInfoList = new ArrayList<CdcSuperviseReviewInfo>();
	@Transient
	private CdcSuperviseInfo cdcSuperviseInfo;
	
	// 统计内码
	private String recordId;
	//【城市：居务公开 居数】
	private BigDecimal publishNum;
	
	private BigDecimal noPublishNum;
	//【城市： 政务公开 居数】
	private BigDecimal auditNum;
	
	private BigDecimal noAuditNum;
	//【城市： 财务公开 居数】
	private BigDecimal discussNum;
	
	private BigDecimal noDiscussNum;
	//【城市：居委会成员接受评议次数】
	private BigDecimal partYear;
	
	private BigDecimal partSeason;
	
	private BigDecimal partMonth;
	
	private BigDecimal partImm;
	//【城市：居委会聘用人员受评人数】
	private BigDecimal govYear;
	
	private BigDecimal govSeason;
	
	private BigDecimal govMonth;
	
	private BigDecimal govImm;
	//【城市：连续两次被评议为不称职人数】
	private BigDecimal affairYear;
	
	private BigDecimal affairSeason;
	
	private BigDecimal affairMonth;
	
	private BigDecimal affairImm;
	//【城市：居务监督委员会人数】
	private BigDecimal financeYear;
	
	private BigDecimal financeSeason;
	//【城市：居务监督委员会经居民会议推选产生人数】
	private BigDecimal financeMonth;
	//【城市：居务监督委员会经居民会代表会议产生人数】
	private BigDecimal financeImm;
	
	private BigDecimal placardNum;
	//网络 
	private BigDecimal webNum;
	//触摸屏
	private BigDecimal meetingNum;
	
	private BigDecimal paperNum;
	
	private BigDecimal otherNum;
	
	private BigDecimal mbNum;
	
	private BigDecimal mbExcellentNum;
	
	private BigDecimal mbCompetentNum;
	
	private BigDecimal mbUncompetentNum;
	
	private BigDecimal emNum;
	
	private BigDecimal emExcellentNum;
	
	private BigDecimal emCompetentNum;
	
	private BigDecimal emUncompetentNum;
	
	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;
	
	// 填报报表类型
	private String reportType;
	
	//创建日期
	private String createTime;
	

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public BigDecimal getPublishNum() {
		return publishNum;
	}

	public void setPublishNum(BigDecimal publishNum) {
		this.publishNum = publishNum;
	}

	public BigDecimal getNoPublishNum() {
		return noPublishNum;
	}

	public void setNoPublishNum(BigDecimal noPublishNum) {
		this.noPublishNum = noPublishNum;
	}

	public BigDecimal getAuditNum() {
		return auditNum;
	}

	public void setAuditNum(BigDecimal auditNum) {
		this.auditNum = auditNum;
	}

	public BigDecimal getNoAuditNum() {
		return noAuditNum;
	}

	public void setNoAuditNum(BigDecimal noAuditNum) {
		this.noAuditNum = noAuditNum;
	}

	public BigDecimal getDiscussNum() {
		return discussNum;
	}

	public void setDiscussNum(BigDecimal discussNum) {
		this.discussNum = discussNum;
	}

	public BigDecimal getNoDiscussNum() {
		return noDiscussNum;
	}

	public void setNoDiscussNum(BigDecimal noDiscussNum) {
		this.noDiscussNum = noDiscussNum;
	}

	public BigDecimal getPartYear() {
		return partYear;
	}

	public void setPartYear(BigDecimal partYear) {
		this.partYear = partYear;
	}

	public BigDecimal getPartSeason() {
		return partSeason;
	}

	public void setPartSeason(BigDecimal partSeason) {
		this.partSeason = partSeason;
	}

	public BigDecimal getPartMonth() {
		return partMonth;
	}

	public void setPartMonth(BigDecimal partMonth) {
		this.partMonth = partMonth;
	}

	public BigDecimal getPartImm() {
		return partImm;
	}

	public void setPartImm(BigDecimal partImm) {
		this.partImm = partImm;
	}

	public BigDecimal getGovYear() {
		return govYear;
	}

	public void setGovYear(BigDecimal govYear) {
		this.govYear = govYear;
	}

	public BigDecimal getGovSeason() {
		return govSeason;
	}

	public void setGovSeason(BigDecimal govSeason) {
		this.govSeason = govSeason;
	}

	public BigDecimal getGovMonth() {
		return govMonth;
	}

	public void setGovMonth(BigDecimal govMonth) {
		this.govMonth = govMonth;
	}

	public BigDecimal getGovImm() {
		return govImm;
	}

	public void setGovImm(BigDecimal govImm) {
		this.govImm = govImm;
	}

	public BigDecimal getAffairYear() {
		return affairYear;
	}

	public void setAffairYear(BigDecimal affairYear) {
		this.affairYear = affairYear;
	}

	public BigDecimal getAffairSeason() {
		return affairSeason;
	}

	public void setAffairSeason(BigDecimal affairSeason) {
		this.affairSeason = affairSeason;
	}

	public BigDecimal getAffairMonth() {
		return affairMonth;
	}

	public void setAffairMonth(BigDecimal affairMonth) {
		this.affairMonth = affairMonth;
	}

	public BigDecimal getAffairImm() {
		return affairImm;
	}

	public void setAffairImm(BigDecimal affairImm) {
		this.affairImm = affairImm;
	}

	public BigDecimal getFinanceYear() {
		return financeYear;
	}

	public void setFinanceYear(BigDecimal financeYear) {
		this.financeYear = financeYear;
	}

	public BigDecimal getFinanceSeason() {
		return financeSeason;
	}

	public void setFinanceSeason(BigDecimal financeSeason) {
		this.financeSeason = financeSeason;
	}

	public BigDecimal getFinanceMonth() {
		return financeMonth;
	}

	public void setFinanceMonth(BigDecimal financeMonth) {
		this.financeMonth = financeMonth;
	}

	public BigDecimal getFinanceImm() {
		return financeImm;
	}

	public void setFinanceImm(BigDecimal financeImm) {
		this.financeImm = financeImm;
	}

	public BigDecimal getPlacardNum() {
		return placardNum;
	}

	public void setPlacardNum(BigDecimal placardNum) {
		this.placardNum = placardNum;
	}

	public BigDecimal getWebNum() {
		return webNum;
	}

	public void setWebNum(BigDecimal webNum) {
		this.webNum = webNum;
	}

	public BigDecimal getMeetingNum() {
		return meetingNum;
	}

	public void setMeetingNum(BigDecimal meetingNum) {
		this.meetingNum = meetingNum;
	}

	public BigDecimal getPaperNum() {
		return paperNum;
	}

	public void setPaperNum(BigDecimal paperNum) {
		this.paperNum = paperNum;
	}

	public BigDecimal getOtherNum() {
		return otherNum;
	}

	public void setOtherNum(BigDecimal otherNum) {
		this.otherNum = otherNum;
	}

	public BigDecimal getMbNum() {
		return mbNum;
	}

	public void setMbNum(BigDecimal mbNum) {
		this.mbNum = mbNum;
	}

	public BigDecimal getMbExcellentNum() {
		return mbExcellentNum;
	}

	public void setMbExcellentNum(BigDecimal mbExcellentNum) {
		this.mbExcellentNum = mbExcellentNum;
	}

	public BigDecimal getMbCompetentNum() {
		return mbCompetentNum;
	}

	public void setMbCompetentNum(BigDecimal mbCompetentNum) {
		this.mbCompetentNum = mbCompetentNum;
	}

	public BigDecimal getMbUncompetentNum() {
		return mbUncompetentNum;
	}

	public void setMbUncompetentNum(BigDecimal mbUncompetentNum) {
		this.mbUncompetentNum = mbUncompetentNum;
	}

	public BigDecimal getEmNum() {
		return emNum;
	}

	public void setEmNum(BigDecimal emNum) {
		this.emNum = emNum;
	}

	public BigDecimal getEmExcellentNum() {
		return emExcellentNum;
	}

	public void setEmExcellentNum(BigDecimal emExcellentNum) {
		this.emExcellentNum = emExcellentNum;
	}

	public BigDecimal getEmCompetentNum() {
		return emCompetentNum;
	}

	public void setEmCompetentNum(BigDecimal emCompetentNum) {
		this.emCompetentNum = emCompetentNum;
	}

	public BigDecimal getEmUncompetentNum() {
		return emUncompetentNum;
	}

	public void setEmUncompetentNum(BigDecimal emUncompetentNum) {
		this.emUncompetentNum = emUncompetentNum;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getOrganName() {
		return organName;
	}

	public void setOrganName(String organName) {
		this.organName = organName;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public List<CdcSuperviseReviewInfo> getCdcSuperviseReviewInfoList() {
		return cdcSuperviseReviewInfoList;
	}

	public void setCdcSuperviseReviewInfoList(
			List<CdcSuperviseReviewInfo> cdcSuperviseReviewInfoList) {
		this.cdcSuperviseReviewInfoList = cdcSuperviseReviewInfoList;
	}

	public CdcSuperviseInfo getCdcSuperviseInfo() {
		return cdcSuperviseInfo;
	}

	public void setCdcSuperviseInfo(CdcSuperviseInfo cdcSuperviseInfo) {
		this.cdcSuperviseInfo = cdcSuperviseInfo;
	}


}