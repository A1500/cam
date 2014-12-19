package com.inspur.cams.fis.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * 数据上报信息databean
 * @author 
 * @date Mon Apr 16 15:35:06 GMT+08:00 2012
 */
@Table(tableName = "FIS_IMPORT_DATA", keyFields = "recordId")
public class FisImportData extends StatefulDatabean {

	// 记录内码
	@Column(name = "RECORD_ID")
	private String recordId;

	// 上传时间
	@Column(name = "UPLOAD_TIME")
	private String uploadTime;

	// 上传人
	@Column(name = "UPLOAD_PERSON")
	private String uploadPerson;

	// 上传单位
	@Column(name = "UPLOAD_UNIT")
	private String uploadUnit;

	// 上报文件名称
	@Column(name = "UPLOAD_FILE")
	private String uploadFile;

	// 上传内容
	@Column(name = "UPLOAD_CONTENT")
	private UploadFile uploadContent;

	// 上传描述
	@Column(name = "UPLOAD_DESC")
	private String uploadDesc;

	// 客户端的时间（馆）
	@Column(name = "CLIENT_TIME")
	private String clientTime;
	
	// 上报开始时间
	@Column(name = "START_TIME")
	private String startTime;
	
	// 上报截止时间
	@Column(name = "END_TIME")
	private String endTime;
	
	// 是否通过文件传输
	@Column(name = "IF_FILE")
	private String ifFile;
	
	@Transient
	private String desc;

	/**
	 * 获取 记录内码
	 * @return String
	 */
	public String getRecordId() {
		return recordId;
	}

	/**
	 * 设置 记录内码
	 */
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 获取 上传时间
	 * @return String
	 */
	public String getUploadTime() {
		return uploadTime;
	}

	/**
	 * 设置 上传时间
	 */
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}

	/**
	 * 获取 上传人
	 * @return String
	 */
	public String getUploadPerson() {
		return uploadPerson;
	}

	/**
	 * 设置 上传人
	 */
	public void setUploadPerson(String uploadPerson) {
		this.uploadPerson = uploadPerson;
	}

	/**
	 * 获取 上传单位
	 * @return String
	 */
	public String getUploadUnit() {
		return uploadUnit;
	}

	/**
	 * 设置 上传单位
	 */
	public void setUploadUnit(String uploadUnit) {
		this.uploadUnit = uploadUnit;
	}

	/**
	 * 获取 上报文件名称
	 * @return String
	 */
	public String getUploadFile() {
		return uploadFile;
	}

	/**
	 * 设置 上报文件名称
	 */
	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}

	/**
	 * 获取 上传内容
	 * @return Blob
	 */
	public UploadFile getUploadContent() {
		return uploadContent;
	}

	/**
	 * 设置 上传内容
	 */
	public void setUploadContent (UploadFile uploadContent) {
		this.uploadContent = uploadContent;
	}

	/**
	 * 获取 上传描述
	 * @return String
	 */
	public String getUploadDesc() {
		return uploadDesc;
	}

	/**
	 * 设置 上传描述
	 */
	public void setUploadDesc(String uploadDesc) {
		this.uploadDesc = uploadDesc;
	}

	public String getClientTime() {
		return clientTime;
	}

	public void setClientTime(String clientTime) {
		this.clientTime = clientTime;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getIfFile() {
		return ifFile;
	}

	public void setIfFile(String ifFile) {
		this.ifFile = ifFile;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

}