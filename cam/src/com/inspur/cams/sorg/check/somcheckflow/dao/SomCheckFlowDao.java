package com.inspur.cams.sorg.check.somcheckflow.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.somcheckflow.data.SomCheckFlow;

/**
 * @title:SomCheckFlowDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 public class SomCheckFlowDao extends EntityDao<SomCheckFlow> implements ISomCheckFlowDao{

 	public SomCheckFlowDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckFlow.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckFlow");
	}
   
}
