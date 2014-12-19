package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomElectionOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomElectionOnline;

/**
 * @title:SomElectionOnlineDao
 * @description:
 * @author:
 * @since:2012-11-22
 * @version:1.0
*/
 public class SomElectionOnlineDao extends EntityDao<SomElectionOnline> implements ISomElectionOnlineDao{

 	public SomElectionOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomElectionOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomElectionOnline");
	}
   
}
