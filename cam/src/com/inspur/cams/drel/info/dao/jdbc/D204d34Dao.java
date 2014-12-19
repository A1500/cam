package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204d34Dao;
import com.inspur.cams.drel.info.data.D204d34;

/**
 * 公积金缴纳情况dao
 * @author 
 * @date 2014-06-09
 */
public class D204d34Dao extends EntityDao<D204d34> implements ID204d34Dao {
	
	@Override
	public Class<D204d34> getEntityClass() {
		return D204d34.class;
	}

}