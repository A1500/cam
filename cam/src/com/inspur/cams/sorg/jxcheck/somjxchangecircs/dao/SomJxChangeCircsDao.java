package com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxChangeCircsDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxChangeCircsDao extends EntityDao<SomJxChangeCircs> implements ISomJxChangeCircsDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHANGE_CIRCS WHERE TASK_CODE = ?";
 	public SomJxChangeCircsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxChangeCircs.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxChangeCircs");
	}

public void deleteByTaskCode(String taskCode) {
	executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },
			new Object[] { taskCode });
	
}
   
}
