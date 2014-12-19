package com.inspur.cams.sorg.assess.assesstask.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.assess.assesstask.data.SomAssessTask;

/**
 * @title:SomAssessTaskDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public class SomAssessTaskDao extends EntityDao<SomAssessTask> implements ISomAssessTaskDao{

 	public SomAssessTaskDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomAssessTask.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomAssessTask");
	}
   
}
