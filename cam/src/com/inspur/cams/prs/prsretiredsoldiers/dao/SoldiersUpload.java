package com.inspur.cams.prs.prsretiredsoldiers.dao;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:SoldiersUpload
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
 */
@Table(tableName = "PRS_CATALOGUE", keyFields = "catalogId")
public class SoldiersUpload extends StatefulDatabean {
	// 主键ID
	//@Rule(value = "require")
	@Column(name = "CATALOG_ID")
	private String catalogId;
	// 目录代码
	@Rule(value = "require")
	@Column(name = "CATALOG_CODE")
	private String catalogCode;
	// 目录名称
	//@Rule(value = "require")
	@Column(name = "CATALOG_NAME")
	private String catalogName;
	// 目录描述
	@Column(name = "CATALOG_INFO")
	private String catalogInfo;
	// 文件路径
	//@Rule(value = "require")
	@Column(name = "FILE_PATH")
	private String filePath;
	//上传人
	//@Rule(value = "require")
	@Column(name = "FILE_OPER")
	private String fileOper;
	//上传时间
	//@Rule(value = "require")
	@Column(name = "UPLOAD_TIME")
	private String uploadTime;
	// 所在军区
	@Rule(value = "require")
	@Column(name = "MILITARY_REGION")
	private String militaryRegion;
	// 是否导入
	//@Rule(value = "require")
	@Column(name = "INSERT_FLAG")
	private String insertFlag;

	@Column(name = "CONTAIN_NUM" )
	private Integer contain_num;


	/**
	 * getter for 主键ID
	 *
	 * @generated
	 */
	public String getCatalogId() {
		return this.catalogId;
	}

	/**
	 * setter for 主键ID
	 *
	 * @generated
	 */
	public void setCatalogId(String catalogId) {
		this.catalogId = catalogId;
	}

	/**
	 * getter for 目录代码
	 *
	 * @generated
	 */
	public String getCatalogCode() {
		return this.catalogCode;
	}

	/**
	 * setter for 目录代码
	 *
	 * @generated
	 */
	public void setCatalogCode(String catalogCode) {
		this.catalogCode = catalogCode;
	}

	/**
	 * getter for 目录名称
	 *
	 * @generated
	 */
	public String getCatalogName() {
		return this.catalogName;
	}

	/**
	 * setter for 目录名称
	 *
	 * @generated
	 */
	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}

	/**
	 * getter for 目录描述
	 *
	 * @generated
	 */
	public String getCatalogInfo() {
		return this.catalogInfo;
	}

	/**
	 * setter for 目录描述
	 *
	 * @generated
	 */
	public void setCatalogInfo(String catalogInfo) {
		this.catalogInfo = catalogInfo;
	}

	/**
	 * getter for 文件路径
	 *
	 * @generated
	 */
	public String getFilePath() {
		return this.filePath;
	}

	/**
	 * setter for 文件路径
	 *
	 * @generated
	 */
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	/**
	 * getter for 上传人
	 *
	 * @generated
	 */
	public String getFileOper() {
		return this.fileOper;
	}

	/**
	 * setter for 上传人
	 *
	 * @generated
	 */
	public void setFileOper(String fileOper) {
		this.fileOper = fileOper;
	}

	/**
	 * getter for 上传时间
	 *
	 * @generated
	 */
	public String getUploadTime() {
		return this.uploadTime;
	}

	/**
	 * setter for 上传时间
	 *
	 * @generated
	 */
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}

	/**
	 * getter for 所在军区
	 *
	 * @generated
	 */
	public String getMilitaryRegion() {
		return this.militaryRegion;
	}

	/**
	 * setter for 所在军区
	 *
	 * @generated
	 */
	public void setMilitaryRegion(String militaryRegion) {
		this.militaryRegion = militaryRegion;
	}
	/**
	 * getter for 是否导入
	 *
	 * @generated
	 */
	public String getInsertFlag() {
		return this.insertFlag;
	}

	/**
	 * setter for 是否导入
	 *
	 * @generated
	 */
	public void setInsertFlag(String insertFlag) {
		this.insertFlag = insertFlag;
	}

	public Integer getContain_num() {
		return contain_num;
	}

	public void setContain_num(Integer contain_num) {
		this.contain_num = contain_num;
	}


}