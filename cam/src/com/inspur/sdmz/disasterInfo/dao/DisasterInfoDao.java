package com.inspur.sdmz.disasterInfo.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:DisasterInfoDao
 * @description:
 * @author:
 * @since:2011-09-13
 * @version:1.0
*/
 public class DisasterInfoDao extends EntityDao<DisasterInfo> implements IDisasterInfoDao{

 	public DisasterInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return DisasterInfo.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from DisasterInfo");
	}
   
}
