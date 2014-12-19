package com.inspur.cams.comm.bbs.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.bbs.dao.IPubPostDao;
import com.inspur.cams.comm.bbs.data.PubPost;

/**
 * 帖子表dao
 * @author 
 * @date Thu Apr 25 01:05:26 GMT 2013
 */
public class PubPostDao extends EntityDao<PubPost> implements IPubPostDao {
	
	@Override
	public Class<PubPost> getEntityClass() {
		return PubPost.class;
	}

	public void updateNum(String postId) {
		StringBuffer sql = new StringBuffer();
		
		sql.append(" UPDATE PUB_POST a SET a.REPLY_AMOUNT=( ");
		sql.append(" SELECT COUNT(T.POST_ID) FROM PUB_POST_REPLY T WHERE T.POST_ID='"+postId+"')-1 ");
		sql.append(" WHERE  a.POST_ID ='"+postId+"'  ");
		this.executeUpdate(sql.toString());
	}
}