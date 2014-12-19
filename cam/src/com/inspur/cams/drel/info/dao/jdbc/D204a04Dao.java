package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204a04Dao;
import com.inspur.cams.drel.info.data.D204a04;

/**
 * 区划信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204a04Dao extends EntityDao<D204a04> implements ID204a04Dao {
	
	@Override
	public Class<D204a04> getEntityClass() {
		return D204a04.class;
	}

}