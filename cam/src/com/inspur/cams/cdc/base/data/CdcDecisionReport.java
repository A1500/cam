package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主民主决策信息databean
 * @author shgtch
 * @date 2011-12-19
 */
@Table(tableName = "CDC_DECISION_REPORT", keyFields = "recordId")
public class CdcDecisionReport extends StatefulDatabean {

	@Transient
	private List<CdcDecisionInfo> cdcDecisionInfoList = new ArrayList<CdcDecisionInfo>();
	
	// 统计内码
	private String recordId;
	
	private BigDecimal meetingNum;
	//【城市：居民会议次数】
	private BigDecimal meetingShouldNum;
	//【城市：居民会议参加人数】
	private BigDecimal meetingRealNum;
	//【城市：居民代表会议次数】
	private BigDecimal meetingAgreeNum;
	//【城市：居民代表会议参加人数】
	private BigDecimal meetingUnagreeNum;
	
	private BigDecimal meetingGiveupNum;
	
	private BigDecimal sovietNum;

	private BigDecimal sovietShouldNum;
	
	private BigDecimal sovietRealNum;

	private BigDecimal sovietFemaleNum;
	
	private BigDecimal sovietAgreeNum;
	
	private BigDecimal sovietUnagreeNum;
	
	private BigDecimal sovietGiveupNum;

	private BigDecimal refNum;
	
	private BigDecimal refShouldNum;
	
	private BigDecimal refRealNum;
	
	private BigDecimal refAgreeNum;
	
	private BigDecimal refUnagreeNum;
	
	private BigDecimal refGiveupNum;
	
	private String organCode;
	
	private String organName;
	
	private String parentCode;
	
	private String reportType;
	
	private String reportDate;
	
	private String status;
	
	private String submitDate;
	
	private String createTime;
	

	public List<CdcDecisionInfo> getCdcDecisionInfoList() {
		return cdcDecisionInfoList;
	}

	public void setCdcDecisionInfoList(List<CdcDecisionInfo> cdcDecisionInfoList) {
		this.cdcDecisionInfoList = cdcDecisionInfoList;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public BigDecimal getMeetingNum() {
		return meetingNum;
	}

	public void setMeetingNum(BigDecimal meetingNum) {
		this.meetingNum = meetingNum;
	}

	public BigDecimal getMeetingShouldNum() {
		return meetingShouldNum;
	}

	public void setMeetingShouldNum(BigDecimal meetingShouldNum) {
		this.meetingShouldNum = meetingShouldNum;
	}

	public BigDecimal getMeetingRealNum() {
		return meetingRealNum;
	}

	public void setMeetingRealNum(BigDecimal meetingRealNum) {
		this.meetingRealNum = meetingRealNum;
	}

	public BigDecimal getMeetingAgreeNum() {
		return meetingAgreeNum;
	}

	public void setMeetingAgreeNum(BigDecimal meetingAgreeNum) {
		this.meetingAgreeNum = meetingAgreeNum;
	}

	public BigDecimal getMeetingUnagreeNum() {
		return meetingUnagreeNum;
	}

	public void setMeetingUnagreeNum(BigDecimal meetingUnagreeNum) {
		this.meetingUnagreeNum = meetingUnagreeNum;
	}

	public BigDecimal getMeetingGiveupNum() {
		return meetingGiveupNum;
	}

	public void setMeetingGiveupNum(BigDecimal meetingGiveupNum) {
		this.meetingGiveupNum = meetingGiveupNum;
	}

	public BigDecimal getSovietNum() {
		return sovietNum;
	}

	public void setSovietNum(BigDecimal sovietNum) {
		this.sovietNum = sovietNum;
	}

	public BigDecimal getSovietShouldNum() {
		return sovietShouldNum;
	}

	public void setSovietShouldNum(BigDecimal sovietShouldNum) {
		this.sovietShouldNum = sovietShouldNum;
	}

	public BigDecimal getSovietRealNum() {
		return sovietRealNum;
	}

	public void setSovietRealNum(BigDecimal sovietRealNum) {
		this.sovietRealNum = sovietRealNum;
	}

	public BigDecimal getSovietFemaleNum() {
		return sovietFemaleNum;
	}

	public void setSovietFemaleNum(BigDecimal sovietFemaleNum) {
		this.sovietFemaleNum = sovietFemaleNum;
	}

	public BigDecimal getSovietAgreeNum() {
		return sovietAgreeNum;
	}

	public void setSovietAgreeNum(BigDecimal sovietAgreeNum) {
		this.sovietAgreeNum = sovietAgreeNum;
	}

	public BigDecimal getSovietUnagreeNum() {
		return sovietUnagreeNum;
	}

	public void setSovietUnagreeNum(BigDecimal sovietUnagreeNum) {
		this.sovietUnagreeNum = sovietUnagreeNum;
	}

	public BigDecimal getSovietGiveupNum() {
		return sovietGiveupNum;
	}

	public void setSovietGiveupNum(BigDecimal sovietGiveupNum) {
		this.sovietGiveupNum = sovietGiveupNum;
	}

	public BigDecimal getRefNum() {
		return refNum;
	}

	public void setRefNum(BigDecimal refNum) {
		this.refNum = refNum;
	}

	public BigDecimal getRefShouldNum() {
		return refShouldNum;
	}

	public void setRefShouldNum(BigDecimal refShouldNum) {
		this.refShouldNum = refShouldNum;
	}

	public BigDecimal getRefRealNum() {
		return refRealNum;
	}

	public void setRefRealNum(BigDecimal refRealNum) {
		this.refRealNum = refRealNum;
	}

	public BigDecimal getRefAgreeNum() {
		return refAgreeNum;
	}

	public void setRefAgreeNum(BigDecimal refAgreeNum) {
		this.refAgreeNum = refAgreeNum;
	}

	public BigDecimal getRefUnagreeNum() {
		return refUnagreeNum;
	}

	public void setRefUnagreeNum(BigDecimal refUnagreeNum) {
		this.refUnagreeNum = refUnagreeNum;
	}

	public BigDecimal getRefGiveupNum() {
		return refGiveupNum;
	}

	public void setRefGiveupNum(BigDecimal refGiveupNum) {
		this.refGiveupNum = refGiveupNum;
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

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
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

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}


}