package com.inspur.cams.sorg.check.somcheckpunnish.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckPunnishDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckPunnishDao extends EntityDao<SomCheckPunnish> implements ISomCheckPunnishDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Check_Punnish WHERE TASK_CODE = ?";
 	public SomCheckPunnishDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckPunnish.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckPunnish");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
