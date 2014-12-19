package com.inspur.cams.sorg.check.somcheckexpenditure.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckExpenditureDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckExpenditureDao extends EntityDao<SomCheckExpenditure> implements ISomCheckExpenditureDao{

 	public SomCheckExpenditureDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckExpenditure.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckExpenditure");
	}
   
}
