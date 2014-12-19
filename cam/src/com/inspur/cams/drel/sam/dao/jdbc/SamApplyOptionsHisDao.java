package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamApplyOptionsHisDao;
import com.inspur.cams.drel.sam.data.SamApplyOptionsHis;

/**
 * @title:申请审批历史意见Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public class SamApplyOptionsHisDao extends EntityDao<SamApplyOptionsHis> implements ISamApplyOptionsHisDao{

 	public SamApplyOptionsHisDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamApplyOptionsHis.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamApplyOptionsHis");
	}
   
}
