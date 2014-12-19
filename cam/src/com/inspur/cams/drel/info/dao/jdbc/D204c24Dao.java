package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c24Dao;
import com.inspur.cams.drel.info.data.D204c24;

/**
 * 股票dao
 * @author 
 * @date 2014-06-09
 */
public class D204c24Dao extends EntityDao<D204c24> implements ID204c24Dao {
	
	@Override
	public Class<D204c24> getEntityClass() {
		return D204c24.class;
	}

}