package com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxDiscriplineIntegrityDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxDiscriplineIntegrityDao extends EntityDao<SomJxDiscriplineIntegrity> implements ISomJxDiscriplineIntegrityDao{

 	public SomJxDiscriplineIntegrityDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxDiscriplineIntegrity.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxDiscriplineIntegrity");
	}
   
}
