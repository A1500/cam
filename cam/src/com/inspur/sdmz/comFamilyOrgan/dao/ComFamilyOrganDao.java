package com.inspur.sdmz.comFamilyOrgan.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:ComFamilyOrganDao
 * @description:
 * @author:
 * @since:2011-09-17
 * @version:1.0
*/
 public class ComFamilyOrganDao extends EntityDao<ComFamilyOrgan> implements IComFamilyOrganDao{

 	public ComFamilyOrganDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return ComFamilyOrgan.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from ComFamilyOrgan");
	}
   
}
