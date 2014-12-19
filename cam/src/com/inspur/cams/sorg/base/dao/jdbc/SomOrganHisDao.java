package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.base.dao.ISomOrganHisDao;
import com.inspur.cams.sorg.base.data.SomOrganHis;

/**
 * @title:SomOrganHisDao
 * @description:
 * @author:
 * @since:2012-05-28
 * @version:1.0
*/
 public class SomOrganHisDao extends EntityDao<SomOrganHis> implements ISomOrganHisDao{

 	public SomOrganHisDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomOrganHis.class;
	}
   
}
