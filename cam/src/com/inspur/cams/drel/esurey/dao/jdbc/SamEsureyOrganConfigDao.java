package com.inspur.cams.drel.esurey.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.esurey.dao.ISamEsureyOrganConfigDao;
import com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig;

/**
 * @title:SamEsureyOrganConfigDao
 * @description:
 * @author:
 * @since:2011-07-05
 * @version:1.0
*/
 public class SamEsureyOrganConfigDao extends EntityDao<SamEsureyOrganConfig> implements ISamEsureyOrganConfigDao{

 	public SamEsureyOrganConfigDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyOrganConfig.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyOrganConfig");
	}
   
}
