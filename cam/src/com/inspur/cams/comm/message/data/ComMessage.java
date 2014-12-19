package com.inspur.cams.comm.message.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 首页消息框databean
 * @author 
 * @date 2014-02-14
 */
@Table(tableName = "COM_MESSAGE", keyFields = "messageId")
public class ComMessage extends StatefulDatabean {

	// 消息ID
	private String messageId;

	// 消息名称
	private String messageTitle;

	// 消息正文
	private String messageContents;

	// 消息发布时间
	private String messageTime;

	// 是否显示
	private String ifShow;

	// 顺序号
	private String serialNum;
	
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
	 * 获取 消息名称
	 * @return String
	 */
	public String getMessageTitle() {
		return messageTitle;
	}

	/**
	 * 设置 消息名称
	 */
	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}

	/**
	 * 获取 消息正文
	 * @return String
	 */
	public String getMessageContents() {
		return messageContents;
	}

	/**
	 * 设置 消息正文
	 */
	public void setMessageContents(String messageContents) {
		this.messageContents = messageContents;
	}

	/**
	 * 获取 消息发布时间
	 * @return String
	 */
	public String getMessageTime() {
		return messageTime;
	}

	/**
	 * 设置 消息发布时间
	 */
	public void setMessageTime(String messageTime) {
		this.messageTime = messageTime;
	}

	/**
	 * 获取 是否显示
	 * @return String
	 */
	public String getIfShow() {
		return ifShow;
	}

	/**
	 * 设置 是否显示
	 */
	public void setIfShow(String ifShow) {
		this.ifShow = ifShow;
	}

	public String getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
}