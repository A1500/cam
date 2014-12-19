package com.inspur.cams.drel.archive.sampeoplediseasearchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.sampeoplediseasearchive.dao.ISamPeopleDiseaseArchiveDao;
import com.inspur.cams.drel.archive.sampeoplediseasearchive.data.SamPeopleDiseaseArchive;

/**
 * @title:SamPeopleDiseaseArchiveDao
 * @description:
 * @author:
 * @since:2012-06-04
 * @version:1.0
*/
 public class SamPeopleDiseaseArchiveDao extends EntityDao<SamPeopleDiseaseArchive> implements ISamPeopleDiseaseArchiveDao{

 	public SamPeopleDiseaseArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleDiseaseArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamPeopleDiseaseArchive");
	}
   
}
