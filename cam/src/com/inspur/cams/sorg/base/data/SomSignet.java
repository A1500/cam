package com.inspur.cams.sorg.base.data;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * 社会组织印章信息表
 * 
 * @author yanliangliang
 * @date 2011-9-19
 */
@Table(tableName = "SOM_SIGNET", keyFields = "id")
public class SomSignet extends StatefulDatabean {
	// 印章名录表
	@Transient
	private List<SomSignetDirectory> somSignetDirectoryList = new ArrayList<SomSignetDirectory>();
	
	// 印章ID
	private String id;

	// 社会组织ID
	private String sorgId;

	// 印章样式
	private UploadFile signet;

	// 印章启用时间
	private String signetDate;

	// 领章人
	private String fetchPeople;

	// 录入人
	private String createPeople;

	// 录入时间
	private String createTime;

	// 社会组织类型
	private String sorgType;

	// 业务编号
	private String taskCode;

	// 备案承办人
	private String regPeople;

	// 备案日期
	private String regDate;

	// 备案状态
	private String regStatus;

	// 登记管理机关名称
	private String morgName;

	// 登记管理机关行政区划
	private String morgArea;

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
	 * getter for SORG_ID
	 * 
	 * @generated
	 */
	public String getSorgId() {
		return this.sorgId;
	}

	/**
	 * setter for SORG_ID
	 * 
	 * @generated
	 */
	public void setSorgId(String sorgId) {
		this.sorgId = sorgId;
	}

	/**
	 * getter for SIGNET
	 * 
	 * @generated
	 */
	public UploadFile getSignet() {
		return this.signet;
	}

	/**
	 * setter for SIGNET
	 * 
	 * @generated
	 */
	public void setSignet(UploadFile signet) {
		this.signet = signet;
	}

	/**
	 * getter for SIGNET_DATE
	 * 
	 * @generated
	 */
	public String getSignetDate() {
		return this.signetDate;
	}

	/**
	 * setter for SIGNET_DATE
	 * 
	 * @generated
	 */
	public void setSignetDate(String signetDate) {
		this.signetDate = signetDate;
	}

	/**
	 * getter for FETCH_PEOPLE
	 * 
	 * @generated
	 */
	public String getFetchPeople() {
		return this.fetchPeople;
	}

	/**
	 * setter for FETCH_PEOPLE
	 * 
	 * @generated
	 */
	public void setFetchPeople(String fetchPeople) {
		this.fetchPeople = fetchPeople;
	}

	/**
	 * getter for CREATE_PEOPLE
	 * 
	 * @generated
	 */
	public String getCreatePeople() {
		return this.createPeople;
	}

	/**
	 * setter for CREATE_PEOPLE
	 * 
	 * @generated
	 */
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	/**
	 * getter for CREATE_TIME
	 * 
	 * @generated
	 */
	public String getCreateTime() {
		return this.createTime;
	}

	/**
	 * setter for CREATE_TIME
	 * 
	 * @generated
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * getter for SORG_TYPE
	 * 
	 * @generated
	 */
	public String getSorgType() {
		return this.sorgType;
	}

	/**
	 * setter for SORG_TYPE
	 * 
	 * @generated
	 */
	public void setSorgType(String sorgType) {
		this.sorgType = sorgType;
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
	 * getter for REG_PEOPLE
	 * 
	 * @generated
	 */
	public String getRegPeople() {
		return this.regPeople;
	}

	/**
	 * setter for REG_PEOPLE
	 * 
	 * @generated
	 */
	public void setRegPeople(String regPeople) {
		this.regPeople = regPeople;
	}

	/**
	 * getter for REG_DATE
	 * 
	 * @generated
	 */
	public String getRegDate() {
		return this.regDate;
	}

	/**
	 * setter for REG_DATE
	 * 
	 * @generated
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	/**
	 * getter for REG_STATUS
	 * 
	 * @generated
	 */
	public String getRegStatus() {
		return this.regStatus;
	}

	/**
	 * setter for REG_STATUS
	 * 
	 * @generated
	 */
	public void setRegStatus(String regStatus) {
		this.regStatus = regStatus;
	}

	/**
	 * getter for MORG_NAME
	 * 
	 * @generated
	 */
	public String getMorgName() {
		return this.morgName;
	}

	/**
	 * setter for MORG_NAME
	 * 
	 * @generated
	 */
	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	/**
	 * getter for MORG_AREA
	 * 
	 * @generated
	 */
	public String getMorgArea() {
		return this.morgArea;
	}

	/**
	 * setter for MORG_AREA
	 * 
	 * @generated
	 */
	public void setMorgArea(String morgArea) {
		this.morgArea = morgArea;
	}

	public List<SomSignetDirectory> getSomSignetDirectoryList() {
		return somSignetDirectoryList;
	}

	public void setSomSignetDirectoryList(
			List<SomSignetDirectory> somSignetDirectoryList) {
		this.somSignetDirectoryList = somSignetDirectoryList;
	}

}