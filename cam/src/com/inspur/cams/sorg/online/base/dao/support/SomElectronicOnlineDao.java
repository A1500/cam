package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomElectronicOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomElectronicOnline;

/**
 * @title:SomElectronicOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public class SomElectronicOnlineDao extends EntityDao<SomElectronicOnline> implements ISomElectronicOnlineDao{

 	public SomElectronicOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomElectronicOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomElectronicOnline");
	}
   
}
