package com.inspur.cams.marry.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:MrmElectronic
 * @description:
 * @author:
 * @since:2011-07-19
 * @version:1.0
 */
@Table(tableName = "MRM_ELECTRONIC", keyFields = "electronicId")
public class MrmElectronic extends StatefulDatabean {
	// ELECTRONIC_ID
	@Rule(value = "require")
	@Column(name = "ELECTRONIC_ID")
	private String electronicId;
	// APPLY_ID
	@Rule(value = "require")
	@Column(name = "APPLY_ID")
	private String applyId;
	// FILE_CODE
	@Rule(value = "require")
	@Column(name = "FILE_CODE")
	private String fileCode;
	// DEPT_ID
	@Rule(value = "require")
	@Column(name = "DEPT_ID")
	private String deptId;
	// APPLY_TYPE
	@Column(name = "APPLY_TYPE")
	private String applyType;
	// IF_VALID
	@Rule(value = "require")
	@Column(name = "IF_VALID")
	private String ifValid;
	// CATALOG_CODE
	@Rule(value = "require")
	@Column(name = "CATALOG_CODE")
	private String catalogCode;
	// FILE_NAME
	@Column(name = "FILE_NAME")
	private String fileName;
	// FILE_TYPE
	@Column(name = "FILE_TYPE")
	private String fileType;
	// FILE_MESS
	@Column(name = "FILE_MESS")
	private String fileMess;
	// FILE_PATH
	@Column(name = "FILE_PATH")
	private String filePath;
	// FILES
	@Column(name = "FILES")
	private UploadFile files;
	// UP_CATALOG_CODE
	@Transient
	private String upCatalogCode;

	public String getElectronicId() {
		return electronicId;
	}

	public void setElectronicId(String electronicId) {
		this.electronicId = electronicId;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public String getFileCode() {
		return fileCode;
	}

	public void setFileCode(String fileCode) {
		this.fileCode = fileCode;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getIfValid() {
		return ifValid;
	}

	public void setIfValid(String ifValid) {
		this.ifValid = ifValid;
	}

	public String getCatalogCode() {
		return catalogCode;
	}

	public void setCatalogCode(String catalogCode) {
		this.catalogCode = catalogCode;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileMess() {
		return fileMess;
	}

	public void setFileMess(String fileMess) {
		this.fileMess = fileMess;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public UploadFile getFiles() {
		return files;
	}

	public void setFiles(UploadFile files) {
		this.files = files;
	}

	public String getUpCatalogCode() {
		return upCatalogCode;
	}

	public void setUpCatalogCode(String upCatalogCode) {
		this.upCatalogCode = upCatalogCode;
	}
}