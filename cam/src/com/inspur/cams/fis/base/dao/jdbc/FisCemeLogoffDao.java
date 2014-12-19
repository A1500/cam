package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisCemeLogoffDao;
import com.inspur.cams.fis.base.data.FisCemeLogoff;

/**
 * 公墓撤销备案表dao
 * @author 
 * @date 2013-08-01
 */
public class FisCemeLogoffDao extends EntityDao<FisCemeLogoff> implements IFisCemeLogoffDao {
	
	@Override
	public Class<FisCemeLogoff> getEntityClass() {
		return FisCemeLogoff.class;
	}

}