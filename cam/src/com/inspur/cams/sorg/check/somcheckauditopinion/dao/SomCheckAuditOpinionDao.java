package com.inspur.cams.sorg.check.somcheckauditopinion.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomCheckAuditOpinionDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public class SomCheckAuditOpinionDao extends EntityDao<SomCheckAuditOpinion> implements ISomCheckAuditOpinionDao{

 	public SomCheckAuditOpinionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheckAuditOpinion.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheckAuditOpinion");
	}
   
}
