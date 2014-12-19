package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.base.dao.IBptAssistiveDevicesMaintenaDao;
import com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena;

/**
 * @title:BptAssistiveDevicesMaintenaDao
 * @description:
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 public class BptAssistiveDevicesMaintenaDao extends EntityDao<BptAssistiveDevicesMaintena> implements IBptAssistiveDevicesMaintenaDao{

 	public BptAssistiveDevicesMaintenaDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptAssistiveDevicesMaintena> getEntityClass() {
		return BptAssistiveDevicesMaintena.class;
	}
}
