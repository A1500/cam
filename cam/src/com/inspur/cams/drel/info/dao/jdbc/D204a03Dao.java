package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204a03Dao;
import com.inspur.cams.drel.info.data.D204a03;

/**
 * 家庭基本信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204a03Dao extends EntityDao<D204a03> implements ID204a03Dao {
	
	@Override
	public Class<D204a03> getEntityClass() {
		return D204a03.class;
	}

}