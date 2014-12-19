package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamApplyDiscussionDao;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;

/**
 * @title:评议结果Dao
 * @description:
 * @author:	yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public class SamApplyDiscussionDao extends EntityDao<SamApplyDiscussion> implements ISamApplyDiscussionDao{

 	public SamApplyDiscussionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamApplyDiscussion.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamApplyDiscussion");
	}
   
}
