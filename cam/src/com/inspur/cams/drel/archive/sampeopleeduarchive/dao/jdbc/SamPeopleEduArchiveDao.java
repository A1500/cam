package com.inspur.cams.drel.archive.sampeopleeduarchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeopleeduarchive.dao.ISamPeopleEduArchiveDao;
import com.inspur.cams.drel.archive.sampeopleeduarchive.data.SamPeopleEduArchive;

/**
 * @title:SamPeopleEduArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleEduArchiveDao extends EntityDao<SamPeopleEduArchive> implements ISamPeopleEduArchiveDao{

 	public SamPeopleEduArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleEduArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleEduArchive");
	}
   
}
