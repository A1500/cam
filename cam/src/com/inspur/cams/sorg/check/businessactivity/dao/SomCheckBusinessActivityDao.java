package com.inspur.cams.sorg.check.businessactivity.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity;

/**
 * @title:SomCheckBusinessActivityDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public class SomCheckBusinessActivityDao extends EntityDao<SomCheckBusinessActivity> implements ISomCheckBusinessActivityDao{

 	public SomCheckBusinessActivityDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckBusinessActivity.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckBusinessActivity");
	}
   
}
