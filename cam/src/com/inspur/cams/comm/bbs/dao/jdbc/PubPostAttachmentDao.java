package com.inspur.cams.comm.bbs.dao.jdbc;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.bbs.dao.IPubPostAttachmentDao;
import com.inspur.cams.comm.bbs.data.PubPostAttachment;

/**
 * 帖子附件表dao
 * @author 
 * @date Fri Apr 26 08:57:51 GMT 2013
 */
public class PubPostAttachmentDao extends EntityDao<PubPostAttachment> implements IPubPostAttachmentDao {
	
	public static final String SELECT_PID_COM_TZTG_FJ_BY_TZTG="SELECT ATTACH_ID,ATTACH_NAME FROM PUB_POST_ATTACHMENT WHERE POST_ID=?";
	@Override
	public Class<PubPostAttachment> getEntityClass() {
		return PubPostAttachment.class;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> queryAttachByPostId(String tztg) {
		return executeQuery(SELECT_PID_COM_TZTG_FJ_BY_TZTG,new int[]{Types.VARCHAR},new Object[]{tztg});
	}

}