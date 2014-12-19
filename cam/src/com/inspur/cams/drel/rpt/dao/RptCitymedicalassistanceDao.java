package com.inspur.cams.drel.rpt.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.rpt.data.RptCitymedicalassistance;

/**
 * @title:RptCitymedicalassistanceDao
 * @description:城市医疗救助工作情况Dao实现类
 * @author:fujw
 * @since:2011-06-14
 * @version:1.0
*/
 public class RptCitymedicalassistanceDao extends EntityDao<RptCitymedicalassistance> implements IRptCitymedicalassistanceDao{

 	public RptCitymedicalassistanceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<RptCitymedicalassistance> getEntityClass() {
		return RptCitymedicalassistance.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from RptCitymedicalassistance");
	}
   
}
