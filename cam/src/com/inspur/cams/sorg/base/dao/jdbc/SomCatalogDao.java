package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomCatalogDao;
import com.inspur.cams.sorg.base.data.SomCatalog;

/**
 * 社会组织档案目录树dao实现类
 * @author Muqi
 * @date 2011-7-21
 */
public class SomCatalogDao extends EntityDao<SomCatalog> implements
		ISomCatalogDao {

	@Override
	public Class<SomCatalog> getEntityClass() {
		return SomCatalog.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomCatalog");
	}

}
