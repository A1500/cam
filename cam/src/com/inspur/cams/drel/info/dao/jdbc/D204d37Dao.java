package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204d37Dao;
import com.inspur.cams.drel.info.data.D204d37;

/**
 * 地税-法人纳税信息dao
 * @author 
 * @date 2014-08-26
 */
public class D204d37Dao extends EntityDao<D204d37> implements ID204d37Dao {
	
	@Override
	public Class<D204d37> getEntityClass() {
		return D204d37.class;
	}

}