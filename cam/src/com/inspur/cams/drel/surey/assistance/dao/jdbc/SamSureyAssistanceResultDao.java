package com.inspur.cams.drel.surey.assistance.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.surey.assistance.dao.ISamSureyAssistanceResultDao;
import com.inspur.cams.drel.surey.assistance.data.SamSureyAssistanceResult;



/**
 * @title:SamSureyAssitanceResultDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public class SamSureyAssistanceResultDao extends EntityDao<SamSureyAssistanceResult> implements ISamSureyAssistanceResultDao{

 	public SamSureyAssistanceResultDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamSureyAssistanceResult.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamSureyAssitanceResult");
	}
   
}
