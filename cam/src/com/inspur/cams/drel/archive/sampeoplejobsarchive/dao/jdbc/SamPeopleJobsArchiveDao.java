package com.inspur.cams.drel.archive.sampeoplejobsarchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeoplejobsarchive.dao.ISamPeopleJobsArchiveDao;
import com.inspur.cams.drel.archive.sampeoplejobsarchive.data.SamPeopleJobsArchive;

/**
 * @title:SamPeopleJobsArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleJobsArchiveDao extends EntityDao<SamPeopleJobsArchive> implements ISamPeopleJobsArchiveDao{

 	public SamPeopleJobsArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleJobsArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleJobsArchive");
	}
   
}
