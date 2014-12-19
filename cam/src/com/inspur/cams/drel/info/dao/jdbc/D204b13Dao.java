package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204b13Dao;
import com.inspur.cams.drel.info.data.D204b13;

/**
 * 财产性收入dao
 * @author 
 * @date 2014-06-09
 */
public class D204b13Dao extends EntityDao<D204b13> implements ID204b13Dao {
	
	@Override
	public Class<D204b13> getEntityClass() {
		return D204b13.class;
	}

}