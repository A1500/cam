package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举正式选举databean
 * @author 
 * @date 2012-12-14
 */
@Table(tableName = "CDC_ELECTION_VOTE", keyFields = "voteId")
public class CdcElectionVote extends StatefulDatabean {

	// 投票内码
	private String voteId;

	// 选举内码
	private String recordId;

	// 投票方式
	private String voterManner;

	// 参加正式选举投票的村民总数【城市：选民总数】
	private BigDecimal voterNum;

	// 委托投票人数【城市：委托投票总数】
	private BigDecimal entrustNum;

	// 使用流动票箱投票人数【城市：流动票箱投票数】
	private BigDecimal flowNum;

	// 代写选票人数
	private BigDecimal replaceNum;

	// 中心会场投票箱数【城市：选举会场投票数】
	private BigDecimal centerBoxNum;

	// 设立分会场数
	private BigDecimal subNum;
	
	//【城市：居委会成员罢免情况 罢免主任人数】
	private BigDecimal dismissHeadNum;
	
	//【城市：居委会成员罢免情况 罢免副主任人数】
	private BigDecimal dismissSheadNum;
	
	//【城市：居委会成员罢免情况 罢免成员人数】
	private BigDecimal dismissMemberNum;

	// 分会场投票箱数【城市：函投票数】
	private BigDecimal subBoxNum;

	// 投票箱总数
	private BigDecimal boxNum;

	// 参加投票站投票总数【城市：投票站投票数】
	private BigDecimal stationVoteNum;

	// 秘密写票处
	private BigDecimal secretNum;

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

	/**
	 * 获取 投票内码
	 * @return String
	 */
	public String getVoteId() {
		return voteId;
	}

	/**
	 * 设置 投票内码
	 */
	public void setVoteId(String voteId) {
		this.voteId = voteId;
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
	 * 获取 投票方式
	 * @return String
	 */
	public String getVoterManner() {
		return voterManner;
	}

	/**
	 * 设置 投票方式
	 */
	public void setVoterManner(String voterManner) {
		this.voterManner = voterManner;
	}

	/**
	 * 获取 参加正式选举投票的村民总数
	 * @return BigDecimal
	 */
	public BigDecimal getVoterNum() {
		return voterNum;
	}

	/**
	 * 设置 参加正式选举投票的村民总数
	 */
	public void setVoterNum(BigDecimal voterNum) {
		this.voterNum = voterNum;
	}

	/**
	 * 获取 委托投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getEntrustNum() {
		return entrustNum;
	}

	/**
	 * 设置 委托投票人数
	 */
	public void setEntrustNum(BigDecimal entrustNum) {
		this.entrustNum = entrustNum;
	}

	/**
	 * 获取 使用流动票箱投票人数
	 * @return BigDecimal
	 */
	public BigDecimal getFlowNum() {
		return flowNum;
	}

	/**
	 * 设置 使用流动票箱投票人数
	 */
	public void setFlowNum(BigDecimal flowNum) {
		this.flowNum = flowNum;
	}

	/**
	 * 获取 代写选票人数
	 * @return BigDecimal
	 */
	public BigDecimal getReplaceNum() {
		return replaceNum;
	}

	/**
	 * 设置 代写选票人数
	 */
	public void setReplaceNum(BigDecimal replaceNum) {
		this.replaceNum = replaceNum;
	}

	/**
	 * 获取 中心会场投票箱数
	 * @return BigDecimal
	 */
	public BigDecimal getCenterBoxNum() {
		return centerBoxNum;
	}

	/**
	 * 设置 中心会场投票箱数
	 */
	public void setCenterBoxNum(BigDecimal centerBoxNum) {
		this.centerBoxNum = centerBoxNum;
	}

	/**
	 * 获取 设立分会场数
	 * @return BigDecimal
	 */
	public BigDecimal getSubNum() {
		return subNum;
	}

	/**
	 * 设置 设立分会场数
	 */
	public void setSubNum(BigDecimal subNum) {
		this.subNum = subNum;
	}

	/**
	 * 获取 分会场投票箱数
	 * @return BigDecimal
	 */
	public BigDecimal getSubBoxNum() {
		return subBoxNum;
	}

	/**
	 * 设置 分会场投票箱数
	 */
	public void setSubBoxNum(BigDecimal subBoxNum) {
		this.subBoxNum = subBoxNum;
	}

	/**
	 * 获取 投票箱总数
	 * @return BigDecimal
	 */
	public BigDecimal getBoxNum() {
		return boxNum;
	}

	/**
	 * 设置 投票箱总数
	 */
	public void setBoxNum(BigDecimal boxNum) {
		this.boxNum = boxNum;
	}

	/**
	 * 获取 参加投票站投票总数
	 * @return BigDecimal
	 */
	public BigDecimal getStationVoteNum() {
		return stationVoteNum;
	}

	/**
	 * 设置 参加投票站投票总数
	 */
	public void setStationVoteNum(BigDecimal stationVoteNum) {
		this.stationVoteNum = stationVoteNum;
	}

	/**
	 * 获取 秘密写票处
	 * @return BigDecimal
	 */
	public BigDecimal getSecretNum() {
		return secretNum;
	}

	/**
	 * 设置 秘密写票处
	 */
	public void setSecretNum(BigDecimal secretNum) {
		this.secretNum = secretNum;
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

	public BigDecimal getDismissHeadNum() {
		return dismissHeadNum;
	}

	public void setDismissHeadNum(BigDecimal dismissHeadNum) {
		this.dismissHeadNum = dismissHeadNum;
	}

	public BigDecimal getDismissSheadNum() {
		return dismissSheadNum;
	}

	public void setDismissSheadNum(BigDecimal dismissSheadNum) {
		this.dismissSheadNum = dismissSheadNum;
	}

	public BigDecimal getDismissMemberNum() {
		return dismissMemberNum;
	}

	public void setDismissMemberNum(BigDecimal dismissMemberNum) {
		this.dismissMemberNum = dismissMemberNum;
	}

}