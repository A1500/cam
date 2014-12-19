package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.bptinstitution.dao.IBptMartyrBuildingsDao;
import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildings;


/**
 * @title:BptMartyrBuildingsDao
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
 public class BptMartyrBuildingsDao extends EntityDao<BptMartyrBuildings> implements IBptMartyrBuildingsDao{

 	public BptMartyrBuildingsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return BptMartyrBuildings.class;
	}

   
}
