package com.inspur.cams.fis.ep.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.ep.base.dao.ICemeInspectionDao;
import com.inspur.cams.fis.ep.base.data.CemeInspection;


/**
 * @title:InspectionDao
 * @description:
 * @author:
 * @since:2011-11-17
 * @version:1.0
*/
 public class CemeInspectionDao extends EntityDao<CemeInspection> implements ICemeInspectionDao{

 	public CemeInspectionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return CemeInspection.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from CemeInspection");
	}
   
}
