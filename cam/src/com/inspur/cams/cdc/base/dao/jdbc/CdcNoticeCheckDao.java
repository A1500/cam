package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcNoticeCheckDao;
import com.inspur.cams.cdc.base.data.CdcNoticeCheck;

/**
 * @title:CdcNoticeCheckDao
 * @description:
 * @author:
 * @since:2012-03-29
 * @version:1.0
*/
 public class CdcNoticeCheckDao extends EntityDao<CdcNoticeCheck> implements ICdcNoticeCheckDao{

 	public CdcNoticeCheckDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<CdcNoticeCheck> getEntityClass() {
		return CdcNoticeCheck.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from CdcNoticeCheck");
	}
   
}
