package com.inspur.cams.bpt.dichealth.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:DicHealthDao
 * @description:
 * @author:
 * @since:2011-12-26
 * @version:1.0
*/
 public class DicHealthDao extends EntityDao<DicHealth> implements IDicHealthDao{

 	public DicHealthDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<DicHealth> getEntityClass() {
		return DicHealth.class;
	}

   
}
