package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.marry.base.dao.IMrmCatalogDao;
import com.inspur.cams.marry.base.data.MrmCatalog;

/**
 * 婚姻档案目录树dao实现类
 */
public class MrmCatalogDao extends EntityDao<MrmCatalog> implements
		IMrmCatalogDao {

	@Override
	public Class<MrmCatalog> getEntityClass() {
		return MrmCatalog.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from MrmCatalog");
	}

}
