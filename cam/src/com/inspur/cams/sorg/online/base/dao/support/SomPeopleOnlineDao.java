package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomPeopleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPeopleOnline;

/**
 * @title:SomPeopleOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public class SomPeopleOnlineDao extends EntityDao<SomPeopleOnline> implements ISomPeopleOnlineDao{

 	public SomPeopleOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomPeopleOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomPeopleOnline");
	}
   
}
