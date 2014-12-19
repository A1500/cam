package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c30Dao;
import com.inspur.cams.drel.info.data.D204c30;

/**
 * 贵金属dao
 * @author 
 * @date 2014-06-09
 */
public class D204c30Dao extends EntityDao<D204c30> implements ID204c30Dao {
	
	@Override
	public Class<D204c30> getEntityClass() {
		return D204c30.class;
	}

}