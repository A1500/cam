package com.inspur.sdmz.ygjzcyxxjyxx.dao;


import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:YgjzCyxxJyxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public class YgjzCyxxJyxxDao extends EntityDao<YgjzCyxxJyxx> implements IYgjzCyxxJyxxDao{
 
 	public YgjzCyxxJyxxDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return YgjzCyxxJyxx.class;
	}
	
	public void deleteByYgjzJtxxCyxx(String fkId) {
		executeUpdate("delete from  YGJZ_CYXX_JYXX where CYID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxxCyxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from YGJZ_CYXX_JYXX where CYID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   
}
