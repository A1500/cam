package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:BptApplyDependant
 * @description:
 * @author:
 * @since:2011-08-10
 * @version:1.0
 */
@Table(tableName = "BPT_APPLY_DEPENDANT", keyFields = "applyId")
public class BptApplyDependant extends StatefulDatabean {
	// APPLY_ID
	@Rule(value = "require")
	@Column(name = "APPLY_ID")
	private String applyId;
	// PEOPLE_ID
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// SERVICE_TYPE
	@Column(name = "SERVICE_TYPE")
	private String serviceType;
	//村（居）委会负责人
    private String acceptIncharge;
   //村（居）委会受理时间
    private String acceptDate;
   //村（居）委会意见
    private String acceptAdvice;
	// VERIFY_ADVICE
	@Column(name = "TOWN_ADUIT_ADVICE")
	private String townAduitAdvice;
	// VERIFY_INCHARGE
	@Column(name = "TOWN_ADUIT_INCHARGE")
	private String townAduitIncharge;
	// VERIFY__APPROVE_DATE
	@Column(name = "TOWN_ADUIT_APPROVE_DATE")
	private String townAduitApproveDate;
	// VERIFY_ADVICE
	@Column(name = "COUNTIES_ADUIT_ADVICE")
	private String countiesAduitAdvice;
	// VERIFY_INCHARGE
	@Column(name = "COUNTIES_ADUIT_INCHARGE")
	private String countiesAduitIncharge;
	// VERIFY__APPROVE_DATE
	@Column(name = "COUNTIES_ADUIT_APPROVE_DATE")
	private String countiesAduitApproveDate;
	// APPROVE_DATE
	@Column(name = "APPROVE_DATE")
	private String approveDate;
	// APPROVE_ORGAN_ID
	@Column(name = "APPROVE_ORGAN_ID")
	private String approveOrganId;
	// COMMIT_FLAG
	@Column(name = "COMMIT_FLAG")
	private String commitFlag;

	@Column(name = "OBJECT_TYPE")
	private String objectType;
	
	@Rule(value = "require")
	@Column(name = "IS_APPROVE")
	private String isApprove;
	
	@Column(name = "IS_SURE")
	private String isSure;

	public String getIsApprove() {
		return isApprove;
	}

	public void setIsApprove(String isApprove) {
		this.isApprove = isApprove;
	}

	public String getIsSure() {
		return isSure;
	}

	public void setIsSure(String isSure) {
		this.isSure = isSure;
	}

	public String getCountiesAduitAdvice() {
		return countiesAduitAdvice;
	}

	public void setCountiesAduitAdvice(String countiesAduitAdvice) {
		this.countiesAduitAdvice = countiesAduitAdvice;
	}

	public String getCountiesAduitIncharge() {
		return countiesAduitIncharge;
	}

	public void setCountiesAduitIncharge(String countiesAduitIncharge) {
		this.countiesAduitIncharge = countiesAduitIncharge;
	}

	public String getCountiesAduitApproveDate() {
		return countiesAduitApproveDate;
	}

	public void setCountiesAduitApproveDate(String countiesAduitApproveDate) {
		this.countiesAduitApproveDate = countiesAduitApproveDate;
	}

	/**
	 * getter for APPLY_ID
	 * 
	 * @generated
	 */
	public String getApplyId() {
		return this.applyId;
	}

	/**
	 * setter for APPLY_ID
	 * 
	 * @generated
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * getter for PEOPLE_ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for PEOPLE_ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * getter for SERVICE_TYPE
	 * 
	 * @generated
	 */
	public String getServiceType() {
		return this.serviceType;
	}

	/**
	 * setter for SERVICE_TYPE
	 * 
	 * @generated
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public String getTownAduitAdvice() {
		return townAduitAdvice;
	}

	public void setTownAduitAdvice(String townAduitAdvice) {
		this.townAduitAdvice = townAduitAdvice;
	}

	public String getTownAduitIncharge() {
		return townAduitIncharge;
	}

	public void setTownAduitIncharge(String townAduitIncharge) {
		this.townAduitIncharge = townAduitIncharge;
	}

	public String getTownAduitApproveDate() {
		return townAduitApproveDate;
	}

	public void setTownAduitApproveDate(String townAduitApproveDate) {
		this.townAduitApproveDate = townAduitApproveDate;
	}

	/**
	 * getter for APPROVE_DATE
	 * 
	 * @generated
	 */
	public String getApproveDate() {
		return this.approveDate;
	}

	/**
	 * setter for APPROVE_DATE
	 * 
	 * @generated
	 */
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}

	/**
	 * getter for APPROVE_ORGAN_ID
	 * 
	 * @generated
	 */
	public String getApproveOrganId() {
		return this.approveOrganId;
	}

	/**
	 * setter for APPROVE_ORGAN_ID
	 * 
	 * @generated
	 */
	public void setApproveOrganId(String approveOrganId) {
		this.approveOrganId = approveOrganId;
	}

	/**
	 * getter for COMMIT_FLAG
	 * 
	 * @generated
	 */
	public String getCommitFlag() {
		return this.commitFlag;
	}

	/**
	 * setter for COMMIT_FLAG
	 * 
	 * @generated
	 */
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
	}

	public String getObjectType() {
		return objectType;
	}

	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	public String getAcceptIncharge() {
		return acceptIncharge;
	}

	public void setAcceptIncharge(String acceptIncharge) {
		this.acceptIncharge = acceptIncharge;
	}

	public String getAcceptDate() {
		return acceptDate;
	}

	public void setAcceptDate(String acceptDate) {
		this.acceptDate = acceptDate;
	}

	public String getAcceptAdvice() {
		return acceptAdvice;
	}

	public void setAcceptAdvice(String acceptAdvice) {
		this.acceptAdvice = acceptAdvice;
	}
}