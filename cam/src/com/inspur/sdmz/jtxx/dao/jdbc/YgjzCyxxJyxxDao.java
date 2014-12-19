package com.inspur.sdmz.jtxx.dao.jdbc;


import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.sdmz.jtxx.dao.IYgjzCyxxJyxxDao;
import com.inspur.sdmz.jtxx.data.SamPeopleEdu;

/**
 * @title:YgjzCyxxJyxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public class YgjzCyxxJyxxDao extends EntityDao<SamPeopleEdu> implements IYgjzCyxxJyxxDao{

 	public YgjzCyxxJyxxDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleEdu.class;
	}

	public void deleteByYgjzJtxxCyxx(String fkId) {
		executeUpdate("delete from  SAM_PEOPLE_EDU where PEOPLE_ID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxxCyxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_PEOPLE_EDU where PEOPLE_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}

}
