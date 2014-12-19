package com.inspur.cams.sorg.check.checkevent.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent;

/**
 * @title:SomCheckEventDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
 */
public class SomCheckEventDao extends EntityDao<SomCheckEvent> implements
		ISomCheckEventDao {

	private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_EVENT WHERE TASK_CODE = ?";
	
	public SomCheckEventDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomCheckEvent.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomCheckEvent");
	}

	public void deleteByTaskCode(String taskCode){
		executeUpdate(DELETE_BY_TASKCODE, new int[]{Types.VARCHAR}, new Object[]{taskCode});
	}
}
