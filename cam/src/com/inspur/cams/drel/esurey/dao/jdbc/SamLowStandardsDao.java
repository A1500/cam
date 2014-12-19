package com.inspur.cams.drel.esurey.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.esurey.dao.ISamLowStandardsDao;
import com.inspur.cams.drel.esurey.data.SamLowStandards;

/**
 * @title:SamLowStandardsDao
 * @description:
 * @author:
 * @since:2011-07-06
 * @version:1.0
*/
 public class SamLowStandardsDao extends EntityDao<SamLowStandards> implements ISamLowStandardsDao{

 	public SamLowStandardsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamLowStandards.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamLowStandards");
	}
   
}
