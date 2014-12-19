package com.inspur.cams.comm.bbs.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.bbs.data.PubPost;

/**
 * 帖子表dao
 * @author 
 * @date Thu Apr 25 01:05:26 GMT 2013
 */
public interface IPubPostDao extends BaseCURD<PubPost> {
	
	public void updateNum(String postId);
}