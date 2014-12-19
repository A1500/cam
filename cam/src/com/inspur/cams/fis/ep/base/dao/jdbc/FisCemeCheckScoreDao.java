package com.inspur.cams.fis.ep.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckScoreDao;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;

/**
 * @title:FisCemeCheckScoreDao
 * @description:
 * @author:
 * @since:2011-12-14
 * @version:1.0
*/
 public class FisCemeCheckScoreDao extends EntityDao<FisCemeCheckScore> implements IFisCemeCheckScoreDao{

 	public FisCemeCheckScoreDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisCemeCheckScore.class;
	}
   public void deleteStruAll() {
		executeUpdate("DELETE FROM FISCEMECHECKSCORE");
	}
   
}
