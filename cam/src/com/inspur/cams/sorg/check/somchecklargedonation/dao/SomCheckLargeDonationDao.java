package com.inspur.cams.sorg.check.somchecklargedonation.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckLargeDonationDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckLargeDonationDao extends EntityDao<SomCheckLargeDonation> implements ISomCheckLargeDonationDao{
 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Check_Large_Donation WHERE TASK_CODE = ?";
 	public SomCheckLargeDonationDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckLargeDonation.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckLargeDonation");
	}
   public void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });		
	}
}
