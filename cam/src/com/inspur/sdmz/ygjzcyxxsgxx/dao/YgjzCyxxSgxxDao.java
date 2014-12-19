package com.inspur.sdmz.ygjzcyxxsgxx.dao;


import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:YgjzCyxxSgxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public class YgjzCyxxSgxxDao extends EntityDao<YgjzCyxxSgxx> implements IYgjzCyxxSgxxDao{
 
 	public YgjzCyxxSgxxDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return YgjzCyxxSgxx.class;
	}
	
	public void deleteByYgjzJtxxCyxx(String fkId) {
		executeUpdate("delete from  YGJZ_CYXX_SGXX where CYID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxxCyxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from YGJZ_CYXX_SGXX where CYID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   
}
