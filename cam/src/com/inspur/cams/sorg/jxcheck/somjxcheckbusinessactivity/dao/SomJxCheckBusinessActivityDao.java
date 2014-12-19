package com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckBusinessActivityDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckBusinessActivityDao extends EntityDao<SomJxCheckBusinessActivity> implements ISomJxCheckBusinessActivityDao{

 	public SomJxCheckBusinessActivityDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckBusinessActivity.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckBusinessActivity");
	}
   
}
