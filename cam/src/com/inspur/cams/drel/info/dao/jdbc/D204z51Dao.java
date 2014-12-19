package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z51Dao;
import com.inspur.cams.drel.info.data.D204z51;

/**
 * 教育信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z51Dao extends EntityDao<D204z51> implements ID204z51Dao {
	
	@Override
	public Class<D204z51> getEntityClass() {
		return D204z51.class;
	}

}