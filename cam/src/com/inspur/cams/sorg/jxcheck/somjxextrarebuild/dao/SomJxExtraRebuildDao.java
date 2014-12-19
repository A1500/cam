package com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxExtraRebuildDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxExtraRebuildDao extends EntityDao<SomJxExtraRebuild> implements ISomJxExtraRebuildDao{

 	public SomJxExtraRebuildDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxExtraRebuild.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxExtraRebuild");
	}
   
}
