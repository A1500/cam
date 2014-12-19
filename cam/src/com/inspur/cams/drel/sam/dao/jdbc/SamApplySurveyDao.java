package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamApplySurveyDao;
import com.inspur.cams.drel.sam.data.SamApplySurvey;

/**
 * @title:入户调查Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public class SamApplySurveyDao extends EntityDao<SamApplySurvey> implements ISamApplySurveyDao{

 	public SamApplySurveyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamApplySurvey.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamApplySurvey");
	}
   
}
