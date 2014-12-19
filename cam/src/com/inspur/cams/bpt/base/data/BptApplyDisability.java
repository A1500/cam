package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptApplyDisability
 * @description:
 * @author:
 * @since:2011-06-10
 * @version:1.0
 */
@Table(tableName = "BPT_APPLY_DISABILITY", keyFields = "applyId")
public class BptApplyDisability extends StatefulDatabean {
	// 申请ID
	@Column(name = "APPLY_ID")
	private String applyId;
	// 人员ID
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// 业务类型
	@Column(name = "SERVICE_TYPE")
	private String serviceType;
	// 申请时间
	@Column(name = "APPROVE_DATE")
	private String approveDate;
	// 申请机构
	@Column(name = "APPROVE_ORGAN_ID")
	private String approveOrganId;
	// 县级受理时间
	@Column(name = "TOWN_CHECK_DATE")
	private String townCheckDate;
	// 县级受理人员
	@Column(name = "TOWN_CHECK_PEOPLE_ID")
	private String townCheckPeopleId;
	// 县级_伤残性质
	@Column(name = "TOWN_ADUIT_DISABILITY_NATURE")
	private String townAduitDisabilityNature;
	// 县级_申报等级
	@Column(name = "TOWN_ADUIT_DISABILITY_LEVEL")
	private String townAduitDisabilityLevel;
	// 县级_公示结果
	@Column(name = "TOWN_ADUIT_BULLETIN_RESULT")
	private String townAduitBulletinResult;
	// 县级_负责人
	@Column(name = "TOWN_ADUIT_INCHARGE")
	private String townAduitIncharge;
	// 县级_意见
	@Column(name = "TOWN_ADUIT_ADVICE")
	private String townAduitAdvice;
	// 县级_时间
	@Column(name = "TOWN_ADUIT__APPROVE_DATE")
	private String townAduitApproveDate;
	// 市级受理时间
	@Column(name = "CITY_CHECK_DATE")
	private String cityCheckDate;
	// 市级受理人员
	@Column(name = "CITY_CHECK_PEOPLE_ID")
	private String cityCheckPeopleId;

	// 市级受理_伤残性质
	@Column(name = "CITY_CHECK_DISABILITY_NATURE")
	private String cityCheckDisabilityNature;

	// 市级受理_申报等级
	@Column(name = "CITY_CHECK_DISABILITY_LEVEL")
	private String cityCheckDisabilityLevel;

	// 市级受理_意见
	@Column(name = "CITY_CHECK_ADVICE")
	private String cityCheckAdvice;

	// 市级_伤残性质
	@Column(name = "CITY_ADUIT_DISABILITY_NATURE")
	private String cityAduitDisabilityNature;
	// 市级_申报等级
	@Column(name = "CITY_ADUIT_DISABILITY_LEVEL")
	private String cityAduitDisabilityLevel;
	// 市级_负责人
	@Column(name = "CITY_ADUIT_INCHARGE")
	private String cityAduitIncharge;
	// 市级_意见
	@Column(name = "CITY_ADUIT_ADVICE")
	private String cityAduitAdvice;
	// 市级_时间
	@Column(name = "CITY_ADUIT_APPROVE_DATE")
	private String cityAduitApproveDate;
	// 省厅受理时间
	@Column(name = "PROVINCE_CHECK_DATE")
	private String provinceCheckDate;
	// 省厅受理人员
	@Column(name = "PROVINCE_CHECK_PEOPLE_ID")
	private String provinceCheckPeopleId;

	// 省厅受理_伤残性质
	@Column(name = "PROVINCE_CHECK_DIS_NATURE")
	private String provinceCheckDisNature;

	// 省厅受理_伤残等级
	@Column(name = "PROVINCE_CHECK_DIS_LEVEL")
	private String provinceCheckDisLevel;

	// 省厅受理_意见
	@Column(name = "PROVINCE_CHECK_ADVICE")
	private String provinceCheckAdvice;

