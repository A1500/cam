package com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckAccountingPeopleDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckAccountingPeopleDao extends EntityDao<SomJxCheckAccountingPeople> implements ISomJxCheckAccountingPeopleDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHECK_ACCOUNTING_PEOPLE WHERE TASK_CODE = ?";
 	public SomJxCheckAccountingPeopleDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckAccountingPeople.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckAccountingPeople");
	}

public void deleteByTaskCode(String taskCode) {
	executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },
			new Object[] { taskCode });
	
}
   
}
