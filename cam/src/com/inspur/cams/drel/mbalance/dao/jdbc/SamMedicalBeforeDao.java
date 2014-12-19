package com.inspur.cams.drel.mbalance.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalBeforeDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;

/**
 * @title:SamMedicalBeforeDao
 * @description:
 * @author:
 * @since:2011-06-25
 * @version:1.0
*/
 public class SamMedicalBeforeDao extends EntityDao<SamMedicalBefore> implements ISamMedicalBeforeDao{

 	public SamMedicalBeforeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamMedicalBefore.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamMedicalBefore");
	}
   
}
