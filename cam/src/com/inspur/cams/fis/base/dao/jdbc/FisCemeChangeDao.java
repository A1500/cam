package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisCemeChangeDao;
import com.inspur.cams.fis.base.data.FisCemeChange;

/**
 * 公墓信息变更备案表dao
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeDao extends EntityDao<FisCemeChange> implements IFisCemeChangeDao {
	
	@Override
	public Class<FisCemeChange> getEntityClass() {
		return FisCemeChange.class;
	}

}