package com.inspur.cams.sorg.jxcheck.somjxextrarebuildconcrete.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxExtraRebuildConcreteDao
 * @description:
 * @author:
 * @since:2012-01-16
 * @version:1.0
*/
 public class SomJxExtraRebuildConcreteDao extends EntityDao<SomJxExtraRebuildConcrete> implements ISomJxExtraRebuildConcreteDao{

 	public SomJxExtraRebuildConcreteDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxExtraRebuildConcrete.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxExtraRebuildConcrete");
	}
   
}
