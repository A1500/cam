package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社区图片展示databean
 * @author shgtch
 * @date 2012-2-7
 */
@Table(tableName = "CDC_PIC_INFO", keyFields = "id")
public class CdcPicInfo extends StatefulDatabean {

	// 内码
	private String id;

	// 照片内容
	private String content;

	// 备注
	private String note;

	// 上传单位行政区划
	private String organCode;

	// 上传单位名称
	private String organName;

	// 上传时间
	private String createTime;
	
	// 非表列
	@Transient
	private String photoTemp;

	public String getPhotoTemp() {
		return photoTemp;
	}

	public void setPhotoTemp(String photoTemp) {
		this.photoTemp = photoTemp;
	}

	/**
	 * 获取 内码
	 * @return String
	 */
	public String getId() {
		return id;
	}

	/**
	 * 设置 内码
	 * @return String
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * 获取 照片内容
	 * @return String
	 */
	public String getContent() {
		return content;
	}

	/**
	 * 设置 照片内容
	 * @return String
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 * @return String
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取 上传单位行政区划
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 上传单位行政区划
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 上传单位名称
	 * @return
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 上传单位名称
	 * @param organName
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 上传时间
	 * @return
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 上传时间
	 * @param organName
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
}