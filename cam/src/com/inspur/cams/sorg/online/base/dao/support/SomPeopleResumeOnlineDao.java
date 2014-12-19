package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomPeopleResumeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPeopleResumeOnline;

/**
 * @title:SomPeopleResumeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public class SomPeopleResumeOnlineDao extends EntityDao<SomPeopleResumeOnline> implements ISomPeopleResumeOnlineDao{

 	public SomPeopleResumeOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomPeopleResumeOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomPeopleResumeOnline");
	}
   
}
