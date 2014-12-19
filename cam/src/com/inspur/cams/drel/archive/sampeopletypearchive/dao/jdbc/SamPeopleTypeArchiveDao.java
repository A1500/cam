package com.inspur.cams.drel.archive.sampeopletypearchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeopletypearchive.dao.ISamPeopleTypeArchiveDao;
import com.inspur.cams.drel.archive.sampeopletypearchive.data.SamPeopleTypeArchive;

/**
 * @title:SamPeopleTypeArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleTypeArchiveDao extends EntityDao<SamPeopleTypeArchive> implements ISamPeopleTypeArchiveDao{

 	public SamPeopleTypeArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleTypeArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleTypeArchive");
	}
   
}
