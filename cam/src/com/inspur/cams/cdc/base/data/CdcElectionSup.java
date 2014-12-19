package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举监督委员会databean
 * @author 
 * @date 2012-12-14
 */
@Table(tableName = "CDC_ELECTION_SUP", keyFields = "supId")
public class CdcElectionSup extends StatefulDatabean {

	@Transient
	private List<CdcElectionMember> cdcElectionMemberList = new ArrayList<CdcElectionMember>();
	
	// 监督委员会内码
	private String supId;

	// 选举内码
	private String recordId;

	// 村务监督委员会成员数
	private BigDecimal supMbNum;

	// 村务监督委员会产生方式
	private String supManner;

	// 村民会议推选登记参加选举的村民（户代表）总数
	private BigDecimal meetingNum;

	// 村民会议推选实际推选人数
	private BigDecimal meetingActNum;

	// 村民会议推选同意人数
	private BigDecimal meetingAgreeNum;

	// 村民会议推选不同意人数
	private BigDecimal meetingUnagreeNum;

	// 村民会议推选弃权人数
	private BigDecimal meetingGiveupNum;

	// 村民代表会议推选村民代表会议总数
	private BigDecimal sovietNum;

	// 村民代表会议推选实际参加推选的人数
	private BigDecimal sovietActNum;

	// 村民代表会议推选同意人数
	private BigDecimal sovietAgreeNum;

	// 村民代表会议推选不同意人数
	private BigDecimal sovietUnagreeNum;

	// 村民代表会议推选弃权人数
	private BigDecimal sovietGiveupNum;

	// 罢免联名罢免职务
	private String recallDuty;

	// 罢免联名选举村民总数
	private BigDecimal recallVoteNum;

	// 罢免联名女性人数
	private BigDecimal recallFemaleNum;

	// 罢免联名少数民族人数
	private BigDecimal recallFolkNum;

	// 罢免联名委托投票人数
	private BigDecimal recallEntrustNum;

	// 罢免联名使用流动票箱投票人数
	private BigDecimal recallFlowNum;

	// 罢免联名代写选票人数
	private BigDecimal recallReplaceNum;

	// 罢免联名参加罢免大会投票的选民数
	private BigDecimal recallNum;

	// 罢免表决中心会场投票箱数
	private BigDecimal recallCenBoxNum;

	// 罢免表决设立分会场数
	private BigDecimal recallSubNum;

	// 罢免表决分会场投票箱数
	private BigDecimal recallSubBoxNum;

	// 罢免表决投票箱总数
	private BigDecimal recallBoxNum;

	// 罢免表决参加会议村民总数
	private BigDecimal recallMeetingNum;

	// 罢免表决同意人数
	private BigDecimal recallAgreeNum;

	// 罢免表决不同意人数
	private BigDecimal recallUnagreeNum;

	// 罢免是否成功
	private String recallSuccess;

	// 补选原因
	private String reReason;

	// 补选情况
	private String reSituation;

	// 补选补选主任数
	private BigDecimal reDirNum;

	// 补选委员数
	private BigDecimal reComNum;
	
	// 差额数
	private BigDecimal reRedNum;

	// 村民会议补选总数
	private BigDecimal reMeetingNum;

	// 村民会议补选女性人数
	private BigDecimal reMeetingFemaleNum;

	// 村民会议补选少数民族人数
	private BigDecimal reMeetingFolkNum;

	// 村民会议补选委托投票人数
	private BigDecimal reEntrustNum;

	// 村民会议补选使用流动票箱投票人数
	private BigDecimal reFlowNum;

	// 村民会议补选代写选票人数
	private BigDecimal reReplaceNum;

	// 村民会议补选实际参加投票村民数
	private BigDecimal reActNum;

	// 村民代表会议代表总数
	private BigDecimal reSovietNum;

	// 村民代表会议女性人数
	private BigDecimal reSovietFemaleNum;

	// 村民代表会议少数民族人数
	private BigDecimal reSovietFolkNum;

	// 村民代表会议参加人数
	private BigDecimal reSovietJoinNum;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报报表类型
	private String reportType;

	// 填报日期
	private String reportDate;

