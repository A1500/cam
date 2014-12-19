package com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCommonwealOutputDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCommonwealOutputDao extends EntityDao<SomJxCommonwealOutput> implements ISomJxCommonwealOutputDao{

 	public SomJxCommonwealOutputDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCommonwealOutput.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCommonwealOutput");
	}
   
}
