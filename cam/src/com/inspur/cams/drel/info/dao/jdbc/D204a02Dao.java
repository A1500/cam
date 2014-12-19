package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204a02Dao;
import com.inspur.cams.drel.info.data.D204a02;

/**
 * 家庭成员就业信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204a02Dao extends EntityDao<D204a02> implements ID204a02Dao {
	
	@Override
	public Class<D204a02> getEntityClass() {
		return D204a02.class;
	}

}