package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomHeldPeopleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomHeldPeopleOnline;

/**
 * @title:SomHeldPeopleOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public class SomHeldPeopleOnlineDao extends EntityDao<SomHeldPeopleOnline> implements ISomHeldPeopleOnlineDao{

 	public SomHeldPeopleOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomHeldPeopleOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomHeldPeopleOnline");
	}
   
}
