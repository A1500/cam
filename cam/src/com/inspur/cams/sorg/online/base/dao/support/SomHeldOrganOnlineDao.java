package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomHeldOrganOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomHeldOrganOnline;

/**
 * @title:SomHeldOrganOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public class SomHeldOrganOnlineDao extends EntityDao<SomHeldOrganOnline> implements ISomHeldOrganOnlineDao{

 	public SomHeldOrganOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomHeldOrganOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomHeldOrganOnline");
	}
   
}
