package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomOfficeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomOfficeOnline;

/**
 * @title:SomOfficeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-26
 * @version:1.0
*/
 public class SomOfficeOnlineDao extends EntityDao<SomOfficeOnline> implements ISomOfficeOnlineDao{

 	public SomOfficeOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomOfficeOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomOfficeOnline");
	}
   
}
