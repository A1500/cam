package com.inspur.cams.marry.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmBiWorkingCapacityYearDao;
import com.inspur.cams.marry.base.data.MrmBiWorkingCapacityYear;

/**
 * @title:MrmBiWorkingCapacityYearDao
 * @description:
 * @author:
 * @since:2012-02-02
 * @version:1.0
*/
 public class MrmBiWorkingCapacityYearDao extends EntityDao<MrmBiWorkingCapacityYear> implements IMrmBiWorkingCapacityYearDao{

 	public MrmBiWorkingCapacityYearDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmBiWorkingCapacityYear.class;
	}
   
}
