package com.inspur.cams.fis.ep.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.fis.ep.base.dao.IFisCemeItemsDao;
import com.inspur.cams.fis.ep.base.data.FisCemeItems;

/**
 * @title: FisCemeItemsDao
 * @description:公墓审批事项dao
 * @author:lidongdong（xxz）
 * @since:2011-11-11
 * @version:1.0
 */
public class FisCemeItemsDao extends EntityDao<FisCemeItems> implements
		IFisCemeItemsDao {

	public FisCemeItemsDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisCemeItems.class;
	}
}
