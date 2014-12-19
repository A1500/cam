package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204d31Dao;
import com.inspur.cams.drel.info.data.D204d31;

/**
 * 公共事业缴费dao
 * @author 
 * @date 2014-06-09
 */
public class D204d31Dao extends EntityDao<D204d31> implements ID204d31Dao {
	
	@Override
	public Class<D204d31> getEntityClass() {
		return D204d31.class;
	}

}