package com.inspur.cams.sorg.check.checktask.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.checktask.data.SomCheckTask;

/**
 * @title:SomCheckTaskDao
 * @description:
 * @author:
 * @since:2011-12-28
 * @version:1.0
*/
 public class SomCheckTaskDao extends EntityDao<SomCheckTask> implements ISomCheckTaskDao{

 	public SomCheckTaskDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckTask.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckTask");
	}
   
}
