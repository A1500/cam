package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomMeetingOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomMeetingOnline;

/**
 * @title:SomMeetingOnlineDao
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public class SomMeetingOnlineDao extends EntityDao<SomMeetingOnline> implements ISomMeetingOnlineDao{

 	public SomMeetingOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomMeetingOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomMeetingOnline");
	}
   
}
