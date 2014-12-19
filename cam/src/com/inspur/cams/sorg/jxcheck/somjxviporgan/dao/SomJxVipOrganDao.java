package com.inspur.cams.sorg.jxcheck.somjxviporgan.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxVipOrganDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxVipOrganDao extends EntityDao<SomJxVipOrgan> implements ISomJxVipOrganDao{

 	public SomJxVipOrganDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxVipOrgan.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxVipOrgan");
	}
   
}
