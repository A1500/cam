package com.inspur.sdmz.jtxxzrzh.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:YgjzJtxxZrzhDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public class YgjzJtxxZrzhDao extends EntityDao<YgjzJtxxZrzh> implements IYgjzJtxxZrzhDao{
 
 	public YgjzJtxxZrzhDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return YgjzJtxxZrzh.class;
	}
	
	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  YGJZ_JTXX_ZRZH where JTID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from YGJZ_JTXX_ZRZH where JTID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   
}
