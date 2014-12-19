package com.inspur.cams.welfare.base.dao.support;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealFitChangerecordDao;
import com.inspur.cams.welfare.base.data.WealFitChangerecord;

/**
 * @title:WealFitChangerecordDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealFitChangerecordDao extends EntityDao<WealFitChangerecord> implements IWealFitChangerecordDao{

 	public WealFitChangerecordDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealFitChangerecord.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealFitChangerecord");
	}
   
}
