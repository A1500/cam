package com.inspur.cams.sorg.check.somcheckchangecircs.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckAccountingPeopleDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckChangeCircsDao extends EntityDao<SomCheckChangeCircs> {
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHANGE_CIRCS WHERE TASK_CODE = ?";
 	public SomCheckChangeCircsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckChangeCircs.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomChangeCircs");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
