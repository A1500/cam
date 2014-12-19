package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204d39Dao;
import com.inspur.cams.drel.info.data.D204d39;

/**
 * 地税-投资方纳税信息dao
 * @author 
 * @date 2014-08-26
 */
public class D204d39Dao extends EntityDao<D204d39> implements ID204d39Dao {
	
	@Override
	public Class<D204d39> getEntityClass() {
		return D204d39.class;
	}

}