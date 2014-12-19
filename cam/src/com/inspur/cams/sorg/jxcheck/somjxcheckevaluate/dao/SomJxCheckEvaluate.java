package com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao;

import java.sql.*;
import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.upload.UploadFile;

/**
 * 江西评估情况
 * 
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
@Table(tableName = "SOM_JX_CHECK_EVALUATE", keyFields = "id")
public class SomJxCheckEvaluate extends StatefulDatabean {
	// ID
	@Column(name = "ID")
	private String id;
	// TASK_CODE
	@Column(name = "TASK_CODE")
	private String taskCode;
	// EVAL_LEVEL
	@Column(name = "EVAL_LEVEL")
	private String evalLevel;
	// START_DATE
	@Column(name = "START_DATE")
	private String startDate;
	// END_DATE
	@Column(name = "END_DATE")
	private String endDate;
	// IF_REVENUE_FAVORABLE
	@Column(name = "IF_REVENUE_FAVORABLE")
	private String ifRevenueFavorable;
	// FAVORABLE_TYPE
	@Column(name = "FAVORABLE_TYPE")
	private String favorableType;
	// FAVORABLE_DATE_ORGAN_DOC
	@Column(name = "FAVORABLE_DATE_ORGAN_DOC")
	private String favorableDateOrganDoc;
	// IF_PUNNISH
	@Column(name = "IF_PUNNISH")
	private String ifPunnish;
	// IF_CORRECT
	@Column(name = "IF_CORRECT")
	private String ifCorrect;
	// CORRECT_DESC
	@Column(name = "CORRECT_DESC")
	private String correctDesc;
	private String noLevel;
	public String getNoLevel() {
		return noLevel;
	}

	public void setNoLevel(String noLevel) {
		this.noLevel = noLevel;
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
	 * getter for EVAL_LEVEL
	 * 
	 * @generated
	 */
	public String getEvalLevel() {
		return this.evalLevel;
	}

	/**
	 * setter for EVAL_LEVEL
	 * 
	 * @generated
	 */
	public void setEvalLevel(String evalLevel) {
		this.evalLevel = evalLevel;
	}

	/**
	 * getter for START_DATE
	 * 
	 * @generated
	 */
	public String getStartDate() {
		return this.startDate;
	}

	/**
	 * setter for START_DATE
	 * 
	 * @generated
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * getter for END_DATE
	 * 
	 * @generated
	 */
	public String getEndDate() {
		return this.endDate;
	}

	/**
	 * setter for END_DATE
	 * 
	 * @generated
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getIfRevenueFavorable() {
		return ifRevenueFavorable;
	}

	public void setIfRevenueFavorable(String ifRevenueFavorable) {
		this.ifRevenueFavorable = ifRevenueFavorable;
	}

	public String getFavorableType() {
		return favorableType;
	}

	public void setFavorableType(String favorableType) {
		this.favorableType = favorableType;
	}

	public String getIfPunnish() {
		return ifPunnish;
	}

	public void setIfPunnish(String ifPunnish) {
		this.ifPunnish = ifPunnish;
	}

	public String getIfCorrect() {
		return ifCorrect;
	}

	public void setIfCorrect(String ifCorrect) {
		this.ifCorrect = ifCorrect;
	}

	public String getCorrectDesc() {
		return correctDesc;
	}

	public void setCorrectDesc(String correctDesc) {
		this.correctDesc = correctDesc;
	}

	public String getFavorableDateOrganDoc() {
		return favorableDateOrganDoc;
	}

	public void setFavorableDateOrganDoc(String favorableDateOrganDoc) {
		this.favorableDateOrganDoc = favorableDateOrganDoc;
	}

}