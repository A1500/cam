package com.inspur.sdmz.jtxx.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.sdmz.jtxx.dao.IYgjzJzzsDao;
import com.inspur.sdmz.jtxx.data.SamIndex;

/**
 * @title:YgjzJzzsDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public class YgjzJzzsDao extends EntityDao<SamIndex> implements IYgjzJzzsDao{

 	public YgjzJzzsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamIndex.class;
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
