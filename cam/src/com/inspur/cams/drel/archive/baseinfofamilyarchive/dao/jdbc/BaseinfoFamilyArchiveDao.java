package com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.baseinfofamilyarchive.dao.IBaseinfoFamilyArchiveDao;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;

/**
 * @title:BaseinfoFamilyArchiveDao
 * @description:
 * @author:
 * @since:2012-05-30
 * @version:1.0
*/
 public class BaseinfoFamilyArchiveDao extends EntityDao<BaseinfoFamilyArchive> implements IBaseinfoFamilyArchiveDao{

 	public BaseinfoFamilyArchiveDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return BaseinfoFamilyArchive.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from BaseinfoFamilyArchive");
	}
}