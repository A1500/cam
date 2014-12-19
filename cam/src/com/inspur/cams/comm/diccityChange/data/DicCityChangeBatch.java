package com.inspur.cams.comm.diccityChange.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * 变更批次表databean
 * @author 
 * @date 2014-01-02
 */
@Table(tableName = "DIC_CITY_CHANGE_BATCH", keyFields = "batchId")
public class DicCityChangeBatch extends StatefulDatabean {

	// 批次Id
	private String batchId;
	
	// 批次Id
	private String batchName;

	// 行政区划代码
	private String organCode;

	// 行政区划名称
	private String organName;

	// 提交时间
	private String submitDate;

	// 提交人
	private String submitPeople;

	// 批次月份
	private String batchMonth;

	// 当月提交次数
	private String submitTiems;

	// 审批人
	private String checkPeo;

	// 审批时间
	private String checkTime;

	// 批次状态
	private String batchType;

	// 附件
	private UploadFile attachment;

	// 审批意见
	private String checkOppion;
	
	// 申请人
	private String applyPeo;
	
	// 申请人电话
	private String applyPhone;
	
	// 审核意见
	private String auditOpinion;
	
	// 审核人
	private String auditPeo;
	
	// 审核时间
	private String auditTime;
	
	// 审核结果
	private String auditType;
	
	// 城市名
	private String city;


	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	/**
	 * 获取 批次Id
	 * @return String
	 */
	public String getBatchId() {
		return batchId;
	}

	/**
	 * 设置 批次Id
	 */
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	/**
	 * 获取 行政区划代码
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 行政区划代码
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 行政区划名称
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 行政区划名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 提交时间
	 * @return String
	 */
	public String getSubmitDate() {
		return submitDate;
	}

	/**
	 * 设置 提交时间
	 */
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	/**
	 * 获取 提交人
	 * @return String
	 */
	public String getSubmitPeople() {
		return submitPeople;
	}

	/**
	 * 设置 提交人
	 */
	public void setSubmitPeople(String submitPeople) {
		this.submitPeople = submitPeople;
	}

	/**
	 * 获取 批次月份
	 * @return String
	 */
	public String getBatchMonth() {
		return batchMonth;
	}

	/**
	 * 设置 批次月份
	 */
	public void setBatchMonth(String batchMonth) {
		this.batchMonth = batchMonth;
	}

	/**
	 * 获取 当月提交次数
	 * @return String
	 */
	public String getSubmitTiems() {
		return submitTiems;
	}

	/**
	 * 设置 当月提交次数
	 */
	public void setSubmitTiems(String submitTiems) {
		this.submitTiems = submitTiems;
	}

	/**
	 * 获取 审批人
	 * @return String
	 */
	public String getCheckPeo() {
		return checkPeo;
	}

	/**
	 * 设置 审批人
	 */
	public void setCheckPeo(String checkPeo) {
		this.checkPeo = checkPeo;
	}

	/**
	 * 获取 审批时间
	 * @return String
	 */
	public String getCheckTime() {
		return checkTime;
	}

	/**
	 * 设置 审批时间
	 */
	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	/**
	 * 获取 批次状态
	 * @return String
	 */
	public String getBatchType() {
		return batchType;
	}

	/**
	 * 设置 批次状态
	 */
	public void setBatchType(String batchType) {
		this.batchType = batchType;
	}

	/**
	 * 获取 附件
	 * @return Blob
	 */
	public UploadFile getAttachment() {
		return attachment;
	}

	/**
	 * 设置 附件
	 */
	public void setAttachment (UploadFile attachment) {
		this.attachment = attachment;
	}

	/**
	 * 获取 审批意见
	 * @return String
	 */
	public String getCheckOppion() {
		return checkOppion;
	}

	/**
	 * 设置 审批意见
	 */
	public void setCheckOppion(String checkOppion) {
		this.checkOppion = checkOppion;
	}

	public String getBatchName() {
		return batchName;
	}

	public void setBatchName(String batchName) {
		this.batchName = batchName;
	}

	public String getApplyPeo() {
		return applyPeo;
	}

	public void setApplyPeo(String applyPeo) {
		this.applyPeo = applyPeo;
	}

	public String getApplyPhone() {
		return applyPhone;
	}

	public void setApplyPhone(String applyPhone) {
		this.applyPhone = applyPhone;
	}

	public String getAuditOpinion() {
		return auditOpinion;
	}

	public void setAuditOpinion(String auditOpinion) {
		this.auditOpinion = auditOpinion;
	}

	public String getAuditPeo() {
		return auditPeo;
	}

	public void setAuditPeo(String auditPeo) {
		this.auditPeo = auditPeo;
	}

	public String getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(String auditTime) {
		this.auditTime = auditTime;
	}

	public String getAuditType() {
		return auditType;
	}

	public void setAuditType(String auditType) {
		this.auditType = auditType;
	}

}