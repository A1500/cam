package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204b11Dao;
import com.inspur.cams.drel.info.data.D204b11;

/**
 * 工资性收入dao
 * @author 
 * @date 2014-06-09
 */
public class D204b11Dao extends EntityDao<D204b11> implements ID204b11Dao {
	
	@Override
	public Class<D204b11> getEntityClass() {
		return D204b11.class;
	}

}