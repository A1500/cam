package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmPybzyDao;
import com.inspur.cams.marry.base.data.MrmPybzy;

/**
 * @title:MrmPybzyDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public class MrmPybzyDao extends EntityDao<MrmPybzy> implements IMrmPybzyDao{

 	public MrmPybzyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmPybzy.class;
	}
 
}
