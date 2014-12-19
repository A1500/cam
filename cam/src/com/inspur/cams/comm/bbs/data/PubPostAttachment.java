package com.inspur.cams.comm.bbs.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * 帖子附件表databean
 * @author 
 * @date Fri Apr 26 08:57:51 GMT 2013
 */
@Table(tableName = "PUB_POST_ATTACHMENT", keyFields = "attachId")
public class PubPostAttachment extends StatefulDatabean {

	// 附件Id
	private String attachId;

	// 帖子Id
	private String postId;

	// 附件名称
	private String attachName;

	// 附件内容
	private UploadFile attachContent;

	// 上传人行政区划
	private String attachPeopleCode;

	// 上传人行政区划名称
	private String attachPeopleName;

	// 上传时间
	private String attachTime;

	/**
	 * 获取 附件Id
	 * @return String
	 */
	public String getAttachId() {
		return attachId;
	}

	/**
	 * 设置 附件Id
	 */
	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}

	/**
	 * 获取 帖子Id
	 * @return String
	 */
	public String getPostId() {
		return postId;
	}

	/**
	 * 设置 帖子Id
	 */
	public void setPostId(String postId) {
		this.postId = postId;
	}

	/**
	 * 获取 附件名称
	 * @return String
	 */
	public String getAttachName() {
		return attachName;
	}

	/**
	 * 设置 附件名称
	 */
	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}


	/**
	 * 获取 附件内容
	 * @return Blob
	 */
	public UploadFile getAttachContent() {
		return attachContent;
	}

	/**
	 * 设置 附件内容
	 */
	public void setAttachContent (UploadFile attachContent) {
		this.attachContent = attachContent;
	}

	/**
	 * 获取 上传人行政区划
	 * @return String
	 */
	public String getAttachPeopleCode() {
		return attachPeopleCode;
	}

	/**
	 * 设置 上传人行政区划
	 */
	public void setAttachPeopleCode(String attachPeopleCode) {
		this.attachPeopleCode = attachPeopleCode;
	}

	/**
	 * 获取 上传人行政区划名称
	 * @return String
	 */
	public String getAttachPeopleName() {
		return attachPeopleName;
	}

	/**
	 * 设置 上传人行政区划名称
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