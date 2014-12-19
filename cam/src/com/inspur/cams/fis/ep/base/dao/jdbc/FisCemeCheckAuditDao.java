package com.inspur.cams.fis.ep.base.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckAuditDao;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;

/**
 * @title:FisCemeCheckAuditDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public class FisCemeCheckAuditDao extends EntityDao<FisCemeCheckAudit> implements IFisCemeCheckAuditDao{

 	public FisCemeCheckAuditDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return FisCemeCheckAudit.class;
	}
   public void deleteStruAll() {
		executeUpdate("DELETE FROM FISCEMECHECKAUDIT");
	}
   
}
