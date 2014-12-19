package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmResourcesInfoDao;
import com.inspur.cams.marry.base.data.MrmResourcesInfo;

/**
 * @title:MrmResourcesInfoDao
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
*/
 public class MrmResourcesInfoDao extends EntityDao<MrmResourcesInfo> implements IMrmResourcesInfoDao{
 
 	public MrmResourcesInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return MrmResourcesInfo.class;
	}
	
	public void deleteByMrmRegisOrganInfo(String fkId) {
		StringBuffer ressql=new  StringBuffer("delete from  MRM_RESOURCES_INFO where ORGAN_ID= ? ");
		executeUpdate(ressql.toString(), new int[]{Types.VARCHAR}, new Object[]{fkId});
		
	}
	/*
	public void batchDeleteByMrmRegisOrganInfo(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from MRM_RESOURCES_INFO where ORGAN_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	*/
   
}
