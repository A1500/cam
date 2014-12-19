package com.inspur.sdmz.jtxx.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.sdmz.jtxx.dao.ISamFamilyHouseDao;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;


/**
 * @title:SamFamilyHouseDao
 * @description:
 * @author:save
 * @since:2011-04-18
 * @version:1.0
 */
public class SamFamilyHouseDao extends EntityDao<SamFamilyHouse>
		implements ISamFamilyHouseDao {

	public SamFamilyHouseDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamFamilyHouse.class;
	}
}
