package com.inspur.cams.comm.message.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * 首页消息框上传附件表databean
 * @author 
 * @date 2014-02-14
 */
@Table(tableName = "COM_MESSAGE_ATTACHMENT", keyFields = "attachmentId")
public class ComMessageAttachment extends StatefulDatabean {

	// 附件ID
	private String attachmentId;

	// 消息ID
	private String messageId;

	// 文件名称
	private String fileName;

	// 上传文件
	private UploadFile fileContent;

	/**
	 * 获取 附件ID
	 * @return String
	 */
	public String getAttachmentId() {
		return attachmentId;
	}

	/**
	 * 设置 附件ID
	 */
	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	/**
	 * 获取 消息ID
	 * @return String
	 */
	public String getMessageId() {
		return messageId;
	}

	/**
	 * 设置 消息ID
	 */
	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}

	/**
	 * 获取 文件名称
	 * @return String
	 */
	public String getFileName() {
		return fileName;
	}

	/**
	 * 设置 文件名称
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * 获取 上传文件
	 * @return Blob
	 */
	public UploadFile getFileContent() {
		return fileContent;
	}

	/**
	 * 设置 上传文件
	 */
	public void setFileContent (UploadFile fileContent) {
		this.fileContent = fileContent;
	}

}