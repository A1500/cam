package com.inspur.cams.sorg.check.somcheckevaluate.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckEvaluateDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckEvaluateDao extends EntityDao<SomCheckEvaluate> implements ISomCheckEvaluateDao{

 	public SomCheckEvaluateDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckEvaluate.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckEvaluate");
	}
   
}
