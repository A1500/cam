package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomLiqpeopleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomLiqpeopleOnline;

/**
 * @title:SomLiqpeopleOnlineDao
 * @description:
 * @author:
 * @since:2012-11-14
 * @version:1.0
*/
 public class SomLiqpeopleOnlineDao extends EntityDao<SomLiqpeopleOnline> implements ISomLiqpeopleOnlineDao{

 	public SomLiqpeopleOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomLiqpeopleOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomLiqpeopleOnline");
	}
   
}
