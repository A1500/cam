package com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckFinanceDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckFinanceDao extends EntityDao<SomJxCheckFinance> implements ISomJxCheckFinanceDao{

 	public SomJxCheckFinanceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckFinance.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckFinance");
	}
   
}
