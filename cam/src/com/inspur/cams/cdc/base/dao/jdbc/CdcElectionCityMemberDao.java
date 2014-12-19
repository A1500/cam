package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.cdc.base.dao.ICdcElectionCityMemberDao;
import com.inspur.cams.cdc.base.data.CdcElectionCityMember;

/**
 * @title:CdcElectionCityMemberDao
 * @description:
 * @author:
 * @since:2013-02-17
 * @version:1.0
*/
 public class CdcElectionCityMemberDao extends EntityDao<CdcElectionCityMember> implements ICdcElectionCityMemberDao{

 	public CdcElectionCityMemberDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<?> getEntityClass() {
		return CdcElectionCityMember.class;
	}
   
}
