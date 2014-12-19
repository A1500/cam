package com.inspur.cams.drel.esurey.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.esurey.dao.ISamEsureyFamilySumDao;
import com.inspur.cams.drel.esurey.data.SamEsureyFamilySum;

/**
 * @title:SamEsureyFamilySumDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyFamilySumDao extends EntityDao<SamEsureyFamilySum> implements ISamEsureyFamilySumDao{

 	public SamEsureyFamilySumDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyFamilySum.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyFamilySum");
	}
   
}
