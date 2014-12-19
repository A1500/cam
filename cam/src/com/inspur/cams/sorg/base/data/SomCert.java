package com.inspur.cams.sorg.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * 社会组织证书databean
 * 
 * @author shgtch
 * @date 2011年5月20日8:59:05
 */
@Table(tableName = "SOM_CERT", keyFields = "id")
public class SomCert extends StatefulDatabean {

	// 证书ID
	private String id;

	// 社会组织ID
	private String sorgId;

	// 社会组织类型
	@Rule(value = "require")
	private String sorgType;
	// 业务编号
	private String taskCode;

	// 社会组织种类
	private String sorgKind;
	// 是否为分支
	private String ifBranch;

	// 证书类别
	private String certType;

	// 登记证号
	private String sorgCode;

	// 组织机构代码
	private String organCode;

	// 社会组织名称
	private String sorgName;

	// 业务范围
	private String business;

	// 住所
	private String residence;

	// 法定代表人
	private String legalPeople;

	// 活动范围
	private String actArea;

	// 资金数额（万元）
	private String regMon;

	// 业务主管单位
	private String borgName;

	// 证件有效日期起
	private String signBeginDate;

	// 证件有效日期止
	private String signEndDate;

	// 证件有效期
	@Rule(value = "number")
	private BigDecimal signPeriod;

	// 发证机关
	private String signOrgan;

	// 发证日期
	private String signDate;

	// 发证原因代码
	private String issueReason;

	// 发证原因描述
	private String issueReasonDesc;

	// 制证人
	private String printPeople;

	// 制证时间
	private String printTime;

	// 领取人
	private String fetchPeople;
	
	// 领证人联系电话
	private String fetchPhone;

	// 发证人
	private String issuePeople;

	// 领证日期
	private String fetchDate;

	// 证件状态
	private String certStatus;

	// 登记管理机关名称
	@Rule(value = "require")
	private String morgName;

	// 登记管理机关行政区划
	@Rule(value = "require")
	private String morgArea;

	// 收缴标志
	private String ifReceive;

	// 收缴人
	private String receivePeople;

	// 收缴日期
	private String receiveDate;
	// 登记日期
	private String regDate;
	
	// 年检结果
	private String checkResult;

	public String getIfBranch() {
		return ifBranch;
	}

	public void setIfBranch(String ifBranch) {
		this.ifBranch = ifBranch;
	}

	/**
	 * getter for ID
	 * 
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for ID
	 * 
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for SORG_ID
	 * 
	 * @generated
	 */
	public String getSorgId() {
		return this.sorgId;
	}

	/**
	 * setter for SORG_ID
	 * 
	 * @generated
	 */
	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	/**
	 * getter for SORG_TYPE
	 * 
	 * @generated
	 */
	public String getSorgType() {
		return this.sorgType;
	}

	/**
	 * setter for SORG_TYPE
	 * 
	 * @generated
	 */
	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	/**
	 * 获取 社会组织种类
	 * 
	 * @return
	 */
	public String getSorgKind() {
		return sorgKind;
	}

	/**
	 * 设置 社会组织种类
	 * 
	 * @param sorgKind
	 */
	public void setSorgKind(String sorgKind) {
		this.sorgKind = sorgKind;
	}

	/**
	 * getter for CERT_TYPE
	 * 
	 * @generated
	 */
	public String getCertType() {
		return this.certType;
	}

	/**
	 * setter for CERT_TYPE
	 * 
	 * @generated
	 */
	public void setCertType(String certType) {
		this.certType = certType;
	}

	/**
	 * getter for SORG_CODE
	 * 
	 * @generated
	 */
	public String getSorgCode() {
		return this.sorgCode;
	}

	/**
	 * setter for SORG_CODE
	 * 
	 * @generated
	 */
	public void setSorgCode(String sorgCode) {
		this.sorgCode = sorgCode;
	}

	/**
	 * getter for ORGAN_CODE
	 * 
	 * @generated
	 */
	public String getOrganCode() {
		return this.organCode;
	}

