package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomChangeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomChangeOnline;

/**
 * @title:SomChangeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-12
 * @version:1.0
*/
 public class SomChangeOnlineDao extends EntityDao<SomChangeOnline> implements ISomChangeOnlineDao{

 	public SomChangeOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomChangeOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomChangeOnline");
	}
   
}
