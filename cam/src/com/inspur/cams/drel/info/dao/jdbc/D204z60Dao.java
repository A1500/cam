package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z60Dao;
import com.inspur.cams.drel.info.data.D204z60;

/**
 * 第三方支付信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z60Dao extends EntityDao<D204z60> implements ID204z60Dao {
	
	@Override
	public Class<D204z60> getEntityClass() {
		return D204z60.class;
	}

}