	/**
	 * setter for ORGAN_CODE
	 * 
	 * @generated
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * getter for SORG_NAME
	 * 
	 * @generated
	 */
	public String getSorgName() {
		return this.sorgName;
	}

	/**
	 * setter for SORG_NAME
	 * 
	 * @generated
	 */
	public void setSorgName(String sorgName) {
		this.sorgName = sorgName;
	}

	/**
	 * getter for BUSINESS
	 * 
	 * @generated
	 */
	public String getBusiness() {
		return this.business;
	}

	/**
	 * setter for BUSINESS
	 * 
	 * @generated
	 */
	public void setBusiness(String business) {
		this.business = business;
	}

	/**
	 * getter for RESIDENCE
	 * 
	 * @generated
	 */
	public String getResidence() {
		return this.residence;
	}

	/**
	 * setter for RESIDENCE
	 * 
	 * @generated
	 */
	public void setResidence(String residence) {
		this.residence = residence;
	}

	/**
	 * getter for LEGAL_PEOPLE
	 * 
	 * @generated
	 */
	public String getLegalPeople() {
		return this.legalPeople;
	}

	/**
	 * setter for LEGAL_PEOPLE
	 * 
	 * @generated
	 */
	public void setLegalPeople(String legalPeople) {
		this.legalPeople = legalPeople;
	}

	/**
	 * getter for ACT_AREA
	 * 
	 * @generated
	 */
	public String getActArea() {
		return this.actArea;
	}

	/**
	 * setter for ACT_AREA
	 * 
	 * @generated
	 */
	public void setActArea(String actArea) {
		this.actArea = actArea;
	}



	public String getRegMon() {
		return regMon;
	}

	public void setRegMon(String regMon) {
		this.regMon = regMon;
	}

	public String getBorgName() {
		return borgName;
	}

	public void setBorgName(String borgName) {
		this.borgName = borgName;
	}

	/**
	 * 获取 登记日期
	 * 
	 * @return
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * 设置 登记日期
	 * 
	 * @param regDate
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	/**
	 * getter for SIGN_BEGIN_DATE
	 * 
	 * @generated
	 */
	public String getSignBeginDate() {
		return this.signBeginDate;
	}

	/**
	 * setter for SIGN_BEGIN_DATE
	 * 
	 * @generated
	 */
	public void setSignBeginDate(String signBeginDate) {
		this.signBeginDate = signBeginDate;
	}

	/**
	 * getter for SIGN_END_DATE
	 * 
	 * @generated
	 */
	public String getSignEndDate() {
		return this.signEndDate;
	}

	/**
	 * setter for SIGN_END_DATE
	 * 
	 * @generated
	 */
	public void setSignEndDate(String signEndDate) {
		this.signEndDate = signEndDate;
	}

	/**
	 * getter for SIGN_PERIOD
	 * 
	 * @generated
	 */
	public BigDecimal getSignPeriod() {
		return this.signPeriod;
	}

	/**
	 * setter for SIGN_PERIOD
	 * 
	 * @generated
	 */
	public void setSignPeriod(BigDecimal signPeriod) {
		this.signPeriod = signPeriod;
	}

	/**
	 * getter for SIGN_ORGAN
	 * 
	 * @generated
	 */
	public String getSignOrgan() {
		return this.signOrgan;
	}

	/**
	 * setter for SIGN_ORGAN
	 * 
	 * @generated
	 */
	public void setSignOrgan(String signOrgan) {
		this.signOrgan = signOrgan;
	}

	/**
	 * getter for SIGN_DATE
	 * 
	 * @generated
	 */
	public String getSignDate() {
		return this.signDate;
	}