	// 上报状态
	private String status;

	// 上报日期
	private String submitDate;

	// 创建日期
	private String createTime;

	public List<CdcElectionMember> getCdcElectionMemberList() {
		return cdcElectionMemberList;
	}

	public void setCdcElectionMemberList(
			List<CdcElectionMember> cdcElectionMemberList) {
		this.cdcElectionMemberList = cdcElectionMemberList;
	}

	/**
	 * 获取 监督委员会内码
	 * @return String
	 */
	public String getSupId() {
		return supId;
	}

	/**
	 * 设置 监督委员会内码
	 */
	public void setSupId(String supId) {
		this.supId = supId;
	}

	/**
	 * 获取 选举内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 选举内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 村务监督委员会成员数
	 * @return BigDecimal
	 */
	public BigDecimal getSupMbNum() {
		return supMbNum;
	}

	/**
	 * 设置 村务监督委员会成员数
	 */
	public void setSupMbNum(BigDecimal supMbNum) {
		this.supMbNum = supMbNum;
	}

	/**
	 * 获取 村务监督委员会产生方式
	 * @return String
	 */
	public String getSupManner() {
		return supManner;
	}

	/**
	 * 设置 村务监督委员会产生方式
	 */
	public void setSupManner(String supManner) {
		this.supManner = supManner;
	}

	/**
	 * 获取 村民会议推选登记参加选举的村民（户代表）总数
	 * @return BigDecimal
	 */
	public BigDecimal getMeetingNum() {
		return meetingNum;
	}

	/**
	 * 设置 村民会议推选登记参加选举的村民（户代表）总数
	 */
	public void setMeetingNum(BigDecimal meetingNum) {
		this.meetingNum = meetingNum;
	}

	/**
	 * 获取 村民会议推选实际推选人数
	 * @return BigDecimal
	 */
	public BigDecimal getMeetingActNum() {
		return meetingActNum;
	}

	/**
	 * 设置 村民会议推选实际推选人数
	 */
	public void setMeetingActNum(BigDecimal meetingActNum) {
		this.meetingActNum = meetingActNum;
	}

	/**
	 * 获取 村民会议推选同意人数
	 * @return BigDecimal
	 */
	public BigDecimal getMeetingAgreeNum() {
		return meetingAgreeNum;
	}

	/**
	 * 设置 村民会议推选同意人数
	 */
	public void setMeetingAgreeNum(BigDecimal meetingAgreeNum) {
		this.meetingAgreeNum = meetingAgreeNum;
	}

	/**
	 * 获取 村民会议推选不同意人数
	 * @return BigDecimal
	 */
	public BigDecimal getMeetingUnagreeNum() {
		return meetingUnagreeNum;
	}

	/**
	 * 设置 村民会议推选不同意人数
	 */
	public void setMeetingUnagreeNum(BigDecimal meetingUnagreeNum) {
		this.meetingUnagreeNum = meetingUnagreeNum;
	}

	/**
	 * 获取 村民会议推选弃权人数
	 * @return BigDecimal
	 */
	public BigDecimal getMeetingGiveupNum() {
		return meetingGiveupNum;
	}

	/**
	 * 设置 村民会议推选弃权人数
	 */
	public void setMeetingGiveupNum(BigDecimal meetingGiveupNum) {
		this.meetingGiveupNum = meetingGiveupNum;
	}

	/**
	 * 获取 村民代表会议推选村民代表会议总数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietNum() {
		return sovietNum;
	}

	/**
	 * 设置 村民代表会议推选村民代表会议总数
	 */
	public void setSovietNum(BigDecimal sovietNum) {
		this.sovietNum = sovietNum;
	}

	/**
	 * 获取 村民代表会议推选实际参加推选的人数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietActNum() {
		return sovietActNum;
	}

	/**
	 * 设置 村民代表会议推选实际参加推选的人数
	 */
	public void setSovietActNum(BigDecimal sovietActNum) {
		this.sovietActNum = sovietActNum;
	}

