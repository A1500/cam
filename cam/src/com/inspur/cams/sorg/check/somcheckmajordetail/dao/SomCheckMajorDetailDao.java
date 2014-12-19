package com.inspur.cams.sorg.check.somcheckmajordetail.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckMajorDetailDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckMajorDetailDao extends EntityDao<SomCheckMajorDetail> implements ISomCheckMajorDetailDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM Som_Check_Major_Detail WHERE TASK_CODE = ?";
 	public SomCheckMajorDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckMajorDetail.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckMajorDetail");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
