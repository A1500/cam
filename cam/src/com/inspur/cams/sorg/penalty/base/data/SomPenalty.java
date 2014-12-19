package com.inspur.cams.sorg.penalty.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 行政执法基本信息databean
 * 
 * @author zhangjian
 * @date 2011-12-21
 */
@Table(tableName = "SOM_PENALTY", keyFields = "taskCode")
public class SomPenalty extends StatefulDatabean {
	// 业务编号
	
	private String taskCode;
	// 案号年份
	
	private String caseCodeYear;
	// 案号
	
	private String caseCode;
	// 处罚类型
	private String penaltyType;
	// 社会组织名称
	private String sorgName;
	// 社会组织类型
	private String sorgType;
	// 登记证号
	private String sorgCode;
	// 案件状态
	private String caseStatus;
	// 案件来源
	private String caseSource;
	// 案源提供人种类
	private String caseSourceType;
	// 提供人姓名
	private String providerName;
	// 提供人单位
	private String providerOrgan;
	// 举报投诉或移送、交办方式
	private String providerWay;
	// 提供人电话
	private String providerPhone;
	// 提供人地址
	private String providerAdd;
	// 提供人邮编
	private String providerPost;
	// 其他提供人姓名
	private String providerNameOther;
	// 其他提供人单位
	private String providerOrganOther;
	// 当事人名称
	private String partyName;
	// 当事人法定代表人（负责人）或发起人
	private String partyCharger;
	// 当事人法定代表人（负责人）或发起人职务
	private String partyChargerDuties;
	// 当事人电话
	private String partyPhone;
	// 当事人地址
	private String partyAdd;
	// 案件简要情况
	private String caseBrief;
	// 备注
	private String note;
	// 案情简介
	private String caseDesc;
	// 案件基本事实
	private String caseBaseInfact;
	// 行政处罚违法行为
	private String penaltyInfact;
	// 行政处罚证据证明
	private String penaltyProof;
	// 行政处罚违反规定
	private String penaltyDeregulation;
	// 行政处罚依据
	private String penaltyReason;
	// 行政处罚结果
	private String penaltyResult;
	// 行政处罚交罚款银行名称
	private String penaltyBank;
	// 行政处罚交罚款银行帐号
	private String penaltyBankAccount;
	// 行政处罚申请行政复议单位
	private String penaltyReviewOrgan;
	// 行政处罚申请行政复议单位其他
	private String penaltyReviewOrganOther;
	// 行政处罚决定书编号
	private String penaltyInformNo;
	// 告知书日期
	private String informDate;
	// 告知书编号
	private String informNo;
	// 行政处罚方式的种类
	private String penaltyInformType;
	// 告知书处罚的内容
	private String informContent;
	// 当事人是否陈述、申辩
	private String ifAverment;
	// 行政处罚陈述、申辩的意见和理由
	private String avermentReason;
	// 当事人是否申请听证
	private String ifHearing;
	// 申请听证日期
	private String hearingApplyDate;
	// 申请听证方式
	private String hearingApplyType;
	// 立案时间
	private String regDate;
	// 立案名称
	private String regName;
	// 结案理由
	private String caseFinalReason;
	// 结案时间
	private String finalDate;
	// 调查结束时间
	private String invEndDate;
	// 调查开始时间
	private String invStartDate;
	// 调查人
	private String invPerson;
	// 调查案由及调查经过
	private String invProcess;
	// 调查违法事实
	private String invInfact;
	// 调查证据证明
	private String invProve;
	// 调查案件性质
	private String invCaseNature;
	// 调查处罚依据
	private String invProof;
	// 调查处罚建议
	private String invPunSuggestions;
	// 听证会日期
	private String hearingDate;
	// 听证会地点
	private String hearingAdd;
	// 听证会类型
	private String hearingType;
	// 听证会主持人
	private String hearingPresenter;
	// 听证会主持人单位
	private String hearingPresenterOrgan;
	// 听证会主持人职务
	private String hearingPresenterDuties;
	// 听证会记录人
	private String hearingRecorder;
	// 听证会记录人单位
	private String hearingRecorderOrgan;
	// 听证会记录人职务
	private String hearingRecorderDuties;
	// 听证会参加人
	private String hearingPartyCharger;
	// 听证会参加人名称
	private String hearingPartyChargerName;
	// 陈述和申辩日期
	private String avermentDate;
	// 陈述和申辩地点
	private String avermentAdd;
	// 登记管理机关名称
	
