package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:状态变更实体bean
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
 */
@Table(tableName = "BPT_STATE_CHANGE", keyFields = "stateChangeId")
public class BptStateChange extends StatefulDatabean {
	// 状态变更ID
	@Column(name = "STATE_CHANGE_ID")
	private String stateChangeId;
	// 人员ID
	@Column(name = "PEOPLE_ID")
	private String peopleId;
	// 姓名
	@Column(name = "NAME")
	private String name;
	// 身份证件号码
	@Column(name = "ID_CARD")
	private String idCard;

	// 变更前状态
	@Column(name = "CHANGE_STATE_PRE")
	private String changeStatePre;
	// 变更后状态
	@Column(name = "CHANGE_STATE_SUF")
	private String changeStateSuf;
	// 变更时间
	@Column(name = "CHANGE_STATE_DATE")
	private String changeStateDate;
	// 备注
	@Column(name = "NOTE")
	private String note;
	// 录入人ID
	@Column(name = "REG_ID")
	private String regId;
	// 录入时间
	@Column(name = "REG_TIME")
	private String regTime;
	// 修改人ID
	@Column(name = "MOD_ID")
	private String modId;
	// 修改时间
	@Column(name = "MOD_TIME")
	private String modTime;

	// 抚恤金已发至月份
	@Column(name = "ALLOWANCE_MONTH")
	private String allowanceMonth;

	// 死亡日期
	@Column(name = "DEATH_DATE")
	private String deathDate;

	// 迁入地行政区划
	@Column(name = "IN_DOMICILE_CODE")
	private String inDomicileCode;

	// 迁入地行政区划名称
	@Column(name = "IN_DOMICILE_CODE_NAME")
	private String inDomicileCodeName;

	// 迁出地行政区划
	@Column(name = "OUT_DOMICILE_CODE")
	private String outDomicileCode;

	// 迁出地行政区划名称
	@Column(name = "OUT_DOMICILE_CODE_NAME")
	private String outDomicileCodeName;

	// 优抚对象类别
	@Column(name = "OBJECT_TYPE")
	private String objectType;
	
	// 业务类型
	@Column(name = "SERVICE_TYPE")
	private String serviceType;

	/**
	 * getter for 状态变更ID
	 * 
	 * @generated
	 */
	public String getStateChangeId() {
		return this.stateChangeId;
	}

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	/**
	 * setter for 状态变更ID
	 * 
	 * @generated
	 */
	public void setStateChangeId(String stateChangeId) {
		this.stateChangeId = stateChangeId;
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
	 * getter for 姓名
	 * 
	 * @generated
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * setter for 姓名
	 * 
	 * @generated
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * getter for 身份证件号码
	 * 
	 * @generated
	 */
	public String getIdCard() {
		return this.idCard;
	}

	/**
	 * setter for 身份证件号码
	 * 
	 * @generated
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	/**
	 * getter for 变更时间
	 * 
	 * @generated
	 */
	public String getChangeStateDate() {
		return this.changeStateDate;
	}

	/**
	 * setter for 变更时间
	 * 
	 * @generated
	 */
	public void setChangeStateDate(String changeStateDate) {
		this.changeStateDate = changeStateDate;
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
	 * getter for 录入人ID
	 * 
	 * @generated
	 */
	public String getRegId() {
		return this.regId;
	}

	/**
	 * setter for 录入人ID
	 * 
	 * @generated
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * getter for 录入时间
	 * 
	 * @generated
	 */
	public String getRegTime() {
		return this.regTime;
	}

	/**
	 * setter for 录入时间
	 * 
	 * @generated
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	/**
	 * getter for 修改人ID
	 * 
	 * @generated
	 */
	public String getModId() {
		return this.modId;
	}

	/**
	 * setter for 修改人ID
	 * 
	 * @generated
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}

	/**
	 * getter for 修改时间
	 * 
	 * @generated
	 */
	public String getModTime() {
		return this.modTime;
	}

	/**
	 * setter for 修改时间
	 * 
	 * @generated
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}

	/**
	 * @return the changeStatePre
	 */
	public String getChangeStatePre() {
		return changeStatePre;
	}

	/**
	 * @param changeStatePre
	 *            the changeStatePre to set
	 */
	public void setChangeStatePre(String changeStatePre) {
		this.changeStatePre = changeStatePre;
	}

	/**
	 * @return the changeStateSuf
	 */
	public String getChangeStateSuf() {
		return changeStateSuf;
	}

	/**
	 * @param changeStateSuf
	 *            the changeStateSuf to set
	 */
	public void setChangeStateSuf(String changeStateSuf) {
		this.changeStateSuf = changeStateSuf;
	}

	public String getInDomicileCode() {
		return inDomicileCode;
	}

	public void setInDomicileCode(String inDomicileCode) {
		this.inDomicileCode = inDomicileCode;
	}

	public String getInDomicileCodeName() {
		return inDomicileCodeName;
	}

	public void setInDomicileCodeName(String inDomicileCodeName) {
		this.inDomicileCodeName = inDomicileCodeName;
	}

	public String getOutDomicileCode() {
		return outDomicileCode;
	}

	public void setOutDomicileCode(String outDomicileCode) {
		this.outDomicileCode = outDomicileCode;
	}

	public String getOutDomicileCodeName() {
		return outDomicileCodeName;
	}

	public void setOutDomicileCodeName(String outDomicileCodeName) {
		this.outDomicileCodeName = outDomicileCodeName;
	}

	public String getObjectType() {
		return objectType;
	}

	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	public String getAllowanceMonth() {
		return allowanceMonth;
	}

	public void setAllowanceMonth(String allowanceMonth) {
		this.allowanceMonth = allowanceMonth;
	}

	public String getDeathDate() {
		return deathDate;
	}

	public void setDeathDate(String deathDate) {
		this.deathDate = deathDate;
	}

}