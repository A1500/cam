package com.inspur.cams.sorg.check.somcheckparty.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckPartyDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckPartyDao extends EntityDao<SomCheckParty> implements ISomCheckPartyDao{

 	public SomCheckPartyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckParty.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckParty");
	}
   
}
