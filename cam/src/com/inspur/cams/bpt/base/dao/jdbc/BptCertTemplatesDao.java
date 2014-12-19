package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptCertTemplatesDao;
import com.inspur.cams.bpt.base.data.BptCertTemplates;

/**
 * @title:BptCertTemplatesDao
 * @description:
 * @author:
 * @since:2011-11-22
 * @version:1.0
*/
 public class BptCertTemplatesDao extends EntityDao<BptCertTemplates> implements IBptCertTemplatesDao{

 	public BptCertTemplatesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptCertTemplates> getEntityClass() {
		return BptCertTemplates.class;
	}
}
