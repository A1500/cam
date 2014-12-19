package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDao;
import com.inspur.cams.bpt.bptinstitution.data.BptHospital;


/**
 * @title:BptHospitalDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public class BptHospitalDao extends EntityDao<BptHospital> implements IBptHospitalDao{

 	public BptHospitalDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return BptHospital.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from BptHospital");
	}

public void batchDeleteByBptHospital(String[] fkId) {
	String[] sql = new String[fkId.length];
	for (int i = 0; i < fkId.length; i++) {
		sql[i] = "delete from BPT_HOSPITAL where HOSPITAL_ID='" + fkId[i] + "'";
	}
	batchUpdate(sql);
}

	
}
   
