package com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckAuditOpinionDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckAuditOpinionDao extends EntityDao<SomJxCheckAuditOpinion> implements ISomJxCheckAuditOpinionDao{

 	public SomJxCheckAuditOpinionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckAuditOpinion.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckAuditOpinion");
	}
   
}
