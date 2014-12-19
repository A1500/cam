package com.inspur.cams.drel.rpt.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.rpt.data.RptCountrymedicalassistance;

/**
 * @title:农村医疗救助工作情况dao实现
 * @description:
 * @author:yangliangliang
 * @since:2011-06-22
 * @version:1.0
*/
 public class RptCountrymedicalassistanceDao extends EntityDao<RptCountrymedicalassistance> implements IRptCountrymedicalassistanceDao{

 	public RptCountrymedicalassistanceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<RptCountrymedicalassistance> getEntityClass() {
		return RptCountrymedicalassistance.class;
	}
   
}
