package com.inspur.cams.drel.surey.comm.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.surey.comm.dao.ISamSureyDao;
import com.inspur.cams.drel.surey.comm.data.SamSurey;

/**
 * @title:SamSureyDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public class SamSureyDao extends EntityDao<SamSurey> implements ISamSureyDao{

 	public SamSureyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamSurey.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamSurey");
	}
   
}
