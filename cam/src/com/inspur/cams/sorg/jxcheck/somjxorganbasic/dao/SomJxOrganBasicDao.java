package com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxOrganBasicDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxOrganBasicDao extends EntityDao<SomJxOrganBasic> implements ISomJxOrganBasicDao{

 	public SomJxOrganBasicDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxOrganBasic.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxOrganBasic");
	}
   
}
