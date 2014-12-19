package com.inspur.cams.sorg.check.somcontribute.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomContributeDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomContributeDao extends EntityDao<SomContribute> implements ISomContributeDao{

 	public SomContributeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomContribute.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomContribute");
	}
   
}
