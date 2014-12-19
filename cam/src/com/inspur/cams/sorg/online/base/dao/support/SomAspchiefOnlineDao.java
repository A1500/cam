package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomAspchiefOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomAspchiefOnline;

/**
 * @title:SomAspchiefOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public class SomAspchiefOnlineDao extends EntityDao<SomAspchiefOnline> implements ISomAspchiefOnlineDao{

 	public SomAspchiefOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomAspchiefOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomAspchiefOnline");
	}
   
}
