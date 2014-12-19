package com.inspur.cams.comm.soo.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.soo.data.PubCamsSoo;

/**
 * @title:PubCamsSooDao
 * @description:
 * @author:
 * @since:2011-08-11
 * @version:1.0
*/
 public class PubCamsSooDao extends EntityDao<PubCamsSoo> implements IPubCamsSooDao{

 	public PubCamsSooDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return PubCamsSoo.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from PubCamsSoo");
	}
   
}
