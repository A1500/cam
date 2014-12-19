package com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckFacingDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckFacingDao extends EntityDao<SomJxCheckFacing> implements ISomJxCheckFacingDao{

 	public SomJxCheckFacingDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckFacing.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckFacing");
	}
   
}
