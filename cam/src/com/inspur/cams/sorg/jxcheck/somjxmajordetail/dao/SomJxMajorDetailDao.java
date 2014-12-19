package com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxMajorDetailDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public class SomJxMajorDetailDao extends EntityDao<SomJxMajorDetail> implements ISomJxMajorDetailDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_MAJOR_DETAIL WHERE TASK_CODE = ?";
 	public SomJxMajorDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxMajorDetail.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxMajorDetail");
	}
   public  void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },new Object[] { taskCode });
		
	}
}
