package com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import java.sql.Types;

/**
 * @title:SomJxCheckInterMeetingDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
 */
public class SomJxCheckInterMeetingDao extends
		EntityDao<SomJxCheckInterMeeting> implements ISomJxCheckInterMeetingDao {

	public SomJxCheckInterMeetingDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SomJxCheckInterMeeting.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckInterMeeting");
	}

	public void deleteByTaskCode(String taskCode) {

		executeUpdate("DELETE FROM SOM_JX_CHECK_INTER_MEETING T WHERE T.TASK_CODE = ?",
				new int[]{Types.VARCHAR},new Object[]{taskCode});

	}

}
