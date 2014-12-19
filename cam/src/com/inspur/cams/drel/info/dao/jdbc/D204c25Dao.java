package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204c25Dao;
import com.inspur.cams.drel.info.data.D204c25;

/**
 * 基金dao
 * @author 
 * @date 2014-06-09
 */
public class D204c25Dao extends EntityDao<D204c25> implements ID204c25Dao {
	
	@Override
	public Class<D204c25> getEntityClass() {
		return D204c25.class;
	}

}