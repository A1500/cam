package com.inspur.cams.bpt.base.dao.jdbc;



import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.bpt.base.data.BptRegulationsType;
import com.inspur.cams.bpt.base.dao.IBptRegulationsTypeDao;

/**
 * @title:BptRegulationsTypeDao
 * @description:
 * @author:
 * @since:2011-12-13
 * @version:1.0
*/
 public class BptRegulationsTypeDao extends EntityDao<BptRegulationsType> implements IBptRegulationsTypeDao{

 	public BptRegulationsTypeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptRegulationsType> getEntityClass() {
		return BptRegulationsType.class;
	}
}
