package com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckMajorDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public class SomJxCheckMajorDao extends EntityDao<SomJxCheckMajor> implements ISomJxCheckMajorDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHECK_MAJOR WHERE TASK_CODE = ?";
 	public SomJxCheckMajorDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckMajor.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckMajor");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });		
	}
}
