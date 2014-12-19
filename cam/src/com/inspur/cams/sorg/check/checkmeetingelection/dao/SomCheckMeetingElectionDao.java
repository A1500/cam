package com.inspur.cams.sorg.check.checkmeetingelection.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.checkmeetingelection.data.SomCheckMeetingElection;

/**
 * @title:SomCheckMeetingElectionDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public class SomCheckMeetingElectionDao extends EntityDao<SomCheckMeetingElection> implements ISomCheckMeetingElectionDao{

 	public SomCheckMeetingElectionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckMeetingElection.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckMeetingElection");
	}
   
}
