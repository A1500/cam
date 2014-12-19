package com.inspur.cams.drel.info.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.info.dao.ID204z57Dao;
import com.inspur.cams.drel.info.data.D204z57;

/**
 * 财政供养人员工资信息dao
 * @author 
 * @date 2014-06-09
 */
public class D204z57Dao extends EntityDao<D204z57> implements ID204z57Dao {
	
	@Override
	public Class<D204z57> getEntityClass() {
		return D204z57.class;
	}

}