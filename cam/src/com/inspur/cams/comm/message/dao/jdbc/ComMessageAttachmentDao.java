package com.inspur.cams.comm.message.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.message.dao.IComMessageAttachmentDao;
import com.inspur.cams.comm.message.data.ComMessageAttachment;

/**
 * 首页消息框上传附件表dao
 * @author 
 * @date 2014-02-14
 */
public class ComMessageAttachmentDao extends EntityDao<ComMessageAttachment> implements IComMessageAttachmentDao {
	
	@Override
	public Class<ComMessageAttachment> getEntityClass() {
		return ComMessageAttachment.class;
	}

	public void deleteByMessageId(String messageId){
		String sql = null;
		sql="DELETE FROM COM_MESSAGE_ATTACHMENT A WHERE A.MESSAGE_ID =?";
		executeUpdate(sql,new int[]{Types.VARCHAR},new Object[]{messageId});
	}
}