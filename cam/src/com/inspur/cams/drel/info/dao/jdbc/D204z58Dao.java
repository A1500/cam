package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z58Dao;
import com.inspur.cams.drel.info.data.D204z58;

/**
 * 涉农信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z58Dao extends EntityDao<D204z58> implements ID204z58Dao {
	
	@Override
	public Class<D204z58> getEntityClass() {
		return D204z58.class;
	}

}