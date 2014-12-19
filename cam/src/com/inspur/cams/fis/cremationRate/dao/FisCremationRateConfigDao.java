package com.inspur.cams.fis.cremationRate.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.cremationRate.data.FisCremationRateConfig;

/**
 * @title:FisCremationRateConfigDao
 * @description:
 * @author:
 * @since:2012-11-16
 * @version:1.0
*/
 public class FisCremationRateConfigDao extends EntityDao<FisCremationRateConfig> implements IFisCremationRateConfigDao{

 	public FisCremationRateConfigDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisCremationRateConfig.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from FisCremationRateConfig");
	}
   
}