	// 省厅审核伤残性质
	@Column(name = "PROVINCE_ADUIT_DISABILITY_NATU")
	private String provinceAduitDisabilityNatu;
	// 省厅审核伤残等级
	@Column(name = "PROVINCE_ADUIT_DISABILITY_LEVE")
	private String provinceAduitDisabilityLeve;
	// 省厅审核负责人
	@Column(name = "PROVINCE_ADUIT_INCHARGE")
	private String provinceAduitIncharge;
	// 省厅审核意见
	@Column(name = "PROVINCE_ADUIT_ADVICE")
	private String provinceAduitAdvice;
	// 省厅审核时间
	@Column(name = "PROVINCE_ADUIT_APPROVE_DATE")
	private String provinceAduitApproveDate;
	// 省厅审批伤残性质
	@Column(name = "PROVINCE_VERIFY_DISABILITY_NAT")
	private String provinceVerifyDisabilityNat;
	// 省厅审批审批等级
	@Column(name = "PROVINCE_LEVEL")
	private String provinceLevel;
	// 省厅审批负责人
	@Column(name = "PROVINCE_INCHARGE")
	private String provinceIncharge;
	// 省厅审批意见
	@Column(name = "PROVINCE_ADVICE")
	private String provinceAdvice;
	// 省厅审批时间
	@Column(name = "PROVINCE_APPROVE_DATE")
	private String provinceApproveDate;
	// 批准机关
	@Column(name = "APPROVAL_ORGAN")
	private String approvalOrgan;
	// 备注
	@Column(name = "NOTE")
	private String note;

	// 调整伤残等级原因
	@Column(name = "ADJUST_REASON")
	private String adjustReason;

	// 致残原因
	@Column(name = "DISABILITY_DATE")
	private String disabilityDate;

	// 致残地点
	@Column(name = "DISABILITY_ADD")
	private String disabilityAdd;

	// 致残部位
	@Column(name = "DISABILITY_BODY")
	private String disabilityBody;

	// 致残原因
	@Column(name = "DISABILITY_REASON")
	private String disabilityReason;

	// 新伤残证件编号
	@Column(name = "NEW_DISABILITY_NO")
	private String newDisabilityNo;

	// 原伤残证件编号
	@Column(name = "OLD_DISABILITY_NO")
	private String oldDisabilityNo;

	// 换证、补证原因
	@Column(name = "EXCHANGE_REASON")
	private String exchangeReason;

	// 需变更原因及内容
	@Column(name = "CHANGE_REASON_CONTENT")
	private String changeReasonContent;

	// 抚恤金发至
	@Column(name = "ALLOWANCE_MONTH")
	private String allowanceMonth;

	// 由何地迁入
	@Column(name = "INGOING_ADDRESS")
	private String ingoingAddress;

	// 提交标志
	private String commitFlag;
	// 申请时间
	private String applyDate;

	// 县级审批标示（同意审批或不予认定）
	@Column(name = "TOWN_FLAG")
	private String townFlag;

	// 县级是否上报
	@Column(name = "TOWN_REPORT")
	private String townReport;

	// 市级审批标示（同意审批或不予认定）
	@Column(name = "CITY_FLAG")
	private String cityFlag;

	// 市级是否上报
	@Column(name = "CITY_REPORT")
	private String cityReport;

	// 省级初审审批标示（同意审批或不予认定）
	@Column(name = "PRO_CHECK_FLAG")
	private String proCheckFlag;

	// 省级初审是否上报
	@Column(name = "PRO_CHECK_REPORT")
	private String proCheckReport;

	// 省级复审审批标示（同意审批或不予认定）
	@Column(name = "PRO_ADUIT_FLAG")
	private String proAduitFlag;

	// 省级复审是否上报
	@Column(name = "PRO_ADUIT_REPORT")
	private String proAduitReport;

	// 简要残情
	@Column(name = "BRIEF_DISABILITY")
	private String briefDisability;

