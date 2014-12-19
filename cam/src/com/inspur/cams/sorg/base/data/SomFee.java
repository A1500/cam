package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织会费标准
 * 
 * @author yanliangliang
 * @date 2011-9-19
 */
@Table(tableName = "SOM_FEE", keyFields = "feeId")
public class SomFee extends StatefulDatabean {
	
	// 会费ID
	private String feeId;
	
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
	
	// 会费标准
	private String fee;
	
	// 备案承办人
	private String regPeople;
	
	// 备案日期
	private String regDate;
	
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
	
	// 联系人
	@Transient
	private String linkPeople;
	
	// 联系电话
	@Transient
	private String linkPhone;
	
	public String getFeeId() {
		return feeId;
	}

	public void setFeeId(String feeId) {
		this.feeId = feeId;
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

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getRegPeople() {
		return regPeople;
	}

	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
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

	public String getLinkPeople() {
		return linkPeople;
	}

	public void setLinkPeople(String linkPeople) {
		this.linkPeople = linkPeople;
	}

	public String getLinkPhone() {
		return linkPhone;
	}

	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}

}