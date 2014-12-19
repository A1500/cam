package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主民主监督信息 databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_SUPERVISE_REVIEW_INFO", keyFields = "reviewId")
public class CdcSuperviseReviewInfo extends StatefulDatabean {

	// 民主监督内码
	private String reviewId;
	
	// 统计内码
	private String recordId;

	private String reportDate;
	
	private String organCode;
	
	private String name;
	
	private String peopleType;
	
	private String reviewDate;
	
	private String manner;
	
	private BigDecimal meetingShouldNum;
	
	private BigDecimal meetingRealNum;
	
	private BigDecimal sovietShouldNum;
	
	private BigDecimal sovietRealNum;
	
	private BigDecimal excellentNum;
	
	private BigDecimal competentNum;
	
	private BigDecimal uncompetentNum;
	
	private String result;

	public String getReviewId() {
		return reviewId;
	}

	public void setReviewId(String reviewId) {
		this.reviewId = reviewId;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPeopleType() {
		return peopleType;
	}

	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
	}

	public String getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
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

	public BigDecimal getExcellentNum() {
		return excellentNum;
	}

	public void setExcellentNum(BigDecimal excellentNum) {
		this.excellentNum = excellentNum;
	}

	public BigDecimal getCompetentNum() {
		return competentNum;
	}

	public void setCompetentNum(BigDecimal competentNum) {
		this.competentNum = competentNum;
	}

	public BigDecimal getUncompetentNum() {
		return uncompetentNum;
	}

	public void setUncompetentNum(BigDecimal uncompetentNum) {
		this.uncompetentNum = uncompetentNum;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getManner() {
		return manner;
	}

	public void setManner(String manner) {
		this.manner = manner;
	}
	
}