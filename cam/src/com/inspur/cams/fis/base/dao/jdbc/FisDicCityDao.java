package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.base.dao.IFisDicCityDao;
import com.inspur.cams.fis.base.data.FisDicCity;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisDicCityDao  
 * @Description: TODO 
 * @author jiangzhaobao
 * @date 2011-11-15
 */
 public class FisDicCityDao extends EntityDao<FisDicCity> implements IFisDicCityDao{

 	public FisDicCityDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisDicCity.class;
	}
   
}
