package com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxLargeDonationDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public class SomJxLargeDonationDao extends EntityDao<SomJxLargeDonation> implements ISomJxLargeDonationDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_LARGE_DONATION WHERE TASK_CODE = ?";
 	public SomJxLargeDonationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxLargeDonation.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxLargeDonation");
	}
   public void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });		
	}
}
