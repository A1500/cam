package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.marry.base.dao.IMrmPositionDao;
import com.inspur.cams.marry.base.data.MrmPosition;

/**
 * @title:MrmPositionDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public class MrmPositionDao extends EntityDao<MrmPosition> implements IMrmPositionDao{

 	public MrmPositionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmPosition.class;
	}
 
   
}
