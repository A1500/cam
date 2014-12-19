package com.inspur.cams.sorg.jxcheck.somjxextraplanconcrete.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxExtraPlanConcreteDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxExtraPlanConcreteDao extends EntityDao<SomJxExtraPlanConcrete> implements ISomJxExtraPlanConcreteDao{

 	public SomJxExtraPlanConcreteDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxExtraPlanConcrete.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxExtraPlanConcrete");
	}
   
}
