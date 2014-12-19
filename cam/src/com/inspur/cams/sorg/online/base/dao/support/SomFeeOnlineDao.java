package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomFeeOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomFeeOnline;

/**
 * @title:SomFeeOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public class SomFeeOnlineDao extends EntityDao<SomFeeOnline> implements ISomFeeOnlineDao{

 	public SomFeeOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomFeeOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomFeeOnline");
	}
   
}
