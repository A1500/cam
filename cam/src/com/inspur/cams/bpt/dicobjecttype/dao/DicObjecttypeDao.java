package com.inspur.cams.bpt.dicobjecttype.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:DicObjecttypeDao
 * @description:
 * @author:
 * @since:2011-08-16
 * @version:1.0
*/
 public class DicObjecttypeDao extends EntityDao<DicObjecttype> implements IDicObjecttypeDao{

 	public DicObjecttypeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<DicObjecttype> getEntityClass() {
		return DicObjecttype.class;
	}

   
}
