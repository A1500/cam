package com.inspur.cams.drel.sam.dao.jdbc;


import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamPeopleAccidentDao;
import com.inspur.cams.drel.sam.data.SamPeopleAccident;
/**
 * @title:事故
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public class SamPeopleAccidentDao extends EntityDao<SamPeopleAccident> implements ISamPeopleAccidentDao{

 	public SamPeopleAccidentDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamPeopleAccident.class;
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
