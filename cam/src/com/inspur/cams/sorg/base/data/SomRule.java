package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会组织章程信息表
 * 
 * @author zhangjian
 * @date 2011-9-19
 */
@Table(tableName = "SOM_RULE", keyFields = "ruleId")
public class SomRule extends StatefulDatabean {
	
	// 章程ID
	private String ruleId;
	
	// 业务编号
	private String taskCode;
	
	// 社会组织ID
	private String sorgId;
	
	// 会议ID
	private String meetingId;
	
	// 应到人数
	private String shouldNum;
	
	// 实到人数
	private String realNum;
	
	// 同意人数
	private String passNum;
	
	// 反对人数
	private String nopassNum;
	
	// 弃权人数
	private String giveupNum;
	
	// 是否草案
	private String ifDraft;
	
	// 需说明主要问题
	private String mainQuestion;
	
	// 备案状态
	private String regStatus;
	
	// 登记管理机关名称
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	
	// 录入人
	private String createPeople;
	
	// 录入时间
	private String createTime;

	//TODO 会议相关信息
	
	// 会议名称
	@Transient
	private String meetingName;
	
	// 会议地点
	@Transient
	private String meetingPlace;
	
	// 会议日期
	@Transient
	private String meetingDate;
	
	// 会议形式
	@Transient
	private String meetingFormat;
	
	public String getRuleId() {
		return ruleId;
	}

	public void setRuleId(String ruleId) {
		this.ruleId = ruleId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getMeetingId() {
		return meetingId;
	}

	public void setMeetingId(String meetingId) {
		this.meetingId = meetingId;
	}

	public String getShouldNum() {
		return shouldNum;
	}

	public void setShouldNum(String shouldNum) {
		this.shouldNum = shouldNum;
	}

	public String getRealNum() {
		return realNum;
	}

	public void setRealNum(String realNum) {
		this.realNum = realNum;
	}

	public String getPassNum() {
		return passNum;
	}

	public void setPassNum(String passNum) {
		this.passNum = passNum;
	}

	public String getNopassNum() {
		return nopassNum;
	}

	public void setNopassNum(String nopassNum) {
		this.nopassNum = nopassNum;
	}

	public String getGiveupNum() {
		return giveupNum;
	}

	public void setGiveupNum(String giveupNum) {
		this.giveupNum = giveupNum;
	}

	public String getIfDraft() {
		return ifDraft;
	}

	public void setIfDraft(String ifDraft) {
		this.ifDraft = ifDraft;
	}

	public String getMainQuestion() {
		return mainQuestion;
	}

	public void setMainQuestion(String mainQuestion) {
		this.mainQuestion = mainQuestion;
	}

	public String getRegStatus() {
		return regStatus;
	}

	public void setRegStatus(String regStatus) {
		this.regStatus = regStatus;
	}

	public String getMorgName() {
		return morgName;
	}

	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	public String getMorgArea() {
		return morgArea;
	}

	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	public String getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getMeetingName() {
		return meetingName;
	}

	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}

	public String getMeetingPlace() {
		return meetingPlace;
	}

	public void setMeetingPlace(String meetingPlace) {
		this.meetingPlace = meetingPlace;
	}

	public String getMeetingDate() {
		return meetingDate;
	}

	public void setMeetingDate(String meetingDate) {
		this.meetingDate = meetingDate;
	}

	public String getMeetingFormat() {
		return meetingFormat;
	}

	public void setMeetingFormat(String meetingFormat) {
		this.meetingFormat = meetingFormat;
	}
	
}