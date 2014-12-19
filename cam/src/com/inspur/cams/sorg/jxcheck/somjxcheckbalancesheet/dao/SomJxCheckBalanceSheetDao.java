package com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckBalanceSheetDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckBalanceSheetDao extends EntityDao<SomJxCheckBalanceSheet> implements ISomJxCheckBalanceSheetDao{

 	public SomJxCheckBalanceSheetDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckBalanceSheet.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckBalanceSheet");
	}
   
}
