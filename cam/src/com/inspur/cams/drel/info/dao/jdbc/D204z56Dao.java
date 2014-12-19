package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z56Dao;
import com.inspur.cams.drel.info.data.D204z56;

/**
 * 核对统计信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z56Dao extends EntityDao<D204z56> implements ID204z56Dao {
	
	@Override
	public Class<D204z56> getEntityClass() {
		return D204z56.class;
	}

}