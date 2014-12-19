package com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckPartyDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckPartyDao extends EntityDao<SomJxCheckParty> implements ISomJxCheckPartyDao{

 	public SomJxCheckPartyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckParty.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckParty");
	}
   
}
