package com.inspur.cams.comm.diccityChange.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;


/**
 * 区划变更上传附件表databean
 * @author 
 * @date 2014-01-13
 */
@Table(tableName = "DIC_CITY_CHANGE_BATCH_ATTACH", keyFields = "ATTACH_ID")
public class DicCityChangeBatchAttach extends StatefulDatabean {

	// 主键ID
	private String attachId;

	// 批次ID
	private String batchId;

	// 文件描述
	private String attachName;

	// 上传文件
	private UploadFile attachContent;

	// 区划代码
	private String attachPeopleCode;

	// 上传人
	private String attachPeopleName;

	// 上传时间
	private String attachTime;

	/**
	 * 获取 主键ID
	 * @return String
	 */
	public String getAttachId() {
		return attachId;
	}

	/**
	 * 设置 主键ID
	 */
	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}

	/**
	 * 获取 批次ID
	 * @return String
	 */
	public String getBatchId() {
		return batchId;
	}

	/**
	 * 设置 批次ID
	 */
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	/**
	 * 获取 文件描述
	 * @return String
	 */
	public String getAttachName() {
		return attachName;
	}

	/**
	 * 设置 文件描述
	 */
	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}

	/**
	 * 获取 上传文件
	 * @return Blob
	 */
	public UploadFile getAttachContent() {
		return attachContent;
	}

	/**
	 * 设置 上传文件
	 */
	public void setAttachContent (UploadFile attachContent) {
		this.attachContent = attachContent;
	}

	/**
	 * 获取 区划代码
	 * @return String
	 */
	public String getAttachPeopleCode() {
		return attachPeopleCode;
	}

	/**
	 * 设置 区划代码
	 */
	public void setAttachPeopleCode(String attachPeopleCode) {
		this.attachPeopleCode = attachPeopleCode;
	}

	/**
	 * 获取 上传人
	 * @return String
	 */
	public String getAttachPeopleName() {
		return attachPeopleName;
	}

	/**
	 * 设置 上传人
	 */
	public void setAttachPeopleName(String attachPeopleName) {
		this.attachPeopleName = attachPeopleName;
	}

	/**
	 * 获取 上传时间
	 * @return String
	 */
	public String getAttachTime() {
		return attachTime;
	}

	/**
	 * 设置 上传时间
	 */
	public void setAttachTime(String attachTime) {
		this.attachTime = attachTime;
	}

}