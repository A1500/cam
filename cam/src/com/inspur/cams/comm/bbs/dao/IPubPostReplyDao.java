package com.inspur.cams.comm.bbs.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.bbs.data.PubPostReply;

/**
 * 帖子回复表dao
 * @author 
 * @date Thu Apr 25 01:11:54 GMT 2013
 */
public interface IPubPostReplyDao extends BaseCURD<PubPostReply> {
	
	public void updateReplyByPostId(String postId);
}