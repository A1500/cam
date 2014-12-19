package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * BptCertTemplates
 * 
 * @author zhanghui
 * 
 */
@Table(tableName = "BPT_CERT_TEMPLATES", keyFields = "fileId")
public class BptCertTemplates extends StatefulDatabean {
	// 主键
	// @Rule(value="require")
	@Column(name = "FILE_ID")
	private String fileId;
	// 业务类型
	// @Rule(value="require")
	@Column(name = "SERVICE_TYPE")
	private String serviceType;
	// 模板路径
	// @Rule(value="require")
	@Column(name = "FILE_PATH")
	private String filePath;
	// 模板文件名
	// @Rule(value="require")
	@Column(name = "FILE_NAME")
	private String fileName;
	// 所属市县
	// @Rule(value="require")
	@Column(name = "FILE_DOMICILE")
	private String fileDomicile;
	// 修改时间
	@Column(name = "MOD_TIME")
	private String modTime;

	// 是否为默认模板
	@Column(name = "IS_DEFAULT")
	private String isDefault;

	/**
	 * getter for 主键
	 * 
	 * @generated
	 */
	public String getFileId() {
		return this.fileId;
	}

	/**
	 * setter for 主键
	 * 
	 * @generated
	 */
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	/**
	 * getter for 业务类型
	 * 
	 * @generated
	 */
	public String getServiceType() {
		return this.serviceType;
	}

	/**
	 * setter for 业务类型
	 * 
	 * @generated
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	/**
	 * getter for 模板路径
	 * 
	 * @generated
	 */
	public String getFilePath() {
		return this.filePath;
	}

	/**
	 * setter for 模板路径
	 * 
	 * @generated
	 */
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	/**
	 * getter for 模板文件名
	 * 
	 * @generated
	 */
	public String getFileName() {
		return this.fileName;
	}

	/**
	 * setter for 模板文件名
	 * 
	 * @generated
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * getter for 所属市县
	 * 
	 * @generated
	 */
	public String getFileDomicile() {
		return this.fileDomicile;
	}

	/**
	 * setter for 所属市县
	 * 
	 * @generated
	 */
	public void setFileDomicile(String fileDomicile) {
		this.fileDomicile = fileDomicile;
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

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

}