package com.inspur.sdmz.jtxxszlx.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:YgjzJtxxSzlxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public class YgjzJtxxSzlxDao extends EntityDao<YgjzJtxxSzlx> implements IYgjzJtxxSzlxDao{
 
 	public YgjzJtxxSzlxDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return YgjzJtxxSzlx.class;
	}
	
	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  YGJZ_JTXX_SZLX where JTID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from YGJZ_JTXX_SZLX where JTID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   
}
