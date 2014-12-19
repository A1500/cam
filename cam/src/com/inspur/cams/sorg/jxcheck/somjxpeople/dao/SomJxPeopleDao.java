package com.inspur.cams.sorg.jxcheck.somjxpeople.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxPeopleDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxPeopleDao extends EntityDao<SomJxPeople> implements ISomJxPeopleDao{

 	public SomJxPeopleDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxPeople.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxPeople");
	}
   
}
