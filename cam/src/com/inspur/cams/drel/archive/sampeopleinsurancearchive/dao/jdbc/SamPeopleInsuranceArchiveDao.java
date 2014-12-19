package com.inspur.cams.drel.archive.sampeopleinsurancearchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeopleinsurancearchive.dao.ISamPeopleInsuranceArchiveDao;
import com.inspur.cams.drel.archive.sampeopleinsurancearchive.data.SamPeopleInsuranceArchive;

/**
 * @title:SamPeopleInsuranceArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleInsuranceArchiveDao extends EntityDao<SamPeopleInsuranceArchive> implements ISamPeopleInsuranceArchiveDao{

 	public SamPeopleInsuranceArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleInsuranceArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleInsuranceArchive");
	}
   
}
