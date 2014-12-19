package com.inspur.sdmz.jzzs.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:YgjzJzzsDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public class YgjzJzzsDao extends EntityDao<YgjzJzzs> implements IYgjzJzzsDao{

 	public YgjzJzzsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return YgjzJzzs.class;
	}

	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  SAM_INDEX where FAMILY_ID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_INDEX where FAMILY_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}

}
