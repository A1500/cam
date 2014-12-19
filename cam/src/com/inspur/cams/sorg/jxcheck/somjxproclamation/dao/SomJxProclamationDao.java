package com.inspur.cams.sorg.jxcheck.somjxproclamation.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxProclamationDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
public class SomJxProclamationDao extends EntityDao<SomJxProclamation> implements ISomJxProclamationDao {

	private static String SOM_JX_PROCLAMATION_DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_PROCLAMATION WHERE TASK_CODE = ?";
	
	public SomJxProclamationDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomJxProclamation.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomJxProclamation");
	}
	
	public void deleteByTaskCode(String taskCode){
		executeUpdate(SOM_JX_PROCLAMATION_DELETE_BY_TASKCODE, new int[]{Types.VARCHAR}, new Object[]{taskCode});
	}
}
