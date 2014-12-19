package com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckExpenditureDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckExpenditureDao extends EntityDao<SomJxCheckExpenditure> implements ISomJxCheckExpenditureDao{

 	public SomJxCheckExpenditureDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckExpenditure.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckExpenditure");
	}
   
}
