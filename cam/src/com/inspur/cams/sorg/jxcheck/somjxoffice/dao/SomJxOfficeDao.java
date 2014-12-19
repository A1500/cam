package com.inspur.cams.sorg.jxcheck.somjxoffice.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxOfficeDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxOfficeDao extends EntityDao<SomJxOffice> implements ISomJxOfficeDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_OFFICE WHERE TASK_CODE = ?";
 	public SomJxOfficeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxOffice.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxOffice");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
