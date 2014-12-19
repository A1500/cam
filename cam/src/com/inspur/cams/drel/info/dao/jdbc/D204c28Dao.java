package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c28Dao;
import com.inspur.cams.drel.info.data.D204c28;

/**
 * 期货dao
 * @author 
 * @date 2014-06-09
 */
public class D204c28Dao extends EntityDao<D204c28> implements ID204c28Dao {
	
	@Override
	public Class<D204c28> getEntityClass() {
		return D204c28.class;
	}

}