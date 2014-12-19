package com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxOrganFundsDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxOrganFundsDao extends EntityDao<SomJxOrganFunds> implements ISomJxOrganFundsDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_ORGAN_FUNDS WHERE TASK_CODE = ? AND ORGAN_TYPE = ?";
 	public SomJxOrganFundsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxOrganFunds.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxOrganFunds");
	}

public void deleteByTaskCodeAndOrganType(String taskCode,String organTyoe) {
	int[] types = new int[] {Types.VARCHAR, Types.VARCHAR};
	Object[] objs = new Object[] {taskCode, organTyoe};
	executeUpdate(DELETE_BY_TASKCODE, types, objs);
}
   
}
