package com.inspur.cams.drel.organ.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.organ.dao.ISamSupportOrganDao;
import com.inspur.cams.drel.organ.date.SamSupportOrgan;

/**
 * @title:SamSupportOrganDao
 * @description:
 * @author:孤儿院、敬老院Dao
 * @since:2012-05-21
 * @version:1.0
*/
 public class SamSupportOrganDao extends EntityDao<SamSupportOrgan> implements ISamSupportOrganDao{

 	public SamSupportOrganDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamSupportOrgan.class;
	}
   
}
