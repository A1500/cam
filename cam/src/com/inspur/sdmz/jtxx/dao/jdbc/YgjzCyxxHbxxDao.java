package com.inspur.sdmz.jtxx.dao.jdbc;



import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.sdmz.jtxx.dao.IYgjzCyxxHbxxDao;
import com.inspur.sdmz.jtxx.data.SamPeopleDisease;

/**
 * @title:YgjzCyxxHbxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public class YgjzCyxxHbxxDao extends EntityDao<SamPeopleDisease> implements IYgjzCyxxHbxxDao{

 	public YgjzCyxxHbxxDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleDisease.class;
	}

	public void deleteByYgjzJtxxCyxx(String fkId) {
		executeUpdate("delete from  SAM_PEOPLE_DISEASE where PEOPLE_ID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxxCyxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_PEOPLE_DISEASE where PEOPLE_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}

}
