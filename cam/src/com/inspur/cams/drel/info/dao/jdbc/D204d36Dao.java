package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204d36Dao;
import com.inspur.cams.drel.info.data.D204d36;

/**
 * 大额支出dao
 * @author 
 * @date 2014-06-09
 */
public class D204d36Dao extends EntityDao<D204d36> implements ID204d36Dao {
	
	@Override
	public Class<D204d36> getEntityClass() {
		return D204d36.class;
	}

}