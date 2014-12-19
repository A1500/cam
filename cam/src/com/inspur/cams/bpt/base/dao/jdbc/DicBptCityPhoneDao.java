package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.base.dao.IDicBptCityPhoneDao;
import com.inspur.cams.bpt.base.data.DicBptCityPhone;

/**
 * @title:DicBptCityPhoneDao
 * @description:
 * @author:
 * @since:2011-09-20
 * @version:1.0
*/
 public class DicBptCityPhoneDao extends EntityDao<DicBptCityPhone> implements IDicBptCityPhoneDao{

 	public DicBptCityPhoneDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<DicBptCityPhone> getEntityClass() {
		return DicBptCityPhone.class;
	}
}
