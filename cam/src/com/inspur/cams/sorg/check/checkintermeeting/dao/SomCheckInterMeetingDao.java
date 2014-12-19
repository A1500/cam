package com.inspur.cams.sorg.check.checkintermeeting.dao;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkintermeeting.data.SomCheckInterMeeting;

/**
 * @title:SomCheckInterMeetingDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
 */
public class SomCheckInterMeetingDao extends EntityDao<SomCheckInterMeeting>
		implements ISomCheckInterMeetingDao {

	private static String DELETE_BY_TASKCODE = "DELETE FROM SOM_CHECK_INTER_MEETING WHERE TASK_CODE = ?";
	
	public SomCheckInterMeetingDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomCheckInterMeeting.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomCheckInterMeeting");
	}
	public void deleteByTaskCode(String taskCode){
		executeUpdate(DELETE_BY_TASKCODE, new int[]{Types.VARCHAR}, new Object[]{taskCode});
	}
}
