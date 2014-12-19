package com.inspur.cams.welfare.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealFitLogoffDao;
import com.inspur.cams.welfare.base.data.WealFitLogoff;

/**
 * @title:WealFitLogoffDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealFitLogoffDao extends EntityDao<WealFitLogoff> implements IWealFitLogoffDao{

 	public WealFitLogoffDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealFitLogoff.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealFitLogoff");
	}
   
}
