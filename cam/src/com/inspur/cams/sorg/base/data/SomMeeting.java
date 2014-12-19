package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织会议databean
 * @author shgtch
 * @date 2011-5-11
 */
@Table(tableName = "SOM_MEETING", keyFields = "meetingId")
public class SomMeeting extends StatefulDatabean {
	
	// 会议ID
//	@Rule(value = "require")
	private String meetingId;
	
	// 社会组织ID
	private String sorgId;
	
	// 会议类型
	private String meetingType;
	
	// 会议形式
	private String meetingFormat;
	
	// 会议名称
	private String meetingName;
	
	// 会议地点
	private String meetingPlace;
	
	// 会议日期
	private String meetingDate;
	
	// 联系人
	private String linkPeople;
	
	// 联系电话
	private String linkPhone;
	
	// 参会主要人员
	private String mainPeople;
	
	// 登记管理机关名称
	private String morgName;
	
	// 登记管理机关行政区划
	private String morgArea;
	// 录入人
	private String createPeople;
	
	// 录入时间
	private String createTime;
	
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
	
	// 是否是老的数据 由于要添加换届审批中的会议与章程、负责人换届备案、会费标准备案的关系，老的数据这些关系已经无从判断，通过该标志位来区别处理新老数据
	private String ifOld;


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

	public String getMeetingId() {
		return meetingId;
	}

	public void setMeetingId(String meetingId) {
		this.meetingId = meetingId;
	}

	public String getSorgId() {
		return sorgId;
	}

	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	public String getMeetingType() {
		return meetingType;
	}

	public void setMeetingType(String meetingType) {
		this.meetingType = meetingType;
	}

	public String getMeetingFormat() {
		return meetingFormat;
	}

	public void setMeetingFormat(String meetingFormat) {
		this.meetingFormat = meetingFormat;
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

	public String getMainPeople() {
		return mainPeople;
	}

	public void setMainPeople(String mainPeople) {
		this.mainPeople = mainPeople;
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

	public String getIfOld() {
		return ifOld;
	}

	public void setIfOld(String ifOld) {
		this.ifOld = ifOld;
	}
	

}