package com.inspur.sdmz.jtxx.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.sdmz.jtxx.dao.IYgjzJtxxZrzhDao;
import com.inspur.sdmz.jtxx.data.SamFamilyCalamity;

/**
 * @title:YgjzJtxxZrzhDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public class YgjzJtxxZrzhDao extends EntityDao<SamFamilyCalamity> implements IYgjzJtxxZrzhDao{

 	public YgjzJtxxZrzhDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamFamilyCalamity.class;
	}

	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  SAM_FAMILY_CALAMITY where FAMILY_ID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_FAMILY_CALAMITY where FAMILY_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}

}
