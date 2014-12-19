package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptHouseSubsidyInfoDao;
import com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo;

/**
 * @title:BptHouseSubsidyInfoDao
 * @description:建购房补助信息
 * @author:
 * @since:2011-07-04
 * @version:1.0
*/
 public class BptHouseSubsidyInfoDao extends EntityDao<BptHouseSubsidyInfo> implements IBptHouseSubsidyInfoDao{

 	public BptHouseSubsidyInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptHouseSubsidyInfo> getEntityClass() {
		return BptHouseSubsidyInfo.class;
	}
}
