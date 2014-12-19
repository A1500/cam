package com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckSupervisorOpinDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckSupervisorOpinDao extends EntityDao<SomJxCheckSupervisorOpin> implements ISomJxCheckSupervisorOpinDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHECK_SUPERVISOR_OPIN WHERE TASK_CODE = ?";
 	public SomJxCheckSupervisorOpinDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckSupervisorOpin.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckSupervisorOpin");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
