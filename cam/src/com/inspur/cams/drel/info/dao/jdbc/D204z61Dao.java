package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z61Dao;
import com.inspur.cams.drel.info.data.D204z61;

/**
 * 船舶信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z61Dao extends EntityDao<D204z61> implements ID204z61Dao {
	
	@Override
	public Class<D204z61> getEntityClass() {
		return D204z61.class;
	}

}