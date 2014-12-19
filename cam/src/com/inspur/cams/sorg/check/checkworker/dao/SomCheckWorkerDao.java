package com.inspur.cams.sorg.check.checkworker.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkworker.data.SomCheckWorker;

/**
 * @title:SomCheckWorkerDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public class SomCheckWorkerDao extends EntityDao<SomCheckWorker> implements ISomCheckWorkerDao{

 	public SomCheckWorkerDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckWorker.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckWorker");
	}
   
}
