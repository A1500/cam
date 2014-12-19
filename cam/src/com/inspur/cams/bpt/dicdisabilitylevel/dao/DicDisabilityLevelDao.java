package com.inspur.cams.bpt.dicdisabilitylevel.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:DicDisabilityLevelDao
 * @description:
 * @author:
 * @since:2011-11-03
 * @version:1.0
*/
 public class DicDisabilityLevelDao extends EntityDao<DicDisabilityLevel> implements IDicDisabilityLevelDao{

 	public DicDisabilityLevelDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<DicDisabilityLevel> getEntityClass() {
		return DicDisabilityLevel.class;
	}

   
}
