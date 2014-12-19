package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.bptinstitution.dao.IBptMartyrBuildingsLegalDao;
import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal;


/**
 * @title:BptMartyrBuildingsLegalDao
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
 public class BptMartyrBuildingsLegalDao extends EntityDao<BptMartyrBuildingsLegal> implements IBptMartyrBuildingsLegalDao{
 
 	public BptMartyrBuildingsLegalDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return BptMartyrBuildingsLegal.class;
	}
	
	public void deleteByBptMartyrBuildings(String fkId) {
		executeUpdate("delete from  BPT_MARTYR_BUILDINGS_LEGAL where MBUILDING_ID=?",new int[]{Types.VARCHAR},new Object[]{fkId});
	}

	public void batchDeleteByBptMartyrBuildings(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BPT_MARTYR_BUILDINGS_LEGAL where MBUILDING_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   
}