	/**
	 * setter for SIGN_DATE
	 * 
	 * @generated
	 */
	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}

	/**
	 * getter for ISSUE_REASON
	 * 
	 * @generated
	 */
	public String getIssueReason() {
		return this.issueReason;
	}

	/**
	 * setter for ISSUE_REASON
	 * 
	 * @generated
	 */
	public void setIssueReason(String issueReason) {
		this.issueReason = issueReason;
	}

	/**
	 * getter for ISSUE_REASON_DESC
	 * 
	 * @generated
	 */
	public String getIssueReasonDesc() {
		return this.issueReasonDesc;
	}

	/**
	 * setter for ISSUE_REASON_DESC
	 * 
	 * @generated
	 */
	public void setIssueReasonDesc(String issueReasonDesc) {
		this.issueReasonDesc = issueReasonDesc;
	}

	/**
	 * getter for PRINT_PEOPLE
	 * 
	 * @generated
	 */
	public String getPrintPeople() {
		return this.printPeople;
	}

	/**
	 * setter for PRINT_PEOPLE
	 * 
	 * @generated
	 */
	public void setPrintPeople(String printPeople) {
		this.printPeople = printPeople;
	}

	/**
	 * getter for PRINT_TIME
	 * 
	 * @generated
	 */
	public String getPrintTime() {
		return this.printTime;
	}

	/**
	 * setter for PRINT_TIME
	 * 
	 * @generated
	 */
	public void setPrintTime(String printTime) {
		this.printTime = printTime;
	}

	/**
	 * getter for FETCH_PEOPLE
	 * 
	 * @generated
	 */
	public String getFetchPeople() {
		return this.fetchPeople;
	}

	/**
	 * setter for FETCH_PEOPLE
	 * 
	 * @generated
	 */
	public void setFetchPeople(String fetchPeople) {
		this.fetchPeople = fetchPeople;
	}
	
	public String getFetchPhone() {
		return fetchPhone;
	}

	public void setFetchPhone(String fetchPhone) {
		this.fetchPhone = fetchPhone;
	}

	/**
	 * getter for ISSUE_PEOPLE
	 * 
	 * @generated
	 */
	public String getIssuePeople() {
		return this.issuePeople;
	}

	/**
	 * setter for ISSUE_PEOPLE
	 * 
	 * @generated
	 */
	public void setIssuePeople(String issuePeople) {
		this.issuePeople = issuePeople;
	}

	/**
	 * getter for FETCH_DATE
	 * 
	 * @generated
	 */
	public String getFetchDate() {
		return this.fetchDate;
	}

	/**
	 * setter for FETCH_DATE
	 * 
	 * @generated
	 */
	public void setFetchDate(String fetchDate) {
		this.fetchDate = fetchDate;
	}

	/**
	 * getter for CERT_STATUS
	 * 
	 * @generated
	 */
	public String getCertStatus() {
		return this.certStatus;
	}

	/**
	 * setter for CERT_STATUS
	 * 
	 * @generated
	 */
	public void setCertStatus(String certStatus) {
		this.certStatus = certStatus;
	}

	/**
	 * getter for MORG_NAME
	 * 
	 * @generated
	 */
	public String getMorgName() {
		return this.morgName;
	}

	/**
	 * setter for MORG_NAME
	 * 
	 * @generated
	 */
	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	/**
	 * getter for MORG_AREA
	 * 
	 * @generated
	 */
	public String getMorgArea() {
		return this.morgArea;
	}

	/**
	 * setter for MORG_AREA
	 * 
	 * @generated
	 */
	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	/**
	 * getter for IF_RECEIVE
	 * 
	 * @generated
	 */
	public String getIfReceive() {
		return this.ifReceive;
	}

	/**
	 * setter for IF_RECEIVE
	 * 
	 * @generated
	 */
	public void setIfReceive(String ifReceive) {
		this.ifReceive = ifReceive;
	}

	/**
	 * getter for RECEIVE_PEOPLE
	 * 
	 * @generated
	 */
	public String getReceivePeople() {
		return this.receivePeople;
	}

	/**
	 * setter for RECEIVE_PEOPLE
	 * 
	 * @generated
	 */
	public void setReceivePeople(String receivePeople) {
		this.receivePeople = receivePeople;
	}

	/**
	 * getter for RECEIVE_DATE
	 * 
	 * @generated
	 */
	public String getReceiveDate() {
		return this.receiveDate;
	}

	/**
	 * setter for RECEIVE_DATE
	 * 
	 * @generated
	 */
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

}