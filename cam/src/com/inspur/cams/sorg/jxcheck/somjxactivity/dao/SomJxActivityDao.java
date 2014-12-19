package com.inspur.cams.sorg.jxcheck.somjxactivity.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxActivityDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxActivityDao extends EntityDao<SomJxActivity> implements ISomJxActivityDao{

 	public SomJxActivityDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxActivity.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxActivity");
	}
   
}
