package com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckEvaluateDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckEvaluateDao extends EntityDao<SomJxCheckEvaluate> implements ISomJxCheckEvaluateDao{

 	public SomJxCheckEvaluateDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckEvaluate.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckEvaluate");
	}
   
}
