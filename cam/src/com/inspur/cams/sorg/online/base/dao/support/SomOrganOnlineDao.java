package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomOrganOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomOrganOnline;

/**
 * @title:SomOrganOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public class SomOrganOnlineDao extends EntityDao<SomOrganOnline> implements ISomOrganOnlineDao{

 	public SomOrganOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomOrganOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomOrganOnline");
	}
   
}
