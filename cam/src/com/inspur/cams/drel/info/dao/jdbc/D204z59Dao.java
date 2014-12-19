package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z59Dao;
import com.inspur.cams.drel.info.data.D204z59;

/**
 * 新农合信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z59Dao extends EntityDao<D204z59> implements ID204z59Dao {
	
	@Override
	public Class<D204z59> getEntityClass() {
		return D204z59.class;
	}

}