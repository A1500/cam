package com.inspur.cams.drel.esurey.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.esurey.dao.ISamEsureyPeopleSumDao;
import com.inspur.cams.drel.esurey.data.SamEsureyPeopleSum;

/**
 * @title:SamEsureyPeopleSumDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyPeopleSumDao extends EntityDao<SamEsureyPeopleSum> implements ISamEsureyPeopleSumDao{

 	public SamEsureyPeopleSumDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyPeopleSum.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyPeopleSum");
	}
   
}
