package com.inspur.cams.bpt.base.data;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:Demobilizedflow
 * @description:
 * @author:
 * @since:2011-07-29
 * @version:1.0
 */
@Table(tableName = "BPT_APPLY_DEMOBILIZED", keyFields = "applyId")
public class Demobilizedflow extends StatefulDatabean {
	//提交换证、补证标志
	@Column(name = "EXCHACERTI_COMMIT_FLAG")
	private String exchacertiCommitFlag;
	//换证、补证原因
	@Column(name = "EXCHANGE_REASON")
	private String exchangeReason;
	//提交标志
	@Column(name = "COMMIT_FLAG")
	private String commitFlag;
	//申请ID
	@Rule(value = "require")
	@Column(name = "APPLY_ID")
	private String applyId;
	//业务类型
	@Column(name = "SERVICE_TYPE")
	private String serviceYype;
	//优抚对象类别
	@Column(name = "OBJECT_TYPE")
	private String objectType;
	//乡镇初审意见
	@Column(name = "TOWN_VIEWS")
	private String townViews;
	//初审人
	@Column(name = "TOWN_TRIAL_NAME")
	private String trialName;
	//初审日期
	@Column(name = "TOWN_TRIAL_DATE")
	private String trialDate;
	// 县级审批标示（同意审批或不予认定）
	@Column(name = "TOWN_FLAG")
	private String townFlag;
	// 县级是否上报
	@Column(name = "TOWN_REPORT")
	private String townReport;
	//县区复审意见
	@Column(name = "COUNTIES_VIEWS")
	private String countiesViews;
	//复审人
	@Column(name = "COUNTIES_REVIEW_VIEW")
	private String reviewView;
	//复审日期
	@Column(name = "COUNTIES_REVIEW_DATE")
	private String reviewDate;
	//地市审批意见
	@Column(name = "CITIES_VIEWS")
	private String citiesViews;
	// 市级审批标示（同意审批或不予认定）
	@Column(name = "CITY_FLAG")
	private String cityFlag;
	//审批人
	@Column(name = "CITIES_APPROVAL_NAME")
	private String approvalName;
	//审批日期
	@Column(name = "CITIES_APPROVAL_DATE")
	private String approvalDate;
	//人员ID
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	//申请时间
	@Column(name = "APPLY_DATE")
	private String applyDate;
	
	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public String getTownFlag() {
		return townFlag;
	}

	public void setTownFlag(String townFlag) {
		this.townFlag = townFlag;
	}

	public String getTownReport() {
		return townReport;
	}

	public void setTownReport(String townReport) {
		this.townReport = townReport;
	}

	/**
	 * getter for 申请ID
	 * @generated
	 */
	public String getApplyId() {
		return this.applyId;
	}

	/**
	 * setter for 申请ID
	 * @generated
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * getter for 录入人ID
	 * @generated
	 */

	/**
	 * getter for 优抚对象类别
	 * @generated
	 */
	public String getObjectType() {
		return this.objectType;
	}

	/**
	 * setter for 优抚对象类别
	 * @generated
	 */
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	/**
	 * getter for 乡镇初审意见
	 * @generated
	 */
	public String getTownViews() {
		return this.townViews;
	}

	/**
	 * setter for 乡镇初审意见
	 * @generated
	 */
	public void setTownViews(String townViews) {
		this.townViews = townViews;
	}

	/**
	 * getter for 初审人
	 * @generated
	 */
	public String getTrialName() {
		return this.trialName;
	}

	/**
	 * setter for 初审人
	 * @generated
	 */
	public void setTrialName(String trialName) {
		this.trialName = trialName;
	}

	/**
	 * getter for 初审日期
	 * @generated
	 */
	public String getTrialDate() {
		return this.trialDate;
	}

	/**
	 * setter for 初审日期
	 * @generated
	 */
	public void setTrialDate(String trialDate) {
		this.trialDate = trialDate;
	}

	/**
	 * getter for 县区复审意见
	 * @generated
	 */
	public String getCountiesViews() {
		return this.countiesViews;
	}

	/**
	 * setter for 县区复审意见
	 * @generated
	 */
	public void setCountiesViews(String countiesViews) {
		this.countiesViews = countiesViews;
	}

	/**
	 * getter for 复审人
	 * @generated
	 */
	public String getReviewView() {
		return this.reviewView;
	}

	/**
	 * setter for 复审人
	 * @generated
	 */
	public void setReviewView(String reviewView) {
		this.reviewView = reviewView;
	}

	/**
	 * getter for 复审日期
	 * @generated
	 */
	public String getReviewDate() {
		return this.reviewDate;
	}

	/**
	 * setter for 复审日期
	 * @generated
	 */
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}

	/**
	 * getter for 地市审批意见
	 * @generated
	 */
	public String getCitiesViews() {
		return this.citiesViews;
	}

	/**
	 * setter for 地市审批意见
	 * @generated
	 */
	public void setCitiesViews(String citiesViews) {
		this.citiesViews = citiesViews;
	}

	/**
	 * getter for 审批人
	 * @generated
	 */
	public String getApprovalName() {
		return this.approvalName;
	}

	/**
	 * setter for 审批人
	 * @generated
	 */
	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}

	/**
	 * getter for 审批日期
	 * @generated
	 */
	public String getApprovalDate() {
		return this.approvalDate;
	}

	/**
	 * setter for 审批日期
	 * @generated
	 */
	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}

	/**
	 * getter for 人员ID
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for 人员ID
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	public String getCommitFlag() {
		return commitFlag;
	}

	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
	}

	

	public String getServiceYype() {
		return serviceYype;
	}

	public void setServiceYype(String serviceYype) {
		this.serviceYype = serviceYype;
	}

	public String getExchacertiCommitFlag() {
		return exchacertiCommitFlag;
	}

	public void setExchacertiCommitFlag(String exchacertiCommitFlag) {
		this.exchacertiCommitFlag = exchacertiCommitFlag;
	}

	public String getExchangeReason() {
		return exchangeReason;
	}

	public void setExchangeReason(String exchangeReason) {
		this.exchangeReason = exchangeReason;
	}

	public String getCityFlag() {
		return cityFlag;
	}

	public void setCityFlag(String cityFlag) {
		this.cityFlag = cityFlag;
	}

}