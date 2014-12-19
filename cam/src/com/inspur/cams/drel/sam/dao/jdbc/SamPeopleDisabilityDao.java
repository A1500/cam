package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamPeopleDisabilityDao;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
/**
 * @title:残疾
 * @description:
 * @author:
 * @since:2011-04-19
 * @version:1.0
*/
 public class SamPeopleDisabilityDao extends EntityDao<SamPeopleDisability> implements ISamPeopleDisabilityDao{

 	public SamPeopleDisabilityDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
  	@Override
	public Class getEntityClass() {
		return SamPeopleDisability.class;
	}

	public void deleteByYgjzJtxxCyxx(String fkId) {
		executeUpdate("delete from  YGJZ_CYXX_CJXX where CYID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxxCyxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from YGJZ_CYXX_CJXX where CYID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}

}
