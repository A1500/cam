package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主民主决策信息databean
 * @author shgtch
 * @date 2011-12-19
 */
@Table(tableName = "CDC_DECISION_INFO", keyFields = "decisionId")
public class CdcDecisionInfo extends StatefulDatabean {
	
	// 民主决策内码
	private String decisionId;
	
	// 统计内码
	private String recordId;
	
	// 会议类型
	private String meetingType;
	
	// 会议议题
	private String meetingContent;
	
	// 会议时间
	private String meetingDate;
	
	// 应到人数
	private BigDecimal shouldNum;
	
	// 实到人数
	private BigDecimal realNum;
	
	// 妇女人数
	private BigDecimal femaleNum;
	
	// 同意人数
	private BigDecimal agreeNum;
	
	// 不同意人数
	private BigDecimal unagreeNum;
	
	// 弃权人数
	private BigDecimal giveupNum;

	// 所属行政区划
	private String organCode;
	
	private String reportDate;
	
	public String getDecisionId() {
		return decisionId;
	}

	public void setDecisionId(String decisionId) {
		this.decisionId = decisionId;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public String getMeetingType() {
		return meetingType;
	}

	public void setMeetingType(String meetingType) {
		this.meetingType = meetingType;
	}

	public String getMeetingContent() {
		return meetingContent;
	}

	public void setMeetingContent(String meetingContent) {
		this.meetingContent = meetingContent;
	}

	public String getMeetingDate() {
		return meetingDate;
	}

	public void setMeetingDate(String meetingDate) {
		this.meetingDate = meetingDate;
	}

	public BigDecimal getShouldNum() {
		return shouldNum;
	}

	public void setShouldNum(BigDecimal shouldNum) {
		this.shouldNum = shouldNum;
	}

	public BigDecimal getRealNum() {
		return realNum;
	}

	public void setRealNum(BigDecimal realNum) {
		this.realNum = realNum;
	}

	public BigDecimal getFemaleNum() {
		return femaleNum;
	}

	public void setFemaleNum(BigDecimal femaleNum) {
		this.femaleNum = femaleNum;
	}

	public BigDecimal getAgreeNum() {
		return agreeNum;
	}

	public void setAgreeNum(BigDecimal agreeNum) {
		this.agreeNum = agreeNum;
	}

	public BigDecimal getUnagreeNum() {
		return unagreeNum;
	}

	public void setUnagreeNum(BigDecimal unagreeNum) {
		this.unagreeNum = unagreeNum;
	}

	public BigDecimal getGiveupNum() {
		return giveupNum;
	}

	public void setGiveupNum(BigDecimal giveupNum) {
		this.giveupNum = giveupNum;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	
}