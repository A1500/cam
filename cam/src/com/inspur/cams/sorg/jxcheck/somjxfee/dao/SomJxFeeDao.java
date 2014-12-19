package com.inspur.cams.sorg.jxcheck.somjxfee.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxFeeDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxFeeDao extends EntityDao<SomJxFee> implements ISomJxFeeDao{

 	public SomJxFeeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxFee.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxFee");
	}
   
}
