package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.bptinstitution.dao.IBptOtherprovideDao;
import com.inspur.cams.bpt.bptinstitution.data.BptOtherprovide;
import org.loushang.next.dao.EntityDao;

/**
 * @title:BptOtherprovideDao
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 public class BptOtherprovideDao extends EntityDao<BptOtherprovide> implements IBptOtherprovideDao{

 	public BptOtherprovideDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return BptOtherprovide.class;
	}

   
}
