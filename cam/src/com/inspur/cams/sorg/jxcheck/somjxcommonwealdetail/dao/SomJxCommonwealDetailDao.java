package com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import java.sql.Types;

/**
 * @title:SomJxCommonwealDetailDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCommonwealDetailDao extends EntityDao<SomJxCommonwealDetail> implements ISomJxCommonwealDetailDao{

 	public SomJxCommonwealDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCommonwealDetail.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCommonwealDetail");
	}

	public void deleteByTaskCode(String taskCode) {
		executeUpdate("DELETE FROM SOM_JX_COMMONWEAL_DETAIL T WHERE T.TASK_CODE = ? ",
				new int[]{Types.VARCHAR},new Object[]{taskCode});
	}
   
}
