package com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckSystemsDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckSystemsDao extends EntityDao<SomJxCheckSystems> implements ISomJxCheckSystemsDao{

 	public SomJxCheckSystemsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckSystems.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckSystems");
	}
   
}
