package com.inspur.cams.comm.userExt.dao;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.userExt.data.PubUsersExt;
 
/**
 * @author licb
 * @date:2011-10-27 上午08:52:07
 * @version :
 * UserExtDao.java 
 */
public class PubUsersExtDao extends EntityDao<PubUsersExt> {
	@Override
	protected Class getEntityClass() {
		return PubUsersExt.class;
	}
}

 
