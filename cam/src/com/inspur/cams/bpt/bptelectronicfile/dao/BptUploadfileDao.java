package com.inspur.cams.bpt.bptelectronicfile.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:BptUploadfileDao
 * @description:
 * @author:
 * @since:2011-06-21
 * @version:1.0
*/
 public class BptUploadfileDao extends EntityDao<BptUploadfile> implements IBptUploadfileDao{

 	public BptUploadfileDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptUploadfile> getEntityClass() {
		return BptUploadfile.class;
	}

}
