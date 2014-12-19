package com.inspur.cams.sorg.jxcheck.somjxoffice.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:江西内设机构情况
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
@Table(tableName = "SOM_JX_OFFICE", keyFields = "id")
public class SomJxOffice extends StatefulDatabean {
	// ID
	@Rule(value = "require")
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// PRINCIPAL_PEOPEL
	@Column(name = "PRINCIPAL_PEOPEL")
	private String principalPeopel;
	// IF_CHANGE
	@Column(name = "IF_CHANGE")
	private String ifChange;
	// CHANGE_BEFORE
	@Column(name = "CHANGE_BEFORE")
	private String changeBefore;
	// CHANGE_AFTER
	@Column(name = "CHANGE_AFTER")
	private String changeAfter;
	// OFFICER
	@Column(name = "OFFICER")
	private String officer;
	// OFFICE_NAME
	@Column(name = "OFFICE_NAME")
	private String officeName;

	public String getOfficer() {
		return officer;
	}

	public void setOfficer(String officer) {
		this.officer = officer;
	}

	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
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
	 * getter for TASK_CODE
	 * 
	 * @generated
	 */
	public String getTaskCode() {
		return this.taskCode;
	}

	/**
	 * setter for TASK_CODE
	 * 
	 * @generated
	 */
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	/**
	 * getter for PRINCIPAL_PEOPEL
	 * 
	 * @generated
	 */
	public String getPrincipalPeopel() {
		return this.principalPeopel;
	}

	/**
	 * setter for PRINCIPAL_PEOPEL
	 * 
	 * @generated
	 */
	public void setPrincipalPeopel(String principalPeopel) {
		this.principalPeopel = principalPeopel;
	}

	/**
	 * getter for IF_CHANGE
	 * 
	 * @generated
	 */
	public String getIfChange() {
		return this.ifChange;
	}

	/**
	 * setter for IF_CHANGE
	 * 
	 * @generated
	 */
	public void setIfChange(String ifChange) {
		this.ifChange = ifChange;
	}

	/**
	 * getter for CHANGE_BEFORE
	 * 
	 * @generated
	 */
	public String getChangeBefore() {
		return this.changeBefore;
	}

	/**
	 * setter for CHANGE_BEFORE
	 * 
	 * @generated
	 */
	public void setChangeBefore(String changeBefore) {
		this.changeBefore = changeBefore;
	}

	/**
	 * getter for CHANGE_AFTER
	 * 
	 * @generated
	 */
	public String getChangeAfter() {
		return this.changeAfter;
	}

	/**
	 * setter for CHANGE_AFTER
	 * 
	 * @generated
	 */
	public void setChangeAfter(String changeAfter) {
		this.changeAfter = changeAfter;
	}

}