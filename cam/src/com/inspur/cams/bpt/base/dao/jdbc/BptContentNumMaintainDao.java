package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import com.inspur.cams.bpt.base.dao.IBptContentNumMaintainDao;
import com.inspur.cams.bpt.base.data.BptContentNumMaintain;

/**
 * @title:BptContentNumMaintainDao
 * @description:目录号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
 public class BptContentNumMaintainDao extends EntityDao<BptContentNumMaintain> implements IBptContentNumMaintainDao{

 	public BptContentNumMaintainDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptContentNumMaintain> getEntityClass() {
		return BptContentNumMaintain.class;
	}
}
