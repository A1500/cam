package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:WfProcessBusiness
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
 */
@Table(tableName = "WF_PROCESS_BUSINESS", keyFields = "processId")
public class WfProcessBusiness extends StatefulDatabean {
	// PROCESS_ID
	@Rule(value = "require")
	@Column(name = "PROCESS_ID")
	private String processId;
	// BUSINESS_ID
	@Rule(value = "require")
	@Column(name = "BUSINESS_ID")
	private String businessId;
	// BUSINESS_TYPE
	@Column(name = "BUSINESS_TYPE")
	private String businessType;
	// CONNECT_ID
	@Column(name = "CONNECT_ID")
	private String connectId;

	// 是否被退回
	@Column(name = "IFBACK")
	private String ifback;

	/**
	 * getter for PROCESS_ID
	 * 
	 * @generated
	 */
	public String getProcessId() {
		return this.processId;
	}

	/**
	 * setter for PROCESS_ID
	 * 
	 * @generated
	 */
	public void setProcessId(String processId) {
		this.processId = processId;
	}

	/**
	 * getter for BUSINESS_ID
	 * 
	 * @generated
	 */
	public String getBusinessId() {
		return this.businessId;
	}

	/**
	 * setter for BUSINESS_ID
	 * 
	 * @generated
	 */
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}

	/**
	 * getter for BUSINESS_TYPE
	 * 
	 * @generated
	 */
	public String getBusinessType() {
		return this.businessType;
	}

	/**
	 * setter for BUSINESS_TYPE
	 * 
	 * @generated
	 */
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}

	/**
	 * getter for CONNECT_ID
	 * 
	 * @generated
	 */
	public String getConnectId() {
		return this.connectId;
	}

	/**
	 * setter for CONNECT_ID
	 * 
	 * @generated
	 */
	public void setConnectId(String connectId) {
		this.connectId = connectId;
	}

	public String getIfback() {
		return ifback;
	}

	public void setIfback(String ifback) {
		this.ifback = ifback;
	}

}