	private String morgName;
	// 登记管理机关行政区划
	
	private String morgArea;
	// 联系人地址
	private String linkmanAdd;
	// 联系人邮政编码
	private String linkmanPost;
	// 联系人
	private String linkmanName;
	// 联系人电话
	private String linkmanPhone;
	// 登记日期
	private String acceptDate;
	// 登记人ID
	private String acceptPeopleId;
	// 登记人名称
	private String acceptPeopleName;

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getCaseCodeYear() {
		return caseCodeYear;
	}

	public void setCaseCodeYear(String caseCodeYear) {
		this.caseCodeYear = caseCodeYear;
	}

	public String getCaseCode() {
		return caseCode;
	}

	public void setCaseCode(String caseCode) {
		this.caseCode = caseCode;
	}

	public String getPenaltyType() {
		return penaltyType;
	}

	public void setPenaltyType(String penaltyType) {
		this.penaltyType = penaltyType;
	}

	public String getSorgName() {
		return sorgName;
	}

	public void setSorgName(String sorgName) {
		this.sorgName = sorgName;
	}

	public String getSorgType() {
		return sorgType;
	}

	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
	}

	public String getSorgCode() {
		return sorgCode;
	}

	public void setSorgCode(String sorgCode) {
		this.sorgCode = sorgCode;
	}

	public String getCaseStatus() {
		return caseStatus;
	}

	public void setCaseStatus(String caseStatus) {
		this.caseStatus = caseStatus;
	}

	public String getCaseSource() {
		return caseSource;
	}

	public void setCaseSource(String caseSource) {
		this.caseSource = caseSource;
	}

	public String getCaseSourceType() {
		return caseSourceType;
	}

	public void setCaseSourceType(String caseSourceType) {
		this.caseSourceType = caseSourceType;
	}

	public String getProviderName() {
		return providerName;
	}

	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}

	public String getProviderOrgan() {
		return providerOrgan;
	}

	public void setProviderOrgan(String providerOrgan) {
		this.providerOrgan = providerOrgan;
	}

	public String getProviderWay() {
		return providerWay;
	}

	public void setProviderWay(String providerWay) {
		this.providerWay = providerWay;
	}

	public String getProviderPhone() {
		return providerPhone;
	}

	public void setProviderPhone(String providerPhone) {
		this.providerPhone = providerPhone;
	}

	public String getProviderAdd() {
		return providerAdd;
	}

	public void setProviderAdd(String providerAdd) {
		this.providerAdd = providerAdd;
	}

	public String getProviderPost() {
		return providerPost;
	}

	public void setProviderPost(String providerPost) {
		this.providerPost = providerPost;
	}

	public String getProviderNameOther() {
		return providerNameOther;
	}

	public void setProviderNameOther(String providerNameOther) {
		this.providerNameOther = providerNameOther;
	}

	public String getProviderOrganOther() {
		return providerOrganOther;
	}

	public void setProviderOrganOther(String providerOrganOther) {
		this.providerOrganOther = providerOrganOther;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getPartyCharger() {
		return partyCharger;
	}

	public void setPartyCharger(String partyCharger) {
		this.partyCharger = partyCharger;
	}

	public String getPartyChargerDuties() {
		return partyChargerDuties;
	}

	public void setPartyChargerDuties(String partyChargerDuties) {
		this.partyChargerDuties = partyChargerDuties;
	}

	public String getPartyPhone() {
		return partyPhone;
	}

	public void setPartyPhone(String partyPhone) {
		this.partyPhone = partyPhone;
	}

	public String getPartyAdd() {
		return partyAdd;
	}

	public void setPartyAdd(String partyAdd) {
		this.partyAdd = partyAdd;
	}

	public String getCaseBrief() {
		return caseBrief;
	}

	public void setCaseBrief(String caseBrief) {
		this.caseBrief = caseBrief;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getCaseDesc() {
		return caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public String getCaseBaseInfact() {
		return caseBaseInfact;
	}

	public void setCaseBaseInfact(String caseBaseInfact) {
		this.caseBaseInfact = caseBaseInfact;
	}

	public String getPenaltyInfact() {
		return penaltyInfact;
	}

	public void setPenaltyInfact(String penaltyInfact) {
		this.penaltyInfact = penaltyInfact;
	}

	public String getPenaltyProof() {
		return penaltyProof;
	}

	public void setPenaltyProof(String penaltyProof) {
		this.penaltyProof = penaltyProof;
	}

	public String getPenaltyDeregulation() {
		return penaltyDeregulation;
	}

	public void setPenaltyDeregulation(String penaltyDeregulation) {
		this.penaltyDeregulation = penaltyDeregulation;
	}

	public String getPenaltyReason() {
		return penaltyReason;
	}

	public void setPenaltyReason(String penaltyReason) {
		this.penaltyReason = penaltyReason;
	}

	public String getPenaltyResult() {
		return penaltyResult;
	}

	public void setPenaltyResult(String penaltyResult) {
		this.penaltyResult = penaltyResult;
	}

	public String getPenaltyBank() {
		return penaltyBank;
	}

	public void setPenaltyBank(String penaltyBank) {
		this.penaltyBank = penaltyBank;
	}

	public String getPenaltyBankAccount() {
		return penaltyBankAccount;
	}

	public void setPenaltyBankAccount(String penaltyBankAccount) {
		this.penaltyBankAccount = penaltyBankAccount;
	}

	public String getPenaltyReviewOrgan() {
		return penaltyReviewOrgan;
	}

	public void setPenaltyReviewOrgan(String penaltyReviewOrgan) {
		this.penaltyReviewOrgan = penaltyReviewOrgan;
	}

	public String getInformDate() {
		return informDate;
	}

	public void setInformDate(String informDate) {
		this.informDate = informDate;
	}

	public String getInformNo() {
		return informNo;
	}

	public void setInformNo(String informNo) {
		this.informNo = informNo;
	}

	public String getInformContent() {
		return informContent;
	}

	public void setInformContent(String informContent) {
		this.informContent = informContent;
	}

	public String getIfAverment() {
		return ifAverment;
	}

	public void setIfAverment(String ifAverment) {
		this.ifAverment = ifAverment;
	}

	public String getAvermentReason() {
		return avermentReason;
	}

	public void setAvermentReason(String avermentReason) {
		this.avermentReason = avermentReason;
	}

	public String getIfHearing() {
		return ifHearing;
	}

	public void setIfHearing(String ifHearing) {
		this.ifHearing = ifHearing;
	}

	public String getHearingApplyDate() {
		return hearingApplyDate;
	}

	public void setHearingApplyDate(String hearingApplyDate) {
		this.hearingApplyDate = hearingApplyDate;
	}

	public String getHearingApplyType() {
		return hearingApplyType;
	}

	public void setHearingApplyType(String hearingApplyType) {
		this.hearingApplyType = hearingApplyType;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getCaseFinalReason() {
		return caseFinalReason;
	}

	public void setCaseFinalReason(String caseFinalReason) {
		this.caseFinalReason = caseFinalReason;
	}

	public String getFinalDate() {
		return finalDate;
	}

	public void setFinalDate(String finalDate) {
		this.finalDate = finalDate;
	}

	public String getInvEndDate() {
		return invEndDate;
	}

	public void setInvEndDate(String invEndDate) {
		this.invEndDate = invEndDate;
	}

	public String getInvStartDate() {
		return invStartDate;
	}

	public void setInvStartDate(String invStartDate) {
		this.invStartDate = invStartDate;
	}

	public String getInvPerson() {
		return invPerson;
	}

	public void setInvPerson(String invPerson) {
		this.invPerson = invPerson;
	}

	public String getInvProcess() {
		return invProcess;
	}

	public void setInvProcess(String invProcess) {
		this.invProcess = invProcess;
	}

	public String getInvInfact() {
		return invInfact;
	}

	public void setInvInfact(String invInfact) {
		this.invInfact = invInfact;
	}

	public String getInvCaseNature() {
		return invCaseNature;
	}

	public void setInvCaseNature(String invCaseNature) {
		this.invCaseNature = invCaseNature;
	}

	public String getInvProof() {
		return invProof;
	}

	public void setInvProof(String invProof) {
		this.invProof = invProof;
	}

	public String getInvPunSuggestions() {
		return invPunSuggestions;
	}

	public void setInvPunSuggestions(String invPunSuggestions) {
		this.invPunSuggestions = invPunSuggestions;
	}

	public String getHearingDate() {
		return hearingDate;
	}

	public void setHearingDate(String hearingDate) {
		this.hearingDate = hearingDate;
	}

	public String getHearingAdd() {
		return hearingAdd;
	}

	public void setHearingAdd(String hearingAdd) {
		this.hearingAdd = hearingAdd;
	}

	public String getHearingPresenter() {
		return hearingPresenter;
	}

	public void setHearingPresenter(String hearingPresenter) {
		this.hearingPresenter = hearingPresenter;
	}

	public String getAvermentDate() {
		return avermentDate;
	}

	public void setAvermentDate(String avermentDate) {
		this.avermentDate = avermentDate;
	}

	public String getAvermentAdd() {
		return avermentAdd;
	}

	public void setAvermentAdd(String avermentAdd) {
		this.avermentAdd = avermentAdd;
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

	public String getLinkmanAdd() {
		return linkmanAdd;
	}

	public void setLinkmanAdd(String linkmanAdd) {
		this.linkmanAdd = linkmanAdd;
	}

	public String getLinkmanPost() {
		return linkmanPost;
	}

	public void setLinkmanPost(String linkmanPost) {
		this.linkmanPost = linkmanPost;
	}

	public String getLinkmanName() {
		return linkmanName;
	}

	public void setLinkmanName(String linkmanName) {
		this.linkmanName = linkmanName;
	}

	public String getLinkmanPhone() {
		return linkmanPhone;
	}

	public void setLinkmanPhone(String linkmanPhone) {
		this.linkmanPhone = linkmanPhone;
	}

	public String getAcceptDate() {
		return acceptDate;
	}

	public void setAcceptDate(String acceptDate) {
		this.acceptDate = acceptDate;
	}

	public String getAcceptPeopleId() {
		return acceptPeopleId;
	}

	public void setAcceptPeopleId(String acceptPeopleId) {
		this.acceptPeopleId = acceptPeopleId;
	}

	public String getAcceptPeopleName() {
		return acceptPeopleName;
	}

	public void setAcceptPeopleName(String acceptPeopleName) {
		this.acceptPeopleName = acceptPeopleName;
	}

	public String getPenaltyInformNo() {
		return penaltyInformNo;
	}

	public void setPenaltyInformNo(String penaltyInformNo) {
		this.penaltyInformNo = penaltyInformNo;
	}

	public String getHearingPresenterOrgan() {
		return hearingPresenterOrgan;
	}

	public void setHearingPresenterOrgan(String hearingPresenterOrgan) {
		this.hearingPresenterOrgan = hearingPresenterOrgan;
	}

	public String getHearingPresenterDuties() {
		return hearingPresenterDuties;
	}

	public void setHearingPresenterDuties(String hearingPresenterDuties) {
		this.hearingPresenterDuties = hearingPresenterDuties;
	}

	public String getHearingRecorder() {
		return hearingRecorder;
	}

	public void setHearingRecorder(String hearingRecorder) {
		this.hearingRecorder = hearingRecorder;
	}

	public String getHearingRecorderOrgan() {
		return hearingRecorderOrgan;
	}

	public void setHearingRecorderOrgan(String hearingRecorderOrgan) {
		this.hearingRecorderOrgan = hearingRecorderOrgan;
	}

	public String getHearingRecorderDuties() {
		return hearingRecorderDuties;
	}

	public void setHearingRecorderDuties(String hearingRecorderDuties) {
		this.hearingRecorderDuties = hearingRecorderDuties;
	}

	public String getHearingType() {
		return hearingType;
	}

	public void setHearingType(String hearingType) {
		this.hearingType = hearingType;
	}

	public String getHearingPartyCharger() {
		return hearingPartyCharger;
	}

	public void setHearingPartyCharger(String hearingPartyCharger) {
		this.hearingPartyCharger = hearingPartyCharger;
	}

	public String getHearingPartyChargerName() {
		return hearingPartyChargerName;
	}

	public void setHearingPartyChargerName(String hearingPartyChargerName) {
		this.hearingPartyChargerName = hearingPartyChargerName;
	}

	public String getInvProve() {
		return invProve;
	}

	public void setInvProve(String invProve) {
		this.invProve = invProve;
	}

	public String getPenaltyReviewOrganOther() {
		return penaltyReviewOrganOther;
	}

	public void setPenaltyReviewOrganOther(String penaltyReviewOrganOther) {
		this.penaltyReviewOrganOther = penaltyReviewOrganOther;
	}

	public String getPenaltyInformType() {
		return penaltyInformType;
	}

	public void setPenaltyInformType(String penaltyInformType) {
		this.penaltyInformType = penaltyInformType;
	}
}