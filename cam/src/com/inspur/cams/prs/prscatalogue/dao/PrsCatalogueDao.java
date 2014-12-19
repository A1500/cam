package com.inspur.cams.prs.prscatalogue.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:PrsCatalogueDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public class PrsCatalogueDao extends EntityDao<PrsCatalogue> implements IPrsCatalogueDao{

 	public PrsCatalogueDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return PrsCatalogue.class;
	}

}
