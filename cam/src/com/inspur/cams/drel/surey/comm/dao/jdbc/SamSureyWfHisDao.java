package com.inspur.cams.drel.surey.comm.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfHisDao;
import com.inspur.cams.drel.surey.comm.data.SamSureyWfHis;

/**
 * @title:SamSureyWfHisDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public class SamSureyWfHisDao extends EntityDao<SamSureyWfHis> implements ISamSureyWfHisDao{

 	public SamSureyWfHisDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamSureyWfHis.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamSureyWfHis");
	}
   
}