	// 省级审批（同意审批或不予认定）
	@Column(name = "PRO_FLAG")
	private String proFlag;

	// 是否通过审批标示
	@Column(name = "PASS_FLAG")
	private String passFlag;

	// 是否已打证
	@Column(name = "PRINT_FLAG")
	private String printFlag;

	// 变更类型
	@Column(name = "CHANGE_FLAG")
	private String changeFlag;

	// 变更内容
	@Column(name = "CHANGE_CONTENT")
	private String changeContent;

	// 证件业务类型
	@Column(name = "CERT_TYPE")
	private String certType;
	
	// 变更前姓名
	@Column(name = "OLD_NAME")
	private String oldName;
	// 变更后姓名
	@Column(name = "NEW_NAME")
	private String newName;
	// 变更前身份证号
	@Column(name = "OLD_ID_CARD")
	private String oldIdCard;
	// 变更后身份证号
	@Column(name = "NEW_ID_CARD")
	private String newIdCard;
	// 原残疾等级
	@Column(name = "OLD_DISABILITY_LEVEL")
	private String oldDisabilityLevel;
	// 原残疾性质
	@Column(name = "OLD_DISABILITY_NATURE")
	private String oldDisabilityNature;
	
	/**
	 * @description:取消待遇，添加如果是假证，取消待遇功能
	 * @since:2012-04-16
	 */
	private String cancelTreateFlag;
	
	public String getCancelTreateFlag() {
		return cancelTreateFlag;
	}

	public void setCancelTreateFlag(String cancelTreateFlag) {
		this.cancelTreateFlag = cancelTreateFlag;
	}

	public String getOldName() {
		return oldName;
	}

	public void setOldName(String oldName) {
		this.oldName = oldName;
	}

	public String getNewName() {
		return newName;
	}

	public void setNewName(String newName) {
		this.newName = newName;
	}

	public String getOldIdCard() {
		return oldIdCard;
	}

	public void setOldIdCard(String oldIdCard) {
		this.oldIdCard = oldIdCard;
	}

	public String getNewIdCard() {
		return newIdCard;
	}

	public void setNewIdCard(String newIdCard) {
		this.newIdCard = newIdCard;
	}

	/**
	 * @return the applyDate
	 */
	public String getApplyDate() {
		return applyDate;
	}

	/**
	 * @param applyDate
	 *            the applyDate to set
	 */
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	/**
	 * @return the commitFlag
	 */
	public String getCommitFlag() {
		return commitFlag;
	}

