package com.inspur.cams.sorg.check.checkintervisit.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkintervisit.data.SomCheckInterVisit;

/**
 * @title:SomCheckInterVisitDao
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
 public class SomCheckInterVisitDao extends EntityDao<SomCheckInterVisit> implements ISomCheckInterVisitDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_INTER_VISIT WHERE TASK_CODE = ?";
 	public SomCheckInterVisitDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckInterVisit.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckInterVisit");
	}
	public void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },
				new Object[] { taskCode });
	}
}
