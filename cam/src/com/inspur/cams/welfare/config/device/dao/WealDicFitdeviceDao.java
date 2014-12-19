package com.inspur.cams.welfare.config.device.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

/**
 * @title:WealDicFitdeviceDao
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
 public class WealDicFitdeviceDao extends EntityDao<WealDicFitdevice> implements IWealDicFitdeviceDao{

 	public WealDicFitdeviceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealDicFitdevice.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealDicFitdevice");
	}
   
}
