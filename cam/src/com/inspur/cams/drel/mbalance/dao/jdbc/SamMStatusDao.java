package com.inspur.cams.drel.mbalance.dao.jdbc;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.mbalance.dao.ISamMStatusDao;
import com.inspur.cams.drel.mbalance.data.SamMStatus;

/**
 * @title:SamMedicalStatusDao
 * @description:救助状态Dao实现
 * @author:luguosui
 * @since:2011-06-01
 * @version:1.0
*/
 public class SamMStatusDao extends EntityDao<SamMStatus> implements ISamMStatusDao{

 	public SamMStatusDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamMStatus.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamMedicalStatus");
	}

	public void updateAss(SamMStatus samMStatus) {
		StringBuffer sql=new StringBuffer();
		sql.append("update sam_medical_status \n");
		sql.append("set status='"+samMStatus.getStatus()+"' \n");
		sql.append(",note='"+samMStatus.getNote()+"' \n");
		sql.append("where status_Id='"+samMStatus.getStatusId()+"'\n");
		executeUpdate(sql.toString());
	}
   
}
