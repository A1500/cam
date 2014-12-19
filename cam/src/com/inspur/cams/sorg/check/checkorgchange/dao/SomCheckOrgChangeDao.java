package com.inspur.cams.sorg.check.checkorgchange.dao;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.checkorgchange.data.SomCheckOrgChange;

/**
 * @title:SomCheckOrgChangeDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public class SomCheckOrgChangeDao extends EntityDao<SomCheckOrgChange> implements ISomCheckOrgChangeDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_ORG_CHANGE WHERE TASK_CODE = ?";
 	public SomCheckOrgChangeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckOrgChange.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckOrgChange");
	}
   public void deleteByTaskCode(String taskCode){
		executeUpdate(DELETE_BY_TASKCODE, new int[]{Types.VARCHAR}, new Object[]{taskCode});
	}
}
