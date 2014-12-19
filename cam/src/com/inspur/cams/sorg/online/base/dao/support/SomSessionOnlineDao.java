package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomSessionOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomSessionOnline;

/**
 * @title:SomSessionOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public class SomSessionOnlineDao extends EntityDao<SomSessionOnline> implements ISomSessionOnlineDao{

 	public SomSessionOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomSessionOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomSessionOnline");
	}
   
}
