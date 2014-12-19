package com.inspur.cams.welfare.config.economic.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:WealDicEconomicnatureDao
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
 public class WealDicEconomicnatureDao extends EntityDao<WealDicEconomicnature> implements IWealDicEconomicnatureDao{

 	public WealDicEconomicnatureDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealDicEconomicnature.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealDicEconomicnature");
	}
   
}
