package com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckFlowDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckFlowDao extends EntityDao<SomJxCheckFlow> implements ISomJxCheckFlowDao{

 	public SomJxCheckFlowDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckFlow.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckFlow");
	}
   
}
