package com.inspur.cams.sorg.check.checkchanges.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges;

/**
 * @title:SomCheckChangesDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
 */
public class SomCheckChangesDao extends EntityDao<SomCheckChanges> implements ISomCheckChangesDao {

	private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_CHANGES WHERE TASK_CODE = ?";
	
	public SomCheckChangesDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomCheckChanges.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomCheckChanges");
	}
	
	public void deleteByTaskCode(String taskCode){
		executeUpdate(DELETE_BY_TASKCODE, new int[]{Types.VARCHAR}, new Object[]{taskCode});
	}
}
