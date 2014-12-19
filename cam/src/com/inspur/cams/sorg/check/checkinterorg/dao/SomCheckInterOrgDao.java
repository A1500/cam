package com.inspur.cams.sorg.check.checkinterorg.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.sorg.check.checkinterorg.data.SomCheckInterOrg;

/**
 * @title:SomCheckInterOrgDao
 * @description:
 * @author:
 * @since:2012-01-08
 * @version:1.0
*/
 public class SomCheckInterOrgDao extends EntityDao<SomCheckInterOrg> implements ISomCheckInterOrgDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_INTER_ORG WHERE TASK_CODE = ?";
 	public SomCheckInterOrgDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckInterOrg.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckInterOrg");
	}
   public void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },
				new Object[] { taskCode });
	}
}
