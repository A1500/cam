package com.inspur.cams.sorg.penalty.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.penalty.base.dao.ISomPenaltyCorrectDao;
import com.inspur.cams.sorg.penalty.base.data.SomPenaltyCorrect;

/**
 * @title:SomPenaltyCorrectDao
 * @description:
 * @author:
 * @since:2011-12-29
 * @version:1.0
*/
 public class SomPenaltyCorrectDao extends EntityDao<SomPenaltyCorrect> implements ISomPenaltyCorrectDao{

 	public SomPenaltyCorrectDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomPenaltyCorrect.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomPenaltyCorrect");
	}
   
}
