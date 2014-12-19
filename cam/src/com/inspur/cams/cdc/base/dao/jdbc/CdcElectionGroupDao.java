package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionGroupDao;
import com.inspur.cams.cdc.base.data.CdcElectionGroup;

/**
 * @title:CdcElectionGroupDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public class CdcElectionGroupDao extends EntityDao<CdcElectionGroup> implements ICdcElectionGroupDao{

 	public CdcElectionGroupDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<?> getEntityClass() {
		return CdcElectionGroup.class;
	}
   
}
