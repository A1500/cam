package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204d35Dao;
import com.inspur.cams.drel.info.data.D204d35;

/**
 * 大病支出dao
 * @author 
 * @date 2014-06-09
 */
public class D204d35Dao extends EntityDao<D204d35> implements ID204d35Dao {
	
	@Override
	public Class<D204d35> getEntityClass() {
		return D204d35.class;
	}

}