package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204d38Dao;
import com.inspur.cams.drel.info.data.D204d38;

/**
 * 地税-个人所得税dao
 * @author 
 * @date 2014-08-26
 */
public class D204d38Dao extends EntityDao<D204d38> implements ID204d38Dao {
	
	@Override
	public Class<D204d38> getEntityClass() {
		return D204d38.class;
	}

}