package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import com.inspur.cams.drel.sam.dao.ISamApplyFilesDao;
import com.inspur.cams.drel.sam.data.SamApplyFiles;

/**
 * @title:申请材料Dao
 * @description:
 * @author:yanll
 * @since:2012-05-05
 * @version:1.0
*/
 public class SamApplyFilesDao extends EntityDao<SamApplyFiles> implements ISamApplyFilesDao{

 	public SamApplyFilesDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamApplyFiles.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamApplyFiles");
	}
   
}
