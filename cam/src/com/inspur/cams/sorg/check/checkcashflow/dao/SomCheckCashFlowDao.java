package com.inspur.cams.sorg.check.checkcashflow.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow;

/**
 * @title:现金流量表dao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public class SomCheckCashFlowDao extends EntityDao<SomCheckCashFlow> implements ISomCheckCashFlowDao{

 	public SomCheckCashFlowDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckCashFlow.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckCashFlow");
	}
   
}
