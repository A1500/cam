package com.inspur.cams.welfare.base.dao.support;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.welfare.base.dao.IWealUnitInfoDao;
import com.inspur.cams.welfare.base.data.*;

/**
 * @title:WealUnitInfoDao
 * @description:
 * @author:
 * @since:2013-06-08
 * @version:1.0
 */
public class WealUnitInfoDao extends EntityDao<WealUnitInfo> implements
		IWealUnitInfoDao {

	public WealUnitInfoDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return WealUnitInfo.class;
	}

	public void deleteStruAll() {
		executeUpdate("delete from WealUnitInfo");
	}

}
