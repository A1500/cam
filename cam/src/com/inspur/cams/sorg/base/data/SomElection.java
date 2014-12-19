package com.inspur.cams.sorg.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会组织选举信息表
 * @author shgtch
 * @date 2011-10-14
 */
@Table(tableName = "SOM_ELECTION", keyFields = "electionId")
public class SomElection extends StatefulDatabean {

	// 社会组织筹备拟任负责人
	@Transient
	private List<SomAspchief> somAspchiefList = new ArrayList<SomAspchief>();

	// 选举决议ID
	private String electionId;

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

	// 负责人候选人数
	private String chiefNum;

	// 理事会候选人数
	private String councilNum;

	// 监事人数
	private String supervisorNum;

	// 上次换届时间
	private String lastDate;

	// 应到届时间
	private String nextDate;

	// 是否制定修改会费
	private String ifMakeFee;

	// 登记管理机关名称
	private String morgName;

	// 登记管理机关行政区划
	private String morgArea;

	// 录入人
	private String createPeople;

	// 录入时间
	private String createTime;

	// 录入时间
	private String electionType;

	// 录入时间
	private String delayDate;

	// 录入时间
	private String delayReason;

	// 录入时间
	private String process;

	// 社会组织名称
	private String sorgName;

	// 社会组织登记证号或筹备文号
	private String sorgCode;

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

	// 参会主要人员
	@Transient
	private String mainPeople;

	// 联系人
	@Transient
	private String linkPeople;

	// 联系电话
	@Transient
	private String linkPhone;

	public List<SomAspchief> getSomAspchiefList() {
		return somAspchiefList;
	}

	public void setSomAspchiefList(List<SomAspchief> somAspchiefList) {
		this.somAspchiefList = somAspchiefList;
	}

	public String getElectionId() {
		return electionId;
	}

	public void setElectionId(String electionId) {
		this.electionId = electionId;
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

	public String getChiefNum() {
		return chiefNum;
	}

	public void setChiefNum(String chiefNum) {
		this.chiefNum = chiefNum;
	}

	public String getCouncilNum() {
		return councilNum;
	}

	public void setCouncilNum(String councilNum) {
		this.councilNum = councilNum;
	}

	public String getSupervisorNum() {
		return supervisorNum;
	}

	public void setSupervisorNum(String supervisorNum) {
		this.supervisorNum = supervisorNum;
	}

	public String getLastDate() {
		return lastDate;
	}

	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}

	public String getNextDate() {
		return nextDate;
	}

	public void setNextDate(String nextDate) {
		this.nextDate = nextDate;
	}

	public String getIfMakeFee() {
		return ifMakeFee;
	}

	public void setIfMakeFee(String ifMakeFee) {
		this.ifMakeFee = ifMakeFee;
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

	public String getMainPeople() {
		return mainPeople;
	}

	public void setMainPeople(String mainPeople) {
		this.mainPeople = mainPeople;
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

	public String getElectionType() {
		return electionType;
	}

	public void setElectionType(String electionType) {
		this.electionType = electionType;
	}

	public String getDelayDate() {
		return delayDate;
	}

	public void setDelayDate(String delayDate) {
		this.delayDate = delayDate;
	}

	public String getDelayReason() {
		return delayReason;
	}

	public void setDelayReason(String delayReason) {
		this.delayReason = delayReason;
	}

	public String getProcess() {
		return process;
	}

	public void setProcess(String process) {
		this.process = process;
	}

	public String getSorgName() {
		return sorgName;
	}

	public void setSorgName(String sorgName) {
		this.sorgName = sorgName;
	}

	public String getSorgCode() {
		return sorgCode;
	}

	public void setSorgCode(String sorgCode) {
		this.sorgCode = sorgCode;
	}

}