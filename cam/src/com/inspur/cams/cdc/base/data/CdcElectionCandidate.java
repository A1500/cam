package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 民主选举正式候�?�人信息�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_ELECTION_CANDIDATE", keyFields = "candidateId")
public class CdcElectionCandidate extends StatefulDatabean {

	// 候选人内码
	private String candidateId;

	// 选举内码
	private String recordId;

	// 应选名额
	@Rule( value = "number" )
	private BigDecimal shouldNum;

	// 正式候选人人数 
	@Rule( value = "number" )
	private BigDecimal candidateNum;

	// 女性人数
	@Rule( value = "number" )
	private BigDecimal femaleNum;

	// 党员人数
	@Rule( value = "number" )
	private BigDecimal partyNum;

	// 少数民族人数
	@Rule( value = "number" )
	private BigDecimal folkNum;
	
	// 确定方式
	private String  confirm;

	// 是否组织竞职演讲
	private String ifLecture;

	// 填报单位行政区划
	private String organCode;

	// 填报单位名称
	private String organName;

	// 所属上级行政区划
	private String parentCode;

	// 填报日期
	private String reportDate;

	// 上报状�??
	private String status;

	// 上报日期
	private String submitDate;
	
	//填报报表类型
	private String reportType;
	
	//创建时间
	private String createTime;

	// 直接提名产生人数
	@Rule( value = "number" )
	private BigDecimal directNum;
	// 村居民预选人�?
	@Rule( value = "number" )
	private BigDecimal preelectionNum;

	/**
	 * 设置 候�?�人内码
	 * @return String
	 */
	public String getCandidateId() {
		return candidateId;
	}

	/**
	 * 设置 候�?�人内码
	 */
	public void setCandidateId(String candidateId) {
		this.candidateId = candidateId;
	}

	/**
	 * 设置 选举内码
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
	 * 设置 应�?�名�?
	 * @return BigDecimal
	 */
	public BigDecimal getShouldNum() {
		return shouldNum;
	}

	/**
	 * 设置 应�?�名�?
	 */
	public void setShouldNum(BigDecimal shouldNum) {
		this.shouldNum = shouldNum;
	}

	/**
	 * 设置 正式候�?�人人数
	 * @return BigDecimal
	 */
	public BigDecimal getCandidateNum() {
		return candidateNum;
	}

	/**
	 * 设置 正式候�?�人人数
	 */
	public void setCandidateNum(BigDecimal candidateNum) {
		this.candidateNum = candidateNum;
	}

	/**
	 * 设置 正式候�?�人女�?�人�?
	 * @return BigDecimal
	 */
	public BigDecimal getFemaleNum() {
		return femaleNum;
	}

	/**
	 * 设置 正式候�?�人女�?�人�?
	 */
	public void setFemaleNum(BigDecimal femaleNum) {
		this.femaleNum = femaleNum;
	}

	/**
	 * 设置 正式候�?�人党员人数
	 * @return BigDecimal
	 */
	public BigDecimal getPartyNum() {
		return partyNum;
	}

	/**
	 * 设置 正式候�?�人党员人数
	 */
	public void setPartyNum(BigDecimal partyNum) {
		this.partyNum = partyNum;
	}

	/**
	 * 设置 正式候�?�人少数民族�?
	 * @return BigDecimal
	 */
	public BigDecimal getFolkNum() {
		return folkNum;
	}

	/**
	 * 设置 正式候�?�人少数民族�?
	 */
	public void setFolkNum(BigDecimal folkNum) {
		this.folkNum = folkNum;
	}

	/**
	 * 设置 村居民预选人�?
	 * @return BigDecimal
	 */
	public BigDecimal getPreelectionNum() {
		return preelectionNum;
	}

	/**
	 * 设置 村居民预选人�?
	 */
	public void setPreelectionNum(BigDecimal preelectionNum) {
		this.preelectionNum = preelectionNum;
	}

//	/**
//	 * 设置 提名预�?�人�?
//	 * @return BigDecimal
//	 */
//	public BigDecimal getNominateNum() {
//		return nominateNum;
//	}
//
//	/**
//	 * 设置 提名预�?�人�?
//	 */
//	public void setNominateNum(BigDecimal nominateNum) {
//		this.nominateNum = nominateNum;
//	}

	/**
	 * 设置 直接提名产生人数
	 * @return BigDecimal
	 */
	public BigDecimal getDirectNum() {
		return directNum;
	}

	/**
	 * 设置 直接提名产生人数
	 */
	public void setDirectNum(BigDecimal directNum) {
		this.directNum = directNum;
	}

//	/**
//	 * 设置 组织竞职演讲人数
//	 * @return BigDecimal
//	 */
//	public BigDecimal getLectureNum() {
//		return lectureNum;
//	}
//
//	/**
//	 * 设置 组织竞职演讲人数
//	 */
//	public void setLectureNum(BigDecimal lectureNum) {
//		this.lectureNum = lectureNum;
//	}

	/**
	 * 设置 填报单位行政区划
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
	 * @return
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 填报单位名称
	 * @param organName
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	
	/**
	 * 获取 所属上级行政区划
	 * @return
	 */
	public String getParentCode() {
		return parentCode;
	}

	/**
	 * 设置 所属上级行政区划
	 * @param parentCode
	 */
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	/**
	 * 设置 填报日期
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
	 * 设置 上报状�??
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 上报状�??
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 设置 上报日期
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
	
	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public String getIfLecture() {
		return ifLecture;
	}

	public void setIfLecture(String ifLecture) {
		this.ifLecture = ifLecture;
	}
}