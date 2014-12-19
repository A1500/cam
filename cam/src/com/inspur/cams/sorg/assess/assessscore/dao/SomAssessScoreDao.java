package com.inspur.cams.sorg.assess.assessscore.dao;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.assess.assessscore.data.SomAssessScore;

/**
 * @title:SomAssessScoreDao
 * @description:
 * @author:
 * @since:2011-12-09
 * @version:1.0
*/
 public class SomAssessScoreDao extends EntityDao<SomAssessScore> implements ISomAssessScoreDao{

 	public SomAssessScoreDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomAssessScore.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomAssessScore");
	}
   
   public void deleteByTaskCode(String taskCode) {
	   String sql = "DELETE FROM SOM_ASSESS_SCORE A WHERE A.TASK_CODE=?";
		int[] types = new int[] { Types.VARCHAR };
	    Object[] args = new Object[] { taskCode };
	    executeUpdate(sql, types, args);
	}
   
}
