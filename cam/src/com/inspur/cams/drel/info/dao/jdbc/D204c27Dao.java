package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c27Dao;
import com.inspur.cams.drel.info.data.D204c27;

/**
 * 券商dao
 * @author 
 * @date 2014-06-09
 */
public class D204c27Dao extends EntityDao<D204c27> implements ID204c27Dao {
	
	@Override
	public Class<D204c27> getEntityClass() {
		return D204c27.class;
	}

}