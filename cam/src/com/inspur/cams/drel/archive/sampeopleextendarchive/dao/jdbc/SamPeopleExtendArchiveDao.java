package com.inspur.cams.drel.archive.sampeopleextendarchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeopleextendarchive.dao.ISamPeopleExtendArchiveDao;
import com.inspur.cams.drel.archive.sampeopleextendarchive.data.SamPeopleExtendArchive;

/**
 * @title:SamPeopleExtendArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleExtendArchiveDao extends EntityDao<SamPeopleExtendArchive> implements ISamPeopleExtendArchiveDao{

 	public SamPeopleExtendArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleExtendArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleExtendArchive");
	}
   
}
