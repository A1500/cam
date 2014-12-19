package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.bpt.base.dao.IBptApplyDisabilityNoticeDao;
import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;

/**
 * @title:BptApplyDisabilityNoticeDao
 * @description:
 * @author:
 * @since:2011-05-18
 * @version:1.0
*/
 public class BptApplyDisabilityNoticeDao extends EntityDao<BptApplyDisabilityNotice> implements IBptApplyDisabilityNoticeDao{

 	public BptApplyDisabilityNoticeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyDisabilityNotice> getEntityClass() {
		return BptApplyDisabilityNotice.class;
	}
}
