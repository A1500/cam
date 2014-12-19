package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c26Dao;
import com.inspur.cams.drel.info.data.D204c26;

/**
 * 商业保险dao
 * @author 
 * @date 2014-06-09
 */
public class D204c26Dao extends EntityDao<D204c26> implements ID204c26Dao {
	
	@Override
	public Class<D204c26> getEntityClass() {
		return D204c26.class;
	}

}