package com.inspur.cams.sorg.jxcheck.somjxcheckchanges.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckChangesDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckChangesDao extends EntityDao<SomJxCheckChanges> implements ISomJxCheckChangesDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHECK_CHANGES WHERE TASK_CODE = ?";
 	public SomJxCheckChangesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckChanges.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckChanges");
	}

public  void deleteByTaskCode(String taskCode) {
	executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
	
}
   
}
