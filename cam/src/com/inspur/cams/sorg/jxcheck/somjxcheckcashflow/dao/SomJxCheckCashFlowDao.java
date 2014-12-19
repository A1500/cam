package com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckCashFlowDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckCashFlowDao extends EntityDao<SomJxCheckCashFlow> implements ISomJxCheckCashFlowDao{

 	public SomJxCheckCashFlowDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckCashFlow.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckCashFlow");
	}
   
}
