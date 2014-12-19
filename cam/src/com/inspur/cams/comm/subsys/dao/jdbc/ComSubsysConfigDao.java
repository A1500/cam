package com.inspur.cams.comm.subsys.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.subsys.dao.IComSubsysConfigDao;
import com.inspur.cams.comm.subsys.data.ComSubsysConfig;

/**
 * @title:ComSubsysConfigDao
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
 public class ComSubsysConfigDao extends EntityDao<ComSubsysConfig> implements IComSubsysConfigDao{

 	public ComSubsysConfigDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return ComSubsysConfig.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from ComSubsysConfig");
	}
   
}
