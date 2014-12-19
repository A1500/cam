package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamApplyNoticeDao;
import com.inspur.cams.drel.sam.data.SamApplyNotice;

/**
 * @title:公示结果Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public class SamApplyNoticeDao extends EntityDao<SamApplyNotice> implements ISamApplyNoticeDao{

 	public SamApplyNoticeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamApplyNotice.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamApplyNotice");
	}
   
}
