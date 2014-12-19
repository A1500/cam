package com.inspur.sdmz.jtxxcyxx.dao;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

/**
 * @title:YgjzJtxxCyxxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public class YgjzJtxxCyxxDao extends EntityDao<YgjzJtxxCyxx> implements IYgjzJtxxCyxxDao{
 
 	public YgjzJtxxCyxxDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return YgjzJtxxCyxx.class;
	}
	
	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  YGJZ_JTXX_CYXX where JTID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from YGJZ_JTXX_CYXX where JTID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   
}
