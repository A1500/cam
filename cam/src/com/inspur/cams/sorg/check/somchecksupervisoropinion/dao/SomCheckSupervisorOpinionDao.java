package com.inspur.cams.sorg.check.somchecksupervisoropinion.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckSupervisorOpinionDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckSupervisorOpinionDao extends EntityDao<SomCheckSupervisorOpinion> implements ISomCheckSupervisorOpinionDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Check_Supervisor_Opinion WHERE TASK_CODE = ?";
 	public SomCheckSupervisorOpinionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckSupervisorOpinion.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckSupervisorOpinion");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
