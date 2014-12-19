package com.inspur.cams.sorg.check.checksystems.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.checksystems.data.SomCheckSystems;

/**
 * @title:内部制度建设情况dao
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
 */
public class SomCheckSystemsDao extends EntityDao<SomCheckSystems> implements
		ISomCheckSystemsDao {

	public SomCheckSystemsDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return SomCheckSystems.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomCheckSystems");
	}

}
