package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalLegalDao;
import com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal;


/**
 * @title:BptHospitalLegalDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public class BptHospitalLegalDao extends EntityDao<BptHospitalLegal> implements IBptHospitalLegalDao{
 
 	public BptHospitalLegalDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return BptHospitalLegal.class;
	}
	
	public void deleteByBptHospitalDetail(String fkId) {
		executeUpdate("delete from  BPT_HOSPITAL_LEGAL where HOSPITAL_DETAIL_ID=?",new int[]{Types.VARCHAR},new Object[]{fkId});
	}

	public void batchDeleteByBptHospitalDetail(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BPT_HOSPITAL_LEGAL where HOSPITAL_DETAIL_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
   
}
