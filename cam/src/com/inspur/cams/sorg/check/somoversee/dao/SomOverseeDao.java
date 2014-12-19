package com.inspur.cams.sorg.check.somoversee.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomOverseeDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomOverseeDao extends EntityDao<SomOversee> implements ISomOverseeDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Oversee WHERE TASK_CODE = ?";
 	public SomOverseeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomOversee.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomOversee");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
