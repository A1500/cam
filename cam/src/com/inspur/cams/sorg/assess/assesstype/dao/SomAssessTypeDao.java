package com.inspur.cams.sorg.assess.assesstype.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomAssessTypeDao
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class SomAssessTypeDao extends EntityDao<SomAssessType> implements ISomAssessTypeDao{

 	public SomAssessTypeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomAssessType.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomAssessType");
	}
   
}
