package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomApplyOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomApplyOnline;

/**
 * @title:SomApplyOnlineDao
 * @description:
 * @author:
 * @since:2012-11-06
 * @version:1.0
*/
 public class SomApplyOnlineDao extends EntityDao<SomApplyOnline> implements ISomApplyOnlineDao{

 	public SomApplyOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomApplyOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomApplyOnline");
	}
   
}
