package com.inspur.cams.sorg.online.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.online.base.dao.ISomPartyMemberOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomPartyMemberOnline;

/**
 * @title:SomPartyMemberOnlineDao
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public class SomPartyMemberOnlineDao extends EntityDao<SomPartyMemberOnline> implements ISomPartyMemberOnlineDao{

 	public SomPartyMemberOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomPartyMemberOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomPartyMemberOnline");
	}
   
}
