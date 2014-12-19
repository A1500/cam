package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomRuleOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomRuleOnline;

/**
 * @title:SomRuleOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public class SomRuleOnlineDao extends EntityDao<SomRuleOnline> implements ISomRuleOnlineDao{

 	public SomRuleOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomRuleOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomRuleOnline");
	}
   
}
