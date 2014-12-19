package com.inspur.cams.comm.bbs.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 帖子回复表databean
 * @author 
 * @date Thu Apr 25 01:11:54 GMT 2013
 */
@Table(tableName = "PUB_POST_REPLY", keyFields = "replyId")
public class PubPostReply extends StatefulDatabean {

	// 回复Id
	private String replyId;

	// 帖子Id
	private String postId;

	// 回复人用户名
	private String replyOrganname;

	// 回复人行政区划
	private String replyOrgancode;

	// 回复时间
	private String replyTime;

	// 帖子回复内容
	private String replyContent;

	// 回复状态
	private String status;

	// 帖子楼数
	private String replyNum;

	/**
	 * 获取 回复Id
	 * @return String
	 */
	public String getReplyId() {
		return replyId;
	}

	/**
	 * 设置 回复Id
	 */
	public void setReplyId(String replyId) {
		this.replyId = replyId;
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
	 * 获取 回复人用户名
	 * @return String
	 */
	public String getReplyOrganname() {
		return replyOrganname;
	}

	/**
	 * 设置 回复人用户名
	 */
	public void setReplyOrganname(String replyOrganname) {
		this.replyOrganname = replyOrganname;
	}

	/**
	 * 获取 回复人行政区划
	 * @return String
	 */
	public String getReplyOrgancode() {
		return replyOrgancode;
	}

	/**
	 * 设置 回复人行政区划
	 */
	public void setReplyOrgancode(String replyOrgancode) {
		this.replyOrgancode = replyOrgancode;
	}

	/**
	 * 获取 回复时间
	 * @return String
	 */
	public String getReplyTime() {
		return replyTime;
	}

	/**
	 * 设置 回复时间
	 */
	public void setReplyTime(String replyTime) {
		this.replyTime = replyTime;
	}

	/**
	 * 获取 帖子回复内容
	 * @return String
	 */
	public String getReplyContent() {
		return replyContent;
	}

	/**
	 * 设置 帖子回复内容
	 */
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	/**
	 * 获取 回复状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 回复状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 获取 帖子楼数
	 * @return String
	 */
	public String getReplyNum() {
		return replyNum;
	}

	/**
	 * 设置 帖子楼数
	 */
	public void setReplyNum(String replyNum) {
		this.replyNum = replyNum;
	}

}