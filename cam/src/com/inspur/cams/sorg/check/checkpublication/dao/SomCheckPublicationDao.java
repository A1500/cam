package com.inspur.cams.sorg.check.checkpublication.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkpublication.data.SomCheckPublication;

/**
 * @title:SomCheckPublicationDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public class SomCheckPublicationDao extends EntityDao<SomCheckPublication> implements ISomCheckPublicationDao{

 	public SomCheckPublicationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckPublication.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckPublication");
	}
   
}