	/**
	 * 获取 村民代表会议推选同意人数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietAgreeNum() {
		return sovietAgreeNum;
	}

	/**
	 * 设置 村民代表会议推选同意人数
	 */
	public void setSovietAgreeNum(BigDecimal sovietAgreeNum) {
		this.sovietAgreeNum = sovietAgreeNum;
	}

	/**
	 * 获取 村民代表会议推选不同意人数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietUnagreeNum() {
		return sovietUnagreeNum;
	}

	/**
	 * 设置 村民代表会议推选不同意人数
	 */
	public void setSovietUnagreeNum(BigDecimal sovietUnagreeNum) {
		this.sovietUnagreeNum = sovietUnagreeNum;
	}

	/**
	 * 获取 村民代表会议推选弃权人数
	 * @return BigDecimal
	 */
	public BigDecimal getSovietGiveupNum() {
		return sovietGiveupNum;
	}

	/**
	 * 设置 村民代表会议推选弃权人数
	 */
	public void setSovietGiveupNum(BigDecimal sovietGiveupNum) {
		this.sovietGiveupNum = sovietGiveupNum;
	}

	/**
	 * 获取 罢免联名罢免职务
	 * @return String
	 */
	public String getRecallDuty() {
		return recallDuty;
	}

	/**
	 * 设置 罢免联名罢免职务
	 */
	public void setRecallDuty(String recallDuty) {
		this.recallDuty = recallDuty;
	}

	/**
	 * 获取 罢免联名选举村民总数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallVoteNum() {
		return recallVoteNum;
	}

	/**
	 * 设置 罢免联名选举村民总数
	 */
	public void setRecallVoteNum(BigDecimal recallVoteNum) {
		this.recallVoteNum = recallVoteNum;
	}

	/**
	 * 获取 罢免联名女性人数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallFemaleNum() {
		return recallFemaleNum;
	}

	/**
	 * 设置 罢免联名女性人数
	 */
	public void setRecallFemaleNum(BigDecimal recallFemaleNum) {
		this.recallFemaleNum = recallFemaleNum;
	}

	/**
	 * 获取 罢免联名少数民族人数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallFolkNum() {
		return recallFolkNum;
	}

	/**
	 * 设置 罢免联名少数民族人数
	 */
	public void setRecallFolkNum(BigDecimal recallFolkNum) {
		this.recallFolkNum = recallFolkNum;
	}

	/**
	 * 获取 罢免联名委托投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallEntrustNum() {
		return recallEntrustNum;
	}

	/**
	 * 设置 罢免联名委托投票人数
	 */
	public void setRecallEntrustNum(BigDecimal recallEntrustNum) {
		this.recallEntrustNum = recallEntrustNum;
	}

	/**
	 * 获取 罢免联名使用流动票箱投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallFlowNum() {
		return recallFlowNum;
	}

	/**
	 * 设置 罢免联名使用流动票箱投票人数
	 */
	public void setRecallFlowNum(BigDecimal recallFlowNum) {
		this.recallFlowNum = recallFlowNum;
	}

	/**
	 * 获取 罢免联名代写选票人数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallReplaceNum() {
		return recallReplaceNum;
	}

	/**
	 * 设置 罢免联名代写选票人数
	 */
	public void setRecallReplaceNum(BigDecimal recallReplaceNum) {
		this.recallReplaceNum = recallReplaceNum;
	}

	/**
	 * 获取 罢免联名参加罢免大会投票的选民数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallNum() {
		return recallNum;
	}

	/**
	 * 设置 罢免联名参加罢免大会投票的选民数
	 */
	public void setRecallNum(BigDecimal recallNum) {
		this.recallNum = recallNum;
	}

	/**
	 * 获取 罢免表决中心会场投票箱数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallCenBoxNum() {
		return recallCenBoxNum;
	}

	/**
	 * 设置 罢免表决中心会场投票箱数
	 */
	public void setRecallCenBoxNum(BigDecimal recallCenBoxNum) {
		this.recallCenBoxNum = recallCenBoxNum;
	}

	/**
	 * 获取 罢免表决设立分会场数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallSubNum() {
		return recallSubNum;
	}

	/**
	 * 设置 罢免表决设立分会场数
	 */
	public void setRecallSubNum(BigDecimal recallSubNum) {
		this.recallSubNum = recallSubNum;
	}

