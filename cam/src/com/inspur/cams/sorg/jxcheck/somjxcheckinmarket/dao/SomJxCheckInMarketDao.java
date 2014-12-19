package com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckInMarketDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckInMarketDao extends EntityDao<SomJxCheckInMarket> implements ISomJxCheckInMarketDao{
	 private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHECK_IN_MARKET WHERE TASK_CODE = ?";
 	public SomJxCheckInMarketDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckInMarket.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckInMarket");
	}

public void deleteByTaskCode(String taskCode) {
	executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },
			new Object[] { taskCode });
	
}
   
}
