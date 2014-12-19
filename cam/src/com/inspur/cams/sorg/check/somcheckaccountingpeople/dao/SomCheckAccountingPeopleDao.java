package com.inspur.cams.sorg.check.somcheckaccountingpeople.dao;

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
 public class SomCheckAccountingPeopleDao extends EntityDao<SomCheckAccountingPeople> implements ISomCheckAccountingPeopleDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Check_Accounting_People WHERE TASK_CODE = ?";
 	public SomCheckAccountingPeopleDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckAccountingPeople.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckAccountingPeople");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