	/**
	 * 获取 罢免表决分会场投票箱数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallSubBoxNum() {
		return recallSubBoxNum;
	}

	/**
	 * 设置 罢免表决分会场投票箱数
	 */
	public void setRecallSubBoxNum(BigDecimal recallSubBoxNum) {
		this.recallSubBoxNum = recallSubBoxNum;
	}

	/**
	 * 获取 罢免表决投票箱总数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallBoxNum() {
		return recallBoxNum;
	}

	/**
	 * 设置 罢免表决投票箱总数
	 */
	public void setRecallBoxNum(BigDecimal recallBoxNum) {
		this.recallBoxNum = recallBoxNum;
	}

	/**
	 * 获取 罢免表决参加会议村民总数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallMeetingNum() {
		return recallMeetingNum;
	}

	/**
	 * 设置 罢免表决参加会议村民总数
	 */
	public void setRecallMeetingNum(BigDecimal recallMeetingNum) {
		this.recallMeetingNum = recallMeetingNum;
	}

	/**
	 * 获取 罢免表决同意人数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallAgreeNum() {
		return recallAgreeNum;
	}

	/**
	 * 设置 罢免表决同意人数
	 */
	public void setRecallAgreeNum(BigDecimal recallAgreeNum) {
		this.recallAgreeNum = recallAgreeNum;
	}

	/**
	 * 获取 罢免表决不同意人数
	 * @return BigDecimal
	 */
	public BigDecimal getRecallUnagreeNum() {
		return recallUnagreeNum;
	}

	/**
	 * 设置 罢免表决不同意人数
	 */
	public void setRecallUnagreeNum(BigDecimal recallUnagreeNum) {
		this.recallUnagreeNum = recallUnagreeNum;
	}

	/**
	 * 获取 罢免是否成功
	 * @return String
	 */
	public String getRecallSuccess() {
		return recallSuccess;
	}

	/**
	 * 设置 罢免是否成功
	 */
	public void setRecallSuccess(String recallSuccess) {
		this.recallSuccess = recallSuccess;
	}

	/**
	 * 获取 补选原因
	 * @return String
	 */
	public String getReReason() {
		return reReason;
	}

	/**
	 * 设置 补选原因
	 */
	public void setReReason(String reReason) {
		this.reReason = reReason;
	}

	/**
	 * 获取 补选情况
	 * @return String
	 */
	public String getReSituation() {
		return reSituation;
	}

	/**
	 * 设置 补选情况
	 */
	public void setReSituation(String reSituation) {
		this.reSituation = reSituation;
	}

	/**
	 * 获取 村民会议补选总数
	 * @return BigDecimal
	 */
	public BigDecimal getReMeetingNum() {
		return reMeetingNum;
	}

	/**
	 * 设置 村民会议补选总数
	 */
	public void setReMeetingNum(BigDecimal reMeetingNum) {
		this.reMeetingNum = reMeetingNum;
	}

	/**
	 * 获取 村民会议补选女性人数
	 * @return BigDecimal
	 */
	public BigDecimal getReMeetingFemaleNum() {
		return reMeetingFemaleNum;
	}

	/**
	 * 设置 村民会议补选女性人数
	 */
	public void setReMeetingFemaleNum(BigDecimal reMeetingFemaleNum) {
		this.reMeetingFemaleNum = reMeetingFemaleNum;
	}

	/**
	 * 获取 村民会议补选少数民族人数
	 * @return BigDecimal
	 */
	public BigDecimal getReMeetingFolkNum() {
		return reMeetingFolkNum;
	}

	/**
	 * 设置 村民会议补选少数民族人数
	 */
	public void setReMeetingFolkNum(BigDecimal reMeetingFolkNum) {
		this.reMeetingFolkNum = reMeetingFolkNum;
	}

	public BigDecimal getReDirNum() {
		return reDirNum;
	}

	public void setReDirNum(BigDecimal reDirNum) {
		this.reDirNum = reDirNum;
	}

	public BigDecimal getReComNum() {
		return reComNum;
	}

