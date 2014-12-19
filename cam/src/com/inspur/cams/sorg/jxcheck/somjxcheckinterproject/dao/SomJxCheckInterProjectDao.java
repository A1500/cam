package com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckInterProjectDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
public class SomJxCheckInterProjectDao extends EntityDao<SomJxCheckInterProject> implements ISomJxCheckInterProjectDao {

	private static String SOM_JX_CHECK_INTER_PROJECT_DELETE_BY_TASKCODE = "DELETE FROM SOM_JX_CHECK_INTER_PROJECT WHERE TASK_CODE = ?";
	
	public SomJxCheckInterProjectDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomJxCheckInterProject.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckInterProject");
	}

	public void deleteByTaskCode(String taskCode){
		executeUpdate(SOM_JX_CHECK_INTER_PROJECT_DELETE_BY_TASKCODE, new int[]{Types.VARCHAR}, new Object[]{taskCode});
	}
}