	/**
	 * @param commitFlag
	 *            the commitFlag to set
	 */
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
	}

	/**
	 * @return the newDisabilityNo
	 */
	public String getNewDisabilityNo() {
		return newDisabilityNo;
	}

	/**
	 * @param newDisabilityNo
	 *            the newDisabilityNo to set
	 */
	public void setNewDisabilityNo(String newDisabilityNo) {
		this.newDisabilityNo = newDisabilityNo;
	}

	/**
	 * @return the exchangeReason
	 */
	public String getExchangeReason() {
		return exchangeReason;
	}

	/**
	 * @param exchangeReason
	 *            the exchangeReason to set
	 */
	public void setExchangeReason(String exchangeReason) {
		this.exchangeReason = exchangeReason;
	}

	/**
	 * @return the changeReasonContent
	 */
	public String getChangeReasonContent() {
		return changeReasonContent;
	}

	/**
	 * @param changeReasonContent
	 *            the changeReasonContent to set
	 */
	public void setChangeReasonContent(String changeReasonContent) {
		this.changeReasonContent = changeReasonContent;
	}

	/**
	 * @return the adjustReason
	 */
	public String getAdjustReason() {
		return adjustReason;
	}

	/**
	 * @param adjustReason
	 *            the adjustReason to set
	 */
	public void setAdjustReason(String adjustReason) {
		this.adjustReason = adjustReason;
	}

	/**
	 * @return the disabilityAdd
	 */
	public String getDisabilityAdd() {
		return disabilityAdd;
	}

	/**
	 * @param disabilityAdd
	 *            the disabilityAdd to set
	 */
	public void setDisabilityAdd(String disabilityAdd) {
		this.disabilityAdd = disabilityAdd;
	}

	/**
	 * @return the disabilityBody
	 */
	public String getDisabilityBody() {
		return disabilityBody;
	}

	/**
	 * @param disabilityBody
	 *            the disabilityBody to set
	 */
	public void setDisabilityBody(String disabilityBody) {
		this.disabilityBody = disabilityBody;
	}

	/**
	 * @return the disabilityReason
	 */
	public String getDisabilityReason() {
		return disabilityReason;
	}

	/**
	 * @param disabilityReason
	 *            the disabilityReason to set
	 */
	public void setDisabilityReason(String disabilityReason) {
		this.disabilityReason = disabilityReason;
	}

	/**
	 * getter for 申请ID
	 * 
	 * @generated
	 */
	public String getApplyId() {
		return this.applyId;
	}

	/**
	 * setter for 申请ID
	 * 
	 * @generated
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * getter for 人员ID
	 * 
	 * @generated
	 */
	public String getPeopleId() {
		return this.peopleId;
	}

	/**
	 * setter for 人员ID
	 * 
	 * @generated
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}

	/**
	 * getter for 业务类型（评残或调残）
	 * 
	 * @generated
	 */
	public String getServiceType() {
		return this.serviceType;
	}

	/**
	 * setter for 业务类型（评残或调残）
	 * 
	 * @generated
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	/**
	 * getter for 申请时间
	 * 
	 * @generated
	 */
	public String getApproveDate() {
		return this.approveDate;
	}

	/**
	 * setter for 申请时间
	 * 
	 * @generated
	 */
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}

	/**
	 * getter for 申请机构
	 * 
	 * @generated
	 */
	public String getApproveOrganId() {
		return this.approveOrganId;
	}

	/**
	 * setter for 申请机构
	 * 
	 * @generated
	 */
	public void setApproveOrganId(String approveOrganId) {
		this.approveOrganId = approveOrganId;
	}

	/**
	 * getter for 县级受理时间
	 * 
	 * @generated
	 */
	public String getTownCheckDate() {
		return this.townCheckDate;
	}

	/**
	 * setter for 县级受理时间
	 * 
	 * @generated
	 */
	public void setTownCheckDate(String townCheckDate) {
		this.townCheckDate = townCheckDate;
	}

	/**
	 * getter for 县级受理人员
	 * 
	 * @generated
	 */
	public String getTownCheckPeopleId() {
		return this.townCheckPeopleId;
	}

	/**
	 * setter for 县级受理人员
	 * 
	 * @generated
	 */
	public void setTownCheckPeopleId(String townCheckPeopleId) {
		this.townCheckPeopleId = townCheckPeopleId;
	}

	/**
	 * getter for 县级_伤残性质
	 * 
	 * @generated
	 */
	public String getTownAduitDisabilityNature() {
		return this.townAduitDisabilityNature;
	}

	/**
	 * setter for 县级_伤残性质
	 * 
	 * @generated
	 */
	public void setTownAduitDisabilityNature(String townAduitDisabilityNature) {
		this.townAduitDisabilityNature = townAduitDisabilityNature;
	}

	/**
	 * getter for 县级_申报等级
	 * 
	 * @generated
	 */
	public String getTownAduitDisabilityLevel() {
		return this.townAduitDisabilityLevel;
	}

	/**
	 * setter for 县级_申报等级
	 * 
	 * @generated
	 */
	public void setTownAduitDisabilityLevel(String townAduitDisabilityLevel) {
		this.townAduitDisabilityLevel = townAduitDisabilityLevel;
	}

	/**
	 * getter for 县级_公示结果
	 * 
	 * @generated
	 */
	public String getTownAduitBulletinResult() {
		return this.townAduitBulletinResult;
	}

	/**
	 * setter for 县级_公示结果
	 * 
	 * @generated
	 */
	public void setTownAduitBulletinResult(String townAduitBulletinResult) {
		this.townAduitBulletinResult = townAduitBulletinResult;
	}

	/**
	 * getter for 县级_负责人
	 * 
	 * @generated
	 */
	public String getTownAduitIncharge() {
		return this.townAduitIncharge;
	}

	/**
	 * setter for 县级_负责人
	 * 
	 * @generated
	 */
	public void setTownAduitIncharge(String townAduitIncharge) {
		this.townAduitIncharge = townAduitIncharge;
	}

	/**
	 * getter for 县级_意见
	 * 
	 * @generated
	 */
	public String getTownAduitAdvice() {
		return this.townAduitAdvice;
	}

	/**
	 * setter for 县级_意见
	 * 
	 * @generated
	 */
	public void setTownAduitAdvice(String townAduitAdvice) {
		this.townAduitAdvice = townAduitAdvice;
	}

	/**
	 * getter for 县级_时间
	 * 
	 * @generated
	 */
	public String getTownAduitApproveDate() {
		return this.townAduitApproveDate;
	}

	/**
	 * setter for 县级_时间
	 * 
	 * @generated
	 */
	public void setTownAduitApproveDate(String townAduitApproveDate) {
		this.townAduitApproveDate = townAduitApproveDate;
	}

	/**
	 * getter for 市级受理时间
	 * 
	 * @generated
	 */
	public String getCityCheckDate() {
		return this.cityCheckDate;
	}

	/**
	 * setter for 市级受理时间
	 * 
	 * @generated
	 */
	public void setCityCheckDate(String cityCheckDate) {
		this.cityCheckDate = cityCheckDate;
	}

	/**
	 * getter for 市级受理人员
	 * 
	 * @generated
	 */
	public String getCityCheckPeopleId() {
		return this.cityCheckPeopleId;
	}

	/**
	 * setter for 市级受理人员
	 * 
	 * @generated
	 */
	public void setCityCheckPeopleId(String cityCheckPeopleId) {
		this.cityCheckPeopleId = cityCheckPeopleId;
	}

	/**
	 * getter for 市级_伤残性质
	 * 
	 * @generated
	 */
	public String getCityAduitDisabilityNature() {
		return this.cityAduitDisabilityNature;
	}

	/**
	 * setter for 市级_伤残性质
	 * 
	 * @generated
	 */
	public void setCityAduitDisabilityNature(String cityAduitDisabilityNature) {
		this.cityAduitDisabilityNature = cityAduitDisabilityNature;
	}

	/**
	 * getter for 市级_申报等级
	 * 
	 * @generated
	 */
	public String getCityAduitDisabilityLevel() {
		return this.cityAduitDisabilityLevel;
	}

	/**
	 * setter for 市级_申报等级
	 * 
	 * @generated
	 */
	public void setCityAduitDisabilityLevel(String cityAduitDisabilityLevel) {
		this.cityAduitDisabilityLevel = cityAduitDisabilityLevel;
	}

	/**
	 * getter for 市级_负责人
	 * 
	 * @generated
	 */
	public String getCityAduitIncharge() {
		return this.cityAduitIncharge;
	}

	/**
	 * setter for 市级_负责人
	 * 
	 * @generated
	 */
	public void setCityAduitIncharge(String cityAduitIncharge) {
		this.cityAduitIncharge = cityAduitIncharge;
	}

	/**
	 * getter for 市级_意见
	 * 
	 * @generated
	 */
	public String getCityAduitAdvice() {
		return this.cityAduitAdvice;
	}

	/**
	 * setter for 市级_意见
	 * 
	 * @generated
	 */
	public void setCityAduitAdvice(String cityAduitAdvice) {
		this.cityAduitAdvice = cityAduitAdvice;
	}

	/**
	 * getter for 市级_时间
	 * 
	 * @generated
	 */
	public String getCityAduitApproveDate() {
		return this.cityAduitApproveDate;
	}

	/**
	 * setter for 市级_时间
	 * 
	 * @generated
	 */
	public void setCityAduitApproveDate(String cityAduitApproveDate) {
		this.cityAduitApproveDate = cityAduitApproveDate;
	}

	/**
	 * getter for 省厅受理时间
	 * 
	 * @generated
	 */
	public String getProvinceCheckDate() {
		return this.provinceCheckDate;
	}

	/**
	 * setter for 省厅受理时间
	 * 
	 * @generated
	 */
	public void setProvinceCheckDate(String provinceCheckDate) {
		this.provinceCheckDate = provinceCheckDate;
	}

	/**
	 * getter for 省厅受理人员
	 * 
	 * @generated
	 */
	public String getProvinceCheckPeopleId() {
		return this.provinceCheckPeopleId;
	}

	/**
	 * setter for 省厅受理人员
	 * 
	 * @generated
	 */
	public void setProvinceCheckPeopleId(String provinceCheckPeopleId) {
		this.provinceCheckPeopleId = provinceCheckPeopleId;
	}

	/**
	 * getter for 省厅审核伤残性质
	 * 
	 * @generated
	 */
	public String getProvinceAduitDisabilityNatu() {
		return this.provinceAduitDisabilityNatu;
	}

	/**
	 * setter for 省厅审核伤残性质
	 * 
	 * @generated
	 */
	public void setProvinceAduitDisabilityNatu(
			String provinceAduitDisabilityNatu) {
		this.provinceAduitDisabilityNatu = provinceAduitDisabilityNatu;
	}

	/**
	 * getter for 省厅审核伤残等级
	 * 
	 * @generated
	 */
	public String getProvinceAduitDisabilityLeve() {
		return this.provinceAduitDisabilityLeve;
	}

	/**
	 * setter for 省厅审核伤残等级
	 * 
	 * @generated
	 */
	public void setProvinceAduitDisabilityLeve(
			String provinceAduitDisabilityLeve) {
		this.provinceAduitDisabilityLeve = provinceAduitDisabilityLeve;
	}

	/**
	 * getter for 省厅审核负责人
	 * 
	 * @generated
	 */
	public String getProvinceAduitIncharge() {
		return this.provinceAduitIncharge;
	}

	/**
	 * setter for 省厅审核负责人
	 * 
	 * @generated
	 */
	public void setProvinceAduitIncharge(String provinceAduitIncharge) {
		this.provinceAduitIncharge = provinceAduitIncharge;
	}

	/**
	 * getter for 省厅审核意见
	 * 
	 * @generated
	 */
	public String getProvinceAduitAdvice() {
		return this.provinceAduitAdvice;
	}

	/**
	 * setter for 省厅审核意见
	 * 
	 * @generated
	 */
	public void setProvinceAduitAdvice(String provinceAduitAdvice) {
		this.provinceAduitAdvice = provinceAduitAdvice;
	}

	/**
	 * getter for 省厅审核时间
	 * 
	 * @generated
	 */
	public String getProvinceAduitApproveDate() {
		return this.provinceAduitApproveDate;
	}

	/**
	 * setter for 省厅审核时间
	 * 
	 * @generated
	 */
	public void setProvinceAduitApproveDate(String provinceAduitApproveDate) {
		this.provinceAduitApproveDate = provinceAduitApproveDate;
	}

	/**
	 * getter for 省厅审批伤残性质
	 * 
	 * @generated
	 */
	public String getProvinceVerifyDisabilityNat() {
		return this.provinceVerifyDisabilityNat;
	}

	/**
	 * setter for 省厅审批伤残性质
	 * 
	 * @generated
	 */
	public void setProvinceVerifyDisabilityNat(
			String provinceVerifyDisabilityNat) {
		this.provinceVerifyDisabilityNat = provinceVerifyDisabilityNat;
	}

	/**
	 * getter for 省厅审批审批等级
	 * 
	 * @generated
	 */
	public String getProvinceLevel() {
		return this.provinceLevel;
	}

	/**
	 * setter for 省厅审批审批等级
	 * 
	 * @generated
	 */
	public void setProvinceLevel(String provinceLevel) {
		this.provinceLevel = provinceLevel;
	}

	/**
	 * getter for 省厅审批负责人
	 * 
	 * @generated
	 */
	public String getProvinceIncharge() {
		return this.provinceIncharge;
	}

	/**
	 * setter for 省厅审批负责人
	 * 
	 * @generated
	 */
	public void setProvinceIncharge(String provinceIncharge) {
		this.provinceIncharge = provinceIncharge;
	}

	/**
	 * getter for 省厅审批意见
	 * 
	 * @generated
	 */
	public String getProvinceAdvice() {
		return this.provinceAdvice;
	}

	/**
	 * setter for 省厅审批意见
	 * 
	 * @generated
	 */
	public void setProvinceAdvice(String provinceAdvice) {
		this.provinceAdvice = provinceAdvice;
	}

	/**
	 * getter for 省厅审批时间
	 * 
	 * @generated
	 */
	public String getProvinceApproveDate() {
		return this.provinceApproveDate;
	}

	/**
	 * setter for 省厅审批时间
	 * 
	 * @generated
	 */
	public void setProvinceApproveDate(String provinceApproveDate) {
		this.provinceApproveDate = provinceApproveDate;
	}

	/**
	 * getter for 批准机关
	 * 
	 * @generated
	 */
	public String getApprovalOrgan() {
		return this.approvalOrgan;
	}

	/**
	 * setter for 批准机关
	 * 
	 * @generated
	 */
	public void setApprovalOrgan(String approvalOrgan) {
		this.approvalOrgan = approvalOrgan;
	}

	/**
	 * getter for 备注
	 * 
	 * @generated
	 */
	public String getNote() {
		return this.note;
	}

	/**
	 * setter for 备注
	 * 
	 * @generated
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * @return the cityCheckDisabilityNature
	 */
	public String getCityCheckDisabilityNature() {
		return cityCheckDisabilityNature;
	}

	/**
	 * @param cityCheckDisabilityNature
	 *            the cityCheckDisabilityNature to set
	 */
	public void setCityCheckDisabilityNature(String cityCheckDisabilityNature) {
		this.cityCheckDisabilityNature = cityCheckDisabilityNature;
	}

	/**
	 * @return the cityCheckDisabilityLevel
	 */
	public String getCityCheckDisabilityLevel() {
		return cityCheckDisabilityLevel;
	}

	/**
	 * @param cityCheckDisabilityLevel
	 *            the cityCheckDisabilityLevel to set
	 */
	public void setCityCheckDisabilityLevel(String cityCheckDisabilityLevel) {
		this.cityCheckDisabilityLevel = cityCheckDisabilityLevel;
	}

	/**
	 * @return the cityCheckAdvice
	 */
	public String getCityCheckAdvice() {
		return cityCheckAdvice;
	}

	/**
	 * @param cityCheckAdvice
	 *            the cityCheckAdvice to set
	 */
	public void setCityCheckAdvice(String cityCheckAdvice) {
		this.cityCheckAdvice = cityCheckAdvice;
	}

	/**
	 * @return the provinceCheckDisNature
	 */
	public String getProvinceCheckDisNature() {
		return provinceCheckDisNature;
	}

	/**
	 * @param provinceCheckDisNature
	 *            the provinceCheckDisNature to set
	 */
	public void setProvinceCheckDisNature(String provinceCheckDisNature) {
		this.provinceCheckDisNature = provinceCheckDisNature;
	}

	/**
	 * @return the provinceCheckDisLevel
	 */
	public String getProvinceCheckDisLevel() {
		return provinceCheckDisLevel;
	}

	/**
	 * @param provinceCheckDisLevel
	 *            the provinceCheckDisLevel to set
	 */
	public void setProvinceCheckDisLevel(String provinceCheckDisLevel) {
		this.provinceCheckDisLevel = provinceCheckDisLevel;
	}

	/**
	 * @return the provinceCheckAdvice
	 */
	public String getProvinceCheckAdvice() {
		return provinceCheckAdvice;
	}

	/**
	 * @param provinceCheckAdvice
	 *            the provinceCheckAdvice to set
	 */
	public void setProvinceCheckAdvice(String provinceCheckAdvice) {
		this.provinceCheckAdvice = provinceCheckAdvice;
	}

	/**
	 * @return the disabilityDate
	 */
	public String getDisabilityDate() {
		return disabilityDate;
	}

	/**
	 * @param disabilityDate
	 *            the disabilityDate to set
	 */
	public void setDisabilityDate(String disabilityDate) {
		this.disabilityDate = disabilityDate;
	}

	public String getOldDisabilityNo() {
		return oldDisabilityNo;
	}

	public void setOldDisabilityNo(String oldDisabilityNo) {
		this.oldDisabilityNo = oldDisabilityNo;
	}

	public String getAllowanceMonth() {
		return allowanceMonth;
	}

	public void setAllowanceMonth(String allowanceMonth) {
		this.allowanceMonth = allowanceMonth;
	}

	public String getIngoingAddress() {
		return ingoingAddress;
	}

	public void setIngoingAddress(String ingoingAddress) {
		this.ingoingAddress = ingoingAddress;
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

	public String getCityFlag() {
		return cityFlag;
	}

	public void setCityFlag(String cityFlag) {
		this.cityFlag = cityFlag;
	}

	public String getCityReport() {
		return cityReport;
	}

	public void setCityReport(String cityReport) {
		this.cityReport = cityReport;
	}

	public String getProCheckFlag() {
		return proCheckFlag;
	}

	public void setProCheckFlag(String proCheckFlag) {
		this.proCheckFlag = proCheckFlag;
	}

	public String getProCheckReport() {
		return proCheckReport;
	}

	public void setProCheckReport(String proCheckReport) {
		this.proCheckReport = proCheckReport;
	}

	public String getProAduitFlag() {
		return proAduitFlag;
	}

	public void setProAduitFlag(String proAduitFlag) {
		this.proAduitFlag = proAduitFlag;
	}

	public String getProAduitReport() {
		return proAduitReport;
	}

	public void setProAduitReport(String proAduitReport) {
		this.proAduitReport = proAduitReport;
	}

	public String getBriefDisability() {
		return briefDisability;
	}

	public void setBriefDisability(String briefDisability) {
		this.briefDisability = briefDisability;
	}

	public String getProFlag() {
		return proFlag;
	}

	public void setProFlag(String proFlag) {
		this.proFlag = proFlag;
	}

	public String getPassFlag() {
		return passFlag;
	}

	public void setPassFlag(String passFlag) {
		this.passFlag = passFlag;
	}

	public String getPrintFlag() {
		return printFlag;
	}

	public void setPrintFlag(String printFlag) {
		this.printFlag = printFlag;
	}

	public String getChangeFlag() {
		return changeFlag;
	}

	public void setChangeFlag(String changeFlag) {
		this.changeFlag = changeFlag;
	}

	public String getChangeContent() {
		return changeContent;
	}

	public void setChangeContent(String changeContent) {
		this.changeContent = changeContent;
	}

	public String getCertType() {
		return certType;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	public String getOldDisabilityLevel() {
		return oldDisabilityLevel;
	}

	public void setOldDisabilityLevel(String oldDisabilityLevel) {
		this.oldDisabilityLevel = oldDisabilityLevel;
	}


	public String getOldDisabilityNature() {
		return oldDisabilityNature;
	}

	public void setOldDisabilityNature(String oldDisabilityNature) {
		this.oldDisabilityNature = oldDisabilityNature;
	}

}