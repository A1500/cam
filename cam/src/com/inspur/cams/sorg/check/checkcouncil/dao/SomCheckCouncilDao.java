package com.inspur.cams.sorg.check.checkcouncil.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil;

/**
 * @title:SomCheckCouncilDao
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 public class SomCheckCouncilDao extends EntityDao<SomCheckCouncil> implements ISomCheckCouncilDao{

 	public SomCheckCouncilDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckCouncil.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckCouncil");
	}
   
}