	public void setReComNum(BigDecimal reComNum) {
		this.reComNum = reComNum;
	}

	/**
	 * 获取 村民会议补选委托投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getReEntrustNum() {
		return reEntrustNum;
	}

	/**
	 * 设置 村民会议补选委托投票人数
	 */
	public void setReEntrustNum(BigDecimal reEntrustNum) {
		this.reEntrustNum = reEntrustNum;
	}

	/**
	 * 获取 村民会议补选使用流动票箱投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getReFlowNum() {
		return reFlowNum;
	}

	/**
	 * 设置 村民会议补选使用流动票箱投票人数
	 */
	public void setReFlowNum(BigDecimal reFlowNum) {
		this.reFlowNum = reFlowNum;
	}

	/**
	 * 获取 村民会议补选代写选票人数
	 * @return BigDecimal
	 */
	public BigDecimal getReReplaceNum() {
		return reReplaceNum;
	}

	/**
	 * 设置 村民会议补选代写选票人数
	 */
	public void setReReplaceNum(BigDecimal reReplaceNum) {
		this.reReplaceNum = reReplaceNum;
	}

	/**
	 * 获取 村民会议补选实际参加投票村民数
	 * @return BigDecimal
	 */
	public BigDecimal getReActNum() {
		return reActNum;
	}

	/**
	 * 设置 村民会议补选实际参加投票村民数
	 */
	public void setReActNum(BigDecimal reActNum) {
		this.reActNum = reActNum;
	}

	/**
	 * 获取 村民代表会议代表总数
	 * @return BigDecimal
	 */
	public BigDecimal getReSovietNum() {
		return reSovietNum;
	}

	/**
	 * 设置 村民代表会议代表总数
	 */
	public void setReSovietNum(BigDecimal reSovietNum) {
		this.reSovietNum = reSovietNum;
	}

	/**
	 * 获取 村民代表会议女性人数
	 * @return BigDecimal
	 */
	public BigDecimal getReSovietFemaleNum() {
		return reSovietFemaleNum;
	}

	/**
	 * 设置 村民代表会议女性人数
	 */
	public void setReSovietFemaleNum(BigDecimal reSovietFemaleNum) {
		this.reSovietFemaleNum = reSovietFemaleNum;
	}

	/**
	 * 获取 村民代表会议少数民族人数
	 * @return BigDecimal
	 */
	public BigDecimal getReSovietFolkNum() {
		return reSovietFolkNum;
	}

	/**
	 * 设置 村民代表会议少数民族人数
	 */
	public void setReSovietFolkNum(BigDecimal reSovietFolkNum) {
		this.reSovietFolkNum = reSovietFolkNum;
	}

	/**
	 * 获取 村民代表会议参加人数
	 * @return BigDecimal
	 */
	public BigDecimal getReSovietJoinNum() {
		return reSovietJoinNum;
	}

	/**
	 * 设置 村民代表会议参加人数
	 */
	public void setReSovietJoinNum(BigDecimal reSovietJoinNum) {
		this.reSovietJoinNum = reSovietJoinNum;
	}

	/**
	 * 获取 填报单位行政区划
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 填报单位行政区划
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 填报单位名称
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 填报单位名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 所属上级行政区划
	 * @return String
	 */
	public String getParentCode() {
		return parentCode;
	}

	/**
	 * 设置 所属上级行政区划
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * 获取 填报报表类型
	 * @return String
	 */
	public String getReportType() {
		return reportType;
	}

	/**
	 * 设置 填报报表类型
	 */
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	/**
	 * 获取 填报日期
	 * @return String
	 */
	public String getReportDate() {
		return reportDate;
	}

	/**
	 * 设置 填报日期
	 */
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * 获取 上报状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 上报状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 获取 上报日期
	 * @return String
	 */
	public String getSubmitDate() {
		return submitDate;
	}

	/**
	 * 设置 上报日期
	 */
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	/**
	 * 获取 创建日期
	 * @return String
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建日期
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getReRedNum() {
		return reRedNum;
	}

	public void setReRedNum(BigDecimal reRedNum) {
		this.reRedNum = reRedNum;
	}

}