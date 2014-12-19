package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举候选人的产生databean
 * @author 
 * @date 2012-12-14
 */
@Table(tableName = "CDC_ELECTION_NOMINATE", keyFields = "nominateId")
public class CdcElectionNominate extends StatefulDatabean {

	@Transient
	private List<CdcElectionMember> cdcElectionMemberList = new ArrayList<CdcElectionMember>();
	
	// 提名内码
	private String nominateId;

	// 选举内码
	private String recordId;

	// 候选人产生方式
	private String candidateManner;

	// 提名候选人应选职数
	private BigDecimal nomNum;

	// 提名候选人差额数
	private BigDecimal nomDiffNum;

	// 提名的村民数【城市:提名方式“初步候选人总数(人)”】
	private BigDecimal nomJoinNum;

	// 预选（提名）村民委员会应选职数【城市:提名方式“女性人数(人)”】
	private BigDecimal prenomNum;

	// 预选（提名）村民委员会差额【城市:提名方式“党员人数(人)”】
	private BigDecimal prenomDiffNum;

	// 预选（提名）投票的村民数【城市:提名方式“少数民族人数(人)”】
	private BigDecimal prenomJoinNum;

	// 预选（提名）候选人人数
	private BigDecimal prenomCanNum;

	// 预选（提名）候选人差额数
	private BigDecimal prenomCanDiffNum;

	// 预选村民委员会应选职数
	private BigDecimal preNum;

	// 预选候选人数
	private BigDecimal preCanNum;

	// 预选差额数
	private BigDecimal preDiffNum;

	// 预选投票的村民数
	private BigDecimal preJoinNum;

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
	 * 获取 提名内码
	 * @return String
	 */
	public String getNominateId() {
		return nominateId;
	}

	/**
	 * 设置 提名内码
	 */
	public void setNominateId(String nominateId) {
		this.nominateId = nominateId;
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
	 * 获取 候选人产生方式
	 * @return String
	 */
	public String getCandidateManner() {
		return candidateManner;
	}

	/**
	 * 设置 候选人产生方式
	 */
	public void setCandidateManner(String candidateManner) {
		this.candidateManner = candidateManner;
	}

	/**
	 * 获取 提名候选人应选职数
	 * @return BigDecimal
	 */
	public BigDecimal getNomNum() {
		return nomNum;
	}

	/**
	 * 设置 提名候选人应选职数
	 */
	public void setNomNum(BigDecimal nomNum) {
		this.nomNum = nomNum;
	}

	/**
	 * 获取 提名候选人差额数
	 * @return BigDecimal
	 */
	public BigDecimal getNomDiffNum() {
		return nomDiffNum;
	}

	/**
	 * 设置 提名候选人差额数
	 */
	public void setNomDiffNum(BigDecimal nomDiffNum) {
		this.nomDiffNum = nomDiffNum;
	}

	/**
	 * 获取 提名的村民数
	 * @return BigDecimal
	 */
	public BigDecimal getNomJoinNum() {
		return nomJoinNum;
	}

	/**
	 * 设置 提名的村民数
	 */
	public void setNomJoinNum(BigDecimal nomJoinNum) {
		this.nomJoinNum = nomJoinNum;
	}

	/**
	 * 获取 预选（提名）村民委员会应选职数
	 * @return BigDecimal
	 */
	public BigDecimal getPrenomNum() {
		return prenomNum;
	}

	/**
	 * 设置 预选（提名）村民委员会应选职数
	 */
	public void setPrenomNum(BigDecimal prenomNum) {
		this.prenomNum = prenomNum;
	}

	/**
	 * 获取 预选（提名）村民委员会差额
	 * @return BigDecimal
	 */
	public BigDecimal getPrenomDiffNum() {
		return prenomDiffNum;
	}

	/**
	 * 设置 预选（提名）村民委员会差额
	 */
	public void setPrenomDiffNum(BigDecimal prenomDiffNum) {
		this.prenomDiffNum = prenomDiffNum;
	}

	/**
	 * 获取 预选（提名）投票的村民数
	 * @return BigDecimal
	 */
	public BigDecimal getPrenomJoinNum() {
		return prenomJoinNum;
	}

	/**
	 * 设置 预选（提名）投票的村民数
	 */
	public void setPrenomJoinNum(BigDecimal prenomJoinNum) {
		this.prenomJoinNum = prenomJoinNum;
	}

	/**
	 * 获取 预选（提名）候选人人数
	 * @return BigDecimal
	 */
	public BigDecimal getPrenomCanNum() {
		return prenomCanNum;
	}

	/**
	 * 设置 预选（提名）候选人人数
	 */
	public void setPrenomCanNum(BigDecimal prenomCanNum) {
		this.prenomCanNum = prenomCanNum;
	}

	/**
	 * 获取 预选（提名）候选人差额数
	 * @return BigDecimal
	 */
	public BigDecimal getPrenomCanDiffNum() {
		return prenomCanDiffNum;
	}

	/**
	 * 设置 预选（提名）候选人差额数
	 */
	public void setPrenomCanDiffNum(BigDecimal prenomCanDiffNum) {
		this.prenomCanDiffNum = prenomCanDiffNum;
	}

	/**
	 * 获取 预选村民委员会应选职数
	 * @return BigDecimal
	 */
	public BigDecimal getPreNum() {
		return preNum;
	}

	/**
	 * 设置 预选村民委员会应选职数
	 */
	public void setPreNum(BigDecimal preNum) {
		this.preNum = preNum;
	}

	/**
	 * 获取 预选候选人数
	 * @return BigDecimal
	 */
	public BigDecimal getPreCanNum() {
		return preCanNum;
	}

	/**
	 * 设置 预选候选人数
	 */
	public void setPreCanNum(BigDecimal preCanNum) {
		this.preCanNum = preCanNum;
	}

	/**
	 * 获取 预选差额数
	 * @return BigDecimal
	 */
	public BigDecimal getPreDiffNum() {
		return preDiffNum;
	}

	/**
	 * 设置 预选差额数
	 */
	public void setPreDiffNum(BigDecimal preDiffNum) {
		this.preDiffNum = preDiffNum;
	}

	/**
	 * 获取 预选投票的村民数
	 * @return BigDecimal
	 */
	public BigDecimal getPreJoinNum() {
		return preJoinNum;
	}

	/**
	 * 设置 预选投票的村民数
	 */
	public void setPreJoinNum(BigDecimal preJoinNum) {
		this.preJoinNum = preJoinNum;
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

}