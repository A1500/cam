package com.inspur.cams.jcm.data;

import java.io.Serializable;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 人员调动管理
 * @author zhenSenSen
 * @date 2014-12-15
 */
@Table(tableName = "JCM_PEOPLE_TRANSFER", keyFields = "id")
public class JcmPeopleTransferManage extends StatefulDatabean implements Serializable{
	
	//主键
	private String id;
	
	//被调动人id
	private String transferPeopleId;

	//现在单位id
	private String fromDeptId;

	//用人单位id
	private String toDeptId;
	
	//调动类型
	private String transferType;
	
	//申请时间
	private String applyDate;
	
	//审批时间
	private String auditDate;
	
	//发起申请人id
	private String applyPeopleId;
	
	//审批人id
	private String auditPeopleId;
	
	//状态
	private String status;

	
	
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}




	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}




	/**
	 * @return the transferPeopleId
	 */
	public String getTransferPeopleId() {
		return transferPeopleId;
	}




	/**
	 * @param transferPeopleId the transferPeopleId to set
	 */
	public void setTransferPeopleId(String transferPeopleId) {
		this.transferPeopleId = transferPeopleId;
	}




	/**
	 * @return the fromDeptId
	 */
	public String getFromDeptId() {
		return fromDeptId;
	}




	/**
	 * @param fromDeptId the fromDeptId to set
	 */
	public void setFromDeptId(String fromDeptId) {
		this.fromDeptId = fromDeptId;
	}




	/**
	 * @return the toDeptId
	 */
	public String getToDeptId() {
		return toDeptId;
	}




	/**
	 * @param toDeptId the toDeptId to set
	 */
	public void setToDeptId(String toDeptId) {
		this.toDeptId = toDeptId;
	}




	/**
	 * @return the transferType
	 */
	public String getTransferType() {
		return transferType;
	}




	/**
	 * @param transferType the transferType to set
	 */
	public void setTransferType(String transferType) {
		this.transferType = transferType;
	}




	/**
	 * @return the applyDate
	 */
	public String getApplyDate() {
		return applyDate;
	}




	/**
	 * @param applyDate the applyDate to set
	 */
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}




	/**
	 * @return the auditDate
	 */
	public String getAuditDate() {
		return auditDate;
	}




	/**
	 * @param auditDate the auditDate to set
	 */
	public void setAuditDate(String auditDate) {
		this.auditDate = auditDate;
	}




	/**
	 * @return the applyPeopleId
	 */
	public String getApplyPeopleId() {
		return applyPeopleId;
	}




	/**
	 * @param applyPeopleId the applyPeopleId to set
	 */
	public void setApplyPeopleId(String applyPeopleId) {
		this.applyPeopleId = applyPeopleId;
	}




	/**
	 * @return the auditPeopleId
	 */
	public String getAuditPeopleId() {
		return auditPeopleId;
	}




	/**
	 * @param auditPeopleId the auditPeopleId to set
	 */
	public void setAuditPeopleId(String auditPeopleId) {
		this.auditPeopleId = auditPeopleId;
	}




	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}




	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	private static final long serialVersionUID = -6945495907719674743L;
}
