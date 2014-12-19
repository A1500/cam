package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z53Dao;
import com.inspur.cams.drel.info.data.D204z53;

/**
 * 司法援助信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z53Dao extends EntityDao<D204z53> implements ID204z53Dao {
	
	@Override
	public Class<D204z53> getEntityClass() {
		return D204z53.class;
	}

}