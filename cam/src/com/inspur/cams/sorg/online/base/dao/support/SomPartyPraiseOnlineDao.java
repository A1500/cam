package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomPartyPraiseOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPartyPraiseOnline;

/**
 * @title:SomPartyPraiseOnlineDao
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public class SomPartyPraiseOnlineDao extends EntityDao<SomPartyPraiseOnline> implements ISomPartyPraiseOnlineDao{

 	public SomPartyPraiseOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomPartyPraiseOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomPartyPraiseOnline");
	}
   
}
