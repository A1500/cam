package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.base.dao.IFisGlobalConfigDao;
import com.inspur.cams.fis.base.data.FisGlobalConfig;

/**
 * @title:FisGlobalConfigDao
 * @description:
 * @author:
 * @since:2011-12-15
 * @version:1.0
*/
 public class FisGlobalConfigDao extends EntityDao<FisGlobalConfig> implements IFisGlobalConfigDao{

 	public FisGlobalConfigDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisGlobalConfig.class;
	}
   public void deleteAllTable() {
		executeUpdate("delete from FIS_GLOBAL_CONFIG");
	}
}
