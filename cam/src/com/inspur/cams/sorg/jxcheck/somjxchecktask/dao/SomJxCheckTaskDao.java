package com.inspur.cams.sorg.jxcheck.somjxchecktask.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckTaskDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckTaskDao extends EntityDao<SomJxCheckTask> implements ISomJxCheckTaskDao{

 	public SomJxCheckTaskDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckTask.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckTask");
	}
   
}
