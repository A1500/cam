package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204a00Dao;
import com.inspur.cams.drel.info.data.D204a00;

/**
 * 核对总体情况dao
 * @author 
 * @date 2014-06-09
 */
public class D204a00Dao extends EntityDao<D204a00> implements ID204a00Dao {
	
	@Override
	public Class<D204a00> getEntityClass() {
		return D204a00.class;
	}

}