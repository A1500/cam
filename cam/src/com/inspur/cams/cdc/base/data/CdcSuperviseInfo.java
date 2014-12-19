package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主民主监督信息 databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_SUPERVISE_INFO", keyFields = "superviseId")
public class CdcSuperviseInfo extends StatefulDatabean {

	// 民主监督内码
	private String superviseId;
	
	// 统计内码
	private String recordId;

	private String reportDate;
	
	private String organCode;
	//是否经村委会提出公开方案【城市 :居务是否公开】
	private String ifPublish;
	//是否经村务监督委员会审查、补充、完善【城市 :政务是否公开】
	private String ifAudit;
	//是否经村党组织和村委会联席会议讨论确定 【城市：财务是否公开】
	private String ifDiscuss;
	//党务公开【城市：居委会成员接受评议次数】
	private String partCyc;
	//政务公开【城市：居委会聘用人员受评人数】
	private String govCyc;
	//事务公开【城市：连续两次被评议为不称职人数】
	private String affairCyc;
	//财务公开【城市：居务监督委员会人数】
	private String financeCyc;
	//【城市：居务监督委员会经居民会议推选产生人数】
	private String meetingPeopleNum;
	//【城市：居务监督委员会经居民会代表会议产生人数】
	private String sovietPeopleNum;
	//公开形式公开栏
	private String formPlacard;
	//公开形式网络 
	private String formWeb;
	//公开形式民主听证会 【城市：触摸屏】
	private String formMeeting;
	//公开形式 【城市：明白纸】
	private String formPaper;
	//公开形式
	private String formOther;

	public String getSuperviseId() {
		return superviseId;
	}

	public void setSuperviseId(String superviseId) {
		this.superviseId = superviseId;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	public String getOrganCode() {
		return organCode;
	}

	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	public String getIfPublish() {
		return ifPublish;
	}

	public void setIfPublish(String ifPublish) {
		this.ifPublish = ifPublish;
	}

	public String getIfAudit() {
		return ifAudit;
	}

	public void setIfAudit(String ifAudit) {
		this.ifAudit = ifAudit;
	}

	public String getIfDiscuss() {
		return ifDiscuss;
	}

	public void setIfDiscuss(String ifDiscuss) {
		this.ifDiscuss = ifDiscuss;
	}

	public String getPartCyc() {
		return partCyc;
	}

	public void setPartCyc(String partCyc) {
		this.partCyc = partCyc;
	}

	public String getGovCyc() {
		return govCyc;
	}

	public void setGovCyc(String govCyc) {
		this.govCyc = govCyc;
	}

	public String getAffairCyc() {
		return affairCyc;
	}

	public void setAffairCyc(String affairCyc) {
		this.affairCyc = affairCyc;
	}

	public String getFinanceCyc() {
		return financeCyc;
	}

	public void setFinanceCyc(String financeCyc) {
		this.financeCyc = financeCyc;
	}

	public String getFormPlacard() {
		return formPlacard;
	}

	public void setFormPlacard(String formPlacard) {
		this.formPlacard = formPlacard;
	}

	public String getFormWeb() {
		return formWeb;
	}

	public void setFormWeb(String formWeb) {
		this.formWeb = formWeb;
	}

	public String getFormMeeting() {
		return formMeeting;
	}

	public void setFormMeeting(String formMeeting) {
		this.formMeeting = formMeeting;
	}

	public String getFormPaper() {
		return formPaper;
	}

	public void setFormPaper(String formPaper) {
		this.formPaper = formPaper;
	}

	public String getFormOther() {
		return formOther;
	}

	public void setFormOther(String formOther) {
		this.formOther = formOther;
	}

	public String getMeetingPeopleNum() {
		return meetingPeopleNum;
	}

	public void setMeetingPeopleNum(String meetingPeopleNum) {
		this.meetingPeopleNum = meetingPeopleNum;
	}

	public String getSovietPeopleNum() {
		return sovietPeopleNum;
	}

	public void setSovietPeopleNum(String sovietPeopleNum) {
		this.sovietPeopleNum = sovietPeopleNum;
	}
	
}