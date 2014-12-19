package com.inspur.cams.sorg.check.balancesheet.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet;

/**
 * @title:SomCheckBalanceSheetDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public class SomCheckBalanceSheetDao extends EntityDao<SomCheckBalanceSheet> implements ISomCheckBalanceSheetDao{

 	public SomCheckBalanceSheetDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckBalanceSheet.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckBalanceSheet");
	}
   
}
