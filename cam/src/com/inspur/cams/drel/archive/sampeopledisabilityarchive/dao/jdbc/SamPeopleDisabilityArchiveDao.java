package com.inspur.cams.drel.archive.sampeopledisabilityarchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeopledisabilityarchive.dao.ISamPeopleDisabilityArchiveDao;
import com.inspur.cams.drel.archive.sampeopledisabilityarchive.data.SamPeopleDisabilityArchive;

/**
 * @title:SamPeopleDisabilityArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleDisabilityArchiveDao extends EntityDao<SamPeopleDisabilityArchive> implements ISamPeopleDisabilityArchiveDao{

 	public SamPeopleDisabilityArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleDisabilityArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleDisabilityArchive");
	}
   
}
