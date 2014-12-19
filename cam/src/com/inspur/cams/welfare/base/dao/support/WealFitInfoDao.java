package com.inspur.cams.welfare.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealFitInfoDao;
import com.inspur.cams.welfare.base.data.WealFitInfo;

/**
 * @title:WealFitInfoDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealFitInfoDao extends EntityDao<WealFitInfo> implements IWealFitInfoDao{

 	public WealFitInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealFitInfo.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealFitInfo");
	}
   
}
