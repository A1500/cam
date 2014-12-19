package com.inspur.cams.sorg.check.checkdues.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkdues.data.SomCheckDues;

/**
 * @title:SomCheckDuesDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public class SomCheckDuesDao extends EntityDao<SomCheckDues> implements ISomCheckDuesDao{

 	public SomCheckDuesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckDues.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckDues");
	}
   
}
