package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z52Dao;
import com.inspur.cams.drel.info.data.D204z52;

/**
 * 救助信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z52Dao extends EntityDao<D204z52> implements ID204z52Dao {
	
	@Override
	public Class<D204z52> getEntityClass() {
		return D204z52.class;
	}

}