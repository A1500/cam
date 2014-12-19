package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c29Dao;
import com.inspur.cams.drel.info.data.D204c29;

/**
 * 理财dao
 * @author 
 * @date 2014-06-09
 */
public class D204c29Dao extends EntityDao<D204c29> implements ID204c29Dao {
	
	@Override
	public Class<D204c29> getEntityClass() {
		return D204c29.class;
	}

}