package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.base.dao.IBptApplyAssistiveDevicesPrDao;
import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr;

/**
 * @title:BptApplyAssistiveDevicesPrDao
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
 public class BptApplyAssistiveDevicesPrDao extends EntityDao<BptApplyAssistiveDevicesPr> implements IBptApplyAssistiveDevicesPrDao{

 	public BptApplyAssistiveDevicesPrDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyAssistiveDevicesPr> getEntityClass() {
		return BptApplyAssistiveDevicesPr.class;
	}
}
