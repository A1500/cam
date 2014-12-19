package com.inspur.cams.sorg.assess.assessconfig.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig;

/**
 * @title:SomAssessConfigDao
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class SomAssessConfigDao extends EntityDao<SomAssessConfig> implements ISomAssessConfigDao{

 	public SomAssessConfigDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomAssessConfig.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomAssessConfig");
	}
   
}
