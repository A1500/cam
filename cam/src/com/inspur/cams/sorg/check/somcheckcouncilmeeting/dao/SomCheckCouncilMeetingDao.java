package com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckCouncilMeetingDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckCouncilMeetingDao extends EntityDao<SomCheckCouncilMeeting> implements ISomCheckCouncilMeetingDao{

 	public SomCheckCouncilMeetingDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckCouncilMeeting.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckCouncilMeeting");
	}
   
}
