package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z55Dao;
import com.inspur.cams.drel.info.data.D204z55;

/**
 * 优待抚恤信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z55Dao extends EntityDao<D204z55> implements ID204z55Dao {
	
	@Override
	public Class<D204z55> getEntityClass() {
		return D204z55.class;
	}

}