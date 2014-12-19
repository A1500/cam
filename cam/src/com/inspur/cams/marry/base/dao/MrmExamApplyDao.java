package com.inspur.cams.marry.base.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:MrmExamApplyDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public class MrmExamApplyDao extends EntityDao<MrmExamApply> implements IMrmExamApplyDao{

 	public MrmExamApplyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmExamApply.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from MrmExamApply");
	}
   
}
