package com.inspur.cams.sorg.check.somcheckmajor.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckMajorDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckMajorDao extends EntityDao<SomCheckMajor> implements ISomCheckMajorDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Check_Major WHERE TASK_CODE = ?";
 	public SomCheckMajorDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckMajor.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckMajor");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
