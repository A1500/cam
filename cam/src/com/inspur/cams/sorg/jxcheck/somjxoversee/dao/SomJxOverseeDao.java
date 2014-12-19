package com.inspur.cams.sorg.jxcheck.somjxoversee.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxOverseeDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxOverseeDao extends EntityDao<SomJxOversee> implements ISomJxOverseeDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_OVERSEE WHERE TASK_CODE = ?";
 	public SomJxOverseeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxOversee.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxOversee");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
