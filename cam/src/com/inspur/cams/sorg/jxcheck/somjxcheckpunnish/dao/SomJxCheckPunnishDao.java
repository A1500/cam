package com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckPunnishDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckPunnishDao extends EntityDao<SomJxCheckPunnish> implements ISomJxCheckPunnishDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHECK_PUNNISH WHERE TASK_CODE = ?";
 	public SomJxCheckPunnishDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckPunnish.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckPunnish");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
