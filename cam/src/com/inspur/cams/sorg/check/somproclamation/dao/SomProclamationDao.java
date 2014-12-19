package com.inspur.cams.sorg.check.somproclamation.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomProclamationDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomProclamationDao extends EntityDao<SomProclamation> implements ISomProclamationDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Proclamation WHERE TASK_CODE = ?";
 	public SomProclamationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomProclamation.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomProclamation");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
