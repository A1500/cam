package com.inspur.cams.cdc.base.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基层民主与社区建设通知通告databean
 * @author xu
 * @date 2012-3-12
 */
@Table(tableName = "CDC_NOTICE_INFO", keyFields = "NOTICE_ID")
public class CdcNoticeInfo extends StatefulDatabean {
	
	/**
	 * 通知通告内码
	 */
	@Column(name = "NOTICE_ID")
	private String noticeId;
	/**
	 * 通知通告类型
	 */
	@Column(name = "NOTICE_TYPE")
	private String noticeType;
	/**
	 * 主题
	 */
	@Column(name = "NAME")
	private String name;
	/**
	 * 内容
	 */
	@Column(name = "CONTENT")
	private String content;
	/**
	 * 附件
	 */
	@Column(name = "FILE_ID")
	private String fileId;
	/**
	 * 发布状态
	 */
	@Column(name = "FLAG")
	private String flag;
	/**
	 * 发布单位行政区划
	 */
	@Column(name = "ORGAN_AREA")
	private String organArea;
	/**
	 * 发布单位名称
	 */
	@Column(name = "ORGAN_NAME")
	private String organName;
	/**
	 * 发布时间
	 */
	@Column(name = "CREATE_TIME")
	private String createTime;
	//发布单位级别
	@Column(name = "ORGAN_LEVEL")
	private String organLevel;
	
	@Column(name = "TARGETTO")
	private String targetTo ;
	public String getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}
	public String getNoticeType() {
		return noticeType;
	}
	public void setNoticeType(String noticeType) {
		this.noticeType = noticeType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getOrganArea() {
		return organArea;
	}
	public void setOrganArea(String organArea) {
		this.organArea = organArea;
	}
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getTargetTo() {
		return targetTo;
	}
	public void setTargetTo(String targetTo) {
		this.targetTo = targetTo;
	}
	public String getOrganLevel() {
		return organLevel;
	}
	public void setOrganLevel(String organLevel) {
		this.organLevel = organLevel;
	}
}