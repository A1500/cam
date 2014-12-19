package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptArchivalFondsNumberDao;
import com.inspur.cams.bpt.base.data.BptArchivalFondsNumber;

/**
 * @title:BptArchivalFondsNumberDao
 * @description:全宗号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
 public class BptArchivalFondsNumberDao extends EntityDao<BptArchivalFondsNumber> implements IBptArchivalFondsNumberDao{

 	public BptArchivalFondsNumberDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptArchivalFondsNumber> getEntityClass() {
		return BptArchivalFondsNumber.class;
	}
}
