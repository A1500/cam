package com.inspur.cams.comm.bbs.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 帖子表databean
 * @author 
 * @date Thu Apr 25 01:05:26 GMT 2013
 */
@Table(tableName = "PUB_POST", keyFields = "postId")
public class PubPost extends StatefulDatabean {

	// 帖子Id
	private String postId;

	// 帖子标题
	private String subject;

	// 发帖人用户名
	private String postOrganname;

	// 发帖人行政区划
	private String postOrgancode;

	// 发帖时间
	private String postTime;

	// 板块ID
	private String boardId;

	// 帖子内容
	private String postContent;

	// 回复数量
	private String replyAmount;

	// 最后回复用户名称
	private String lastReplyOrganname;

	// 最后回复用户行政区划
	private String lastReplyOrgancode;

	// 最后回复时间
	private String lastReplyTime;

	// 帖子状态
	private String status;

	// 是否置顶
	private String ifTop;

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
	 * 获取 帖子标题
	 * @return String
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * 设置 帖子标题
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * 获取 发帖人用户名
	 * @return String
	 */
	public String getPostOrganname() {
		return postOrganname;
	}

	/**
	 * 设置 发帖人用户名
	 */
	public void setPostOrganname(String postOrganname) {
		this.postOrganname = postOrganname;
	}

	/**
	 * 获取 发帖人行政区划
	 * @return String
	 */
	public String getPostOrgancode() {
		return postOrgancode;
	}

	/**
	 * 设置 发帖人行政区划
	 */
	public void setPostOrgancode(String postOrgancode) {
		this.postOrgancode = postOrgancode;
	}

	/**
	 * 获取 发帖时间
	 * @return String
	 */
	public String getPostTime() {
		return postTime;
	}

	/**
	 * 设置 发帖时间
	 */
	public void setPostTime(String postTime) {
		this.postTime = postTime;
	}

	/**
	 * 获取 板块ID
	 * @return String
	 */
	public String getBoardId() {
		return boardId;
	}

	/**
	 * 设置 板块ID
	 */
	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}

	/**
	 * 获取 帖子内容
	 * @return String
	 */
	public String getPostContent() {
		return postContent;
	}

	/**
	 * 设置 帖子内容
	 */
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	/**
	 * 获取 回复数量
	 * @return String
	 */
	public String getReplyAmount() {
		return replyAmount;
	}

	/**
	 * 设置 回复数量
	 */
	public void setReplyAmount(String replyAmount) {
		this.replyAmount = replyAmount;
	}

	/**
	 * 获取 最后回复用户名称
	 * @return String
	 */
	public String getLastReplyOrganname() {
		return lastReplyOrganname;
	}

	/**
	 * 设置 最后回复用户名称
	 */
	public void setLastReplyOrganname(String lastReplyOrganname) {
		this.lastReplyOrganname = lastReplyOrganname;
	}

	/**
	 * 获取 最后回复用户行政区划
	 * @return String
	 */
	public String getLastReplyOrgancode() {
		return lastReplyOrgancode;
	}

	/**
	 * 设置 最后回复用户行政区划
	 */
	public void setLastReplyOrgancode(String lastReplyOrgancode) {
		this.lastReplyOrgancode = lastReplyOrgancode;
	}

	/**
	 * 获取 最后回复时间
	 * @return String
	 */
	public String getLastReplyTime() {
		return lastReplyTime;
	}

	/**
	 * 设置 最后回复时间
	 */
	public void setLastReplyTime(String lastReplyTime) {
		this.lastReplyTime = lastReplyTime;
	}

	/**
	 * 获取 帖子状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 帖子状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 获取 是否置顶
	 * @return String
	 */
	public String getIfTop() {
		return ifTop;
	}

	/**
	 * 设置 是否置顶
	 */
	public void setIfTop(String ifTop) {
		this.ifTop = ifTop;
	}

}