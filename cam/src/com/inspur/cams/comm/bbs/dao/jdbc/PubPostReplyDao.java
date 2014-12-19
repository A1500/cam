package com.inspur.cams.comm.bbs.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.bbs.dao.IPubPostReplyDao;
import com.inspur.cams.comm.bbs.data.PubPostReply;

/**
 * 帖子回复表dao
 * @author 
 * @date Thu Apr 25 01:11:54 GMT 2013
 */
public class PubPostReplyDao extends EntityDao<PubPostReply> implements IPubPostReplyDao {
	
	@Override
	public Class<PubPostReply> getEntityClass() {
		return PubPostReply.class;
	}
	
	public void updateReplyByPostId(String postId) {
		StringBuffer sql = new StringBuffer();
		
		sql.append(" UPDATE PUB_POST_REPLY a SET a.STATUS='2' ");
		sql.append(" WHERE  a.POST_ID ='"+postId+"'  ");
		this.executeUpdate(sql.toString());
	}

}