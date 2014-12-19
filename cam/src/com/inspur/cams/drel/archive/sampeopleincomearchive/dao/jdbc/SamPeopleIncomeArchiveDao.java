package com.inspur.cams.drel.archive.sampeopleincomearchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeopleincomearchive.dao.ISamPeopleIncomeArchiveDao;
import com.inspur.cams.drel.archive.sampeopleincomearchive.data.SamPeopleIncomeArchive;

/**
 * @title:SamPeopleIncomeArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleIncomeArchiveDao extends EntityDao<SamPeopleIncomeArchive> implements ISamPeopleIncomeArchiveDao{

 	public SamPeopleIncomeArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleIncomeArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleIncomeArchive");
	}
   
}
