package com.inspur.cams.sorg.jxcheck.somjxcouncilmeeting.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCouncilMeetingDao
 * @description:
 * @author:
 * @since:2012-02-07
 * @version:1.0
*/
 public class SomJxCouncilMeetingDao extends EntityDao<SomJxCouncilMeeting> implements ISomJxCouncilMeetingDao{

 	public SomJxCouncilMeetingDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCouncilMeeting.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCouncilMeeting");
	}
   
}
