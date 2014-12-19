package com.inspur.cams.sorg.check.checkinterproject.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkinterproject.data.SomCheckInterProject;

/**
 * @title:SomCheckInterProjectDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
 */
public class SomCheckInterProjectDao extends EntityDao<SomCheckInterProject>
		implements ISomCheckInterProjectDao {

	private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_INTER_PROJECT WHERE TASK_CODE = ?";
	
	public SomCheckInterProjectDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomCheckInterProject.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomCheckInterProject");
	}

	public void deleteByTaskCode(String taskCode) {
		executeUpdate(DELETE_BY_TASKCODE, new int[] { Types.VARCHAR },
				new Object[] { taskCode });
	}
}
