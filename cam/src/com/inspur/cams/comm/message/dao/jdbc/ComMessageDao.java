package com.inspur.cams.comm.message.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import com.inspur.cams.comm.message.dao.IComMessageDao;
import com.inspur.cams.comm.message.data.ComMessage;

/**
 * 首页消息框dao
 * @author 
 * @date 2014-02-14
 */
public class ComMessageDao extends EntityDao<ComMessage> implements IComMessageDao {
	
	@Override
	public Class<ComMessage> getEntityClass() {
		return ComMessage.class;
	}

}