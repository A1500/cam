package com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * @title:SomJxCheckMajor
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
 */
@Table(tableName = "SOM_JX_CHECK_MAJOR", keyFields = "id")
public class SomJxCheckMajor extends StatefulDatabean {
	// ID
	@Rule(value = "require")
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// PROJECT_NAME
	@Column(name = "PROJECT_NAME")
	private String projectName;
	// ZAHLUNGSZIEL
	@Column(name = "ZAHLUNGSZIEL")
	private String zahlungsziel;
	// EXPENDITURE_CASH
	@Column(name = "EXPENDITURE_CASH")
	private String expenditureCash;
	// RATIO
	@Column(name = "RATIO")
	private String ratio;
	// PURPOSE
	@Column(name = "PURPOSE")
	private String purpose;

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
	 * getter for PROJECT_NAME
	 * 
	 * @generated
	 */
	public String getProjectName() {
		return this.projectName;
	}

	/**
	 * setter for PROJECT_NAME
	 * 
	 * @generated
	 */
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	/**
	 * getter for ZAHLUNGSZIEL
	 * 
	 * @generated
	 */
	public String getZahlungsziel() {
		return this.zahlungsziel;
	}

	/**
	 * setter for ZAHLUNGSZIEL
	 * 
	 * @generated
	 */
	public void setZahlungsziel(String zahlungsziel) {
		this.zahlungsziel = zahlungsziel;
	}

	/**
	 * getter for EXPENDITURE_CASH
	 * 
	 * @generated
	 */
	public String getExpenditureCash() {
		return this.expenditureCash;
	}

	/**
	 * setter for EXPENDITURE_CASH
	 * 
	 * @generated
	 */
	public void setExpenditureCash(String expenditureCash) {
		this.expenditureCash = expenditureCash;
	}

	/**
	 * getter for PURPOSE
	 * 
	 * @generated
	 */
	public String getPurpose() {
		return this.purpose;
	}

	/**
	 * setter for PURPOSE
	 * 
	 * @generated
	 */
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getRatio() {
		return ratio;
	}

	public void setRatio(String ratio) {
		this.ratio = ratio;
	}

}