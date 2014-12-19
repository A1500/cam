package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.base.dao.ISomPartyMemberStatusChangeDao;
import com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange;

/**
 * @title:SomPartyMemberStatusChangeDao
 * @description:
 * @author:
 * @since:2012-08-21
 * @version:1.0
*/
 public class SomPartyMemberStatusChangeDao extends EntityDao<SomPartyMemberStatusChange> implements ISomPartyMemberStatusChangeDao{

 	public SomPartyMemberStatusChangeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomPartyMemberStatusChange.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomPartyMemberStatusChange");
	}
   
}
