package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204b14Dao;
import com.inspur.cams.drel.info.data.D204b14;

/**
 * 转移性收入dao
 * @author 
 * @date 2014-06-09
 */
public class D204b14Dao extends EntityDao<D204b14> implements ID204b14Dao {
	
	@Override
	public Class<D204b14> getEntityClass() {
		return D204b14.class;
	}

}