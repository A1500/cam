package com.inspur.cams.sorg.partycheck.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.sorg.partycheck.data.*;

/**
 * @title:SomPartyCheckDao
 * @description:
 * @author:
 * @since:2013-04-26
 * @version:1.0
*/
 public class SomPartyCheckDao extends EntityDao<SomPartyCheck> implements ISomPartyCheckDao{

 	public SomPartyCheckDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomPartyCheck.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomPartyCheck");
	}
   
}
