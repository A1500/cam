package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptDisabilityOpenDao;
import com.inspur.cams.bpt.base.data.BptDisabilityOpen;

public class BptDisabilityOpenDao extends EntityDao<BptDisabilityOpen> implements IBptDisabilityOpenDao {
	public BptDisabilityOpenDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}
	@Override
	protected Class<BptDisabilityOpen> getEntityClass() {
		return BptDisabilityOpen.class;
	}

}
