package com.inspur.cams.drel.special.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.special.data.SpecialpoorFamilyTemp;

/**
 * @title:SpecialpoorFamilyTempDao
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 public class SpecialpoorFamilyTempDao extends EntityDao<SpecialpoorFamilyTemp> implements ISpecialpoorFamilyTempDao{

 	public SpecialpoorFamilyTempDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SpecialpoorFamilyTemp.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SpecialpoorFamilyTemp");
	}
   
}
